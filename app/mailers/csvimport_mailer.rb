class CsvimportMailer < ApplicationMailer
  def import_complete_email(error_messages)
    @error_messages = error_messages
    mail(to: 'nency@gmail.com', subject: 'New Promo')
  end
end
