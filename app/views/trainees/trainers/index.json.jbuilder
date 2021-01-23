json.merge! @trainers.map { |trainer| trainer.to_builder.attributes! }
