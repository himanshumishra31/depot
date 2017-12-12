namespace :db do
  desc "Assign Category id to previous products"
  task :port_legacy_products => :environment do
    Product.where(category_id: nil).each do |product|
      product.update :category, Category.find_by(title: 'men')
    end
  end
end
