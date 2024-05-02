require "rails_helper"

RSpec.describe Admin::PositionsController do
  let(:user) { create(:user, :admin) }
  let(:position) { create(:position) }
  let(:wallet) { create(:wallet) }
  let(:stock) { create(:stock) }

  let(:valid_attributes) { attributes_for(:position).merge(wallet_id: wallet.id, stock_id: stock.id) }
  let(:invalid_attributes) { attributes_for(:position, entry: nil) }

  before { sign_in user }

  describe "GET #index" do
    before do
      position
      get :index, params: { sort_by: :name, sort_direction: :asc }
    end

    it { expect(response).to be_successful }
  end

  describe "GET #show" do
    before { get :show, params: { id: position.to_param } }

    it { expect(response).to be_successful }
  end

  describe "GET #edit" do
    before { get :edit, params: { id: position.to_param } }

    it { expect(response).to be_successful }
  end

  describe "GET #new" do
    before { get :new, params: { id: position.to_param } }

    it { expect(response).to be_successful }
  end

  describe "POST #create" do
    let(:attributes) { }
    let(:post!) { post :create, params: { position: attributes } }

    context "with valid params" do
      let(:attributes) { valid_attributes }

      it { expect { post! }.to change(Position, :count).by(1) }

      context "when called" do
        before { post! }

        it { expect(response).to redirect_to([:admin, Position.last]) }
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
    let(:put!) { put :update, params: { id: position.to_param, position: attributes } }

    before { put! }

    context "with valid params" do
      let(:attributes) { valid_attributes.merge(size: 5) }

      it "updates the requested position" do
        position.reload
        expect(position.size).to eq 5
      end

      it { expect(response).to redirect_to([:admin, position]) }
    end

    context "with invalid params" do
      let(:attributes) { invalid_attributes }

      it { expect(response).to be_unprocessable }
    end
  end

  describe "DELETE #destroy" do
    before { position }

    let(:delete!) { delete :destroy, params: { id: position.to_param } }

    it { expect { delete! }.to change(Position, :count).by(-1) }

    context "when called" do
      before { delete! }

      it { expect(response).to redirect_to(admin_positions_url) }
    end
  end
end
