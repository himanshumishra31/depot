class AdminController < ApplicationController
  # before_action :current_user, only: [:report]
  def index
    @total_orders = Order.count
  end

end
