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
end