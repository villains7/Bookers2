class BooksController < ApplicationController
  def new
    @book = Book.new
  end

   def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book.id)
    else
      @user = current_user
　　　@books = @user.books
    render :index
    end
    flash[:create] ="You have created book successfully!"
   end

  def index
     @book = Book.new
     @books = Book.all
     @user = User.find(current_user.id)
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
     redirect_to book_path
   end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id)
    else
    render :index
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