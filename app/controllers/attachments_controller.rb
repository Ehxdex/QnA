class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge
    flash.now[:notice] = "File successfully deleted"

    redirect_to questions_path
  end
end
