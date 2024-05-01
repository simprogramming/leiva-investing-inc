module Admin
  class StockPolicy < ApplicationPolicy
    include AdminBasePolicy

    # :nocov:
    def update_prices?
      user.admin?
    end
    # :nocov:

    def permitted_attributes
      %i[name symbol price status dividend yield distribution position api_symbol]
    end
  end
end
