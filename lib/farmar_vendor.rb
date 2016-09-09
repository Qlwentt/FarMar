require_relative '../far-mar'

# lib/farmar_vendor.rb
class FarMar::Vendor
	attr_reader :id, :name, :num_employees, :market_id
	
	OBJECT_TYPE="vendor"
	CSV_PATH='./support/vendors.csv'

	def initialize(vendor_hash)
	 	@id=vendor_hash[:id].to_i
	  	@name=vendor_hash[:name]
	  	@num_employees=vendor_hash[:num_employees].to_i
	  	@market_id=vendor_hash[:market_id].to_i
	end

	def self.all
		vendors=[]
 		CSV.foreach(CSV_PATH) do |row|
  			vendors<< self.new({id: row[0], name: row[1], num_employees: row[2], market_id: row[3]})
  		end
  		return vendors
	end

	def self.find(id)
		self.all.each do |vendor|
			return vendor if vendor.id==id
		end
		raise "id not found"
	end

	def market
		FarMar::Market.all.each do |market|
			return market if market.id== market_id
		end
		raise "no market for #{OBJECT_TYPE} id: #{id}"
	end

	def products
		products=[]
		FarMar::Product.all.each do |product|
			products << product if product.vendor_id==id
		end
		if products.length!=0
			return products
		else
			raise "no products for #{OBJECT_TYPE} id: #{id}"
		end
	end


	def sales(date=nil)
		if date==nil
			extra_condition= "true"
		else
			extra_condition= "sale.purchase_time===date"
		end

		sales=[]
		FarMar::Sale.all.each do |sale|
			sales << sale if sale.vendor_id==id and eval extra_condition
		end
		if sales.length!=0
			return sales
		else
			return nil #raise "no sales for vendor id: #{id}"
		end
	end
	
	def revenue(date=nil)
		if date==nil
			these_sales=sales
		else
			these_sales=sales(date)
		end
		unless these_sales==nil
			return these_sales.inject(0){|sum,sale| sum + sale.amount}
		else #if sales = nil return a revenue of 0
			return 0
		end

	end

	def self.by_market(market_id)
		vendors=[]
		self.all.each do |vendor|
			vendors << vendor if vendor.market_id==market_id
		end
		if vendors.length!=0
			return vendors
		else
			raise "no #{OBJECT_TYPE}s found with for market id: #{market_id}"
		end
	end
end

































