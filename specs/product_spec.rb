require_relative 'spec_helper'
require_relative '../lib/farmar_product'

describe FarMar::Product do
  it "can create product objects from data in a csv file" do
    expect(FarMar::Product.all.class.must_equal(Array))
    expect(FarMar::Product.all.first.class).must_equal(FarMar::Product)
    expect(FarMar::Product.all.first.name).must_equal("Dry Beets")
    expect(FarMar::Product.all.first.vendor_id).must_equal(1)
  end

  # it "does not contain duplicates" do
  #   #FarMar::Vendor.add_vendors_from_csv('./support/vendors.csv')
  #   expect(FarMar::Product.all.length).must_equal(
  #     (FarMar::Product.csv_original_length('./support/products.csv')))
  # end

  it "can find a particular market object by its id" do
    expect(FarMar::Product.find(3).name.must_equal("Heavy Chicken"))
  end

  it "raises a runtime error if it cannot find the id" do
    expect(proc{FarMar::Product.find(888888).name}).must_raise(RuntimeError)
  end

  it "returns vendor associated with an instance of product" do
    expect(FarMar::Product.all.first.vendor.name).must_equal("Feil-Farrell")
  end

   it "raises an error if it can't find a vendor for product" do
    m=FarMar::Product.new(id:888888, name: "whatever")
    expect(proc{m.vendor.name}).must_raise(RuntimeError)
  end

  it "returns sales associated with an instance of product" do
    expect(FarMar::Product.all.first.sales.first.amount).must_equal(9290)
  end

  it "raises error if it can't find any sales for this product" do
    m=FarMar::Product.new(id:888888, name: "whatever")
    expect(proc{m.sales.first.amount}).must_raise(RuntimeError)
  end

  it "returns #of sales associated with an instance of product" do
    expect(FarMar::Product.all.first.number_of_sales).must_equal(7)
  end

   it "returns all products with a given vendor id" do
    expect(FarMar::Product.by_vendor(2).first.name).must_equal("Fierce Greens")
  end

  it "raises error if it can't any products for a given vendor" do
    expect(proc{FarMar::Product.by_vendor(88888).first.name}).must_raise(RuntimeError)
  end
end