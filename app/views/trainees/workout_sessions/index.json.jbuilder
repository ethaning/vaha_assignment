json.merge! @sessions.map { |session| session.to_builder.attributes! }
