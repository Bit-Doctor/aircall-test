require 'uri'
require 'plivo'

class PlivoController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :verify_plivo_signature

  def forward
    company_numbers = CompanyNumber.find_by! sip_endpoint: params[:To]

    Call.create({
      uuid: params[:CallUUID],
      caller_name: params[:CallerName],
      caller_number: params[:From],
      company_number: company_numbers,
    })

    r = Plivo::Response.new()
    # Greet the caller.
    r.addSpeak("Welcome! Please stay on the line. Your call is being connected to an agent.")

    # Call sequentially all user linked to this company_numbers.
    company_numbers.users.each do |user|
      # Speak between each user.
      if user != company_numbers.users.first
        r.addSpeak("Please hold while you are connected to the next available agent.")
      end
      dial_params = {
         timeout: 10,
         dialMusic: "real",
         action: plivo_dial_url,
         method: 'POST',
      }
      d = r.addDial(dial_params)
      user.user_numbers.each do |number|
        # Ring all user_numbers at the same time.
        d.addUser(number.sip_endpoint)
      end
    end

    # If no one answered, record a message.
    r.addSpeak("All of our agents are currently busy." <<
               "If you would like to leave a message, you can do so after the beep." <<
               "Or you can email your question to support@mycompany.com." <<
               "Thank you!")
    record_params = {
      action: plivo_record_url,
      redirect: false,
      method: 'POST',
      finishOnKey: '#',
    }
    r.addRecord(record_params)

    # Then hangup.
    r.addHangup(reason: 'busy')

    render xml: r.to_xml, content_type: 'application/xml'
  end


  def dial
    r = Plivo::Response.new()

    # Someone responded so we can hangup the call
    if params[:DialStatus] == 'completed'
      call = Call.find_by! uuid: params[:CallUUID]
      user_number = UserNumber.find_by! sip_endpoint: params[:DialBLegTo]
      call.respondent_number = user_number
      call.respondent = user_number.user
      call.save

      r.addHangup()
    end

    render xml: r.to_xml, content_type: 'application/xml'
  end

  def record
    call = Call.find_by! uuid: params[:CallUUID]
    call.record_url = params[:RecordUrl]
    call.save

    r = Plivo::Response.new()
    render xml: r.to_xml, content_type: 'application/xml'
  end

  private

  def verify_plivo_signature
    signature = request.env["HTTP_X_PLIVO_SIGNATURE"]
    auth_token = Rails.application.secrets.plivo["token"]
    uri = request.url

    hashed_params = Hash.new{[]}
    params = request.body.read
    hashed_params = hashed_params.merge(Hash[*URI.decode_www_form(params).flatten]) if params
    head :unauthorized unless Plivo::XPlivoSignature.new(signature, uri, hashed_params, auth_token).is_valid?
  end

end
