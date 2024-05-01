require "rails_helper"

RSpec.describe Admin::AdminController do
  let(:user) { create(:user, :admin) }

  before { sign_in user }

  describe "GET #admin" do
    before do
      get :admin, params: {}
    end

    it { expect(response).to be_successful }
  end
end
