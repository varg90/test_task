require 'rails_helper'

feature 'customers' do
  let!(:customers) do
    create_list :customer, 20
  end
  let!(:top_customer) { create :customer, email: 'top@customer.com' }
  let!(:old_customer) do
    create :customer, email: 'old@customer.com', birthdate: 101.years.ago
  end

  before do
    allow(top_customer).to receive(:total_amount).and_return 9_999_999
    allow(old_customer).to receive(:total_amount).and_return 0
  end

  context 'index' do
    scenario 'visit root page' do
      visit customers_path
      expect(page).to have_content 'Customers'
      expect(page).to have_selector '.card', count: 10
      expect(page).to have_content 'top@customer.com'
    end

    scenario 'filter by minimum age' do
      visit customers_path
      expect(page).to have_content 'Customers'
      expect(page).to have_field 'Minimum Age:'
      fill_in 'Minimum Age:', with: 100
      click_on 'Search'
      expect(page).to have_selector '.card', count: 1
      expect(page).to have_content 'old@customer.com'
      expect(page).to have_no_content 'top@customer.com'
    end
  end
end
