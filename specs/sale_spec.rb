require_relative 'spec_helper'
require_relative '../lib/farmar_sale'

project="/Users/quaiwentt/Desktop/Ada/week5/FarMar"

describe FarMar::Sale do
  let (:all_sales) {FarMar::Sale.all}

  it "can create sale objects from data in a csv file" do
    expect(all_sales.class.must_equal(Array))
    expect(all_sales.first.class).must_equal(FarMar::Sale)
    expect(all_sales.first.amount).must_equal(9290)
    expect(all_sales.first.purchase_time.class).must_equal(DateTime)
    expect(all_sales.first.vendor_id).must_equal(1)
    expect(all_sales.first.product_id).must_equal(1)
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

  it "raises  error if it can't find a vendor for sale" do
    m=FarMar::Sale.new(id:888888, purchase_time: DateTime.now, amout: 9022)
    expect(proc{m.vendor.name}).must_raise(RuntimeError)
  end
   it "returns a product assoc. with an instance of sale" do
    expect(FarMar::Sale.all.first.product.name).must_equal("Dry Beets")
  end

  it "raises an error if it can't find a product for sale" do
    m=FarMar::Sale.new(id:888888, purchase_time: DateTime.now, amout: 9022)
    expect(proc{m.product.name}).must_raise(RuntimeError)
  end


  it "returns a sales made within a certain time period" do
    beg_time=DateTime.new(2013, 11, 7, 0, 0, 0, "+09:00")
    end_time=DateTime.new(2013, 11, 8, 24, 0, 0, "+09:00")
    expect( FarMar::Sale.between(beg_time,end_time).first.id).must_equal(1)
  end

   it "raises error if no sales within a certain time period" do
    beg_time=DateTime.new(2016, 11, 7, 0, 0, 0, "+09:00")
    end_time=DateTime.new(2016, 11, 8, 24, 0, 0, "+09:00")
    expect(
      proc{FarMar::Sale.between(beg_time,end_time).first.id}).must_raise(RuntimeError)
  end
end