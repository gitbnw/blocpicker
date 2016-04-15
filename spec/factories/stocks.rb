include Faker

change = rand(-4.9..4.9)
lasttradepriceonly = rand(50.0 - 100.0)


FactoryGirl.define do
  factory :stock do
    symbol { Faker::Lorem.characters(4).upcase.gsub!(/\d\s?/, "") }
    name { Faker::Company.name }
    change { change }
    volume { rand(1000..500_000) }
    averagedailyvolume { rand(1000..500_000) }
    lasttradepriceonly lasttradepriceonly.to_s
  end
end
