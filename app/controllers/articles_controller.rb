class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :delete]

  def index
    @articles = Article.order(id: :desc).paginate(page: params[:page], per_page: 8)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      flash[:success] = 'Article was successfully created!'
      redirect_to article_path(@article)
    else
      # render plain: params[:article].inspect
      render 'new'
    end
  end

  def show
    # Executes before_action :set_article
  end

  def edit
    # Executes before_action :set_article
  end

  def update
    # Executes before_action :set_article
    if @article.update(article_params)
      flash[:success] = 'Article was successfully updated!'
      redirect_to article_path(@article)
    else
      # render plain: params[:article].inspect
      render 'edit'
    end
  end

  def destroy
    # Executes before_action :set_article
    @article.destroy
    flash[:danger] = 'Article was successfully deleted!'
    redirect_to articles_path
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    return if current_user == @article.user
    not_authorized
  end
end
