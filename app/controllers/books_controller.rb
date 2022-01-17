class BooksController < ApplicationController
  before_action :current_user, only: [:edit, :update]
  def new
    @book = Book.new
  end

   def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
    render book_path(@book_new.id)
    else
      @user = current_user
　　　@books = @user.books
    render "books/index"
    end
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

  def edit
    @book = Book.find(params[:id])
   if @book.user == current_user
     render :edit
   else
     redirect_to books_path
   end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    render :edit
    else
    redirect_to
    end
    flash[:update] ="You have updated book successfully!"
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
    flash[:sestroy] ="You have deleted book successfully!"
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

end