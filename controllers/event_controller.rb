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
  erb(:'events/index')
end

get '/event/:id/edit' do
  @event = Event.find(params[:id])
  erb(:'events/edit')
end

post '/event/:id' do
  @event = Event.update(params)
  redirect to("/event/#{params[:id]}")
end

post '/event/:id/delete' do 
  Event.destroy( params[:id] )
  redirect to('/event')
end