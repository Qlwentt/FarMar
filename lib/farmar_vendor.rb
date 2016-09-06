require_relative '../far-mar'

# lib/farmar_vendor.rb
class FarMar::Vendor
	attr_reader :id, :name, :num_employees, :market_id
	@@vendors=[]

	def initialize(vendor_hash)
	 	@id=vendor_hash[:id].to_i
	  	@name=vendor_hash[:name]
	  	@num_employees=vendor_hash[:num_employees].to_i
	  	@market_id=vendor_hash[:market_id].to_i
	end

	def self.add_vendor(vendor_hash)
		#why did I have to do self. here? Why not Market.new? It was giving me an error
		#saying FarMar::Market:Market did you mean FarMar::Market
		@@vendors<<self.new(vendor_hash)
	end

	def self.add_vendors_from_csv(csv)
 		CSV.foreach(csv) do |row|
  			self.add_vendor({id: row[0], name: row[1], num_employees: row[2], market_id: row[3]})
  		end
	end

	def self.all
		@@vendors
	end

	def self.find(id)
		self.all.each do |vendor|
			return vendor if vendor.id==id
		end
		raise "id not found"
	end
end