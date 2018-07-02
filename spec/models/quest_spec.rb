require 'rails_helper'

RSpec.describe Quest, type: :model do
  it "validate presence to title" do
    expect(Quest.new(title: '123')).to_not be_valid
  end
  it "validate presence to body" do
    expect(Quest.new(body: '123')).to_not be_valid
  end
  
end


