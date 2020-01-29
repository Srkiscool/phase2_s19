FactoryBot.define do
  
  factory :customer do
    first_name 'Sruthi'
    last_name 'Kalva'
    email 'skalva@gamil.com'
    phone '1234567890'
    active true
  end
  
  factory :address do
    is_billing false
    recipient 'Sunny'
    street_1 'Flying Squirrel'
    street_2 'Middleton Farm'
    city 'Herndon'
    state 'VA'
    zip '20171'
    active true
    association :customer

  end

  factory :order do
    date Date.current
    grand_total 1069.34
    payment_receipt "aisefoaiusld"
    association :customer
    association :address

  end

end