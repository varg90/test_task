require 'rails_helper'

feature 'items' do
  let!(:items) do
    create_list :item, 10
  end
  let!(:item) do
    create :item,
           title: 'Bestseller',
           price: 14.99
  end

  context 'from root page' do
    scenario 'visit items index' do
      visit root_path
      expect(page).to have_selector 'nav.navbar'
      within 'nav.navbar' do
        expect(page).to have_link 'Order Items'
        click_on 'Order Items'
      end
      expect(page).to have_selector 'h1', text: 'Items'
      expect(page).to have_link 'Create Item'
      expect(page).to have_selector '.card', count: 11
    end
  end

  context 'from items page' do
    scenario 'create item' do
      visit items_path
      expect(page).to have_link 'Create Item'
      click_on 'Create Item'

      expect(page).to have_content 'New Item'
      expect(page).to have_field 'Product Name'
      expect(page).to have_field 'Price'

      fill_in 'Product Name', with: 'Best thing in the World!'
      fill_in 'Price', with: 19.99
      click_on 'Create Item'

      expect(page).to have_content 'Item Best thing in the World! has been created!'
      expect(page).to have_selector 'h1', text: 'Best thing in the World!'
      expect(page).to have_content 'Item Price: $19.99'
    end

    scenario 'edit item' do
      visit items_path
      expect(page).to have_selector '.card', text: 'Bestseller'
      within '.card', text: 'Bestseller' do
        click_on 'Actions'
        expect(page).to have_link 'Edit Item'
        click_on 'Edit Item'
      end
      expect(page).to have_selector 'h1', text: 'Edit Item'
      expect(page).to have_field 'Product Name', with: 'Bestseller'
      expect(page).to have_field 'Price', with: 14.99

      fill_in 'Product Name', with: 'Another Product'
      fill_in 'Price', with: 4.99
      click_on 'Update Item'

      expect(page).to have_content 'Item Another Product has been updated!'
      expect(page).to have_content 'Another Product'
      expect(page).to have_content 'Price: $4.99'
    end

    scenario 'delete item' do
      visit items_path
      expect(page).to have_selector '.card', text: 'Bestseller'
      within '.card', text: 'Bestseller' do
        click_on 'Actions'
        expect(page).to have_link 'Delete Item'
        click_on 'Delete Item'
      end
      expect(page).to have_content 'Item Bestseller has been deleted!'
      expect(page).to have_no_selector '.card', text: 'Bestseller'
    end
  end
end
