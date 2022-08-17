# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    user.present? && (record.user == user)
  end

  def destroy?
    user.present? && (record.user == user || record.post.user == user)
  end
end
