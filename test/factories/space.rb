FactoryBot.define do
  factory :space do
    name { Faker::Name.unique.first_name.downcase }
  end
end
