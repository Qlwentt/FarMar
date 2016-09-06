require_relative 'spec_helper'
require_relative '../lib/farmar_market'
#work-around because
#'../support/markets.csv' is not working
#ask about this
project="/Users/quaiwentt/Desktop/Ada/week5/FarMar"

describe FarMar::Market do
  it "can create market objects from data in a csv file" do
   FarMar::Market.add_markets_from_csv(project+'/support/markets.csv')
   expect(FarMar::Market.all.class.must_equal(Array))
   expect(FarMar::Market.all.first.class).must_equal(FarMar::Market)
   expect(FarMar::Market.all.first.name).must_equal("People's Co-op Farmers Market")
  end

  it "can find a particular market object by its id" do
   FarMar::Market.add_markets_from_csv(project+'/support/markets.csv')
   expect(FarMar::Market.find(3).name.must_equal("Dolgeville Farmer's Market"))
  end

  it "raises a runtime error if it cannot find the id" do
  	FarMar::Market.add_markets_from_csv(project+'/support/markets.csv')
  	expect(proc{FarMar::Market.find(888888).name}).must_raise(RuntimeError)
  end
end