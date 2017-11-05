FactoryBot.define do
  factory :user do
    uid { SecureRandom.uuid }
    email { "#{SecureRandom.uuid}@gmail.com"}
  end
end
