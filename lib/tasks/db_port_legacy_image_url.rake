namespace :db do
  desc "Assign image url to previous products"
  task :port_legacy_image_url => :environment do
    Product.where(image_url: nil).each do |product|
      product.update_attribute :image_url, 'rails.png'
    end
  end
end
