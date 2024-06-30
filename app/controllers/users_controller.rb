class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @user = current_user
    @book = Book.new
    @users = User.all

  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
    @use_now = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to user_path
    else
      render :edit
    end
  end

    private

    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end

    def is_matching_login_user
      user = User.find(params[:id])
      unless user.id == current_user.id
        redirect_to users_path
      end
    end
end