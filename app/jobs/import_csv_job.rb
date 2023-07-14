class ImportCsvJob < ApplicationJob
  queue_as :default
  after_perform :delete_temp_file

  def perform(file_path)
    @file_path = file_path
    CsvImportPromosService.new.call(file_path)
  end

  private

  def delete_temp_file
    File.delete(@file_path) if File.exist?(@file_path)
  end
end
