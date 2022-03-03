require "httparty"

SLANG_KEY = ENV["SLANG_CHALLENGE_API_KEY"]

base_url = "https://api.slangapp.com/challenges/v1/activities"

begin
  response = HTTParty.get(
    base_url,
    headers: { "Content-Type": "application/json", Authorization: "Basic #{SLANG_KEY}" }
  )

  puts response.code == 200 ? response.body : response.message
rescue HTTParty::Error, SocketError => e
  puts e
end
