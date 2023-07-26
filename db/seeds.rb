# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

5.times do
  User.create!(
    email: Faker::Internet.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    age: Faker::Number.between(from: 18, to: 65),
    dob: Faker::Date.birthday(min_age: 18, max_age: 65)
  )
end

3.times do
  Company.create!(
    name: Faker::Company.name,
    email: Faker::Internet.email,
    user: User.all.sample
  )
end

5.times do
  FilterOption.create!(
    name: Faker::Lorem.word,
    is_active: Faker::Boolean.boolean,
    company: Company.all.sample
  )
end

2.times do
  Promo.create!(
    name: Faker::Commerce.product_name,
    start_date: Faker::Date.forward(days: 30),
    end_date: Faker::Date.forward(days: 60),
    description: Faker::Lorem.sentence,
    company: Company.all.sample
  )
end

Promo.all.each do |promo|
  rand(1..3).times do
    promo_filter_option = PromoFilterOption.new(
      promo: promo,
      filter_option: FilterOption.all.sample
    )
    promo_filter_option.save if promo_filter_option.valid?
  end
end
