require 'rails_helper'

RSpec.describe Quest, type: :model do
  it "validate presence to body" do
    expect(Quest.new(title: '123')).to_not be_valid
  end
  it "validate presence to title" do
    expect(Quest.new(body: '123')).to_not be_valid
  end
  
   it "validate lenght of title min" do
    expect(Quest.new(title: '13', body: '124r')).to_not be_valid
  end
  
  it "validate lenght of title max" do
    expect(Quest.new(title: 'f'*251, body: '123')).to_not be_valid
  end
  
   it "validate lenght of body min" do
    expect(Quest.new(title: '123', body: '12', )).to_not be_valid
  end
  
  it "validate lenght of body max" do
    expect(Quest.new(title: '123', body: 'f'*2001)).to_not be_valid
  end
  
   it "should have many answers" do
    t = Quest.reflect_on_association(:answers)
    expect(t.macro).to eq(:has_many)
  end
  
end


