require_relative '../far-mar'
require 'Time'
project="/Users/quaiwentt/Desktop/Ada/week5/FarMar"

# lib/farmar_sale.rb
class FarMar::Sale
	attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id

	def initialize(sale_hash)
	 	@id=sale_hash[:id].to_i
	  	@amount=sale_hash[:amount].to_i
	  	@purchase_time=DateTime.strptime(sale_hash[:purchase_time], "%Y-%m-%d %H:%M:%S %z") #to date time look up from bank account
	  	@vendor_id=sale_hash[:vendor_id].to_i
	  	@product_id=sale_hash[:product_id].to_i
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
end
