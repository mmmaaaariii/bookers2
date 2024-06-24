class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
    @user = current_user
    @users = User.all
  end

  def show
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path  
  end
  
    private

    def user_params
      params.require(:user).permit(:name, :introduction, :image)
    end
    
    def is_matching_login_user
      user = User.find(params[:id])
      unless user.id == current_user.id
        redirect_to top_path
      end
    end
end