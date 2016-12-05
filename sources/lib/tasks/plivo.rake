require 'plivo'

namespace :plivo do
  @plivo = Plivo::RestAPI.new(Rails.application.secrets.plivo['id'], Rails.application.secrets.plivo['token'])

  desc "Init plivo application and endpoint."
  task :init, [:host] => [:environment, :clean, :forward, :direct] do |task, args|
  end

  desc "Setup plivo forward application and endpoint."
  task :forward, [:host] => :environment do |task, args|
    Rails.application.routes.default_url_options[:host] = args.host
    _, response = @plivo.create_application({
      answer_url: Rails.application.routes.url_helpers.plivo_forward_url,
      answer_method: 'POST',
      hangup_url: Rails.application.routes.url_helpers.plivo_hangup_url,
      hangup_method: 'POST',
      app_name: "Forward Application",
    })
    forward_app_id = response['app_id']
    # Add all company number endpoint to this app
    CompanyNumber.all.each do |number|
      _, response = @plivo.create_endpoint({
        app_id: forward_app_id,
        username: number.name.tr(' ', ''),
        alias: number.name,
        password: 'jojojo',
      })
      number.sip_endpoint = response['username'] << '@phone.plivo.com'
      number.save
    end
  end

  desc "Setup plivo direc application and endpoint."
  task :direct, [:host] => :environment do |task, args|
    Rails.application.routes.default_url_options[:host] = args.host
    _, response = @plivo.create_application({
      answer_url: Rails.application.routes.url_helpers.plivo_direct_url,
      answer_method: 'POST',
      hangup_url: Rails.application.routes.url_helpers.plivo_hangup_url,
      hangup_method: 'POST',
      app_name: "Direct Application",
    })
    direct_app_id = response['app_id']
    # Add all user number endpoint to this app
    User.all.each do |user|
      user.user_numbers.each do |number|
        _, response = @plivo.create_endpoint({
          app_id: direct_app_id,
          username: user.name.tr(' ', '') << '' << number.name.tr(' ', ''),
          alias: user.name << ' ' << number.name,
          password: 'jojojo',
        })
        number.sip_endpoint = response['username'] << '@phone.plivo.com'
        number.save
    end
  end

  desc "Clean plivo application and endpoint."

  # Remove old apps
  _, resforward = @plivo.get_applications
  end
  task :clean, :environment do
    # Remove old apps
    _, response = @plivo.get_applications
    response["objects"].each do |app|
      @plivo.delete_application(app)
    end

    # Remove old endpoints
    _, response = @plivo.get_endpoints
    response["objects"].each do |endpoint|
      @plivo.delete_endpoint(endpoint)
      puts endpoint
    end
  end
end
