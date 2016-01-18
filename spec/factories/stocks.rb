include Faker

FactoryGirl.define do

  factory :stock do
    symbol Faker::Lorem.characters(4)
    name Faker::Company.name
    price Faker::Number.decimal(2)
    change rand(-4.9..4.9)
    volume rand(1000..500000)
  end


end
