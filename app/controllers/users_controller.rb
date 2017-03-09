class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :show]
  before_action :require_admin, only: [:index, :destroy]

  def index
    # Executes before_action :require_admin
    # @users = User.all
    @users = User.paginate(page: params[:page], per_page: 8)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Your account has been successfully created!'
      redirect_to user_path(current_user.id)
    else
      # render plain: params[:user].inspect
      render 'new'
    end
  end

  def edit
    # Executes before_action :set_user
  end

  def update
    # Executes before_action :set_user
    if @user.update(user_params)
      flash[:success] = 'User\'s profile was successfully updated!'
      redirect_to articles_path
    else
      # render plain: params[:user].inspect
      render 'edit'
    end
  end

  def show
    # Executes before_action :set_user
    # Executes before_action :require_same_user
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    # Executes before_action :set_user
    # Executes before_action :require_same_user
    @user.destroy
    flash[:danger] = 'User and all articles created by the user have been deleted!'
    redirect_to users_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    return if current_user == @user
    require_admin
  end
end
