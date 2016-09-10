require_relative '../far-mar'

class FarMar::Entity
	OBJECT_TYPE="entity"
  CSV_PATH=""
	HEADERS=[:id]

	def self.all
		entities=[]
 		CSV.foreach(self::CSV_PATH) do |row|
  			entity_hash={}
  			self::HEADERS.each_with_index do |header,index|
  				entity_hash[header]=row[index]
  			end
  			entities<< self.new(entity_hash)
  		end
  		return entities
	end

  def self.find(id)
    self.all.each do |entity|
      return entity if entity.id==id
    end
    raise "#{self::OBJECT_TYPE} id not found"
  end

end