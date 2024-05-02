# :nocov:
require "json"
require "uri"
require "net/http"

module RapidApiServices
  class UpdateStockPrices
    API_URL = "https://real-time-finance-data.p.rapidapi.com/stock-quote?symbol=XEI%2CZSP%2CBTCC%2CETHH%2CMSCI&language=en".freeze

    def run!
      response = fetch_stock_data
      update_prices(JSON.parse(response.body)["data"]) if response.is_a?(Net::HTTPSuccess)
    rescue JSON::ParserError
      Rails.logger.error("Failed to parse JSON response.")
    rescue StandardError => e
      Rails.logger.error("Error during stock update: #{e.message}")
    end

    private

    def fetch_stock_data
      url = URI(API_URL)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(url)
      request["X-RapidAPI-Key"] = ENV.fetch("RAPIDAPI_KEY", nil)
      request["X-RapidAPI-Host"] = ENV.fetch("RAPIDAPI_HOST", nil)
      http.request(request)
    end

    def update_prices(stock_data)
      stock_data.each do |stock_info|
        stock = Stock.find_by!(api_symbol: stock_info["symbol"])
        stock.update(price: stock_info["price"])
      end
    end
  end
end
