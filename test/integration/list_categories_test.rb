require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: 'Books')
    @category2 = Category.create(name: 'Programming')
  end

  test 'should show categories listing' do
    get categories_path
    assert_template 'categories/index'
    assert_select 'div', text: @category.name
    assert_select 'div', text: @category2.name
  end

  test 'should have a link to create new category' do
    get categories_path
    assert_select 'a[href=?]', new_category_path, text: 'New Category'
  end
end
