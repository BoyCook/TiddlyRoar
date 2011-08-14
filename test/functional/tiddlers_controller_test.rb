require 'test_helper'

class TiddlersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tiddlers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tiddler" do
    assert_difference('Tiddler.count') do
      post :create, :tiddler => { }
    end

    assert_redirected_to tiddler_path(assigns(:tiddler))
  end

  test "should show tiddler" do
    get :show, :id => tiddlers(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tiddlers(:one).id
    assert_response :success
  end

  test "should update tiddler" do
    put :update, :id => tiddlers(:one).id, :tiddler => { }
    assert_redirected_to tiddler_path(assigns(:tiddler))
  end

  test "should destroy tiddler" do
    assert_difference('Tiddler.count', -1) do
      delete :destroy, :id => tiddlers(:one).id
    end

    assert_redirected_to tiddlers_path
  end
end
