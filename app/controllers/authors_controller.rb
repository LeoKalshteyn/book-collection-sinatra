class AuthorsController < ApplicationController

  get '/authors' do
    "List of Authors"
  end

  get '/authors/new' do
    if !logged_in?
      redirect "/login"
    else
      "New Author form"
    end
  end

  get '/authors/:id/edit' do
    if !logged_in?
      redirect "/login"
    else
      if author = current_user.authors.find(params[:id])
      "Edit Author form #{current_user.id} is editing #{author.id}"
    else
      redirect '/authors'
    end
  end
end

end
