require('pry-byebug')
require_relative('../models/athlete.rb')
require_relative('../models/event.rb')
require_relative('../models/medal.rb')
require_relative('../models/nation.rb')

Nation.delete_all()
Athlete.delete_all()
Event.delete_all()
Medal.delete_all()


nation1 = Nation.new({'name' => 'Croatia'}).save
nation2 = Nation.new({'name' => 'Italia'}).save
nation3 = Nation.new({'name' => 'UK'}).save

athlete1=Athlete.new({'name' => 'Roberto', 'last_name' => 'Baggio', 'nation_id' => nation2.id}).save
athlete3=Athlete.new({'name' => 'Toto', 'last_name' => 'Schillaci', 'nation_id' => nation2.id}).save
athlete4=Athlete.new({'name' => 'David', 'last_name' => 'Beckam', 'nation_id' => nation3.id}).save
athlete2=Athlete.new({'name' => 'Andy', 'last_name' => 'Murray', 'nation_id' => nation3.id}).save

event1=Event.new({'event_date' => '2016-12-12','discipline' =>'football'}).save
event2=Event.new({'event_date' => '2016-11-12','discipline' =>'tennis'}).save
event3=Event.new({'event_date' => '2016-10-12','discipline' =>'run'}).save
event4=Event.new({'event_date' => '2016-10-12','discipline' =>'swimming'}).save

medal1=Medal.new({'event_id' => event1.id,'athlete_id' => athlete1.id, 'medals_type' =>'gold'}).save
# medal2=Medal.new({'event_id' => event2.id,'athlete_id' => athlete2.id, 'medals_type' =>'silver'}).save
# medal3=Medal.new({'event_id' => event3.id,'athlete_id' => athlete1.id, 'medals_type' =>'silver'}).save
# medal4=Medal.new({'event_id' => event4.id,'athlete_id' => athlete1.id, 'medals_type' =>'no'}).save
# medal5=Medal.new({'event_id' => event1.id,'athlete_id' => athlete3.id, 'medals_type' =>'gold'}).save
# medal6=Medal.new({'event_id' => event1.id,'athlete_id' => athlete4.id, 'medals_type' =>'silver'}).save
# medal7=Medal.new({'event_id' => event1.id,'athlete_id' => athlete2.id, 'medals_type' =>'gold'}).save


binding.pry
nil