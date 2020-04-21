require 'rails_helper'

RSpec.describe 'When I visit the discount show page' do
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

    @discount = Discount.create(percentage: 10,
                                     bulk: 15,
                                     merchant_id: @merchant.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@employee)

    visit "/merchant/discounts/#{@discount.id}"
  end

  it "I see a link that takes me to that discounts show page and lists discount attributes" do

    expect(page).to have_content("Discount Number: #{@discount.id}")
    expect(page).to have_content("Percent Off: 10%")
    expect(page).to have_content("Number of Items Required: 15")
  end
end
