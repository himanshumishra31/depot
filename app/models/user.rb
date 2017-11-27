class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true
  validates :email, uniqueness: true, format: { with: /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}\z/ }, allow_blank: true
  has_secure_password
  after_destroy :ensure_an_admin_remains

  class Error < StandardError
  end

  private

    def ensure_an_admin_remains
      if User.count.zero?
        raise Error.new "Can't delete last user"
      end
    end
end
