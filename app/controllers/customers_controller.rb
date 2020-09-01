class CustomersController < ApplicationController
  def index
    customers_request = lambda {
      Customer.includes(orders: :items)
    }
    @customers = if params[:minimum_age].present?
                   customers_request.call.where('birthdate < ?', params[:minimum_age].to_i.years.ago)
                 else
                   customers_request.call.all
                 end
                   .sort { |a, b| a.total_amount <=> b.total_amount }
                   .last(10).reverse
  end
end
