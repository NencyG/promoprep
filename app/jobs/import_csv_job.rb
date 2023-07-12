class ImportCsvJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    CsvImportPromosService.new.call(file_path)
  end
end
