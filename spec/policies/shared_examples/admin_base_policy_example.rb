RSpec.shared_examples "admin_base_policy" do |policy_class, model_class|
  subject { policy_class }

  let(:admin) { build_stubbed(:user, role: :admin) }
  let(:user) { build_stubbed(:user, role: :user) }

  permissions ".scope" do
    subject { policy_class::Scope.new(current_user, model_class).resolve.to_sql }

    context "when admin" do
      let(:current_user) { admin }

      it { expect(subject).to eq model_class.all.to_sql }
    end

    context "when user" do
      let(:current_user) { user }

      it {
        query = if model_class.reflect_on_association(:user).present?
          model_class.where(user: current_user).to_sql
        elsif model_class == User
          model_class.where(id: current_user).to_sql
        else
          model_class.none.to_sql
        end
        expect(subject).to eq query
      }
    end

    context "when unauthenticated" do
      let(:current_user) { nil }

      it { expect(subject).to eq model_class.none.to_sql }
    end
  end

  permissions :index?, :show?, :new?, :edit?, :create?, :update?, :destroy? do
    it { expect(subject).to permit(admin, model_class) }
  end
end
