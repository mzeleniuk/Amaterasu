namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  User.create!(name: 'Example User',
               email: 'admin@example.org',
               password: 'secret',
               password_confirmation: 'secret',
               admin: true,
               activated: true,
               activated_at: Time.zone.now)
  50.times do |n|
    name = Faker::Name.name
    email = "user-#{n+1}@example.org"
    password = 'secret'
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 activated: true,
                 activated_at: Time.zone.now)
  end
end

def make_microposts
  users = User.order(:created_at).take(6)
  20.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end
