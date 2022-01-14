class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    book = Book.new(book_params)
    book.save
    redirect_to  book_path
  #@book = Book.new(book_params)
  # @book.user_id = current_user.id
  #@book.save
  #redirect_to
      #flash[:create] ="You have created book successfully!"
  end

  def index
     @book = Book.new
     @books = Book.all
     @user = current_user
  end

  def show
  end
  
  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id)  
  end

  def destroy
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
end
