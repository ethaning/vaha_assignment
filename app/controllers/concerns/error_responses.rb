module ErrorResponses
  def unauthorized_error
    { errors: ["You are not authorized to view this resource."] }
  end

  def invalid_date_range_error
    { errors: ["Date range is invalid"] }
  end

  def raised_error(exception)
    { errors: [exception.message] }
  end
end