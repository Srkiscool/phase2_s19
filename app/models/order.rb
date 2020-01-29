class Order < ApplicationRecord
  


	#relationships
	belongs_to :customer
	belongs_to :address



	#scopes
  	#chronological' -- orders results chronologically with most recent
  	# orders listed at the top
  	scope :chronological, -> { order('date DESC') }
  	#'paid' -- returns all orders that have been paid (i.e., have a
	#payment receipt recorded)
	scope :paid, -> { where.not("payment_receipt IS NULL") }

	#'for_customer' –- returns all the orders for a particular customer
	# (parameter: customer_id)
	scope :for_customer, -> (customer_id){where('customer_id LIKE ?', "#{customer_id}%")}


	#validations
	validates :date, presence: true
	validates_numericality_of :grand_total, :greater_than_or_equal_to => 0
	

	validates_date :date, on_or_before: -> { Date.current }

	validate :cust_is_active
	validate :add_is_active
	
	#extra methods

	# create a base64 encoded reciept 
	def pay
	#"order: <the order id>; amount_paid: <grand total>; received: <the order date>".
		if self.payment_receipt == nil
			enc   = Base64.encode64("order: " + self.id.to_s + "; amount_paid:" + self.grand_total.to_s + "; recieved: " + self.date.to_s )
			self.payment_receipt = enc
		end
	end



	private


	def cust_is_active
	  # get an array of all active owners in the PATS system
	  all_cust_ids = Customer.active.all.map{|o| o.id}
	  # add error unless the owner id of the pet is in the array of active owners
	  unless all_cust_ids.include?(self.customer_id)
	    errors.add(:customer, "is not an active customer")
	    return false
	  end
	  return true
	end

	def add_is_active
	  # get an array of all active owners in the PATS system
	  all_add_ids = Address.active.all.map{|o| o.id}
	  # add error unless the owner id of the pet is in the array of active owners
	  unless all_add_ids.include?(self.address_id)
	    errors.add(:address, "is not an active customer")
	    return false
	  end
	  return true
	end




end
