include Faker

FactoryGirl.define do
  factory :alert do
    start { Faker::Date.between(2.days.ago, Date.today) }
    expire { Faker::Date.between(Date.today + 1.day, Date.today + 20.days) }
    price_initial { Faker::Number.decimal(2) }
    price_target { Faker::Number.decimal(2) }
    user
    stock
  end
end
