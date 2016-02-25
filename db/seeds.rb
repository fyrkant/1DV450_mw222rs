require "faker"

start = Time.current

User.destroy_all
ApiKey.destroy_all
Place.destroy_all
Event.destroy_all

test_password = "testpass"

User.create!(
  email: "admin@mail.com",
  password: test_password,
  password_confirmation: test_password,
  admin: true

)
p "Created an admin user"

50.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create!(
    email: Faker::Internet.email(first_name + "." + last_name),
    password: test_password,
    password_confirmation: test_password
  )
end

p "Created #{User.count - 1} users" # the minus is the admin...

100.times do
  ApiKey.create!(
    name: Faker::App.name,
    user_id: User.all.ids.sample
  )
end

p "Created #{ApiKey.count} api keys"

10.times do
  Place.create!(
    name: Faker::Address.street_name + Faker::Address.secondary_address,
    lat: Faker::Address.latitude,
    lng: Faker::Address.longitude
  )
end

p "Created #{Place.count} places"

10.times do
  Event.create!(
    name: Faker::Hipster.words(3).join(" "),
    description: Faker::Hipster.sentence(6),
    place_id: Place.all.ids.sample
  )
end

p "Created #{Event.count} events"

p "Seed created in #{(Time.current - start).round(2)} seconds"
