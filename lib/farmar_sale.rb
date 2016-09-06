require_relative '../far-mar'
require 'Time'
project="/Users/quaiwentt/Desktop/Ada/week5/FarMar"

# lib/farmar_sale.rb
class FarMar::Sale
	attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id
	@@sales=[]

	def initialize(sale_hash)
	 	@id=sale_hash[:id].to_i
	  	@amount=sale_hash[:amount].to_i
	  	@purchase_time=DateTime.strptime(sale_hash[:purchase_time], "%Y-%m-%d %H:%M:%S %z") #to date time look up from bank account
	  	@vendor_id=sale_hash[:vendor_id].to_i
	  	@product_id=sale_hash[:product_id].to_i
	end

	def self.add_sale(sale_hash)
		@@sales<<self.new(sale_hash)
	end

	def self.add_sales_from_csv(csv)
 		CSV.foreach(csv) do |row|
  			self.add_sale({id: row[0], amount: row[1], purchase_time: row[2], 
  				vendor_id: row[3], product_id: row[4]})
  		end
	end

	def self.all
		@@sales
	end

	def self.find(id)
		self.all.each do |sale|
			return sale if sale.id==id
		end
		raise "id not found"
	end
end