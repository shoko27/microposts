class UsersController < ApplicationController
  before_action :set_user , only: [:show,:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  
  def index
    @user = User.new
    # Messageを全て取得する。
    @messages = Users.all
  end
  def show
     @microposts = @user.microposts.order(created_at: :desc)
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
  end
  
  def update
    if @user.update(user_params)
      
      redirect_to root_path , notice: 'プロフィールを編集しました'
    else
      render 'edit'
    end
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
    if current_user != @user
        redirect_to root_url
    end
  end
end
