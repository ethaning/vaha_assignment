RSpec.shared_examples 'unauthorized_action' do
  it "returns an error" do
    subject

    expect(response).to have_http_status(:unauthorized)

    res = json_response
    expect(res[:errors]).to eq(["You are not authorized to view this resource."])
  end
end
