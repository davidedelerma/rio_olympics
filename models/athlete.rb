require('pry-byebug')
require_relative('../db/sql_runner')
require_relative('medal')
require_relative('event')
require_relative('nation')

class Athlete

  attr_reader(:id,:name,:last_name,:nation_id)

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @last_name = options['last_name']
    @nation_id = options['nation_id'].to_i
  end


  def save()
    sql = "INSERT INTO athletes (name, last_name, nation_id) VALUES ('#{@name}', '#{@last_name}', '#{@nation_id}') RETURNING *"
    athlete = run(sql).first
    result = Athlete.new( athlete )
    @id = result.id
    return result
  end

  def nation() #tested
    sql = "SELECT * FROM nations WHERE id = #{nation_id};"
    nations_data = run(sql)
    return nation = Nation.new(nations_data.first)
  end

  def events_attended()
    sql="SELECT events.* FROM events INNER JOIN medals ON event_id = events.id WHERE athlete_id = #{@id};"
    return Event.map_items(sql)
  end

  def medals()
    sql="SELECT * FROM medals WHERE athlete_id = #{@id} AND medals_type != 'no';"
    return Medal.map_items(sql) 
  end

  def medal_types_won_by_athlete()
    medals_list=self.medals
    return medals_list.map{|medal| medal.medals_type}
  end

  def self.find(id) #tested
    sql="SELECT * FROM athletes WHERE id = #{id}"
    return Athlete.map_item(sql)
  end

  def self.all() #tested
    sql = "SELECT * FROM athletes"
    return Athlete.map_items(sql)
  end

  def self.delete_all() #tested
    sql = "DELETE FROM athletes"
    run(sql)
  end

  def self.update(options)
    sql = "UPDATE athletes SET 
          name = '#{options['name']}',
          last_name = '#{options['last_name']}',
          nation_id = '#{options['nation_id']}'
          WHERE id = '#{options['id']}';"
    run(sql)
  end

  def self.destroy(id)
    sql="DELETE FROM athletes WHERE id=#{id};"
    run(sql)
  end

  def self.map_items(sql) #tested
    athletes = run(sql)
    result = athletes.map { |athlete| Athlete.new( athlete ) }
    return result
  end

  def self.map_item(sql) #tested
    result = map_items(sql)
    return result.first
  end

end