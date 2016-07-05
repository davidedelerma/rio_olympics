require('pry-byebug')
require_relative('../db/sql_runner')
require_relative('nation')
require_relative('athlete')
require_relative('medal')

class Event

  attr_reader(:id,:event_date,:discipline)

  def initialize(options)
    @id = options['id'].to_i
    @event_date = options['event_date']
    @discipline = options['discipline']
  end

  def save()
    sql = "INSERT INTO events (event_date, discipline) VALUES ( '#{@event_date}', '#{@discipline}') RETURNING *"
    event = run(sql).first
    result = Event.new( event )
    @id = result.id
    return result
  end

  def self.update(options)
    sql = "UPDATE events SET 
          event_date = '#{options['event_date']}'
          WHERE id = '#{options['id']}';"
    run(sql)
  end

  def self.destroy(id)
    sql="DELETE FROM events WHERE id=#{id};"
    run(sql)
  end

  def medalist()
    sql="SELECT * FROM medals WHERE event_id = #{@id} AND medals_type != 'no';"
    medalists = Medal.map_items(sql) 
    return remove_duplicate_medalist(medalists)
  end

  def remove_duplicate_medalist(medalist_list)
    medalist_list = medalist_list.uniq {|medalist| medalist.medals_type}
    return medalist_list
  end

  def nation_won_gold_medal()
    tot_medalists=medalist()
    gold = tot_medalists.select {|medal| medal.medals_type == "gold"}
    return if gold == []
    athlete_gold = Athlete.find(gold.first.athlete_id)
    nation_gold = Nation.find(athlete_gold.nation_id)
    return nation_gold
  end

  def nation_won_silver_medal()
    tot_medalists=medalist()
    silver = tot_medalists.select {|medal| medal.medals_type == "silver"}
    return if silver == []
    athlete_silver = Athlete.find(silver.first.athlete_id)
    nation_silver = Nation.find(athlete_silver.nation_id)
    return nation_silver
  end

  def nation_won_bronze_medal()
    tot_medalists=medalist()
    bronze = tot_medalists.select {|medal| medal.medals_type == "bronze"}
    return if bronze == []
    athlete_bronze = Athlete.find(bronze.first.athlete_id)
    nation_bronze = Nation.find(athlete_bronze.nation_id)
    return nation_bronze
  end

  def self.find(id) #tested
    sql="SELECT * FROM events WHERE id = #{id}"
    return Event.map_item(sql)
  end

  def self.all() #tested
    sql = "SELECT * FROM events"
    return Event.map_items(sql)
  end

  def self.delete_all() #tested
    sql = "DELETE FROM events"
    run(sql)
  end

  def self.map_items(sql) #tested
    events = run(sql)
    result = events.map { |event| Event.new( event ) }
    return result
  end

  def self.map_item(sql) #tested
    result = map_items(sql)
    return result.first
  end

end