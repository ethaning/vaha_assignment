module ErrorResponses
  def unauthorized_error
    { errors: ["You are not authorized to view this resource."] }
  end
end