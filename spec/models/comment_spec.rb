require 'spec_helper'

describe Comment, :type => :model do

  it 'is not valid with a name of less than three characters' do
    comment = Comment.new(thoughts: 'Aw')
    expect(comment).to have(1).error_on(:thoughts)
    expect(comment).not_to be_valid
  end

  it 'is not valid with a name of more than 150 characters' do
    comment = Comment.new(thoughts: '*' * 151)
    expect(comment).to have(1).error_on(:thoughts)
    expect(comment).not_to be_valid
  end

end