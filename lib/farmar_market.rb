require_relative '../far-mar'
require_relative './farmar_entity'

# lib/farmar_market.rb
class FarMar::Market < FarMar::Entity
	attr_reader :id, :name, :address, :city, :county, :state, :zip
	
	OBJECT_TYPE="market"
	CSV_PATH='./support/markets.csv'
	HEADERS=[:id, :name, :address, :city, :county, :state, :zip]

  	def initialize(market_hash)
	  	@id=market_hash[:id].to_i
	  	@name=market_hash[:name]
	  	@address=market_hash[:address]
	  	@city=market_hash[:city]
	  	@county=market_hash[:county]
	  	@state=market_hash[:state]
	  	@zip=market_hash[:zip]
  	end

	def self.search(search_term)
		#how do I make this faster? Runtime currently at 25 secs
		search_term.downcase!
		results=[]
		self.all.each do |market|
			unless market.name.downcase.include?(search_term)
				market.vendors.each do |vendor|
					if vendor.name.downcase.include?(search_term)
						results<<market
					end
				end
			else
				results<<market
			end
		end
		return results
	end

	def vendors
		return get_multiple_related_objects(FarMar::Vendor)	
	end

	def products
	#need to fix get_multiple_related_objects(FarMar::Vendor)
	#to really work when there is not a direct connection
		products=[]
		vendors.each do |vendor|
			vendor.products.each do |product|
				products<<product
			end
		end
		return products
	end

	def prefered_vendor(date=nil)
		pref_vendor={vendor_obj: nil, max_rev: 0}
		#currently if there is a tie, this will return the first item it checked
		#I want to fix that later if there is time
		vendors.each do |vendor| 
			ven_rev= vendor.revenue(date)
			if ven_rev>pref_vendor[:max_rev] 
				pref_vendor[:vendor_obj]=vendor
				pref_vendor[:max_rev]=ven_rev
			end
		end
	
		return pref_vendor[:vendor_obj]
	end

	def worst_vendor(date=nil)
		vs=vendors
		#setting first minimum to be first vendor's revenue
		worst_vendor={vendor_obj: vs.first, min_rev: vs.first.revenue}
			
		#currently if there is a tie, this will return the first item it checked
		#I want to fix that later if there is time

		vs.each do |vendor|
			ven_rev=vendor.revenue(date)

			if ven_rev<worst_vendor[:min_rev] 
				worst_vendor[:vendor_obj]=vendor
				worst_vendor[:min_rev]=ven_rev
			end
		end
	
		return worst_vendor[:vendor_obj]
	end
end
