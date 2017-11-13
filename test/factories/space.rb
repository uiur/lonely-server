FactoryBot.define do
  factory :space do
    name { Faker::Space.planet.downcase }
  end
end
