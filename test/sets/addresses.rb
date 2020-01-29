module Contexts
  module Addresses

    def create_addresses
      @addy1 = FactoryBot.create(:address, recipient: 'Venkata', active: true, customer: @sruthi, is_billing: true)
      @addy2 = FactoryBot.create(:address, recipient: 'Aditya', active: false, zip: '20172', state: 'NH', customer: @aob)
      @addy3 = FactoryBot.create(:address, recipient: 'Kunal', city: 'Pittsburgh', state: 'PA', customer: @aob)
    end
    
    def destroy_addresses
      @addy1.destroy
      @addy2.destroy
      @addy3.destroy
    end

  end
end