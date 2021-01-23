json.merge! @trainees.map { |trainee| trainee.to_builder.attributes! }
