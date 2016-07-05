require('pry-byebug')
require_relative('../models/athlete')
require_relative('../models/medal')
require_relative('../models/event')
require_relative('../models/nation')

get '/medal/new' do 
  @athlete=Athlete.find(params["athlete_id"])
  @events = Event.all()
  #binding.pry
  erb(:'medals/new')
end

post '/medal' do 
  #@event=Event.new(params)
  #save to database
  @medal.save()
  erb(:'medals/create')
end


