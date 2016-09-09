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

	# def self.all
	# 	products=[]
 # 		CSV.foreach(CSV_PATH) do |row|
 #  			products<< self.new({id: row[0], name: row[1], vendor_id: row[2]})
 #  		end
 #  		return products
	# end

	def self.find(id)
		self.all.each do |product|
			return product if product.id==id
		end
		raise "id not found"
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
		FarMar::Vendor.all.each do |vendor|
			return vendor if vendor.id== vendor_id
		end
		raise "no vendor for this #{OBJECT_TYPE} (#{OBJECT_TYPE} id: #{id})"
	end

	def sales
		sales=[] 
		FarMar::Sale.all.each do |sale|
			sales << sale if sale.product_id==id
		end
		if sales.length!=0
			return sales
		else
			raise "no sales for this #{OBJECT_TYPE} (#{OBJECT_TYPE} id: #{id})"
		end
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


