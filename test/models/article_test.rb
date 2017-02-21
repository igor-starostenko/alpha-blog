require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  def setup
    @user = User.create(username: 'test_user',
                     email: 'test@email.com',
                     password: 'password')
    @user_id = User.all.last.id
    @article = Article.new(title: 'Title',
                           description: 'Test Description',
                           user_id: @user_id)
  end

  test 'article should be valid' do
    assert @article.valid?
  end

  test 'article\'s title should be present' do
    @article.title = nil
    assert_not @article.valid?
  end

  test 'article\'s name should not be too long' do
    @article.title = 'a' * 51
    assert_not @article.valid?
  end

  test 'article\'s name should not be too short' do
    @article.title = 'aa'
    assert_not @article.valid?
  end

  test 'article\'s description should be present' do
    @article.description = nil
    assert_not @article.valid?
  end

  test 'article\'s description should not be too long' do
    @article.description = 'a' * 301
    assert_not @article.valid?
  end

  test 'article\'s description should not be too short' do
    @article.description = 'a' * 9
    assert_not @article.valid?
  end

  test 'article should have user_id' do
    @article.user_id = nil
    assert_not @article.valid?
  end

  test 'article\'s user_id should be an integer' do
    @article.user_id = 'four'
    assert_not @article.valid?
  end

  test 'article\'s user_id should match a user' do
    @article.user_id = User.all.map(&:id).sort.last + 1
    assert_not @article.valid?
  end

end
