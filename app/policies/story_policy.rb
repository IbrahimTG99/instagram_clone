# frozen_string_literal: true

class StoryPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def new?
    create?
  end

  def destroy?
    user.present? && (record.user == user)
  end
end
