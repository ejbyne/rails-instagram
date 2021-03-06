require 'spec_helper'

describe Comment, :type => :model do

  it 'is not valid with a name of less than three characters' do
    user = User.new(username: "test", email: "test@test.com", password: "testtest")
    comment = Comment.new(comment: 'He', user_id: user.id)
    expect(comment).to have(1).error_on(:comment)
    expect(comment).not_to be_valid
  end

  it 'is not valid with a name of more than 150 characters' do
    user = User.new(username: "test", email: "test@test.com", password: "testtest")
    comment = Comment.new(comment: '*' * 151, user_id: user.id)
    expect(comment).to have(1).error_on(:comment)
    expect(comment).not_to be_valid
  end

  it 'is not valid if no user id is provided' do
    comment = Comment.new(comment: 'Henry')
    expect(comment).to have(1).error_on(:user_id)
    expect(comment).not_to be_valid
  end

end
