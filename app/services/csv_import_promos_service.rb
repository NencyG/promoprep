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
      company_name = row['company_name']
      company_id = Company.find_by(name: company_name)
      promo_hash[:company_id] = company_id.id if company_id.present?
      @promo = Promo.new(promo_hash)

      filter_options_name = row['filter_options_name'].split(',')
      filter_options = FilterOption.where(name: filter_options_name).ids
      @promo.filter_option_ids = filter_options
      if @promo.valid?
        @promo.save
      else
        @promo.errors.each do |error|
          @error_messages[row['id'].to_i] << error.full_message
        end
      end
    end
    CsvimportMailer.import_complete_email(@error_messages).deliver_now
  end
end
