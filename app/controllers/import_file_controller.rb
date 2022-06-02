class ImportFileController < ApplicationController
  before_action :init_uploader

  def index
  end

  def import
    if params[:csv] != nil
      @upload_file = params[:csv]

      @@uploader.store!(@upload_file)
      puts "File size: #{number_to_human_size(File.size(@upload_file))}"
      puts "File name: #{@upload_file.original_filename}"
    else
      flash[:notice] = "Selecione um arquivo"
    end

    redirect_to import_file_path
  end

  private

  def init_uploader
    @@uploader = TransactionUploader.new
  end
end
