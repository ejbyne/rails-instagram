require 'spec_helper'

describe Comment, :type => :model do

  it 'is not valid with a name of less than three characters' do
    user = User.new(email: "test@test.com", password: "testtest")
    comment = Comment.new(thoughts: 'Aw', user_id: user.id)
    expect(comment).to have(1).error_on(:thoughts)
    expect(comment).not_to be_valid
  end

  it 'is not valid with a name of more than 150 characters' do
    user = User.new(email: "test@test.com", password: "testtest")
    comment = Comment.new(thoughts: '*' * 151, user_id: user.id)
    expect(comment).to have(1).error_on(:thoughts)
    expect(comment).not_to be_valid
  end

  it 'is not valid if no user id is provided' do
    comment = Comment.new(thoughts: '*' * 10)
    expect(comment).to have(1).error_on(:user_id)
    expect(comment).not_to be_valid
  end

end
