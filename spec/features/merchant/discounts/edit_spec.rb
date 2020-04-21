require 'rails_helper'

RSpec.describe 'When I visit the discount edit page' do
  before :each do

    @merchant = Merchant.create(name: 'Brians Bagels',
                                  address: '125 Main St',
                                  city: 'Denver',
                                  state: 'CO',
                                  zip: 80218)

    @employee = @merchant.users.create(name: 'Megan',
                                        address: '123 Main St',
                                        city: 'Denver',
                                        state: 'CO',
                                        zip: 80218,
                                        email: 'megan@example.com',
                                        password: 'securepassword')

    @discount = Discount.create(percentage: 10,
                                     bulk: 15,
                                     merchant_id: @merchant.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@employee)
  end

  it 'I see a link to edit the percentage and bulk of discount' do

    visit "/merchant/discounts/#{@discount.id}"

    click_link 'Edit Discount'

    expect(current_path).to eq("/merchant/discounts/#{@discount.id}/edit")

    expect(page).to have_field("Percentage")
    expect(page).to have_field("Bulk")
  end
end
