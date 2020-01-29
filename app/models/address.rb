class Address < ApplicationRecord
  #Relationships
  belongs_to :customer
  has_many :orders
  


  
# Scopes
#----------------------------------------------------
# get all the owners who are active
scope :active, -> { where(active: true) }

# get all the owners who are active
scope :inactive, -> { where.not(active: true) }

#gets all orders results alphabetically by recipient name
scope :by_recipient, -> {order('recipient')}



scope :by_customer, -> { joins(:customer).order('last_name, first_name') }


#'shipping' -- returns all addresses which are just shipping addresses
scope :shipping, ->  { where(is_billing: false)}


#'billing' -- returns all addresses which are also billing addresses
scope :billing, ->  { where(is_billing: true)}



# scope :search_common, ->(first_name,zip_code) { joins(:address).where('first_name LIKE ? AND zip_code LIKE ?', "#{first_name}%", "#{zip_code}%") }



#Validates
validate :check_dup, on: :create
validate :cust_is_active
validates_presence_of :recipient, :street_1, :zip
# if zip included, it must be 5 digits only
validates_format_of :zip, with: /\A\d{5}\z/, message: "should be five digits long", allow_blank: false


# validates_numericality_of :id, :customer_id 
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


 
def check_dup
	if already_exists?
		errors.add(:recipient, "this address already exists")
	end
end
 
# Extra methods
# 'already_exists?'should determine whether or
# not an address is already in the system for this customer.

def already_exists?
	!Address.where(recipient: self.recipient, zip: self.zip).by_customer().empty?    
end



end
