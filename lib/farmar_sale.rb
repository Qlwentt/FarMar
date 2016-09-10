require_relative '../far-mar'
require_relative './farmar_entity'

# lib/farmar_sale.rb
class FarMar::Sale < FarMar::Entity
	attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id
	
	OBJECT_TYPE="sale"
	CSV_PATH='./support/sales.csv'
	HEADERS=[:id,:amount,:purchase_time,:vendor_id,:product_id]

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
	end

	def self.all
		sales=[]
 		IO.foreach(CSV_PATH) do |row|
  			element=row.split(",")
  			sales<< self.new(
  				{id: element[0], amount: element[1], purchase_time: element[2], 
  				vendor_id: element[3], product_id: element[4]})
  		end
  		return sales
	end

	#This can't be at the top because .all needs be be defined first
	ALL_SALES=self.all

	def vendor
		FarMar::Vendor.all.each do |vendor|
			return vendor if vendor.id== vendor_id
		end
		raise "no vendor for this #{OBJECT_TYPE} (#{OBJECT_TYPE} id: #{id})"
	end

	def product
		FarMar::Product.all.each do |product|
			return product if product.id== product_id
		end
		raise "no product for this #{OBJECT_TYPE} (#{OBJECT_TYPE} id: #{id})"
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
			raise "no #{OBJECT_TYPE}s found between those times"
		end
	end
end
