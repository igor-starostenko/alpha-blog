require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  def setup
    @category = Category.create(name: 'sports')
    @user = User.create(username: 'admin', email: 'admin@test.com', password: 'password', admin: true)
  end

  test 'should get categories index' do
    session[:user_id] = @user.id
    get :index
    assert_response :success
  end

  test 'should get categories new' do
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end

  test 'should not authorize new category unless admin' do
    assert_no_difference 'Category.count' do
      post :create, params: { category: { name: 'test_non_amdin' } }
    end
    assert_response :redirect
    assert_redirected_to root_path
  end

  test 'should not show new category form unless admin' do
    get :new
    assert_response :redirect
    assert_redirected_to root_path
  end
end
