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
		self.all[index]
	end
	def self.destroy(index)
		array = CSV.read(DATA_PATH)
		deleted = self.find(index)
		array.delete_if {|row| row[0].to_i == deleted.id }
		CSV.open(DATA_PATH, "wb") do |csv|
			array.each do |ar|
				csv << ar
			end
		end
		deleted
	end
end
