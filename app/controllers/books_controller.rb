class BooksController < ApplicationController
  def new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(current_user)

     #flash[:create] ="You have created book successfully!"
  end

  def index
     @book = Book.new
     @books = Book.all
     @user = User.find(session[:user_id])
  end

  def show
    @book = Book.find(params[:id])
  end

  def destroy
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
end
