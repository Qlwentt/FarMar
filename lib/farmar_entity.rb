require_relative '../far-mar'

class FarMar::Entity
	OBJECT_TYPE="entity"
  CSV_PATH=""
	HEADERS=[:id]

	def self.all
		entities=[]
    # puts "I'm a #{self}"
    # raise puts "csvpath = #{self::CSV_PATH}"

 		CSV.foreach(self::CSV_PATH) do |row|
  			entity_hash={}
  			self::HEADERS.each_with_index do |header,index|
  				entity_hash[header]=row[index]
  			end
  			entities<< self.new(entity_hash)
  		end
  		return entities
	end
end