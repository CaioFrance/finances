class ImportFileController < ApplicationController

  before_action :init_service

  def index
  end

  def import
    @upload_file = params[:csv]
    if @upload_file.nil?
      flash[:alert] = "Selecione um arquivo"
      return redirect_to import_file_path
    end
    
    transaction = @@import_service.save_file(@upload_file) unless @upload_file.nil?
    
    if transaction
      flash[:notice] = @@import_service.status_file    
    else
      flash[:alert] = @@import_service.status_file    
    end
    
    redirect_to import_file_path
  end

  private
  def init_service
    @@import_service = ImportFileService.new
  end
  
end
