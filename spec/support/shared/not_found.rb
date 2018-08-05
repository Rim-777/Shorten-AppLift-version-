shared_examples_for 'NotFound' do
  it 'returns status 404' do
    expect(response).to be_not_found
  end
end
