require 'rails_helper'

RSpec.describe 'As a merchant user' do
  before :each do
    @merchant = Merchant.create!(name: 'Megans Marmalades',
                                  address: '123 Main St',
                                  city: 'Denver',
                                  state: 'CO',
                                  zip: 80218)

    @employee = @merchant.users.create(name: 'Johnny',
                                              address: '2190 Grape Sreett',
                                              city: 'Denver',
                                              state: 'CO',
                                              zip: 80241,
                                              email: 'employee@example.com',
                                              password: 'securepassword')

    @discount = Discount.create(percentage: 15,
                                     bulk: 25,
                                     merchant_id: @merchant.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@employee)
  end

  describe 'When I visit /merchant/bulk_discounts'
    it 'I can see all availablediscounts' do

    visit '/merchant/discounts'

    expect(page).to have_content("Available Discounts")
    expect(page).to have_link("Create New Discount")

    within "#discount-#{@discount.id}" do
      expect(page).to have_content(@discount.percentage)
      expect(page).to have_content(@discount.bulk)
    end
  end
end
