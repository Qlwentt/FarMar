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

	def self.add_product(product_hash)
		#why did I have to do self. here? Why not Market.new? It was giving me an error
		#saying FarMar::Market:Market did you mean FarMar::Market
		@@products<<self.new(product_hash)
	end

	def self.add_products_from_csv(csv)
 		CSV.foreach(csv) do |row|
  			self.add_product({id: row[0], name: row[1], vendor_id: row[2]})
  		end
	end

	def self.all
		@@products
	end

	def self.find(id)
		self.all.each do |product|
			return product if product.id==id
		end
		raise "id not found"
	end
end