require 'test_helper'

class Finances::AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @finances_account = finances_accounts(:one)
  end

  test "should get index" do
    get finances_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_finances_account_url
    assert_response :success
  end

  test "should create finances_account" do
    assert_difference('Finances::Account.count') do
      post finances_accounts_url, params: { finances_account: { name: @finances_account.name, opening_balance: @finances_account.opening_balance, user_id: @finances_account.user_id } }
    end

    assert_redirected_to finances_account_url(Finances::Account.last)
  end

  test "should show finances_account" do
    get finances_account_url(@finances_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_finances_account_url(@finances_account)
    assert_response :success
  end

  test "should update finances_account" do
    patch finances_account_url(@finances_account), params: { finances_account: { name: @finances_account.name, opening_balance: @finances_account.opening_balance, user_id: @finances_account.user_id } }
    assert_redirected_to finances_account_url(@finances_account)
  end

  test "should destroy finances_account" do
    assert_difference('Finances::Account.count', -1) do
      delete finances_account_url(@finances_account)
    end

    assert_redirected_to finances_accounts_url
  end
end
