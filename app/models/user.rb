class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true
  validates :email, uniqueness: true, format: { with: /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}\z/ }, allow_blank: true
  has_secure_password
  after_destroy :ensure_an_admin_remains
  after_commit :send_email
  before_destroy :ensure_user_is_not_admin
  before_update :ensure_user_is_not_admin

  class Error < StandardError
  end

  private

    def ensure_an_admin_remains
      if User.count.zero?
        raise Error.new "Can't delete last user"
      end
    end

    def ensure_user_is_not_admin
      # throw :abort if email == 'admin@depot.com'
      raise Error.new "User can't be deleted or modified" if email == 'admin@depot.com'
    end

    def send_email
      UserMailer.created(self)
    end
end
