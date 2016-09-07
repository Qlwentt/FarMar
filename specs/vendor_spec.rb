require_relative 'spec_helper'
require_relative '../lib/farmar_vendor'
require_relative '../lib/farmar_market'
require_relative '../lib/farmar_product'
require_relative '../lib/farmar_sale'

describe FarMar::Vendor do
  it "can create vendor objects from data in a csv file" do
    #FarMar::Vendor.add_vendors_from_csv('./support/vendors.csv')
    expect(FarMar::Vendor.all.class.must_equal(Array))
    expect(FarMar::Vendor.all.first.class).must_equal(FarMar::Vendor)
    expect(FarMar::Vendor.all.first.name).must_equal("Feil-Farrell")
    expect(FarMar::Vendor.all.first.num_employees).must_equal(8)
    expect(FarMar::Vendor.all.first.market_id).must_equal(1)
  end

  it "can find a particular market object by its id" do
    #FarMar::Vendor.add_vendors_from_csv('./support/vendors.csv')
    expect(FarMar::Vendor.find(3).name.must_equal("Breitenberg Inc"))
  end

  it "raises a runtime error if it cannot find the id" do
    #FarMar::Vendor.add_vendors_from_csv('./support/vendors.csv')
    expect(proc{FarMar::Vendor.find(888888).name}).must_raise(RuntimeError)
  end
  it "returns market associated with an instance of vendor" do
    #FarMar::Market.add_markets_from_csv('./support/markets.csv')
    #FarMar::Vendor.add_vendors_from_csv('./support/vendors.csv')
    expect(FarMar::Vendor.all.first.market.name).must_equal("People's Co-op Farmers Market")
  end

   it "raises an error if it can't find a market for  vendor" do
    v=FarMar::Vendor.new(id:888888, name:"fake vendor")
    #FarMar::Market.add_markets_from_csv('./support/markets.csv')
    expect(proc{v.market.name}).must_raise(RuntimeError)
  end

  it "returns products associated with an instance of vendor" do
    #FarMar::Product.add_products_from_csv('./support/products.csv')
    #FarMar::Vendor.add_vendors_from_csv('./support/vendors.csv')
    expect(FarMar::Vendor.all.first.products.first.name).must_equal("Dry Beets")
  end

  it "raises an error if it can't find a product for  vendor" do
    v=FarMar::Vendor.new(id:888888, name:"fake vendor")
    #FarMar::Product.add_products_from_csv('./support/products.csv')
    expect(proc{v.products.first.name}).must_raise(RuntimeError)
  end

   it "returns sales associated with an instance of vendor" do
    #FarMar::Market.add_markets_from_csv('./support/markets.csv')
    #FarMar::Vendor.add_vendors_from_csv('./support/vendors.csv')
    #FarMar::Sale.add_sales_from_csv('./support/sales.csv')
    expect(FarMar::Vendor.all.first.sales.first.amount).must_equal(9290)
  end

    it "raises an error if it can't find a sale for vendor" do
    v=FarMar::Vendor.new(id:888888, name:"fake vendor")
    #FarMar::Sale.add_sales_from_csv('./support/sales.csv')
    expect(proc{v.sales.first.amount}).must_raise(RuntimeError)
  end

  it "returns revenue (sum of sales) for a specific vendor" do
    #FarMar::Vendor.add_vendors_from_csv('./support/vendors.csv')
    #FarMar::Sale.add_sales_from_csv('./support/sales.csv')
    expect(FarMar::Vendor.all.first.revenue).must_equal(38259)
  end

  it "returns all vendors with given market id" do
    #FarMar::Market.add_markets_from_csv('./support/markets.csv')
    #FarMar::Vendor.add_vendors_from_csv('./support/vendors.csv')
    expect(FarMar::Vendor.by_market(2).first.name).must_equal("Bechtelar Inc")
  end

    it "raises an error if no vendors have that market id" do
    #FarMar::Vendor.add_vendors_from_csv('./support/vendors.csv')
    #FarMar::Sale.add_sales_from_csv('./support/sales.csv')
    expect(proc{FarMar::Vendor.by_market(888888).first.name}).must_raise(RuntimeError)
  end
end






