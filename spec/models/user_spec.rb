require 'spec_helper'

describe User do
  it { should have_many :grant_applications }
  it { should have_many :organizations }
end
