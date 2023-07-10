class PromoMailer < ApplicationMailer
  def send_promo_email(promo)
    @promo = promo
    mail(to: mail, subject: 'New Promo')
  end
end
