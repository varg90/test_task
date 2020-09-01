require 'rails_helper'

feature 'orders' do
  let!(:orders) do
    create_list :order, 10
  end
  let!(:first_customer) { create :customer, email: 'first@customer.com' }
  let!(:order) do
    create :order,
           number: 'super321number',
           customer: first_customer,
           date: DateTime.new(2020, 9, 1, 10, 30, 15)
  end
  let!(:second_customer) { create :customer, email: 'second@customer.com' }

  context 'from root page' do
    scenario 'visit orders index' do
      visit root_path
      expect(page).to have_selector 'nav.navbar'
      within 'nav.navbar' do
        expect(page).to have_link 'Orders'
        click_on 'Orders'
      end
      expect(page).to have_selector 'h1', text: 'Orders'
      expect(page).to have_link 'Create Order'
      expect(page).to have_selector '.card', count: 11
    end
  end

  context 'from orders page' do
    scenario 'visit order details page' do
      visit orders_path
      expect(page).to have_selector '.card', text: 'super321number'
      within '.card', text: 'super321number' do
        click_on 'Actions'
        expect(page).to have_link 'Details'
        click_on 'Details'
      end
      expect(page).to have_selector 'h1', text: 'super321number'
      expect(page).to have_content 'Customer email: first@customer.com'
      expect(page).to have_content 'Order date: 2020-09-01 10:30:15'
      expect(page).to have_button 'Edit Order'
    end
  end

  context 'from orders page' do
    scenario 'create order' do
      visit orders_path
      expect(page).to have_link 'Create Order'
      click_on 'Create Order'

      expect(page).to have_content 'New Order'
      expect(page).to have_field 'Number'
      expect(page).to have_field 'Date'
      expect(page).to have_select 'Customer'

      fill_in 'Number', with: 'freshnew786number'
      fill_in 'Date', with: '2018-09-01T15:30:15'
      select 'second@customer.com', from: 'Customer'
      click_on 'Create Order'

      expect(page).to have_content 'Order freshnew786number has been created!'
      expect(page).to have_selector 'h1', text: 'freshnew786number'
      expect(page).to have_content 'Customer email: second@customer.com'
      expect(page).to have_content 'Order date: 2018-09-01 15:30:15'
    end

    scenario 'edit order' do
      visit orders_path
      expect(page).to have_selector '.card', text: 'super321number'
      within '.card', text: 'super321number' do
        click_on 'Actions'
        expect(page).to have_link 'Edit Order'
        click_on 'Edit Order'
      end
      expect(page).to have_selector 'h1', text: 'Edit Order'
      expect(page).to have_field 'Number', with: 'super321number'
      expect(page).to have_field 'Date', with: '2020-09-01T10:30:15'
      expect(page).to have_select 'Customer', selected: 'first@customer.com'

      fill_in 'Number', with: 'another123number'
      fill_in 'Date', with: '2019-09-01T15:30:15'
      select 'second@customer.com', from: 'Customer'
      click_on 'Update Order'

      expect(page).to have_content 'Order another123number has been updated!'
      expect(page).to have_content 'another123number'
      expect(page).to have_content 'Customer: second@customer.com'
      expect(page).to have_content 'Date: 2019-09-01 15:30:15'
    end

    scenario 'delete order' do
      visit orders_path
      expect(page).to have_selector '.card', text: 'super321number'
      within '.card', text: 'super321number' do
        click_on 'Actions'
        expect(page).to have_link 'Delete Order'
        click_on 'Delete Order'
      end
      expect(page).to have_content 'Order super321number has been deleted!'
      expect(page).to have_no_selector '.card', text: 'super321number'
    end
  end
end
