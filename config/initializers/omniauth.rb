Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['facebook_key'], ENV['facebook_key_secret'], info_fields: 'first_name, last_name, email'
end