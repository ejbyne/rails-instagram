require 'spec_helper'

describe Picture, :type => :model do

  it 'is not valid with a name of less than three characters' do
    user = User.new(email: "test@test.com", password: "testtest")
    picture = Picture.new(name: 'Be', user_id: user.id)
    expect(picture).to have(1).error_on(:name)
    expect(picture).not_to be_valid
  end

  it 'is not valid with a name of more than 150 characters' do
    user = User.new(email: "test@test.com", password: "testtest")
    picture = Picture.new(name: '*' * 151, user_id: user.id)
    expect(picture).to have(1).error_on(:name)
    expect(picture).not_to be_valid
  end

  it 'is not valid if no user id is provided' do
    picture = Picture.new(name: '*' * 10)
    expect(picture).to have(1).error_on(:user_id)
    expect(picture).not_to be_valid
  end

end
