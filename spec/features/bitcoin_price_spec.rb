require 'rails_helper'

feature 'bitcoin price' do
  scenario 'visit orders index' do
    visit root_path
    expect(page).to have_selector 'h1', text: 'Bitcoin Price'
    expect(page).to have_select 'Period'
    select 'month', from: 'Period'
    click_on 'Update Chart'
    expect(page).to have_selector 'h1', text: 'Bitcoin Price'
    expect(page).to have_select 'Period', selected: 'month'
  end
end
