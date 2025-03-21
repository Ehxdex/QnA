require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question, author: user) }
  let(:answer) { create(:answer, question: question, author: user) }
  let(:user) { create(:user) }

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'save new answer to database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question, format: :turbo_stream } }.to change(Answer, :count).by(1)
      end

      it 'render create template' do
        post :create, params: { answer: attributes_for(:answer), question_id: question.id, format: :turbo_stream }
        expect(response).to render_template(:create)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question } }.to_not change(Answer, :count)
      end

      it 'render create template' do
        post :create, params: { answer: attributes_for(:answer), question_id: question.id, format: :turbo_stream }
        expect(response).to render_template(:create)
      end
    end
  end

  describe 'GET #destroy' do
    before { login(user) }
    let!(:answer) { create(:answer, question: question, author: user) }

    it 'deletes the answer' do
      expect { delete :destroy,  params: { id: answer }, format: :turbo_stream }.to change(Answer, :count).by(-1)
    end

    it 'render destroy template' do
      delete :destroy, params: { id: answer, format: :turbo_stream }
      expect(response).to render_template(:destroy)
    end
  end

  describe 'PATCH #update' do
    before { login(user) }
    let!(:answer) { create(:answer, question: question, author: user) }
    context 'with valid attributes' do
      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :turbo_stream
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'redirect to current question' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :turbo_stream
        expect(response).to redirect_to question_path(answer.question)
      end
    end

    context 'with invalid attributes' do
      it 'does not change answer attributes' do
        expect do
          patch :update, params: { id: answer, answer: { body: :invalid } }, format: :turbo_stream
        end.to_not change(answer, :body)
      end

      it 'redirect to current question' do
        patch :update, params: { id: answer, answer: { body: :invalid } }, format: :turbo_stream
        expect(response).to redirect_to question_path(answer.question)
      end
    end
  end
end
