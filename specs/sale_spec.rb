require_relative 'spec_helper'
require_relative '../lib/farmar_sale'
require 'Time'
#work-around because
#'../support/markets.csv' is not working
#ask about this
project="/Users/quaiwentt/Desktop/Ada/week5/FarMar"

describe FarMar::Sale do
  it "can create sale objects from data in a csv file" do
    FarMar::Sale.add_sales_from_csv(project+'/support/sales.csv')
    expect(FarMar::Sale.all.class.must_equal(Array))
    expect(FarMar::Sale.all.first.class).must_equal(FarMar::Sale)
    expect(FarMar::Sale.all.first.amount).must_equal(9290)
    expect(FarMar::Sale.all.first.purchase_time.class).must_equal(DateTime)
    expect(FarMar::Sale.all.first.vendor_id).must_equal(1)
    expect(FarMar::Sale.all.first.product_id).must_equal(1)
  end                                                       

  it "can find a particular market object by its id" do
    FarMar::Sale.add_sales_from_csv(project+'/support/sales.csv')
    expect(FarMar::Sale.find(3).amount.must_equal(9588))
  end

  it "raises a runtime error if it cannot find the id" do
    FarMar::Sale.add_sales_from_csv(project+'/support/sales.csv')
    expect(proc{FarMar::Sale.find(888888).amount}).must_raise(RuntimeError)
  end
end