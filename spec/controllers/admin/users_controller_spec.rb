require "rails_helper"

RSpec.describe Admin::UsersController do
  let(:user) { create(:user, :admin) }
  let(:other_user) { create(:user, :admin) }

  let(:valid_attributes) { attributes_for(:user).except(:role) }
  let(:invalid_attributes) { attributes_for(:user, first_name: nil) }

  before { sign_in user }

  describe "GET #index" do
    before { get :index, params: { sort_by: :first_name, sort_direction: :asc } }

    it { expect(response).to be_successful }
  end

  describe "GET #show" do
    before { get :show, params: { id: user.to_param } }

    it { expect(response).to be_successful }
  end

  describe "GET #edit" do
    before { get :edit, params: { id: user.to_param } }

    it { expect(response).to be_successful }
  end

  describe "PUT #update" do
    let(:attributes) { }
    let(:put!) { put :update, params: { id: user.to_param, user: attributes } }

    before { put! }

    context "with valid params" do
      context "with password" do
        let(:attributes) { valid_attributes.merge(first_name: "updated") }

        it "updates the requested user" do
          user.reload
          expect(user.first_name).to eq "updated"
        end

        it { expect(response).to redirect_to(admin_users_path) }
      end

      context "without password" do
        let(:attributes) { valid_attributes.merge(first_name: "updated").except(:password) }

        it "updates the requested user" do
          user.reload
          expect(user.first_name).to eq "updated"
        end

        it { expect(response).to redirect_to(admin_users_path) }
      end
    end

    context "with invalid params" do
      let(:attributes) { invalid_attributes }

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe "DELETE #destroy" do
    before { user }

    let(:delete!) { delete :destroy, params: { id: user.to_param } }

    it { expect { delete! }.to change(User, :count).by(-1) }

    context "when called" do
      before { delete! }

      it { expect(response).to redirect_to(admin_users_url) }
    end
  end
end
