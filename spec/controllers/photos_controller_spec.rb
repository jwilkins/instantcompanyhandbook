require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe PhotosController do

  def mock_photo(stubs={})
    @mock_photo ||= mock_model(Photo, stubs).as_null_object
  end

  describe "with no authorisation" do

    describe "disallows GET index" do
      it "redirects to login" do
        get :index
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "disallows GET show" do
      it "redirects to login" do
        Photo.stub(:find).with("37") { mock_photo }
        get :show, :id => "37"
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "disallows GET new" do
      it "redirects to login" do
        Photo.stub(:new) { mock_photo }
        get :new
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "disallows POST create" do
      it "redirects to login" do
        Photo.stub(:new).with({'these' => 'params'}) { mock_photo(:save => true) }
        post :create, :photo => {'these' => 'params'}
        response.should redirect_to(new_user_session_path)
      end
    end
    # todo: finish
  end

  describe "after authorisation" do
    login_user

    describe "GET index" do
      it "assigns all photos as @photos" do
        Photo.stub(:all) { [mock_photo] }
        get :index
        assigns(:photos).should eq([mock_photo])
      end
    end

    describe "GET show" do
      it "assigns the requested photo as @photo" do
        Photo.stub(:find).with("37") { mock_photo }
        get :show, :id => "37"
        assigns(:photo).should be(mock_photo)
      end
    end

    describe "GET new" do
      it "assigns a new photo as @photo" do
        Photo.stub(:new) { mock_photo }
        get :new
        assigns(:photo).should be(mock_photo)
      end
    end

    describe "GET edit" do
      it "assigns the requested photo as @photo" do
        Photo.stub(:find).with("37") { mock_photo }
        get :edit, :id => "37"
        assigns(:photo).should be(mock_photo)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "assigns a newly created photo as @photo" do
          Photo.stub(:new).with({'these' => 'params'}) { mock_photo(:save => true) }
          post :create, :photo => {'these' => 'params'}
          assigns(:photo).should be(mock_photo)
        end

        it "redirects to the created photo" do
          Photo.stub(:new) { mock_photo(:save => true) }
          post :create, :photo => {}
          response.should redirect_to(photo_url(mock_photo))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved photo as @photo" do
          Photo.stub(:new).with({'these' => 'params'}) { mock_photo(:save => false) }
          post :create, :photo => {'these' => 'params'}
          assigns(:photo).should be(mock_photo)
        end

        it "re-renders the 'new' template" do
          Photo.stub(:new) { mock_photo(:save => false) }
          post :create, :photo => {}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested photo" do
          Photo.stub(:find).with("37") { mock_photo }
          mock_photo.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :photo => {'these' => 'params'}
        end

        it "assigns the requested photo as @photo" do
          Photo.stub(:find) { mock_photo(:update_attributes => true) }
          put :update, :id => "1"
          assigns(:photo).should be(mock_photo)
        end

        it "redirects to the photo" do
          Photo.stub(:find) { mock_photo(:update_attributes => true) }
          put :update, :id => "1"
          response.should redirect_to(photo_url(mock_photo))
        end
      end

      describe "with invalid params" do
        it "assigns the photo as @photo" do
          Photo.stub(:find) { mock_photo(:update_attributes => false) }
          put :update, :id => "1"
          assigns(:photo).should be(mock_photo)
        end

        it "re-renders the 'edit' template" do
          Photo.stub(:find) { mock_photo(:update_attributes => false) }
          put :update, :id => "1"
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested photo" do
        Photo.stub(:find).with("37") { mock_photo }
        mock_photo.should_receive(:destroy)
        delete :destroy, :id => "37"
      end

      it "redirects to the photos list" do
        Photo.stub(:find) { mock_photo }
        delete :destroy, :id => "1"
        response.should redirect_to(photos_url)
      end
    end
  end

end
