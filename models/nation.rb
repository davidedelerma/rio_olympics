require('pry-byebug')
require_relative('../db/sql_runner')
require_relative('athlete')

class Nation

  attr_reader(:id,:name)

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @medal_points={'gold' => 5, 'silver' => 3, 'bronze' =>1}
  end

  def save()
    sql = "INSERT INTO nations (name) VALUES ('#{@name}') RETURNING *"
    nation = run(sql).first
    result = Nation.new( nation )
    return result
  end

  def athletes() #tested
    sql = "SELECT * FROM athletes WHERE nation_id = #{@id} ;"
    athletes_data = run(sql)
    return athletes_data.map {|athlete| Athlete.new(athlete)} 
  end

  def points_earned_by_athlete(athlete)
    medals_earned = athlete.medals
    medals_array = medals_earned.map{|medal| medal.medals_type}
    athlete_points = []
    for medal in medals_array
      athlete_points << @medal_points[medal]
    end
    return athlete_points
  end

  def self.find(id) #tested
    sql="SELECT * FROM nations WHERE id = #{id}"
    return Nation.map_item(sql)
  end

  def self.all() #tested
    sql = "SELECT * FROM nations"
    return Nation.map_items(sql)
  end

  def self.delete_all() #tested
    sql = "DELETE FROM nations"
    run(sql)
  end

  def self.map_items(sql) #tested
    nations = run(sql)
    result = nations.map { |nation| Nation.new( nation ) }
    return result
  end

  def self.map_item(sql) #tested
    result = map_items(sql)
    return result.first
  end

end

