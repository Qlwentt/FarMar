require_relative '../far-mar'

# lib/farmar_market.rb
class FarMar::Market
	attr_reader :id, :name, :address, :city, :county, :state, :zip

  	def initialize(market_hash)
	  	@id=market_hash[:id].to_i
	  	@name=market_hash[:name]
	  	@address=market_hash[:address]
	  	@city=market_hash[:city]
	  	@county=market_hash[:county]
	  	@state=market_hash[:state]
	  	@zip=market_hash[:zip]
  	end
  
  	def self.csv
		return './support/markets.csv'
	end

	def self.all
		markets=[]
 		CSV.foreach(self.csv) do |row|
  			markets<< self.new({id: row[0], name: row[1], address: row[2], city: row[3],
  				county: row[4], state: row[5], zip: row[6]})
  		end
  		return markets
	end

	def self.find(id)
		self.all.each do |market|
			return market if market.id==id
		end
		raise "id not found"
	end

	def vendors
		vendors=[]
		FarMar::Vendor.all.each do |vendor|
			vendors << vendor if vendor.market_id==id
		end
		if vendors.length!=0
			return vendors
		else
			raise "no vendors for market id: #{id}"
		end
	end

	def products
		products=[]
		#currently working on 
		#products returns a collection of FarMar::Product instances that are 
		#associated to the market through the FarMar::Vendor class.

		# FarMar::Product.all.each do |product|
		# 	products << product if product.market_id==id
		# end
		# if vendors.length!=0
		# 	return vendors
		# else
		# 	raise "no vendors for market id: #{id}"
		# end
	end
end
