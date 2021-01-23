module JsonHelper
  def json_response
    res = JSON.parse(response.body)
    res.is_a?(Hash) ? res.with_indifferent_access : res
  end
end