require "httparty"
require "time"
require "./services/users_sessions_service"
require "./services/activities_manager"

SLANG_API_KEY = ENV["SLANG_CHALLENGE_API_KEY"]

slang_api_url = "https://api.slangapp.com/challenges/v1/activities"

begin
  response = HTTParty.get(
    slang_api_url,
    headers: {
      "Content-Type": "application/json",
      Authorization: "Basic #{SLANG_API_KEY}"
    }
  )

  puts response.message

  result = JSON.parse(response.body)

  service = ActivitiesManager.new(result["activities"])
  parsed = service.parse_activities_by_user

  puts parsed.to_json
rescue HTTParty::Error, SocketError => e
  puts e
end
