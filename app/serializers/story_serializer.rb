class StorySerializer < ActiveModel::Serializer
  attributes :id, :caption, :created_at, :user_id
end
