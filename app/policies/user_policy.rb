# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def update?
    user.present? && (record == user)
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && (record.user == user)
  end
end
