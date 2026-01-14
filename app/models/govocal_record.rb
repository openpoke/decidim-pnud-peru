# frozen_string_literal: true

class GovocalRecord < ApplicationRecord
  self.abstract_class = true
  connects_to database: { reading: :govocal, writing: :govocal }
end
