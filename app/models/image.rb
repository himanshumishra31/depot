class Image < ApplicationRecord

  belongs_to :product
  validates :content_type, inclusion: { in: Image_Validation }

end
