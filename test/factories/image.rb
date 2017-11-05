FactoryBot.define do
  factory :image do
    space { create(:space) }
    timestamp { Time.now }
  end
end
