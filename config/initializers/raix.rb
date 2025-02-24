OpenRouter.configure do |config|
  config.access_token = Rails.application.credentials.openrouter_api_key
  config.site_name = "Morning Meeting"
end

Raix.configure do |config|
  config.openrouter_client = OpenRouter::Client.new
end
