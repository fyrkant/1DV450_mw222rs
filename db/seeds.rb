require "faker"
Rails.logger = Logger.new(STDOUT)

start = Time.current

User.destroy_all
ApiKey.destroy_all
Place.destroy_all
Event.destroy_all
Tag.destroy_all

test_password = "testpass"

User.create!(
  email: "admin@mail.com",
  password: test_password,
  password_confirmation: test_password,
  admin: true

)
Rails.logger.info "Created an admin user"

50.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create!(
    email: Faker::Internet.email(first_name + "." + last_name),
    password: test_password,
    password_confirmation: test_password
  )
end

Rails.logger.info "Created #{User.count - 1} users" # the minus is the admin...

100.times do
  ApiKey.create!(
    name: Faker::App.name,
    user_id: User.all.ids.sample
  )
end

Rails.logger.info "Created #{ApiKey.count} api keys"

100.times do
  Place.create!(
    name: Faker::Address.street_name + Faker::Address.secondary_address,
    lat: Faker::Address.latitude,
    lng: Faker::Address.longitude
  )
end

Rails.logger.info "Created #{Place.count} places"

10.times do
  Tag.create!(name: Faker::Hipster.word)
end

Rails.logger.info "Created #{Tag.count} tags"

100.times do |i|
  Event.create!(
    name: Faker::Hipster.words(3).join(" "),
    description: Faker::Hipster.sentence(6),
    date: rand(300).days.from_now,
    tags: [Tag.find(Tag.last.id - rand(10))],
    user_id: User.all.ids.sample,
    place_id: Place.find(Place.first.id + i).id
  )
end

Rails.logger.info "Created #{Event.count} events"

Rails.logger.info "Seed created in #{(Time.current - start).round(2)} seconds"
