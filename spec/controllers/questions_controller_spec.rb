require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question, author: user) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 3, author: user) }
    before { get :index }

    it 'fills the array with questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assigns the request question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'assigns new link for answer' do
      expect(assigns(:answer).links.first).to be_a_new(Link)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { login(user) }
    before { get :new }

    it 'assings a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'assings a new Question to @question' do
      expect(assigns(:question).links.first).to be_a_new(Link)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { login(user) }
    context 'with valid attributes' do
      it 'saves a new question in the database' do
        expect { post :create, params: { question: attributes_for(:question), format: :turbo_stream } }.to change(Question, :count).by(1)
      end

      it 'render create template' do
        post :create, params: { question: attributes_for(:question), format: :turbo_stream }
        expect(response).to render_template(:create)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: { question: attributes_for(:question, :invalid) } }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:question, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #destroy' do
    before { login(user) }
    let!(:question) { create(:question, author: user) }

    it 'deletes the question' do
      expect { delete :destroy, params: { id: question }, format: :turbo_stream }.to change(Question, :count).by(-1)
    end

    it 'render destroy template' do
      delete :destroy, params: { id: question, format: :turbo_stream  }
      expect(response).to render_template(:destroy)
    end
  end

  describe 'PATCH #update' do
    before { login(user) }
    let!(:question) { create(:question, author: user) }
    context 'with valid attributes' do
      it 'changes question attributes' do
        patch :update, params: { id: question, question: { body: 'new body' } }, format: :turbo_stream
        question.reload
        expect(question.body).to eq 'new body'
      end

      it 'redirect to current question' do
        patch :update, params: { id: question, question: { body: 'new body' } }, format: :turbo_stream
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      it 'does not change question attributes' do
        expect do
          patch :update, params: { id: question, question: { body: :invalid } }, format: :turbo_stream
        end.to_not change(question, :body)
      end

      it 'redirect to current question' do
        patch :update, params: { id: question, question: { body: :invalid } }, format: :turbo_stream
        expect(response).to redirect_to question_path(question)
      end
    end
  end
end
