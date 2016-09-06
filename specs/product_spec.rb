require_relative 'spec_helper'
require_relative '../lib/farmar_product'
#work-around because
#'../support/markets.csv' is not working
#ask about this
project="/Users/quaiwentt/Desktop/Ada/week5/FarMar"

describe FarMar::Product do
  it "can create product objects from data in a csv file" do
    FarMar::Product.add_products_from_csv(project+'/support/products.csv')
    expect(FarMar::Product.all.class.must_equal(Array))
    expect(FarMar::Product.all.first.class).must_equal(FarMar::Product)
    expect(FarMar::Product.all.first.name).must_equal("Dry Beets")
    expect(FarMar::Product.all.first.vendor_id).must_equal(1)
  end

  it "can find a particular market object by its id" do
    FarMar::Product.add_products_from_csv(project+'/support/products.csv')
    expect(FarMar::Product.find(3).name.must_equal("Heavy Chicken"))
  end

  it "raises a runtime error if it cannot find the id" do
    FarMar::Product.add_products_from_csv(project+'/support/products.csv')
    expect(proc{FarMar::Product.find(888888).name}).must_raise(RuntimeError)
  end
end