class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @attachment = ActiveStorage::Attachment.find(params[:id])

    @question = @attachment.record if @attachment.record.class == Question
    @answer = @attachment.record if @attachment.record.class == Answer

    @attachment.purge
    flash.now[:notice] = "File successfully deleted"
  end
end
