FactoryGirl.define do
  factory :user do
    first_name 'Test'
    sequence(:last_name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password 'foobar'
    password_confirmation 'foobar'
    activated true
    activated_at Time.zone.now

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content 'Test content'
    user
  end
end
