module UsersHelper
  delegate :following?, to: :current_user
  delegate :pending?, to: :current_user
end
