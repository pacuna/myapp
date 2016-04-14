require 'rails_helper'

RSpec.describe Article, type: :model do
    describe '#validations' do
      it 'is not valid without a title' do
        expect(Article.new(title: nil)).to_not be_valid
      end
      it 'is not valid without a body' do
        expect(Article.new(body: nil)).to_not be_valid
      end
      it 'is not valid without a user_id' do
        expect(Article.new(user_id: nil)).to_not be_valid
      end
      it 'is valid with a title, body and user_id' do
        expect(Article.new(title: 'dummy article', body: 'Dummy article body', user_id: 1)).to be_valid
      end
    end
end
