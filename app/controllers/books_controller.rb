class BookController < ApplicationController

# get method requests data from specific resource to show
# post method sends data to server to update or create resource
# erb renders

  get '/books' do
    if Helpers.is_logged_in?(session)
      @books = Book.all
      erb :'/books/books'
    else
      flash[:error] = 'Must be logged in'
      redirect to '/users/login'
    end
  end

  get '/books/new' do
    user = Helpers.current_user(session)
    if user.nil?
      flash[:error] = 'Must be logged in to add books'
      redirect to '/login'
    else
      erb :'books/new'
    end
  end

  post '/book' do
    user = Helpers.current_user(session)
    if user.nil?
      redirect to '/login'
    elsif params[:book][:book_title].empty?
      flash[:error] = 'Book title field must be filled'
      redirect to '/books/new'
    else
      @book = Book.create(params['book'])
      @book[:user_id] = user.id
      @book.save
    end

    redirect to "/books/#{@book.id}"
  end

  get '/books/:id' do
    if Helpers.is_logged_in?(session)
      @book = Book.find(params[:id])
      @users = User.all
      erb :'/books/show'
    else
      redirect to '/login'
    end
  end

  get '/books/:id/edit' do
        redirect_if_not_logged_in
        # find = Retrieve a book single record from database by id/key
        @book = Book.find(params[:id])
        redirect '/menu' unless @book.user == Helpers.current_user(session)
        erb :'/books/edit'
    end


# modifies book id. Redirects to edit if params empty
  patch '/books/:id' do
      @book = Book.find(params[:id])
    if @book.user == Helpers.current_user(session)
      redirect to "/books/#{@book.id}/edit" if params[:book][:book_title].empty?
      @book.update(params[:book])
      @book.save
      redirect to "/books/#{@book.id}"
    else
      redirect to '/menu'
    end
  end

# deletes book
  delete '/books/:id/delete' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    elsif @book = Book.find_by(id: params[:id])
      @book.delete if @book.user == Helpers.current_user(session)
      redirect to '/menu'
    end
  end

  get '/view_all' do
      redirect_if_not_logged_in
      @books = Book.all
      erb :'books/book_index'
    end

  helpers do
    def redirect_if_not_logged_in
      if !Helpers.is_logged_in?(session)
        flash[:error] = 'Must be logged in to view all books'
        redirect to '/login'
      end
    end
  end

end
