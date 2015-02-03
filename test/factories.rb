require 'securerandom'

FactoryGirl.define do 

  factory :user do
    email { SecureRandom.urlsafe_base64(5) +'@email.com'}
    password '123456789'
  end

  factory :place do
    name 'The Place'
    description 'The coolest place to eat.'
    address '123 Broadway Ave' 
    user
  end

  factory :comment do
    message 'this place rocks'
    rating '5_stars'
    user
  end

end