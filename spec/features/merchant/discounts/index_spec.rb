require 'rails_helper'

RSpec.describe 'When I visit merchants index' do
  before :each do

    @merchant = Merchant.create(name: 'Megans Marmalades',
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

    @discount_2 = Discount.create(percentage: 30,
                                          bulk: 100,
                                          merchant_id: @merchant.id)



    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@employee)

    visit '/merchant/discounts'
  end

    it 'I see all available discounts along with percent off and item count required' do

    expect(page).to have_content("Available Discounts")

    within "#discount-#{@discount.id}" do
      expect(page).to have_content(@discount.percentage)
      expect(page).to have_content(@discount.bulk)
    end

    within "#discount-#{@discount_2.id}" do
      expect(page).to have_content(@discount_2.percentage)
      expect(page).to have_content(@discount_2.bulk)
    end
  end
end
