require_relative './gossip.rb'

class ApplicationController < Sinatra::Base

  not_found do
    'This page does not exist.'
  end

  error do
    'Sorry, an error occurred - ' + env['sinatra.error'].message
  end

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    gossip = Gossip.new(params["author"], params["content"])
    gossip.save
    redirect '/'
  end

  get '/gossips/:id' do
    gossip = Gossip.find(params["id"])
    erb :"show"
  end


end
