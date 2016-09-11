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
		rev_vendors=FarMar::Vendor.all.sort_by{|vendor| vendor.revenue(date)}.reverse
		return rev_vendors[0,n]
	end

	def self.most_items(n, date=nil)
		#the rescue keeps it from throwing a runtime error if vendor.sales returns nil. instead the
		#value is nil.length is replaced with 0		
		sales_vendors=FarMar::Vendor.all.sort_by{|vendor| vendor.sales(date).length rescue 0 }.reverse
		return sales_vendors[0,n]
	end

	def market
	    #blatantly calling parent method (no super) because I want to keep 
	    #method name market
	    return get_single_related_object(FarMar::Market)
	end
	
	def products
		return get_multiple_related_objects(FarMar::Product)
	end


	def sales(date=nil)
		date_doesnt_matter=true if date==nil

		sales=[]
		FarMar::Sale::ALL_SALES.each do |sale|
			sales << sale if sale.vendor_id==id and (date_doesnt_matter or sale.purchase_time===date)
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

































