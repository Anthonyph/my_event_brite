# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.all.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('users') #commande pour reset l'id 
Participation.all.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('gossips') #commande pour reset l'id 
Event.all.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('cities') #commande pour reset l'id 


require 'faker'


nb_user = 50
nb_events = 5
nb_guests = 100


nb_user.times do |x|
  User.create(
      email: "#{Faker::Name.first_name}.#{Faker::Name.last_name}@yopmail.com",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      description: Faker::Lorem.paragraph_by_chars(number: 200, supplemental: false))
  puts "Seeding of User nb #{x}"
end

#for the random startdate
t1 = Time.parse("2019-11-03 14:40:34")
t2 = Time.parse("2022-01-01 00:00:00")

nb_events.times do |x|
  Event.create(
    start_date: rand(t1..t2),
    duration: rand(5..100)*5,
    description: Faker::Lorem.paragraph_by_chars(number: 300, supplemental: false),
    location: Faker::Address.city,
    price: rand(1..1000),
    title: Faker::Book.title,
    admin_id: User.all.sample.id)
  puts "Seeding of Event nb #{x}"
end

nb_guests.times do |x|
  Participation.create(
    user_id: User.all.sample.id,
    event_id: Event.all.sample.id)
  puts "Seeding of Guest nb #{x}"
end
