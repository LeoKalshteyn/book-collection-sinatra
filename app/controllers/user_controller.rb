class UserController < ApplicationController

  get '/signup' do
    redirect to '/books' if Helpers.is_logged_in?(session)
    erb :'/users/new'
  end

  post '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/books'
    elsif params[:username] == '' || params[:password] == '' || params[:email] == ''
      flash[:error] = 'Username, email and password fields must be filled'
      redirect to '/signup'
      # find_by = Retrieve first record of username attribute. Returns nil if not in DB
    elsif User.find_by(username: params[:username])
      flash[:error] = 'Username taken, please choose another'
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      session[:user_id] = @user.id
      redirect '/menu'
    end
  end

  get '/login' do
    redirect to '/menu' if Helpers.is_logged_in?(session)
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    # authenticate method which checks if password matches up with the value in password_digest
    # takes string and turns it into salted hashed version and compraes it with the user's version
    if @user && @user.authenticate(params[:password])
      session['user_id'] = @user.id
      redirect to '/menu'
    else
      flash[:error] = 'Invalid username or password. Please Re-login'
      redirect to '/login'
    end
  end

  post '/logout' do
    if Helpers.is_logged_in?(session)
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/menu' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @books = Book.all
    #  @books = Helpers.current_user(session).books
      erb :'users/show'
    else
      flash[:error] = 'Must be logged in to go to menu'
      redirect to '/login'
    end
  end
end
