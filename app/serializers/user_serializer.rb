class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :followers
end
