require 'spec_helper'

describe Node do
  it { Node.new.val.must_equal nil }
  it { Node.new.next.must_equal nil }
  it { Node.new('hola').val.must_equal 'hola' }
end
