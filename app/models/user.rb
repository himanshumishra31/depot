class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness: true, format: { with: /[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}\z/ }
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
