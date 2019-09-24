Rails.application.configure do

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              "smtp.gmail.com",
    port:                  587,
    domain:               "gmail.com",
    user_name:            "ananyaswaminathan222@gmail.com",
    password:             "130997@test#",
    authentication:       :login,
    enable_starttls_auto: true
  }
  config.action_mailer.default_options = { from: 'ananyaswaminathan222@gmail.com' }
  config.action_mailer.default_url_options = { :host => 'localhost', port: '3000'}

end
