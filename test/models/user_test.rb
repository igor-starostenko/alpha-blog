require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: 'test_user',
                     email: 'test@email.com',
                     password: 'password')
  end

  test 'user should be valid' do
    assert @user.valid?
  end

  test 'user\'s username should be present' do
    @user.username = '     '
    assert_not @user.valid?
  end

  test 'user\'s username should be unique' do
    @user.save
    user = User.new(username: 'Test_User',
                    email: 'test2@email.com',
                    password: 'password2')
    assert_not user.valid?
  end

  test 'user\'s username should not be too short' do
    @user.username = 'sh'
    assert_not @user.valid?
  end

  test 'user\'s username should not be too long' do
    @user.username = 'l' * 21
    assert_not @user.valid?
  end

  test 'user\'s email should be present' do
    @user.username = nil
    assert_not @user.valid?
  end

  test 'user\'s email should be unique' do
    @user.save
    user = User.new(username: 'test_user2',
                    email: 'test@email.com',
                    password: 'password2')
    assert_not user.valid?
  end

  test 'user\'s email should not be too long' do
    @user.email = 'a' * 96 + '@email.com'
    assert_not @user.valid?
  end

  test 'user\'s email should conatin "@" sign' do
    @user.email = 'test_email.com'
    assert_not @user.valid?
  end

  test 'user\'s email should have local part' do
    @user.email = '@email.com'
    assert_not @user.valid?
  end

  test 'user\'s email should have domain name' do
    @user.email = 'test@.com'
    assert_not @user.valid?
  end

  test 'user\'s email domain should match the format' do
    @user.email = 'test@email'
    assert_not @user.valid?
  end

  test 'user\'s email should be changed to lowercase' do
    @user.email = 'TEST@EMAIL.COM'
    @user.save
    assert User.last.email == 'test@email.com'
  end

  test 'user\'s password should be present' do
    @user.password = nil
    assert_not @user.valid?
  end

end
