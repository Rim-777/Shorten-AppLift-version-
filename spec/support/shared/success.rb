shared_examples_for 'Success' do
  it 'returns status :ok' do
    expect(response).to be_successful
  end
end
