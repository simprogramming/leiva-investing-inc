module Admin
  class PositionPolicy < ApplicationPolicy
    include AdminBasePolicy

    def permitted_attributes
      %i[wallet_id stock_id size entry]
    end
  end
end
