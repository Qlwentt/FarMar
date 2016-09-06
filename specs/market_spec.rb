require_relative 'spec_helper'
require_relative '../lib/farmar_market'

describe FarMar::Market do
  it "can create market objects from data in a csv file" do
    FarMar::Market.add_markets_from_csv('./support/markets.csv')
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
    FarMar::Market.add_markets_from_csv('./support/markets.csv')
    expect(FarMar::Market.find(3).name.must_equal("Dolgeville Farmer's Market"))
  end

  it "raises a runtime error if it cannot find the id" do
    FarMar::Market.add_markets_from_csv('./support/markets.csv')
    expect(proc{FarMar::Market.find(888888).name}).must_raise(RuntimeError)
  end
  
  it "returns the vendors for an instance of market" do
    FarMar::Market.add_markets_from_csv('./support/markets.csv')
    FarMar::Vendor.add_vendors_from_csv('./support/vendors.csv')
    expect(FarMar::Market.all.first.vendors.first.name).must_equal("Feil-Farrell")
  end
end