class UsersController < ApplicationController
  def show
    @user = User.find(session[:user_id])
    @books = @user.books
  end

  def edit
  end
end
