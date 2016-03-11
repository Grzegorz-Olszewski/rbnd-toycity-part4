class Module
	def create_finder_methods(*attributes)
		attributes.each do |attribute|
			find_by = %Q{
				def find_by_#{attribute}(argument)
					self.all.find {|product| product.#{attribute} == argument}
				end
			}
			class_eval(find_by)	
		end
	end
	create_finder_methods :brand, :name
end