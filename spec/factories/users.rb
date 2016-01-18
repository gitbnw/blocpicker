include Faker

FactoryGirl.define do
  pw = Faker::Internet.password

  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    password pw
    password_confirmation pw
  end

  factory :confirmed_user, :parent => :user do
    after(:create) { |user| user.confirm }
  end

end
