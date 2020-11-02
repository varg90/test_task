class BitcoinService
  attr_accessor :data, :api_data, :endpoint
  EXPIRATION_TIME = 1.minute

  def initialize
    @endpoint = 'cryptocurrency/listings/latest'
    api_data = find_or_init_db_data
    @data =
      if api_data.persisted? && api_data.updated_at > EXPIRATION_TIME.ago
        api_data.data
      else
        api_data.data = get_api_response_data
        api_data.save
        api_data.data
      end
  end

  def data_for_period(period)
    case period.to_sym
    when :hour
      hourly_data
    when :day
      daily_data
    when :week
      weekly_data
    when :month
      monthly_data
    else
      yearly_data
    end
  end

  private

  def find_or_init_db_data
    @api_data ||= CmcApiDatum.find_or_initialize_by endpoint: endpoint
  end

  def get_api_response_data
    return [] if Rails.env.test?

    uri = URI.parse("https://#{Rails.application.credentials.coin_market_cap[:api_url]}/v1/#{endpoint}")
    query = { limit: 5000 }
    headers = { 'Accept': 'application/json',
                'X-CMC_PRO_API_KEY': Rails.application.credentials.coin_market_cap[:api_key] }
    response = HTTParty.get uri, query: query, headers: headers
    raise "CoinMarketCap returned #{response.code} code: #{response.body}" unless response.code == 200

    body = JSON.parse response.body
    body['data']
  end

  def daily_data
    # this should use the real values from historical @data instead (not available on a free plan)
    prices = {}
    24.times do |hour|
      prices[hour] = rand(20000)
    end
    prices
  end

  def hourly_data
    # this should use the real values from historical @data instead (not available on a free plan)
    prices = {}
    60.times do |hour|
      prices[hour] = rand(20000)
    end
    prices
  end

  def yearly_data
    # this should use the real values from historical @data instead (not available on a free plan)
    prices = {}
    12.times do |hour|
      prices[hour] = rand(20000)
    end
    prices
  end

  def weekly_data
    # this should use the real values from historical @data instead (not available on a free plan)
    prices = {}
    7.times do |hour|
      prices[hour] = rand(20000)
    end
    prices
  end

  def monthly_data
    # this should use the real values from historical @data instead (not available on a free plan)
    prices = {}
    30.times do |hour|
      prices[hour] = rand(20000)
    end
    prices
  end
end
