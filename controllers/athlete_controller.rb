require('pry-byebug')
require_relative('../models/athlete')
require_relative('../models/nation')
require_relative('../models/event')
require_relative('../models/medal')

get '/athlete/new' do
  @nations = Nation.all()
  @events = Event.all()
  erb(:'athletes/new')
end

get '/athlete/:id' do 
  @athlete=Athlete.find(params[:id])
  erb(:'athletes/show')
end

post '/athlete' do 
  @athlete=Athlete.new(params)
  #save to database
  @athlete.save()
  medal_params=params 
  medal_params['athlete_id']=@athlete.id
  @medal = Medal.new(medal_params)
  @medal.save()
  erb(:'athletes/create')
end

get '/athlete' do
  @athletes = Athlete.all()
  erb(:'athletes/index')
end

get '/athlete/:id/edit' do
  @athlete = Athlete.find(params[:id])
  @nations = Nation.all()
  @events = Event.all()
  erb(:'athletes/edit')
end

post '/athlete/:id' do
  @athlete = Athlete.update(params)
  redirect to("/athlete/#{params[:id]}")
end

post '/athlete/:id/delete' do 
  Athlete.destroy( params[:id] )
  redirect to('/athlete')
end