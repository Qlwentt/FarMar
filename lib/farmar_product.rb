require_relative '../far-mar'
project="/Users/quaiwentt/Desktop/Ada/week5/FarMar"

# lib/farmar_product.rb
class FarMar::Product
	attr_reader :id, :name, :vendor_id, :object_type

	def initialize(product_hash)
	 	@id=product_hash[:id].to_i
	  	@name=product_hash[:name]
	  	@vendor_id=product_hash[:vendor_id].to_i
	  	@object_type="product"
	end

	def self.object_type
		return "product"
	end

 	def self.csv
 		return './support/products.csv'
	end

	def self.all
		products=[]
 		CSV.foreach(self.csv) do |row|
  			products<< self.new({id: row[0], name: row[1], vendor_id: row[2]})
  		end
  		return products
	end

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
			raise "no #{self.object_type}s found with vendor id: #{vendor_id}"
		end
	end

	def vendor
		FarMar::Vendor.all.each do |vendor|
			return vendor if vendor.id== vendor_id
		end
		raise "no vendor for this product (product id: #{id})"
	end

	def sales
		sales=[] 
		FarMar::Sale.all.each do |sale|
			sales << sale if sale.product_id==id
		end
		if sales.length!=0
			return sales
		else
			raise "no sales for this product (product id: #{id})"
		end
	end

	def number_of_sales
		return sales.length
	end
end


