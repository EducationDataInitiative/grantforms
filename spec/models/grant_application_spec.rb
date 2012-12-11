require 'spec_helper'

describe GrantApplication do
  it { should belong_to :grant }
  it { should belong_to :organization }
  it { should belong_to :user }
end
