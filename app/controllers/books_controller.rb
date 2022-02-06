class BooksController < ApplicationController
  before_action :current_user, only: [:edit, :update]

   def create
    @user = current_user
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
     redirect_to book_path(@book_new.id)
    else
       @books = Book.all
       render:index
    end
    flash[:create] ="You have created book successfully!"
   end

  def index
     @book_new = Book.new
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
    @user = User.find(current_user.id)
   unless  @book.user == current_user
     redirect_to books_path
   end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id)
    else
    render :edit
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