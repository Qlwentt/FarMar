require_relative 'spec_helper'
require_relative '../lib/farmar_market'

describe FarMar::Market do
  let(:all_markets) {FarMar::Market.all}

  it "can create market objects from data in a csv file" do
    expect(all_markets.class.must_equal(Array))
    expect(all_markets.first.class).must_equal(FarMar::Market)
    expect(all_markets.first.name).must_equal("People's Co-op Farmers Market")
    expect(all_markets.first.address).must_equal("30th and Burnside")
    expect(all_markets.first.city).must_equal("Portland")
    expect(all_markets.first.county).must_equal("Multnomah")
    expect(all_markets.first.state).must_equal("Oregon")
    expect(all_markets.first.zip).must_equal("97202")
  end

  it "can find a particular market object by its id" do
    expect(FarMar::Market.find(3).name.must_equal("Dolgeville Farmer's Market"))
  end

  it "raises a runtime error if it cannot find the id" do
    expect(proc{FarMar::Market.find(888888).name}).must_raise(RuntimeError)
  end
  
  it "returns the vendors for an instance of market" do
    expect(all_markets.first.vendors.first.name).must_equal("Feil-Farrell")
  end

  it "raises an error if it can't find a vendor for market" do
    m=FarMar::Market.new(id:888888, name:"fake market")
    expect(proc{m.vendors.first.name}).must_raise(RuntimeError)
  end

  it "returns the products assc. with market through vendor" do
    expect(all_markets.first.products.length).must_equal(13)
    expect(all_markets.first.products.first.name).must_equal("Dry Beets")
  end

  it "returns markets where market/vendor name matches term" do
    search=FarMar::Market.search("School")
    expect(search.length).must_equal(3)
    expect(search.first.name).must_equal("Fox School Farmers Market")
  end

  it "returns vendor with highest revenue" do
    expect(all_markets.first.prefered_vendor.name).must_equal("Reynolds, Schmitt and Klocko")
  end

  it "returns vendor with highest revenue on a date" do
    a_date=DateTime.new(2013, 11, 7, 0, 0, 0, "+09:00")
    expect(all_markets.first.prefered_vendor(a_date).name).must_equal("Feil-Farrell")
  end

  it "returns vendor with lowest revenue" do
    expect(all_markets.first.worst_vendor.name).must_equal("Zulauf and Sons")
  end

  it "returns vendor with lowest revenue on a date" do
    a_date=DateTime.new(2013, 11, 8, 0, 0, 0, "+09:00")
    expect(all_markets.first.worst_vendor(a_date).name).must_equal("Feil-Farrell")
  end

end