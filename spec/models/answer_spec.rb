require 'rails_helper'

RSpec.describe Answer, type: :model do
  it "validate presence to body" do
    expect(Answer.new(quest: Quest.new)).to_not be_valid
  end
  it "validate presence to question" do
    expect(Answer.new(body: '123')).to_not be_valid
  end
  
   it "validate lenght of body" do
    expect(Answer.new(body: '1')).to_not be_valid
  end
  
end
