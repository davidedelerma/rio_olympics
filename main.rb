require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative('controllers/athlete_controller')
require_relative('controllers/event_controller')
require_relative('controllers/medal_controller')
require_relative('controllers/nation_controller')


get '/' do
  erb :home
end