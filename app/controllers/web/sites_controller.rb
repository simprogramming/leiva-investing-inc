module Web
  class SitesController < ApplicationController
    before_action { authorize :sites }

    def home
      skip_policy_scope
      @stocks = Stock.order(:position)
    end
  end
end
