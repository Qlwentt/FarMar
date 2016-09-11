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

  def get_single_related_object(wanted_object_type)
  #for example wanted_object_type=FarMar::Market
    linking_id="@"+ wanted_object_type::OBJECT_TYPE+"_id" # ex. => "@market_id"
    wanted_object_type.all.each do |wanted_object|
      return wanted_object if wanted_object.id== self.instance_variable_get(linking_id)
    end
    raise "no #{wanted_object_type::OBJECT_TYPE} for #{self.class::OBJECT_TYPE} id: #{id}"
  end

  #want to add get_multiple_related_objects
  def get_multiple_related_objects(wanted_objects_type,related_object_type=self.class)
    wanted_objects=[]
    linking_id="@"+ related_object_type::OBJECT_TYPE+"_id" # ex. => "@market_id"

    if wanted_objects_type == FarMar::Sale
      all_objects=FarMar::Sale::ALL_SALES
    else
      all_objects=wanted_objects_type.all
    end

    all_objects.each do |wanted_object|
      wanted_objects << wanted_object if wanted_object.instance_variable_get(linking_id)==self.id
    end
    
    if wanted_objects.length!=0
      return wanted_objects
    else
      return nil if wanted_objects_type==FarMar::Sale 
      raise "no #{wanted_objects_type::OBJECT_TYPE}s for #{self.class::OBJECT_TYPE} id: #{self.id}"
    end
  end
end


