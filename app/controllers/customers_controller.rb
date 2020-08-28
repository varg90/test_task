class CustomersController < ApplicationController
  def index
    @customers = if params[:minimum_age].present?
                   Customer.where('birthdate < ?', params[:minimum_age].to_i.years.ago).limit(10)
                 else
                   Customer.all.limit(10)
                 end
  end
end
