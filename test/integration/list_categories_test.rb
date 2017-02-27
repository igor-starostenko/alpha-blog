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

  test 'should show "Edit" link next to a category' do
    get categories_path
    assert_select 'a[href=?]', edit_category_path(@category.id), text: 'Edit'
    assert_select 'a[href=?]', edit_category_path(@category2.id), text: 'Edit'
  end

  test 'should show "Delete" link next to a category' do
    get categories_path
    assert_select 'a[href=?]', category_path(@category.id), text: 'Delete', method: :delete
    assert_select 'a[href=?]', category_path(@category2.id), text: 'Delete', method: :delete
  end

  test 'should have a link to create new category' do
    get categories_path
    assert_select 'a[href=?]', new_category_path, text: 'New Category'
  end
end
