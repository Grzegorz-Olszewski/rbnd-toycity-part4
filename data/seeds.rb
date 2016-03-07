require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed
	brand = []
	products_names = []
	prices = []
	database = []
	array = []
	10.times do |i|
		brand.push(Faker::Commerce.department)
		products_names.push(Faker::Commerce.product_name)
		prices.push(Faker::Commerce.price)
		product = Product.new(id:i-1,brand:brand[i],name:products_names[i],price:prices[i])
		database.push(product)
	end	
	CSV.open(DATA_PATH,"wb") do |csv|
		database.each do |data|
			csv << [data.id,data.brand,data.name,data.price]
		end
	end

end
