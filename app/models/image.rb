class Image < ApplicationRecord
  belongs_to :product, dependent: :delete
  validates :content_type, inclusion: { in: %w(image/jpeg image/png image/gif) }

end
