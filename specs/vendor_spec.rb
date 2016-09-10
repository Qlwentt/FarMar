require_relative 'spec_helper'
require_relative '../lib/farmar_vendor'
require_relative '../lib/farmar_market'
require_relative '../lib/farmar_product'
require_relative '../lib/farmar_sale'

describe FarMar::Vendor do
  let (:all_vendors) {FarMar::Vendor.all}
  let (:first_vendor) {FarMar::Vendor.all.first}
  let (:fake_vendor) {FarMar::Vendor.new(id:888888, name:"fake vendor")}

  it "can create vendor objects from data in a csv file" do
    expect(all_vendors.class.must_equal(Array))
    expect(first_vendor.class).must_equal(FarMar::Vendor)
    expect(first_vendor.name).must_equal("Feil-Farrell")
    expect(first_vendor.num_employees).must_equal(8)
    expect(first_vendor.market_id).must_equal(1)
  end

  it "can find a particular market object by its id" do
    expect(FarMar::Vendor.find(3).name.must_equal("Breitenberg Inc"))
  end

  it "raises a runtime error if it cannot find the id" do
    expect(proc{FarMar::Vendor.find(888888).name}).must_raise(RuntimeError)
  end
  it "returns market associated with an instance of vendor" do
    expect(first_vendor.market.name).must_equal("People's Co-op Farmers Market")
  end

   it "raises an error if it can't find a market for  vendor" do
    #v=FarMar::Vendor.new(id:888888, name:"fake vendor")
    expect(proc{fake_vendor.market.name}).must_raise(RuntimeError)
  end

  it "returns products assoc. w/ an instance of vendor" do
    expect(first_vendor.products.first.name).must_equal("Dry Beets")
  end

  it "raises an error if no product for vendor" do
    #v=FarMar::Vendor.new(id:888888, name:"fake vendor")
    expect(proc{fake_vendor.products.first.name}).must_raise(RuntimeError)
  end

   it "returns sales associated with an instance of vendor" do
    expect(first_vendor.sales.first.amount).must_equal(9290)
  end

    it "returns nil if it can't find a sale for vendor" do
    #v=FarMar::Vendor.new(id:888888, name:"fake vendor")
    expect(fake_vendor.sales).must_equal(nil)
  end

  it "returns revenue (sum of sales) for a specific vendor" do
    expect(first_vendor.revenue).must_equal(38259)
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
    expect(top.first.name).must_equal("Swaniawski-Schmeler")
  end
end






