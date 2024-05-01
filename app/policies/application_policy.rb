class ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.none
    end

    protected

    attr_reader :user, :scope

    def model
      scope.respond_to?(:model) ? scope.model : scope
    end
  end

  def initialize(user, record)
    @user = user
    @record = record
  end

  def permitted_attributes
    []
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  protected

  attr_reader :user, :record
end
