module Admin
  class AdminController < ApplicationController
    before_action { authorize :admin }

    def admin
      skip_policy_scope
    end
  end
end
