module UsersHelper
  def can_edit_profile?(profile_id)
    user_signed_in? && current_user.id == profile_id
  end

  delegate :following?, to: :current_user
end
