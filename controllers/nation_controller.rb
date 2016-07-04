require('pry-byebug')
require_relative('../models/athlete')
require_relative('../models/nation')
require_relative('../models/event')

get '/nation/new' do
  erb(:'nations/new')
end

get '/nation/:id' do 
  @nation = Nation.find(params[:id])
  erb(:'nations/show')
end

post '/nation' do 
  @nation=Nation.new(params)
  #save to database
  @nation.save()
  erb(:'nations/create')
end

get '/nation' do
  @nations = Nation.all()
  erb(:'nations/index')
end

#### DON'T NEED TO UPDATE NATIONS
# get '/athlete/:id/edit' do
#   @athlete = Athlete.find(params[:id])
#   @nations = Nation.all()
#   erb(:'athletes/edit')
# end

# post '/nation/:id' do
#   @athlete = Athlete.update(params)
#   redirect to("/athlete/#{params[:id]}")
# end
##################################

post '/nation/:id/delete' do 
  Nation.destroy( params[:id] )
  redirect to('/nation')
end