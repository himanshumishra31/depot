namespace :db do
  desc "Assign discount price to products"
  task :port_discount_price => :environment do
    Product.where(discount_price: nil).each do |product|
      product.update_attribute :discount_price, 40
    end
  end
end
