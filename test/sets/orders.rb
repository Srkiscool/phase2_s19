module Contexts
  module Orders

    def create_orders
      @ord1 = FactoryBot.create(:order, date: 4.months.ago.to_date , grand_total: 17.48 , payment_receipt:"zsjj23kjfjsd3ifg", customer: @sruthi, address: @addy1)
      @ord2 = FactoryBot.create(:order,date: 5.months.ago.to_date, grand_total: 108.33, payment_receipt: "hjdsiu3i",   customer: @sruthi, address: @addy1)
      @ord3 = FactoryBot.create(:order, date: 6.months.ago.to_date, grand_total: 72.20, payment_receipt:"asjj23kjfjsd3ifg", customer: @sruthi, address: @addy1)
      @ord4 = FactoryBot.create(:order, date: 7.months.ago.to_date, grand_total: 73.20, payment_receipt: nil, customer: @aob, address: @addy1)
    end
    
    def destroy_orders
      @ord1.destroy
      @ord2.destroy
      @ord3.destroy
    end

  end
end