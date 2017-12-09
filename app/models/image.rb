class Image < ApplicationRecord
  belongs_to :product
  validates :content_type, inclusion: { in: %w(image/jpeg image/png image/gif) }

end
