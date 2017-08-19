require 'test_helper'

class PaymentsControllerTest < ActionController::TestCase
  setup do
    @payment = payments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment" do
    assert_difference('Payment.count') do
      post :create, payment: { amount: @payment.amount, bank_account_number: @payment.bank_account_number, bank_ifsc_code: @payment.bank_ifsc_code, merchant_transaction_ref: @payment.merchant_transaction_ref, payload_to_pg: @payment.payload_to_pg, payload_with_sha: @payment.payload_with_sha, payment_gateway_merchant_reference: @payment.payment_gateway_merchant_reference, transaction_date: @payment.transaction_date }
    end

    assert_redirected_to payment_path(assigns(:payment))
  end

  test "should show payment" do
    get :show, id: @payment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payment
    assert_response :success
  end

  test "should update payment" do
    patch :update, id: @payment, payment: { amount: @payment.amount, bank_account_number: @payment.bank_account_number, bank_ifsc_code: @payment.bank_ifsc_code, merchant_transaction_ref: @payment.merchant_transaction_ref, payload_to_pg: @payment.payload_to_pg, payload_with_sha: @payment.payload_with_sha, payment_gateway_merchant_reference: @payment.payment_gateway_merchant_reference, transaction_date: @payment.transaction_date }
    assert_redirected_to payment_path(assigns(:payment))
  end

  test "should destroy payment" do
    assert_difference('Payment.count', -1) do
      delete :destroy, id: @payment
    end

    assert_redirected_to payments_path
  end
end
