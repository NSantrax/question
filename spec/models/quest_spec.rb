require 'rails_helper'

RSpec.describe Quest, type: :model do
  it "validate presence to title" do
    expect(Quest.new(title: '123')).to_not be_valid
  end
  it "validate presence to body" do
    expect(Quest.new(body: '123')).to_not be_valid
  end
   it "validate lenght of body" do
    expect(Answer.new(body: '1')).to_not be_valid
  end
  
   it "should have many answers" do
    t = Quest.reflect_on_association(:answers)
    expect(t.macro).to eq(:has_many)
  end
  
end


