require 'rails_helper'

RSpec.describe Answer, type: :model do
  it "validate presence to body" do
    expect(Answer.new(body: '123')).to_not be_valid
  end
  
end
