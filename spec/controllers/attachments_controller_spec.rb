require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:user) { create(:user) }
  let!(:question) { create(:question, :with_attachment, author: user) }

  describe 'delete attachment' do
    before { login(user) }

    it 'of question' do
      expect { delete :destroy, params: { id: question.files.first }, format: :turbo_stream }.to change(ActiveStorage::Attachment, :count).by(-1)
    end
  end
end
