require 'spec_helper'

describe Organization do
  it { should belong_to :user }
  it { should validate_presence_of :name }
  it { should validate_presence_of :ein }
  it { should validate_presence_of :duns }
end
