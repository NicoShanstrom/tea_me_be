# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

Customer.destroy_all
Tea.destroy_all
Subscription.destroy_all

ActiveRecord::Base.connection.reset_sequence!('customers', :id)
ActiveRecord::Base.connection.reset_sequence!('teas', :id)
ActiveRecord::Base.connection.reset_sequence!('subscriptions', :id)

10.times do
  Customer.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    address: Faker::Address.full_address
  )
end

5.times do
  Tea.create!(
    title: Faker::Tea.variety,
    description: Faker::Lorem.sentence,
    temperature: rand(150..212),
    brew_time: rand(3..10)
  )
end

Customer.limit(7).each do |customer|
  Tea.all.each do |tea|
    Subscription.create!(
      title: "#{tea.title} Subscription",
      price: rand(5.0..20.0),
      status: [0, 1].sample,
      frequency: rand(1..12),
      customer: customer,
      tea: tea
    )
  end
end

puts "Seeded #{Customer.count} customers, #{Tea.count} teas, and #{Subscription.count} subscriptions."
