require 'test_helper'

class Testing::AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @testing_account = testing_accounts(:one)
  end

  test "should get index" do
    get testing_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_testing_account_url
    assert_response :success
  end

  test "should create testing_account" do
    assert_difference('Testing::Account.count') do
      post testing_accounts_url, params: { testing_account: { name: @testing_account.name } }
    end

    assert_redirected_to testing_account_url(Testing::Account.last)
  end

  test "should show testing_account" do
    get testing_account_url(@testing_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_testing_account_url(@testing_account)
    assert_response :success
  end

  test "should update testing_account" do
    patch testing_account_url(@testing_account), params: { testing_account: { name: @testing_account.name } }
    assert_redirected_to testing_account_url(@testing_account)
  end

  test "should destroy testing_account" do
    assert_difference('Testing::Account.count', -1) do
      delete testing_account_url(@testing_account)
    end

    assert_redirected_to testing_accounts_url
  end
end
