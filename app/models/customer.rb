class Customer < ApplicationRecord
	
  # create a callback that will strip non-digits before saving to db
	before_save :reformat_phone


  #Relationships
	has_many :orders
	has_many :addresses

	
	# Scopes
  # -----------------------------
  # list owners in alphabetical order
  scope :alphabetical, -> { order('last_name, first_name') }
  # get all the owners who are active (not moved out and pet is alive)
  scope :active, -> { where(active: true) }
  # get all the owners who are inactive (have moved out or pet is dead)
  scope :inactive, -> { where.not(active: true) }


	#Validations 
	validates_presence_of :first_name, :last_name
	validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
  # Not allowing for .uk, .ca, etc. because this is a Pittsburgh business and customers not likely to be out-of-country
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"




  # Other methods
  # -------------
  # a method to get owner name in last, first format
  def name
    last_name + ", " + first_name
  end
  
  # a method to get owner name in last, first format
  def proper_name
    first_name + " " + last_name
  end


   # Callback code
   private
     # We need to strip non-digits before saving to db
     def reformat_phone
       phone = self.phone.to_s  # change to string in case input as all numbers 
       phone.gsub!(/[^0-9]/,"") # strip all non-digits
       self.phone = phone       # reset self.phone to new string
     end





end
