class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true
  validates :email, uniqueness: true, format: { with: /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}\z/ }, allow_blank: true
  has_secure_password
  after_destroy :ensure_an_admin_remains
  after_create :send_welcome_email
  before_destroy :ensure_user_is_not_admin
  before_update :ensure_user_is_not_admin
  has_many :orders
  has_many :line_items, through: :orders
  has_one :address
  accepts_nested_attributes_for :address

  class Error < StandardError
  end

  private

    def ensure_an_admin_remains
      raise Error.new "Can't delete last user" if User.count.zero?
    end

    def ensure_user_is_not_admin
      if role == 'admin'
        errors.add(:email, 'cannot update admin')
        throw :abort
      end
    end

    def send_welcome_email
      UserMailer.created(self)
    end
end
