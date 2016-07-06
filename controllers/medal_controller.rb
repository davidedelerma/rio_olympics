require('pry-byebug')
require_relative('../models/athlete')
require_relative('../models/medal')
require_relative('../models/event')
require_relative('../models/nation')

get '/medal/new' do
  @athlete=Athlete.find(params["athlete_id"])
  @events = Event.all()
  erb(:'medals/new')
end

post '/medal' do 
  @medal=Medal.new(params)
  @saved=@medal.save()
  erb(:'medals/create')
end


