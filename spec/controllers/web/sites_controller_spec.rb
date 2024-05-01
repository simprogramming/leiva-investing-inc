require "rails_helper"

RSpec.describe Web::SitesController do
  describe "GET #home" do
    before do
      get :home, params: {}
    end

    it { expect(response).to be_successful }
  end
end
