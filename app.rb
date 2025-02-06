require "sinatra"
require "sinatra/reloader"
require "http"
require "dotenv/load"
require "json"

get("/") do
  exchange_key = ENV.fetch("EXCHANGE_KEY")
  exchange_url = "https://api.exchangerate.host/list?access_key=#{exchange_key}"
  @raw_response = HTTP.get(exchange_url)
  @parsed_response = JSON.parse(@raw_response)
  @currencies = @parsed_response.fetch("currencies")
  erb(:homepage)
end

get("/:first_symbol") do
  @symbol = params.fetch("first_symbol")
  erb(:step_one)
end
