require('pry-byebug')
require_relative('../db/sql_runner')
require_relative('athlete')
require_relative('medal')

class Nation

  attr_reader(:id,:name)

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO nations (name) VALUES ('#{@name}') RETURNING *"
    nation = run(sql).first
    result = Nation.new( nation )
    @id = result.id
    return result
  end

  def self.update(options)
    sql = "UPDATE athletes SET 
          name = '#{options['name']}',
          WHERE id = '#{options['id']}';"
    run(sql)
  end

  def self.destroy(id)
    sql="DELETE FROM nations WHERE id=#{id};"
    run(sql)
  end

  def athletes() #tested
    sql = "SELECT * FROM athletes WHERE nation_id = #{@id} ;"
    athletes_data = run(sql)
    return athletes_data.map {|athlete| Athlete.new(athlete)} 
  end

  def medals_won_by_nation()
    nation_medals=[]
    for athlete in self.athletes
      nation_medals << athlete.medals
    end
    return remove_duplicate_medals(nation_medals.flatten) 
  end

  def remove_duplicate_medals(nation_medals) 
    medals_won = nation_medals.uniq {|medal| medal.event_id}
    return medals_won
  end

  def gold_medals_won_by_nation()
    tot_medals=medals_won_by_nation
    return tot_medals.select {|medal| medal.medals_type == "gold"}
  end

  def silver_medals_won_by_nation()
    tot_medals=medals_won_by_nation
    return tot_medals.select {|medal| medal.medals_type == "silver"}
  end

  def bronze_medals_won_by_nation()
    tot_medals=medals_won_by_nation
    return tot_medals.select {|medal| medal.medals_type == "bronze"}
  end

  def tot_points_earned_by_nation()
    gold_medals = gold_medals_won_by_nation.count
    silver_medals = silver_medals_won_by_nation.count
    bronze_medals = bronze_medals_won_by_nation.count
    tot_points = (gold_medals * 5) + (silver_medals * 3) + (bronze_medals * 1)
    return tot_points
  end

  def self.ranking()
    nations_array = Nation.all
    rank_hash = Hash.new(0)
    for nation in nations_array
      rank_hash[nation.name] = nation.tot_points_earned_by_nation
    end
    rank_hash = rank_hash.sort_by {|_key, value| value}.reverse.to_h
    return rank_hash
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

