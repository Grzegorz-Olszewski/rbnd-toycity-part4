class Module
	def create_finder_methods(*attributes)
		attributes.each do |attribute|
			find_by = %Q{
				def find_by_#{attribute}(argument)
					CSV.foreach(DATA_PATH,:headers => true) do |row|
						if row[1] == argument || row[2] == argument
							return Product.create(id: row[0],brand: row[1], name: row[2], price: row[3])
						end
					end
				end
			}
			class_eval(find_by)	
		end
	end
	create_finder_methods :brand, :name
end