require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe HandbooksController do
  include Devise::TestHelpers

  def mock_handbook(stubs={})
    @mock_handbook ||= mock_model(Handbook, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all handbooks as @handbooks" do
      Handbook.stub(:all) { [mock_handbook] }
      get :index
      assigns(:handbooks).should eq([mock_handbook])
    end
  end

  describe "GET show" do
    it "assigns the requested handbook as @handbook" do
      Handbook.stub(:find).with("37") { mock_handbook }
      get :show, :id => "37"
      assigns(:handbook).should be(mock_handbook)
    end
  end

  describe "GET new" do
    it "assigns a new handbook as @handbook" do
      Handbook.stub(:new) { mock_handbook }
      get :new
      assigns(:handbook).should be(mock_handbook)
    end
  end

  describe "GET edit" do
    it "assigns the requested handbook as @handbook" do
      Handbook.stub(:find).with("37") { mock_handbook }
      get :edit, :id => "37"
      assigns(:handbook).should be(mock_handbook)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created handbook as @handbook" do
        Handbook.stub(:new).with({'these' => 'params'}) { mock_handbook(:save => true) }
        post :create, :handbook => {'these' => 'params'}
        assigns(:handbook).should be(mock_handbook)
      end

      it "redirects to the created handbook" do
        Handbook.stub(:new) { mock_handbook(:save => true) }
        post :create, :handbook => {}
        response.should redirect_to(handbook_url(mock_handbook))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved handbook as @handbook" do
        Handbook.stub(:new).with({'these' => 'params'}) { mock_handbook(:save => false) }
        post :create, :handbook => {'these' => 'params'}
        assigns(:handbook).should be(mock_handbook)
      end

      it "re-renders the 'new' template" do
        Handbook.stub(:new) { mock_handbook(:save => false) }
        post :create, :handbook => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested handbook" do
        Handbook.stub(:find).with("37") { mock_handbook }
        mock_handbook.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :handbook => {'these' => 'params'}
      end

      it "assigns the requested handbook as @handbook" do
        Handbook.stub(:find) { mock_handbook(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:handbook).should be(mock_handbook)
      end

      it "redirects to the handbook" do
        Handbook.stub(:find) { mock_handbook(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(handbook_url(mock_handbook))
      end
    end

    describe "with invalid params" do
      it "assigns the handbook as @handbook" do
        Handbook.stub(:find) { mock_handbook(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:handbook).should be(mock_handbook)
      end

      it "re-renders the 'edit' template" do
        Handbook.stub(:find) { mock_handbook(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested handbook" do
      Handbook.stub(:find).with("37") { mock_handbook }
      mock_handbook.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the handbooks list" do
      Handbook.stub(:find) { mock_handbook }
      delete :destroy, :id => "1"
      response.should redirect_to(handbooks_url)
    end
  end

end
