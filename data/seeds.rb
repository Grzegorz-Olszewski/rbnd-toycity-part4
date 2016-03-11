require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed
	brand = []
	products_names = []
	prices = []
	array = []
	10.times do |i|
		brand.push(Faker::Commerce.department)
		products_names.push(Faker::Commerce.product_name)
		prices.push(Faker::Commerce.price)
		Product.create(id:i,brand:brand[i],name:products_names[i],price:prices[i])
	end	
end
