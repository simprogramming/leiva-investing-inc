module Web
  class SitesPolicy < ApplicationPolicy
    def home?
      true
    end
  end
end
