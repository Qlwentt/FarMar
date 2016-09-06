require_relative 'spec_helper'
require_relative '../lib/farmar_vendor'


describe FarMar::Vendor do
  it "can create vendor objects from data in a csv file" do
    FarMar::Vendor.add_vendors_from_csv('./support/vendors.csv')
    expect(FarMar::Vendor.all.class.must_equal(Array))
    expect(FarMar::Vendor.all.first.class).must_equal(FarMar::Vendor)
    expect(FarMar::Vendor.all.first.name).must_equal("Feil-Farrell")
    expect(FarMar::Vendor.all.first.num_employees).must_equal(8)
    expect(FarMar::Vendor.all.first.market_id).must_equal(1)
  end

  it "can find a particular market object by its id" do
    FarMar::Vendor.add_vendors_from_csv('./support/vendors.csv')
    expect(FarMar::Vendor.find(3).name.must_equal("Breitenberg Inc"))
  end

  it "raises a runtime error if it cannot find the id" do
    FarMar::Vendor.add_vendors_from_csv('./support/vendors.csv')
    expect(proc{FarMar::Vendor.find(888888).name}).must_raise(RuntimeError)
  end
end