FactoryGirl.define do

  sequence :email do |i|
    "user-#{i}@snowfinch.net"
  end

  factory :user do
    email
    password "123456"
  end

  factory :site do
    name "Snowfinch"
  end

end
