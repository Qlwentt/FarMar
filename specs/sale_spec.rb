require_relative 'spec_helper'
require_relative '../lib/farmar_sale'
require 'Time'

project="/Users/quaiwentt/Desktop/Ada/week5/FarMar"

describe FarMar::Sale do
  it "can create sale objects from data in a csv file" do
    expect(FarMar::Sale.all.class.must_equal(Array))
    expect(FarMar::Sale.all.first.class).must_equal(FarMar::Sale)
    expect(FarMar::Sale.all.first.amount).must_equal(9290)
    expect(FarMar::Sale.all.first.purchase_time.class).must_equal(DateTime)
    expect(FarMar::Sale.all.first.vendor_id).must_equal(1)
    expect(FarMar::Sale.all.first.product_id).must_equal(1)
  end                                                       

  it "can find a particular market object by its id" do
    expect(FarMar::Sale.find(3).amount.must_equal(9588))
  end

  it "raises a runtime error if it cannot find the id" do
    expect(proc{FarMar::Sale.find(888888).amount}).must_raise(RuntimeError)
  end

  it "returns a vendor assoc. with an instance of sale" do
    expect(FarMar::Sale.all.first.vendor.name).must_equal("Feil-Farrell")
  end

   it "returns a product assoc. with an instance of sale" do
    expect(FarMar::Sale.all.first.product.name).must_equal("Dry Beets")
  end

  it "returns a sales made within a certain time period" do
    beg_time=DateTime.new(2013, 11, 7, 0, 0, 0, "+09:00")
    end_time=DateTime.new(2013, 11, 8, 24, 0, 0, "+09:00")
    expect(FarMar::Sale.between(beg_time,end_time)).first.first.id.must_equal(1)
  end
end