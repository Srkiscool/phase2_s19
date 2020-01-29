module Contexts
  module Customers

    def create_customers
      @sruthi = FactoryBot.create(:customer, first_name: "Sruthi", last_name: "Kalva", phone: '703-233-6783')
      @bob = FactoryBot.create(:customer, active: false, first_name: 'Bob', last_name: 'Builder')
      @aob = FactoryBot.create(:customer, email: 'hobbyboy@gmail.com', first_name: 'Aob', last_name: 'Auilder')
    end
    
    def destroy_customers
       @aob.delete
       @bob.delete
       @sruthi.delete
      
     
    end

  end
end