module Analyzable
	def count_by_brand(array)
		brands = []
		array.each do |product|
			if brands.include?(product.brand) == false
				brands.push(product.brand)
			end
		end
		brands_hash = Hash.new
		array.each do |product|
			brands.each do |brand|
				if product.brand == brand
					brands_hash[brand] ? brands_hash[brand]+=1 : brands_hash[brand]=1
				end
			end
		end
		brands_hash
	end
	def count_by_name(array)
		names = []
		array.each do |product|
			if names.include?(product.name) == false
				names.push(product.name)
			end
		end
		names_hash = Hash.new
		array.each do |product|
			names.each do |name|
				if product.name == name
					names_hash[name] ? names_hash[name]+=1 : names_hash[name]=1
				end
			end
		end
		names_hash
	end
	def average_price(array)
		prices = array.map {|product| product.price.to_f}
		sum = prices.inject{|total, price| total + price }
		avg = (sum/array.size).round(2)
	end
	def print_report(array)
		string = "Average Price: $#{average_price(array)}\nInventory by brand:\n" 
		count_by_brand(array).each do |key,value|
			string = string + "  - #{key}: #{value}\n"
		end
		string = string + "Inventory by name\n"
		count_by_name(array).each do |key,value|
			string = string + "  - #{key}: #{value}\n"
		end
		string
	end
end
