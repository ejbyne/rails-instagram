require 'spec_helper'

describe Picture, :type => :model do

  it 'is not valid with a name of less than three characters' do
    picture = Picture.new(name: 'Be')
    expect(picture).to have(1).error_on(:name)
    expect(picture).not_to be_valid
  end

  it 'is not valid with a name of more than 150 characters' do
    picture = Picture.new(name: '*' * 151)
    expect(picture).to have(1).error_on(:name)
    expect(picture).not_to be_valid
  end

  it 'is not valid if the user is not logged in' do
    picture = Picture.new(name: '*' * 10)
    expect(picture).not_to be_valid
  end

end
