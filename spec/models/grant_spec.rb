require 'spec_helper'

describe Grant do
  it { should validate_presence_of :name }
end
