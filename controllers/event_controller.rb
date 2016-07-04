require('pry-byebug')
require_relative('../models/athlete')
require_relative('../models/nation')
require_relative('../models/event')
require_relative('../models/medal')

get '/event/new' do
  @nations = Event.all()
  erb(:'events/new')
end

get '/event/:id' do 
  @event=Event.find(params[:id])
  erb(:'events/show')
end

post '/event' do 
  @event=Event.new(params)
  #save to database
  @event.save()
  erb(:'events/create')
end

get '/event' do
  @events = Event.all()
  erb(:'athletes/index')
end

# get '/athlete/:id/edit' do
#   @athlete = Athlete.find(params[:id])
#   @nations = Nation.all()
#   erb(:'athletes/edit')
# end

# post '/athlete/:id' do
#   @athlete = Athlete.update(params)
#   redirect to("/athlete/#{params[:id]}")
# end

# post '/athlete/:id/delete' do 
#   Athlete.destroy( params[:id] )
#   redirect to('/athlete')
# end