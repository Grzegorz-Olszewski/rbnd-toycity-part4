require_relative 'find_by'
require_relative 'errors'
require 'csv'

DATA_PATH = File.dirname(__FILE__) + "/../data/data.csv"
class Udacidata
	def self.create(attributes = nil)
		CSV.foreach(DATA_PATH) do |csv|
			if csv[2] == attributes[:name]
				return self.new(id: csv[0], brand: csv[1], name: csv[2], price: csv[3])
			else
				object = self.new(attributes)
				CSV.open(DATA_PATH, "a") do |csv|
					csv << [object.id, object.brand, object.name, object.price]
				end
				return object
			end
		end
	end

	def self.all
		array = []
		CSV.foreach(DATA_PATH, headers:true) do |csv|
			array.push(self.new(id: csv[0], brand: csv[1], name: csv[2], price: csv[3]))
		end
		array
	end

	def self.first(number = nil)
		array = []
		if number.nil?
			self.all[0]
		else 	
			number.times do |i|
				array.push(self.all[i])
			end
			array
		end
	end
	def self.last(number = nil)
		array = []
		if number.nil?
			self.all[self.all.length - 1]
		else 	
			number.times do |i|
				array.push(self.all[self.all.length - 1 - i])
			end	
			array
		end
	end
	def self.find(index)
		array = self.all
		array.each do |product|
			if product.id == index
				return product
			end
		end
		raise ProductNotFoundError, "Product with #{index} id doesn't exist"
	end

	def self.destroy(index)
		array = CSV.read(DATA_PATH)
		if self.find(index) == false
			raise ProductNotFoundError, "Product with #{index} id doesn't exist"
		end
		deleted = self.find(index)
		array.delete_if {|row| row[0].to_i == deleted.id }
		CSV.open(DATA_PATH, "wb") do |csv|
			array.each do |ar|
				csv << ar
			end
		end
		deleted
	end
	def self.where(attribute = nul)
		array = self.all
		return_array = []
		array.each do |item|
			if item.brand == attribute[:brand] || item.name == attribute[:name]
				return_array.push(item)
			end
		end
		return_array
	end
	def update(attribute = nul)
		array = CSV.read(DATA_PATH)
		id = 0
		array.each do |row|
			if row[0].to_i == self.id
				if attribute[:brand].nil? == false
					row[1] = attribute[:brand]
				end
				if attribute[:name].nil? == false
					row[2] = attribute[:name]
				end
				if attribute[:price].nil? == false
					row[3] = attribute[:price]
				end
				id = row[0].to_i
			end
		end
		CSV.open(DATA_PATH, "wb") do |csv|
			array.each do |ar|
				csv << ar
			end
		end
		Product.find(id)
	end
end