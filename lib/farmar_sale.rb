require_relative '../far-mar'
project="/Users/quaiwentt/Desktop/Ada/week5/FarMar"

# lib/farmar_sale.rb
class FarMar::Sale
	attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id, :object_type

	def initialize(sale_hash)
	 	@id=sale_hash[:id].to_i
	  	@amount=sale_hash[:amount].to_i
	  	if sale_hash[:purchase_time].class == String 
	  		@purchase_time=DateTime.strptime(sale_hash[:purchase_time], "%Y-%m-%d %H:%M:%S %z") #to date time look up from bank account
	  	else
	  		@purchase_time=sale_hash[:purchase_time]
	  	end
	  	@vendor_id=sale_hash[:vendor_id].to_i
	  	@product_id=sale_hash[:product_id].to_i
	  	@object_type="sale"
	end

	def self.object_type
		return "sale"
	end

	def self.csv
		return './support/sales.csv'
	end

	def self.all
		sales=[]
 		CSV.foreach(self.csv) do |row|
  			sales<< self.new({id: row[0], amount: row[1], purchase_time: row[2], 
  				vendor_id: row[3], product_id: row[4]})
  		end
  		return sales
	end

	def self.find(id)
		self.all.each do |sale|
			return sale if sale.id==id
		end
		raise "id not found"
	end

	def vendor
		FarMar::Vendor.all.each do |vendor|
			return vendor if vendor.id== vendor_id
		end
		raise "no vendor for this #{object_type} (#{object_type} id: #{id})"
	end

	def product
		FarMar::Product.all.each do |product|
			return product if product.id== product_id
		end
		raise "no product for this #{object_type} (#{object_type} id: #{id})"
	end

	def self.between(begin_time,end_time)
		sales=[]
		self.all.each do |sale|
			if sale.purchase_time>= begin_time &&  sale.purchase_time<= end_time
			 	sales << sale
			end
		end
		if sales.length!=0
			return sales
		else
			raise "no #{self.object_type}s found between those times"
		end
	end
end
