class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def index
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
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
