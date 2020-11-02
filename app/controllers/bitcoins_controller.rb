class BitcoinsController < ApplicationController
  def index
    @bitcoin_data = bitcoin_service.data_for_period params[:period] || 'year'
  end

  private

  def bitcoin_service
    @bitcoin_service ||= BitcoinService.new
  end
end
