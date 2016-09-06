require_relative '../far-mar'
#project="/Users/quaiwentt/Desktop/Ada/week5/FarMar"

# lib/farmar_market.rb
class FarMar::Market
	attr_reader :id, :name, :address, :city, :county, :state, :zip
  	@@markets=[]

  	def initialize(market_hash)
	  	@id=market_hash[:id].to_i
	  	@name=market_hash[:name]
	  	@address=market_hash[:address]
	  	@city=market_hash[:city]
	  	@county=market_hash[:county]
	  	@state=market_hash[:state]
	  	@zip=market_hash[:zip]
  	end
  
	def self.add_market(market_hash)
		#why did I have to do self. here? Why not Market.new? It was giving me an error
		#saying FarMar::Market:Market did you mean FarMar::Market
		@@markets<<self.new(market_hash)
	end

	def self.add_markets_from_csv(csv)
 		CSV.foreach(csv) do |row|
  			self.add_market({id: row[0], name: row[1], address: row[2], city: row[3],
  				county: row[4], state: row[5], zip: row[6]})
  		end
	end

	def self.all
		@@markets
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
end

# FarMar::Market.add_markets_from_csv(project+'/support/markets.csv')
# puts FarMar::Market.find(3).name