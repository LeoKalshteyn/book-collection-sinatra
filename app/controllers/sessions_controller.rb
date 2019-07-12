class SessionsController < ApplicationController

  get '/login' do
    erb :"sessions/login.html"
  end

  post '/sessions' do
    login(params[:email], params[:password])
    redirect '/authors'
  end

  get '/logout' do
    logout!
    redirect '/authors'
  end
end
