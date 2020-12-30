class ApplicationPolicy
  attr_reader :user, :record
  attr_accessor :error_message

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    if user.is_admin?
      return true
    else
      @error_message = "Test"
      return false
    end
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

  def bulk_create?
    if user.is_admin?
      return true
    else
      @error_message = "Test"
      return false
    end
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
