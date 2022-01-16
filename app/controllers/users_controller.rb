class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
     render :edit
    else
     redirect_to user_path
    end
  end

  def update
   @user = User.find(params[:id])
   if @user.update(user_params)
   redirect_to user_path(@user.id)
   else
    render :edit
   end
   flash[:user_update] ="You have updated user successfully!"
  end

  def index
    @users = User.all
    @user = User.find(current_user.id)

  end
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def book_params
    params.permit(:title, :body, :user_id)
  end
end
