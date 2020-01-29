require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  should belong_to (:customer)
  should belong_to (:address)

  #test date
  should validate_presence_of(:date)
  should allow_value(Date.current).for(:date)
  should_not allow_value("bad").for(:date)
  should_not allow_value(3.14159).for(:date)
  should_not allow_value(-5).for(:grand_total)
  should allow_value(0).for(:grand_total)


  



  context "Given context" do
    # create the objects I want with factories
    setup do 
      create_customers
      create_addresses
      create_orders
      
    end
    
    # and provide a teardown method as well
    teardown do
      destroy_addresses
      destroy_customers
      destroy_orders
      
    end

    #testing Chronological
    should "have a chronological scope for ordering" do
    	assert_equal [@ord1, @ord2, @ord3, @ord4], Order.chronological.to_a
	end 
	should "have a paid scope for ordering" do
		assert_equal [@ord1, @ord2, @ord3], Order.paid.to_a
	end 

	should "have a for_customer scope for ordering" do
		assert_equal [@ord1, @ord2, @ord3], Order.for_customer(@sruthi.id).to_a
	end 

	should "identify a non-active order as invalid" do      
      inactive_address = FactoryBot.build(:order, date: 6.months.ago.to_date , grand_total: 17.48 , payment_receipt:"zsjj23kjfjsd3ifg", customer: @sruthi, address: @addy2)
      inactive_address.save
      assert_equal false, inactive_address.valid?
      inactive_customer = FactoryBot.build(:order, date: 6.months.ago.to_date , grand_total: 17.48 , payment_receipt:"zsjj23kjfjsd3ifg", customer: @bob, address: @addy1)
      inactive_customer.save
      assert_equal false, inactive_customer.valid?
    end

    should "Identify if pay " do  
    	@ord5 = FactoryBot.build(:order, date: 7.months.ago.to_date, grand_total: 73.20, payment_receipt: nil, customer: @aob, address: @addy1)
    	@ord5.pay
    	assert_equal ("order: " + @ord5.id.to_s + "; amount_paid:" + @ord5.grand_total.to_s + "; recieved: " + @ord5.date.to_s ), Base64.decode64(@ord5.payment_receipt)
    end
  # # Validations
  # validates_date :date

  # test "the truth" do
  #   assert true
   end
end
