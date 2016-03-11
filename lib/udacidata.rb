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
		if number.nil?
			self.all.first 
		else 	
			self.all.first(number)
		end
	end
	def self.last(number = nil)
		if number.nil?
			self.all.last
		else 	
			self.all.last(number)
		end
	end
	def self.find(id)
		array = self.all
		array.each do |product|
			if product.id == id
				return product
			end
		end
		raise ProductNotFoundError, "Product with #{id} id doesn't exist"
	end

	def self.destroy(id)
		array = CSV.read(DATA_PATH)
		deleted = self.find(id)
		array.delete_if {|row| row[0].to_i == deleted.id }
		CSV.open(DATA_PATH, "wb") do |csv|
			array.each do |ar|
				csv << ar
			end
		end
		deleted
	end
	def self.where(attribute = nil)
		array = self.all
		return_array = []
		array.each do |item|
			if item.brand == attribute[:brand] || item.name == attribute[:name]
				return_array.push(item)
			end
		end
		return_array
	end
	def update(attribute = nil)
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