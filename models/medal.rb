require('pry-byebug')
require_relative('../db/sql_runner')
require_relative('event')
require_relative('athlete')

class Medal

  attr_reader(:id,:event_id,:athlete_id,:medals_type)

  def initialize(options)
    @id = options['id'].to_i
    @event_id = options['event_id'].to_i
    @athlete_id = options['athlete_id'].to_i
    @medals_type = options['medals_type']
  end

  def save()
    #return if check_if_nation_has_won_medal == true
    sql = "INSERT INTO medals (event_id, athlete_id, medals_type) VALUES ( '#{@event_id}', '#{@athlete_id}','#{medals_type}') RETURNING *"
    medal = run(sql).first
    result = Medal.new( medal )
    @id = result.id
    return result
  end

  def event()
    sql = "SELECT * FROM events WHERE id = #{@event_id}"
    return Event.map_item(sql)
  end

  def self.update(options)
    sql = "UPDATE medals SET 
          event_id = '#{options['event_id']}',
          athlete_id = '#{options['athlete_id']}',
          medals_type = '#{options['medals_type']}'
          WHERE id = '#{options['id']}';"
    run(sql)
  end

  def check_if_nation_has_won_medal()
    all_medals=Medal.all
    athlete1=Athlete.find(@athlete_id)
    for medal in all_medals
      athlete2=Athlete.find(medal.athlete_id)
      return true if (medal.medals_type == @medals_type && athlete1.nation_id != athlete2.nation_id)
    end
    return false
  end

  def self.destroy(id)
    sql="DELETE FROM medals WHERE id=#{id};"
    run(sql)
  end

  def self.find(id) #tested
    sql="SELECT * FROM medals WHERE id = #{id}"
    return Medal.map_item(sql)
  end

  def self.all() #tested
    sql = "SELECT * FROM medals"
    return Medal.map_items(sql)
  end

  def self.delete_all() #tested
    sql = "DELETE FROM medals"
    run(sql)
  end

  def self.map_items(sql) #tested
    medals = run(sql)
    result = medals.map { |medal| Medal.new( medal ) }
    return result
  end

  def self.map_item(sql) #tested
    result = map_items(sql)
    return result.first
  end
end
