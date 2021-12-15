require 'test_helper'

class B2B7AvisoCreditosControllerTest < ActionController::TestCase
  setup do
    @b2_b7_aviso_credito = b2_b7_aviso_credito(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:b2_b7_aviso_credito)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create b2_b7_aviso_credito" do
    assert_difference('B2B7AvisoCredito.count') do
      post :create, b2_b7_aviso_credito: @b2_b7_aviso_credito.attributes
    end

    assert_redirected_to b2_b7_aviso_credito_path(assigns(:b2_b7_aviso_credito))
  end

  test "should show b2_b7_aviso_credito" do
    get :show, id: @b2_b7_aviso_credito.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @b2_b7_aviso_credito.to_param
    assert_response :success
  end

  test "should update b2_b7_aviso_credito" do
    put :update, id: @b2_b7_aviso_credito.to_param, b2_b7_aviso_credito: @b2_b7_aviso_credito.attributes
    assert_redirected_to b2_b7_aviso_credito_path(assigns(:b2_b7_aviso_credito))
  end

  test "should destroy b2_b7_aviso_credito" do
    assert_difference('B2B7AvisoCredito.count', -1) do
      delete :destroy, id: @b2_b7_aviso_credito.to_param
    end

    assert_redirected_to b2_b7_aviso_creditos_path
  end
end
