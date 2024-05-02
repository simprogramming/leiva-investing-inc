module Admin
  class WalletPolicy < ApplicationPolicy
    include AdminBasePolicy

    def permitted_attributes
      %i[user_id name]
    end
  end
end
