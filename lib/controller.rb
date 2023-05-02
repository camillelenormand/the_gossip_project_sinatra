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
    gossip = Gossip.new(params['author'], params['content'])
    gossip.save
    redirect '/'
  end

  get '/gossips/:id' do
    erb :show,  locals: {gossip: Gossip.find(params['id'])}
  end

  get '/gossips/:id/edit' do
    erb :edit, locals: {gossip: Gossip.edit(params['id'], params['content'])}
  end

  post '/gossips/:id/edit' do
    gossip = Gossip.edit(params['id'], params['content'])
    redirect '/'
  end

end
