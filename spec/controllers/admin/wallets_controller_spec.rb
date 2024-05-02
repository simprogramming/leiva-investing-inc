require "rails_helper"

RSpec.describe Admin::WalletsController do
  let(:user) { create(:user, :admin) }
  let(:wallet) { create(:wallet) }

  let(:valid_attributes) { attributes_for(:wallet).merge(user_id: user.id) }
  let(:invalid_attributes) { attributes_for(:wallet, name: nil) }

  before { sign_in user }

  describe "GET #index" do
    before do
      wallet
      get :index, params: { sort_by: :name, sort_direction: :asc }
    end

    it { expect(response).to be_successful }
  end

  describe "GET #show" do
    before { get :show, params: { id: wallet.to_param } }

    it { expect(response).to be_successful }
  end

  describe "GET #edit" do
    before { get :edit, params: { id: wallet.to_param } }

    it { expect(response).to be_successful }
  end

  describe "GET #new" do
    before { get :new, params: { id: wallet.to_param } }

    it { expect(response).to be_successful }
  end

  describe "POST #create" do
    let(:attributes) { }
    let(:post!) { post :create, params: { wallet: attributes } }

    context "with valid params" do
      let(:attributes) { valid_attributes }

      it { expect { post! }.to change(Wallet, :count).by(1) }

      context "when called" do
        before { post! }

        it { expect(response).to redirect_to([:admin, Wallet.last]) }
      end
    end

    context "with invalid params" do
      let(:attributes) { invalid_attributes }

      before { post! }

      it { expect(response).to be_unprocessable }
    end
  end

  describe "PUT #update" do
    let(:attributes) { }
    let(:put!) { put :update, params: { id: wallet.to_param, wallet: attributes } }

    before { put! }

    context "with valid params" do
      let(:attributes) { valid_attributes.merge(name: "updated") }

      it "updates the requested wallet" do
        wallet.reload
        expect(wallet.name).to eq "updated"
      end

      it { expect(response).to redirect_to([:admin, wallet]) }
    end

    context "with invalid params" do
      let(:attributes) { invalid_attributes }

      it { expect(response).to be_unprocessable }
    end
  end

  describe "DELETE #destroy" do
    before { wallet }

    let(:delete!) { delete :destroy, params: { id: wallet.to_param } }

    it { expect { delete! }.to change(Wallet, :count).by(-1) }

    context "when called" do
      before { delete! }

      it { expect(response).to redirect_to(admin_wallets_url) }
    end
  end
end
