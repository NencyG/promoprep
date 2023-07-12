class CsvImportPromosService
  require 'csv'

  def call(file)
    @error_messages = Hash.new { |hash, key| hash[key] = [] }

    file = File.open(file)
    csv = CSV.parse(file, headers: true, col_sep: ';')

    csv.each do |row|
      promo_hash = {}
      promo_hash[:name] = row['name']
      promo_hash[:start_date] = row['start_date']
      promo_hash[:end_date] = row['end_date']
      promo_hash[:description] = row['description']
      promo_hash[:company_id] = row['company_id']

      @promo = Promo.new(promo_hash)

      if @promo.save
        filter_option_ids = row['filter_options_id'].split(',')
        filter_option_ids.each do |filter_option_id|
          promo_filter_option = PromoFilterOption.new(promo_id: @promo.id, filter_option_id: filter_option_id)
          promo_filter_option.save
        end
      else
        @promo.errors.each do |error|
          @error_messages[row['id'].to_i] << error.full_message
        end
      end
    end
    CsvimportMailer.import_complete_email(@error_messages).deliver_now
  end
end
