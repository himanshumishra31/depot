namespace :db do
  desc "Assign Category id to previous products"
  task :port_legacy_products => :environment do
    Product.where(category_id: nil).each do |product|
      product.update_attribute :category_id, 4
    end
  end
end
