require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }

  it { should validate_presence_of :body }
  it { should have_db_column(:best).of_type(:boolean) }

  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }
  let(:answer) { create(:answer, question: question, author: user) }
  let(:answers) { create_list(:answer, 3, question: question, author: user) }

  describe 'set best answer' do
    it 'to true' do
      answer.set_best

      expect(answer.best).to be_truthy
    end

    it 'to false false' do
      answers[1].set_best

      expect(answers[0].best).to be_falsy
    end
  end

  describe 'default scope' do
    it 'best answer to be DESC' do
      answers.should eq [ answers[0], answers[1], answers[2] ]
    end
  end
end
