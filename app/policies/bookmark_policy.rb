class BookmarkPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    user.owner_of? record
  end

  def update?
    user.owner_of? record
  end

  def edit?
    user.owner_of? record
  end

  def destroy?
    user.owner_of? record
  end

  def permitted_attributes
    [:tags, :title, :notes]
  end
end
