require 'sinatra'
require './src/piratescrabble'

get '/' do
	'hello'
end

get '/make-from' do
	word = params[:word]

	content_type :json
	Tiles.instance.to_yaml
end

get '/can-become' do
	word = params[:word]
	content_type :json
end

get '/is-word' do
	word = params[:word]
	content_type :json
end
