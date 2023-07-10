class CsvImportUsersService
  require 'csv'

  def call(file)
    file = File.open(file)
    csv = CSV.parse(file, headers: true, col_sep: ',')
    csv.each do |row|
      promo_hash = {}
      promo_hash[:name] = row['name']
      promo_hash[:start_date] = row['start_date']
      promo_hash[:end_date] = row['end_date']
      promo_hash[:description] = row['description']
      promo_hash[:company_id] = row['company_id']
      Promo.find_or_create_by!(promo_hash)
      # binding.b
      # p row
    end
  end
end