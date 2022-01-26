class UsersController < ApplicationController
  before_action :current_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user.id)
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
    @book_new = Book.new

  end
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def book_params
    params.permit(:title, :body, :user_id)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
