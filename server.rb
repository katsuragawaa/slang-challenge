require "httparty"
require "./services/users_sessions_service"
require "./services/sort_activities_service"

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

  result = JSON.parse(response.body, symbolize_names: true)
  parsed_activities = SortActivitiesService.new(result[:activities]).sort
  users_sessions = UsersSessionsService.new(parsed_activities).create

  puts users_sessions.to_json
rescue HTTParty::Error, SocketError => e
  puts e
end
