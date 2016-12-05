require 'uri'
require 'plivo'

class PlivoController < ApplicationController
  skip_before_action :verify_authenticity_token

  def forward
    to = params[:To]
    from = params[:From]
    cname = params[:CallerName] ? params[:CallerName] : ''
    company_numbers = CompanyNumber.find_by! sip_endpoint: to

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
        d.addUser(number.sip_endpoint || "sip:")
      end
    end

    # If no one answered, record a message.
    r.addSpeak("All of our agents are currently busy." <<
               "If you would like to leave a message, you can do so after the beep." <<
               "Or you can email your question to support@mycompany.com." <<
               "Thank you!")
    record_params = {
      action: plivo_record_url,
      method: 'POST',
      finishOnKey: '#',
    }
    r.addRecord(record_params)

    # Then hangup.
    r.addHangup()

    render xml: r.to_xml, content_type: 'application/xml'
  end


  def dial
    r = Plivo::Response.new()

    # Someone responded so we can hangup the call
    if params[:DialStatus] == 'completed'
      r.addHangup()
    end

    render xml: r.to_xml, content_type: 'application/xml'
  end

  def record
    head :no_content
  end

end
