class UsersController < ApplicationController
  before_action :set_task, only: [:show]
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @tasks = Task.all.page(params[:page]).per(3)
  end
  
  def show
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to :root
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
