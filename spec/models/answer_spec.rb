require 'rails_helper'

RSpec.describe Answer, type: :model do
  it "validate presence to body" do
    expect(Answer.new(quest: Quest.new(id: '11'))).to_not be_valid
  end
  it "validate presence to question" do
    expect(Answer.new(body: '123')).to_not be_valid
  end
  it "validate lenght of body min" do
    expect(Answer.new(body: '12', quest: Quest.new(id: '11'))).to_not be_valid
  end
  
  it "validate lenght of body max" do
    expect(Answer.new(body: 'f'*5001, quest: Quest.new(id: '11'))).to_not be_valid
  end
  
  
end
