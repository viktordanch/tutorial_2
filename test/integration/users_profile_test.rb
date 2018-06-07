require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
    @other_usr = users(:archer)
  end

  test 'profile display' do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body # contains the full HTML source of the page
    assert_select 'div.pagination', count: 1
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end

  test 'profile display follow_form if logged in' do
    get user_path(@other_usr)
    assert_select 'div#follow_form', count: 0
    log_in_as(@user)
    get user_path(@other_usr)
    assert_select 'div#follow_form', count: 1
    @user.follow(@other_usr)
    assert_select 'div#follow_form', count: 1
  end
end
