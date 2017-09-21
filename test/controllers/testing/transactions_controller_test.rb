require 'test_helper'

class Testing::TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @testing_transaction = testing_transactions(:one)
  end

  test "should get index" do
    get testing_transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_testing_transaction_url
    assert_response :success
  end

  test "should create testing_transaction" do
    assert_difference('Testing::Transaction.count') do
      post testing_transactions_url, params: { testing_transaction: { name: @testing_transaction.name, testing_account_id: @testing_transaction.testing_account_id } }
    end

    assert_redirected_to testing_transaction_url(Testing::Transaction.last)
  end

  test "should show testing_transaction" do
    get testing_transaction_url(@testing_transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_testing_transaction_url(@testing_transaction)
    assert_response :success
  end

  test "should update testing_transaction" do
    patch testing_transaction_url(@testing_transaction), params: { testing_transaction: { name: @testing_transaction.name, testing_account_id: @testing_transaction.testing_account_id } }
    assert_redirected_to testing_transaction_url(@testing_transaction)
  end

  test "should destroy testing_transaction" do
    assert_difference('Testing::Transaction.count', -1) do
      delete testing_transaction_url(@testing_transaction)
    end

    assert_redirected_to testing_transactions_url
  end
end
