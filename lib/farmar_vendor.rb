require_relative '../far-mar'
require_relative './farmar_entity'

# lib/farmar_vendor.rb
class FarMar::Vendor < FarMar::Entity
	attr_reader :id, :name, :num_employees, :market_id
	
	OBJECT_TYPE="vendor"
	CSV_PATH='./support/vendors.csv'
	HEADERS=[:id,:name,:num_employees,:market_id]

	def initialize(vendor_hash)
	 	@id=vendor_hash[:id].to_i
	  	@name=vendor_hash[:name]
	  	@num_employees=vendor_hash[:num_employees].to_i
	  	@market_id=vendor_hash[:market_id].to_i
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

	def self.most_revenue(n, date=nil)
		#create a hash with an empty array of size n for the objects
		#and a array filled with 0s of size n for the revenues of those objects
		rev_vendors=FarMar::Vendor.all.sort_by{|vendor| vendor.revenue(date)}.reverse
		return rev_vendors[0,n]
	end

	def self.most_items(n, date=nil)
		#create a hash with an empty array of size n for the objects
		#and a array filled with 0s of size n for the revenues of those objects
		sales_vendors=FarMar::Vendor.all.sort_by{|vendor| vendor.sales(date).length}.reverse
		return sales_vendors[0,n]
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
		FarMar::Sale::ALL_SALES.each do |sale|
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
end

































