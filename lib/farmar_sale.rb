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

	def self.read_from_csv
			sales=[]
		#used IO here instead of CSV because IO is faster
		#this keeps the runtime down when this method is called
		#the downside is I can't use IO for all classes because some CSV data 
		#has commas in it as part of the data. like fake example: "Farmers, Inc. "
		#that name shouldn't be broken up by commas
 		IO.foreach(CSV_PATH) do |row|
  			element=row.split(",")
  			sales<< self.new(
  				{id: element[0], amount: element[1], purchase_time: element[2], 
  				vendor_id: element[3], product_id: element[4]})
  		end
  		return sales
  	end
	#an attempt to make runtime faster
	#I don't think it is working
	ALL_SALES=self.read_from_csv
	
	def self.all
		return ALL_SALES
	end

	#This can't be at the top because self.all needs be be defined first
	#The constant exists to keep the runtime down in the Vendor instance method sales
	

	def vendor
		return get_single_related_object(FarMar::Vendor)
	end

	def product
		return get_single_related_object(FarMar::Product)
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
