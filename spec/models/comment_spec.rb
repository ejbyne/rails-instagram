require 'spec_helper'

describe Comment, type: :model do
  describe "#new" do
    context "thoughts: 'Aw'" do
      subject {Comment.new thoughts: 'Aw'}
      it {is_expected.to have(1).error_on :thoughts}
      it {is_expected.to_not be_valid}
    end
    context "thoughts: #{'*' * 151}" do
      subject {Comment.new thoughts: '*' * 151}
      it {is_expected.to have(1).error_on :thoughts}
      it {is_expected.to_not be_valid}
    end
  end
end
