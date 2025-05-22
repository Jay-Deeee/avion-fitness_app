require "net/http"
require "uri"
require "json"

class FatSecretApi
  TOKEN_URL = "https://oauth.fatsecret.com/connect/token"
  API_BASE_URL = "https://platform.fatsecret.com/rest/server.api"

  def initialize
    @client_id = ENV["FATSECRET_CLIENT_ID"]
    @client_secret = ENV["FATSECRET_CLIENT_SECRET"]
    @access_token = fetch_access_token
  end

  def search_foods(query)
    uri = URI(API_BASE_URL)
    uri.query = URI.encode_www_form({
      method: "foods.search",
      format: "json",
      search_expression: query
    })

    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{@access_token}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }

    JSON.parse(response.body)
  end

  def get_food(food_id)
    uri = URI(API_BASE_URL)
    uri.query = URI.encode_www_form({
      method: "food.get",
      format: "json",
      food_id: food_id
    })
  
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{@access_token}"
  
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }
  
    JSON.parse(response.body)
  rescue => e
    Rails.logger.error("FatSecret API error: #{e.message}")
    {}
  end

  private

  def fetch_access_token
    uri = URI(TOKEN_URL)

    request = Net::HTTP::Post.new(uri)
    request.basic_auth(@client_id, @client_secret)
    request.set_form_data({
      grant_type: "client_credentials",
      scope: "basic"
    })

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }

    result = JSON.parse(response.body)

    result["access_token"]
  end
end

# client = FatSecretApi.new
# result = client.search_foods("chicken sandwich")
# puts result
