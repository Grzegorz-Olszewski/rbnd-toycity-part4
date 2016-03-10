module Analyzable
	def count_by_brand(array)
		hash = {array[0].brand => array.length}
	end
	def count_by_name(array)
		hash = {array[0].name => array.length}
	end
	def average_price(array)
		sum = 0.0
		array.each do |product|
			sum = sum + product.price.to_f
		end
		avg = (sum/array.size).round(2)
	end
	def print_report(array)
		brands = []
		names = []
		array.each do |product|
			if brands.include?(product.brand) == false
				brands.push(product.brand)
			end
			if names.include?(product.name) == false
				names.push(product.name)
			end
		end
		brands_hash = Hash.new
		brands.each do |brand|
			brands_hash[brand] = count_by_brand(Product.where(brand: brand))[brand]
		end
		names_hash = Hash.new
		names.each do |name|
			names_hash[name] = count_by_name(Product.where(name: name))[name]
		end
		string = "Average Price: $#{average_price(array)}\nInventory by brand:\n" 
		brands_hash.each do |key,value|
			string = string + "  - #{key}: #{value}\n"
		end
		string = string + "Inventory by name\n"
		names_hash.each do |key,value|
			string = string + "  - #{key}: #{value}\n"
		end
		puts string
		string
	end
end
