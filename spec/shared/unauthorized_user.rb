RSpec.shared_examples 'unauthorized_user' do
  it "returns an error" do
    subject

    expect(response).to have_http_status(:unauthorized)

    res = json_response
    expect(res[:name]).to be_nil
    expect(res[:errors]).to eq(["You need to sign in or sign up before continuing."])
  end
end
