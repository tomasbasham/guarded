class Post < ApplicationRecord
  # Associations
  belongs_to :user
  
	# Search scopes
  scope :published, -> { where(published: true) }

  # Scopes
  default_scope { order('created_at DESC') }

	# Validations
  validates :title, presence: true
	validates :body,  presence: true
end
