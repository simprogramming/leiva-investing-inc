require "rails_helper"

RSpec.describe Admin::StocksController do
  let(:user) { create(:user, :admin) }
  let(:stock) { create(:stock) }

  let(:valid_attributes) { attributes_for(:stock) }
  let(:invalid_attributes) { attributes_for(:stock, name: nil) }

  before { sign_in user }

  describe "GET #index" do
    before do
      stock
      get :index, params: { sort_by: :name, sort_direction: :asc }
    end

    it { expect(response).to be_successful }
  end

  describe "GET #show" do
    before { get :show, params: { id: stock.to_param } }

    it { expect(response).to be_successful }
  end

  describe "GET #edit" do
    before { get :edit, params: { id: stock.to_param } }

    it { expect(response).to be_successful }
  end

  describe "GET #new" do
    before { get :new, params: { id: stock.to_param } }

    it { expect(response).to be_successful }
  end

  describe "POST #create" do
    let(:attributes) { }
    let(:post!) { post :create, params: { stock: attributes } }

    context "with valid params" do
      let(:attributes) { valid_attributes }

      it { expect { post! }.to change(Stock, :count).by(1) }

      context "when called" do
        before { post! }

        it { expect(response).to redirect_to([:admin, Stock.last]) }
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
    let(:put!) { put :update, params: { id: stock.to_param, stock: attributes } }

    before { put! }

    context "with valid params" do
      let(:attributes) { valid_attributes.merge(name: "updated") }

      it "updates the requested stock" do
        stock.reload
        expect(stock.name).to eq "updated"
      end

      it { expect(response).to redirect_to([:admin, stock]) }
    end

    context "with invalid params" do
      let(:attributes) { invalid_attributes }

      it { expect(response).to be_unprocessable }
    end
  end

  describe "DELETE #destroy" do
    before { stock }

    let(:delete!) { delete :destroy, params: { id: stock.to_param } }

    it { expect { delete! }.to change(Stock, :count).by(-1) }

    context "when called" do
      before { delete! }

      it { expect(response).to redirect_to(admin_stocks_url) }
    end
  end
end
