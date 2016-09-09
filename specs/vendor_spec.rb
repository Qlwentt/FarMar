require_relative 'spec_helper'
require_relative '../lib/farmar_vendor'
require_relative '../lib/farmar_market'
require_relative '../lib/farmar_product'
require_relative '../lib/farmar_sale'

describe FarMar::Vendor do
  it "can create vendor objects from data in a csv file" do
    expect(FarMar::Vendor.all.class.must_equal(Array))
    expect(FarMar::Vendor.all.first.class).must_equal(FarMar::Vendor)
    expect(FarMar::Vendor.all.first.name).must_equal("Feil-Farrell")
    expect(FarMar::Vendor.all.first.num_employees).must_equal(8)
    expect(FarMar::Vendor.all.first.market_id).must_equal(1)
  end

  # it "does not contain duplicates" do
  #   #FarMar::Vendor.add_vendors_from_csv('./support/vendors.csv')
  #   expect(FarMar::Vendor.all.length).must_equal(
  #     (FarMar::Vendor.csv_original_length))
  # end

  it "can find a particular market object by its id" do
    expect(FarMar::Vendor.find(3).name.must_equal("Breitenberg Inc"))
  end

  it "raises a runtime error if it cannot find the id" do
    expect(proc{FarMar::Vendor.find(888888).name}).must_raise(RuntimeError)
  end
  it "returns market associated with an instance of vendor" do
    expect(FarMar::Vendor.all.first.market.name).must_equal("People's Co-op Farmers Market")
  end

   it "raises an error if it can't find a market for  vendor" do
    v=FarMar::Vendor.new(id:888888, name:"fake vendor")
    expect(proc{v.market.name}).must_raise(RuntimeError)
  end

  it "returns products assoc. w/ an instance of vendor" do
    expect(FarMar::Vendor.all.first.products.first.name).must_equal("Dry Beets")
  end

  it "raises an error if no product for vendor" do
    v=FarMar::Vendor.new(id:888888, name:"fake vendor")
    expect(proc{v.products.first.name}).must_raise(RuntimeError)
  end

   it "returns sales associated with an instance of vendor" do
    expect(FarMar::Vendor.all.first.sales.first.amount).must_equal(9290)
  end

    it "returns nil if it can't find a sale for vendor" do
    v=FarMar::Vendor.new(id:888888, name:"fake vendor")
    expect(v.sales).must_equal(nil)
  end

  it "returns revenue (sum of sales) for a specific vendor" do
    expect(FarMar::Vendor.all.first.revenue).must_equal(38259)
  end

  it "returns all vendors with given market id" do
    expect(FarMar::Vendor.by_market(2).first.name).must_equal("Bechtelar Inc")
  end

    it "raises an error if no vendors have that market id" do
    expect(proc{FarMar::Vendor.by_market(888888).first.name}).must_raise(RuntimeError)
  end

  it "returns top n vendors by revenue" do
    top=FarMar::Vendor.most_revenue(3)
    expect(top.class).must_equal(Array)
    expect(top.length).must_equal(3)
    #expected=["Blah","Blah","Blah"]
    expect(top.first.name).must_equal("Swaniawski-Schmeler")
    #expect([top[0].name).must_equal(expected)
  end
end






