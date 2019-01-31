shared_examples_for 'API Authorization Post' do
  context 'unauthorized' do
    it 'returns 401 status if there is no access_token' do
      post api_path
      expect(response.status).to eq 401
    end

    it 'returns 401 status if access_token is invalid' do
      post "#{api_path}?access_token='1234567"
      expect(response.status).to eq 401
    end
  end
end