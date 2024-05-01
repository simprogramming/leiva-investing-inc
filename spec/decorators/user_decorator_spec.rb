require "rails_helper"

RSpec.describe UserDecorator do
  describe "#full_name" do
    let(:user) { build_stubbed(:user, first_name: "John", last_name: "Doe") }
    let(:decorated_user) { user.decorate }

    it "returns the full name of the user" do
      expect(decorated_user.full_name).to eq "John Doe"
    end
  end
end
