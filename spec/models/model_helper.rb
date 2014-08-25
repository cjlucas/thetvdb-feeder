require_relative '../rails_helper'

RSpec::Matchers.define :save_successfully do
  match do |model|
    model.save
  end

  failure_message do |model|
    "save failed with errors: #{model.errors.full_messages}"
  end
end