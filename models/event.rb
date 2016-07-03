require('pry-byebug')
require_relative('../db/sql_runner')

class Event

  attr_reader(:id,:event_date,:discipline)

  def initialize(options)
    @id = options['id']
    @event_date = options['event_date']
    @discipline = options['discipline']
  end

  def save()
    sql = "INSERT INTO events (event_date, discipline) VALUES ( '#{@event_date}', '#{@discipline}') RETURNING *"
    event = run(sql).first
    result = Event.new( event )
    return result
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