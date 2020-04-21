require 'rails_helper'

RSpec.describe "When I visit the create new discount page" do
  before :each do
    
    @merchant = Merchant.create(name: 'Brians Bagels',
                                  address: '125 Main St',
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
  end

  it 'There is a link to create a new brand new discount' do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@employee)

    visit '/merchant/discounts'

    click_link 'Create New Discount'

    expect(current_path).to eq('/merchant/discounts/new')

    expect(page).to have_field("Percentage")
    expect(page).to have_field("Bulk")
  end
end
