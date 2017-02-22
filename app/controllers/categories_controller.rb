class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'New category has been successfully created!'
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def show
    # Executes before_action :set_category
  end

  def edit
    # Executes before_action :set_category
  end

  def update
    # Executes before_action :set_category
    if @category.update(category_params)
      flash[:success] = 'Article was successfully updated!'
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    # Executes before_action :set_category
    @category.destroy
    flash[:danger] = 'Category has been successfully deleted!'
    redirect_to categories_path
  end

  private
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
