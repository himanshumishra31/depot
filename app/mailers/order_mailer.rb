class OrderMailer < ApplicationMailer
  default from: 'Him <himanshumishra3@gmail.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #
  def received(order)
    @order = order
    @order.line_items.each do |line_item|
      attachments.inline[line_item.product.image_url] = File.read("#{ Rails.root.to_s }/app/assets/images/#{ line_item.product.image_url }")
      line_item.product.images.each do |image|
        attachments[image.name] = File.read("#{ Rails.root.to_s }/public/images/#{ image.name }")
      end
    end
    headers['X-SYSTEM-PROCESS-ID'] = Process.pid
    I18n.with_locale(@order.user.language) do
      mail to: order.email, subject: t('.subject')
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end
end
