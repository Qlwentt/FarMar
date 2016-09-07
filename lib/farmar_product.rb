require_relative '../far-mar'
project="/Users/quaiwentt/Desktop/Ada/week5/FarMar"

# lib/farmar_product.rb
class FarMar::Product
	attr_reader :id, :name, :vendor_id
	@@products=[]

	def initialize(product_hash)
	 	@id=product_hash[:id].to_i
	  	@name=product_hash[:name]
	  	@vendor_id=product_hash[:vendor_id].to_i
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
end
