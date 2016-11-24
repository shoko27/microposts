class UsersController < ApplicationController
  #before_action :set_user , only: [:show,:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  
  def show
     @user = User.find(params[:id])
     @microposts = @user.microposts.order(created_at: :desc).page(params[:page]).per(5)    
  end  

  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
     @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user) , notice: 'プロフィールを編集しました'
    else
      render 'edit'
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @users = @user.following_users
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.follower_users
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,:profile,
                                 :password_confirmation)
  end
  def set_user
    @user = User.find(params[:id])
  end
  
  def correct_user
    @user = User.find(params[:id])
    if current_user != @user
        redirect_to root_url
    end
  end
end
