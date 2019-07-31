class UserController < ApplicationController

    get '/signup' do
        if Helpers.is_logged_in?(session)
            redirect to '/books'
        end
      erb :'/users/new'
    end

    post '/signup' do
        if Helpers.is_logged_in?(session)
            redirect to '/books'
        elsif params[:username] == "" || params[:password] == ""
            flash[:error] = "Username and password fields must be filled"
            redirect to '/signup'
        else
          @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
          session[:user_id] = @user.id
          redirect '/menu'
        end
    end

    get '/login' do
        if Helpers.is_logged_in?(session)
            redirect to '/menu'
        end
      erb :'/users/login'
    end

    post '/login' do
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
          session["user_id"] = @user.id
          redirect to "/menu"
        else
          flash[:error] = "Invalid username or password. Please Re-login"
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
        erb :'users/show'
      else
        flash[:error] = "Must be logged in to go to menu"
        redirect to '/login'
      end
    end
end
