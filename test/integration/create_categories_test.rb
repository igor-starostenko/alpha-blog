require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: 'admin', email: 'admin@test.com', password: 'password', admin: true)
  end

  test 'get new category form and create category' do
    sign_in_as(@user.email, 'password')
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: 'Sports' } }
      follow_redirect!
    end
    assert_template 'categories/index'
    assert_match 'Sports', response.body
  end

  test 'submit invalid category and get error message' do
    sign_in_as(@user.email, 'password')
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: ' ' } }
    end
    assert_template 'categories/new'
    assert_select '.panel-danger'
    assert_select 'div.panel-body li'
  end
end
