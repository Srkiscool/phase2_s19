# require needed files
require './test/sets/customers'
require './test/sets/addresses'
require './test/sets/orders'


module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::Customers
  include Contexts::Addresses
  include Contexts::Orders
  
  def create_all
    create_customers
    create_addresses
    create_orders

  end

  end