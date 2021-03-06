require_relative '../far-mar'
require_relative './farmar_entity'

# lib/farmar_product.rb
class FarMar::Product < FarMar::Entity
	attr_reader :id, :name, :vendor_id
	
	OBJECT_TYPE="product"
	CSV_PATH='./support/products.csv'
	HEADERS=[:id,:name,:vendor_id]

	def initialize(product_hash)
	 	@id=product_hash[:id].to_i
	  	@name=product_hash[:name]
	  	@vendor_id=product_hash[:vendor_id].to_i
	end

	def self.by_vendor(vendor_id)
		objects=[]
		self.all.each do |object|
			objects << object if object.vendor_id==vendor_id
		end
		if objects.length!=0
			return objects
		else
			raise "no #{OBJECT_TYPE}s found with vendor id: #{vendor_id}"
		end
	end

	def self.most_revenue(n)
		#create a hash with an empty array of size n for the objects
		#and a array filled with 0s of size n for the revenues of those objects
		rev_products=FarMar::Product.all.sort_by{|product| product.revenue}.reverse
		return rev_products[0,n]
	end

	def vendor
		return get_single_related_object(FarMar::Vendor)
	end

	def sales
		return get_multiple_related_objects(FarMar::Sale)
	end

	def number_of_sales
		return sales.length
	end

	def revenue
		unless sales==nil
			return sales.inject(0){|sum,sale| sum + sale.amount}
		else #if sales = nil return a revenue of 0
			return 0
		end
	end
end


