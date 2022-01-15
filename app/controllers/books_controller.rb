class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    book = Book.new(book_params)
    book.save
    redirect_to book_path(book.id)
    flash[:create] ="You have created book successfully!"
  end

  def index
     @book = Book.new
     @books = Book.all
     @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id)
    flash[:update] ="You have updated book successfully!"
  end

  def destroy
    flash[:sestroy] ="You have deleted book successfully!"
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
end
