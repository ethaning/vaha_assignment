module ErrorResponses
  def unauthorized_error
    { errors: ["You are not authorized to view this resource."] }
  end

  def raised_error(exception)
    { errors: [exception.message] }
  end
end