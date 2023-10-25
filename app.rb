require "sinatra"
require "sinatra/reloader"
require "http"


get("/") do
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)
  @currencies = parsed_data.fetch("currencies")
  erb(:home)
end

get("/:from_currency") do
  @og_currency = params.fetch("from_currency")
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)
  @currencies = parsed_data.fetch("currencies")
  erb(:flex_og_currency)
end

get("/:from_currency/:to_currency") do
  @og_currency = params.fetch("from_currency")
  @new_currency = params.fetch("to_currency")
  api_url = "https://api.exchangerate.host/convert?access_key=#{xrate_key}&from=#{@og_currency}&to=#{@to_currency}&amount=1"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)
  @conversion_rate = parsed_data.fetch("result")
end
