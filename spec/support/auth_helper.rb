module AuthHelper
  def json_headers
    {
      "Accept" => "application/json",
      "Content-Type" => "application/json"
    }
  end

  def create_auth_headers(resource)
    auth_headers = resource.create_new_auth_token
    json_headers.merge({
      'Uid' => auth_headers['uid'],
      'Access-Token' => auth_headers['access-token'],
      'Client' => auth_headers['client']
    })
  end
end
