shared_examples_for 'API Objectation' do
  context "included in " do
    
    it  "object" do
      @objects = JSON.parse(response.body)[objects]

      expect(@objects.first).to eql({"id"=>object.id, "body"=>object.body})
    end
    %w(id body).each do |attr|
      it "contains #{attr}" do        
        expect(response.body).to match(object.send(attr.to_sym).to_json)
      end
    end
  end
end