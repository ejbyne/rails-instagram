require 'spec_helper'

describe Picture, :type => :model do

  it 'is not valid if no user id is provided' do
    picture = Picture.new()
    expect(picture).to have(1).error_on(:user_id)
    expect(picture).not_to be_valid
  end

end
