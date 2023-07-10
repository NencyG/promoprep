class PromoEmailJob < ApplicationJob
  queue_as :default

  def perform(promo)
    PromoMailer.send_promo_email(promo).deliver_now
  end
end
