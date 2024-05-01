require "rails_helper"

RSpec.describe Admin::UserPolicy, type: :policy do
  # include_examples "admin_base_policy", described_class, User

  let(:user) { build_stubbed(:user, role: :user) }
  let(:admin) { build_stubbed(:user, role: :admin) }

  permissions ".scope" do
    subject(:policy_scope) { described_class::Scope.new(current_user, User).resolve.to_sql }

    context "when admin" do
      let(:current_user) { admin }

      it { expect(policy_scope).to eq User.all.to_sql }
    end
  end

  context "when permissions" do
    subject(:policy_class) { described_class }

    permissions :index?, :show?, :new?, :edit?, :create?, :update?, :destroy? do
      it { expect(policy_class).to permit(admin, User) }
      it { expect(policy_class).not_to permit(user, User) }
    end
  end
end
