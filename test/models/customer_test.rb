require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  
	#Relationships
	# --------------------------
	should have_many(:orders)
	should have_many(:addresses)

	#Validation macros...
	should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)

    #validate phone number
   should allow_value("4122683259").for(:phone)
   should allow_value("412-268-3259").for(:phone)
   should allow_value("412.268.3259").for(:phone)
   should allow_value("(412) 268-3259").for(:phone)
  
   should_not allow_value("2683259").for(:phone)
   should_not allow_value("4122683259x224").for(:phone)
   should_not allow_value("800-EAT-FOOD").for(:phone)
   should_not allow_value("412/268/3259").for(:phone)
   should_not allow_value("412-2683-259").for(:phone)



     # Validating email...
	should allow_value("fred@fred.com").for(:email)
	should allow_value("fred@andrew.cmu.edu").for(:email)
	should allow_value("my_fred@fred.org").for(:email)
	should allow_value("fred123@fred.gov").for(:email)
	should allow_value("my.fred@fred.net").for(:email)

	should_not allow_value("fred").for(:email)
	should_not allow_value("fred@fred,com").for(:email)
	should_not allow_value("fred@fred.uk").for(:email)
	should_not allow_value("my fred@fred.com").for(:email)
	should_not allow_value("fred@fred.con").for(:email)

     
 context "Given context" do
    # create the objects I want with factories
    setup do 
      create_customers
      
    end
    
    # and provide a teardown method as well
    teardown do
      destroy_customers
      
    end
  

# test the scope 'active'
    should "shows that there are two active Customers" do
      assert_equal 2, Customer.active.size
      assert_equal ["Aob", "Sruthi"], Customer.active.alphabetical. map{|o| o.first_name}  
      #assert_equal ["Alex", "Mark"], Address.active.map{|o| o.first_name}.sort
    end
    # test the scope 'inactive'
    should "shows that there is one inactive owners" do
      assert_equal 1, Customer.inactive.size
      assert_equal ["Bob"], Customer.inactive.map{|o| o.first_name}.sort
    end

      # test the scope 'alphabetical'
    should "shows that there are three owners in in alphabetical order" do
      assert_equal ["Aob", "Bob", "Sruthi"], Customer.alphabetical.map{|o| o.first_name}
    end

    #tests the method 'name' works
    should "show that the name method works" do
    	assert_equal "Kalva, Sruthi", @sruthi.name
    end
    # test the method 'proper_name' works
    should "shows that proper_name method works" do
      assert_equal "Sruthi Kalva", @sruthi.proper_name
    end

    # test the callback is working 'reformat_phone'
    should "shows that Sruthi's phone is stripped of non-digits" do
      assert_equal "7032336783", @sruthi.phone
    end


  # test "the truth" do
  #   assert true
  # end
end
end