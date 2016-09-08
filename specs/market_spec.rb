require_relative 'spec_helper'
require_relative '../lib/farmar_market'

describe FarMar::Market do
  it "can create market objects from data in a csv file" do
    expect(FarMar::Market.all.class.must_equal(Array))
    expect(FarMar::Market.all.first.class).must_equal(FarMar::Market)
    expect(FarMar::Market.all.first.name).must_equal("People's Co-op Farmers Market")
    expect(FarMar::Market.all.first.address).must_equal("30th and Burnside")
    expect(FarMar::Market.all.first.city).must_equal("Portland")
    expect(FarMar::Market.all.first.county).must_equal("Multnomah")
    expect(FarMar::Market.all.first.state).must_equal("Oregon")
    expect(FarMar::Market.all.first.zip).must_equal("97202")
  end

  it "can find a particular market object by its id" do
    expect(FarMar::Market.find(3).name.must_equal("Dolgeville Farmer's Market"))
  end

  it "raises a runtime error if it cannot find the id" do
    expect(proc{FarMar::Market.find(888888).name}).must_raise(RuntimeError)
  end
  
  it "returns the vendors for an instance of market" do
    expect(FarMar::Market.all.first.vendors.first.name).must_equal("Feil-Farrell")
  end

  it "raises an error if it can't find a vendor for market" do
    m=FarMar::Market.new(id:888888, name:"fake market")
    expect(proc{m.vendors.first.name}).must_raise(RuntimeError)
  end

  it "returns the products assc. with market through vendor" do
    expect(FarMar::Market.all.first.products.length).must_equal(13)
    expect(FarMar::Market.all.first.products.first.name).must_equal("Dry Beets")
  end

  it "returns markets where market/vendor name matches term" do
    search=FarMar::Market.search("School")
    expect(search.length).must_equal(3)
    expect(search.first.name).must_equal("Fox School Farmers Market")
  end
end