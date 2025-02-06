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
  @the_symbol = params.fetch("first_symbol")
  exchange_key = ENV.fetch("EXCHANGE_KEY")
  exchange_url = "https://api.exchangerate.host/list?access_key=#{exchange_key}"
  @raw_response = HTTP.get(exchange_url)
  @parsed_response = JSON.parse(@raw_response)
  @currencies = @parsed_response.fetch("currencies")
  erb(:step_one)
end

get ("/:first_symbol/:second_symbol") do
  @first_symbol = params.fetch("first_symbol")
  @second_symbol = params.fetch("second_symbol")

  exchange_key = ENV.fetch("EXCHANGE_KEY")
  convert_url = "https://api.exchangerate.host/convert?from=#{@first_symbol}&to=#{@second_symbol}&amount=1&access_key=#{exchange_key}"
  @raw_response = HTTP.get(convert_url)
  @parsed_response = JSON.parse(@raw_response)
  @amount = @parsed_response.fetch("result")

 


  erb(:step_two)
  
end
