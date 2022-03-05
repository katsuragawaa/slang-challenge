require "httparty"
require "./services/users_sessions_service"
require "./services/sort_activities_service"

SLANG_API_KEY = ENV["SLANG_CHALLENGE_API_KEY"]

slang_api_url = "https://api.slangapp.com/challenges/v1/activities"
headers = { "Content-Type": "application/json", Authorization: "Basic #{SLANG_API_KEY}" }

begin
  get_response = HTTParty.get(
    slang_api_url,
    headers: headers
  )

  puts "GET activities: #{get_response.message}"

  result = JSON.parse(get_response.body, symbolize_names: true)
  sorted_activities = SortActivitiesService.new(result[:activities]).sort
  users_sessions = UsersSessionsService.new(sorted_activities).create

  post_response = HTTParty.post(
    "#{slang_api_url}/sessions",
    headers: headers,
    body: { user_sessions: users_sessions }.to_json
  )

  puts "POST sessions: #{post_response.message}"
rescue HTTParty::Error, SocketError => e
  puts e
end
