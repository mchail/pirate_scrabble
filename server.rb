require 'sinatra'
require 'json'
require './src/piratescrabble'

get '/' do
	erb :index
end

get '/make-from' do
	word = params[:word]

	content_type :json
	suggestions = MakeFrom.new(word).suggestions.first(10)
	{
		suggestions: suggestions.map(&:as_json)
	}.to_json
end

get '/can-become' do
	word = params[:word]

	content_type :json
	CanBecome.new(word).suggestions
end

get '/is-word' do
	word = params[:word]

	content_type :json
	{
		isWord: IsWord.new(word)
	}
end
