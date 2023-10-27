class Stock < ApplicationRecord
  has_many :user_stocks 
  has_many :users, through: :user_stocks

  def self.check_db?(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
    #   secret_token: "sk_09d31793698545e3bcb1ac8374037cb7",
      endpoint: "https://cloud.iexapis.com/v1",
    )

    # client.price(ticker_symbol)
    begin
        new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol).to_i)
    rescue => exceptions
        return nil
    end        
  end
end
