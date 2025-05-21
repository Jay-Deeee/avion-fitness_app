require "uri"
require "net/http"
require 'json'

class NutriApi
  def self.fetch_records(query)
    api_url = 'https://api.calorieninjas.com/v1/nutrition'
    uri = URI("#{api_url}?query=#{URI.encode_www_form_component(query)}")

    request = Net::HTTP::Get.new(uri)
    request['X-Api-Key'] = ENV["API_KEY"]

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      puts response.body
    else
      puts "Error: #{response.code} #{response.body}"
    end
  end
end
