module Admin
  class ApplicationController < ::ApplicationController
    include NoticeHelper

    layout "admin/layouts/application"

    before_action :authenticate_user!

    after_action :verify_policy_scoped, except: %i[new create] # rubocop:disable Rails/LexicallyScopedActionFilter
  end
end
