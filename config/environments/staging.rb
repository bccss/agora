require_relative "production"

Mail.register_interceptor(
  RecipientInterceptor.new(ENV.fetch("EMAIL_RECIPIENTS"))
)

Rails.application.configure do
  # ...

  config.action_mailer.default_url_options = { host: 'staging.hfm.com' }
end
