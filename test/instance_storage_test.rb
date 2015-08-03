# -*- coding: utf-8 -*-

require 'bundler/setup'
require 'minitest/autorun'

require 'instance_storage'

describe(InstanceStorage) do

  it 'get and create instance' do
    klass = Class.new do
      include InstanceStorage end
    assert_same(klass[:foo], klass[:foo])
    refute_same(klass[:foo], klass[:bar])
  end

  it "get all instances" do
    klass = Class.new do
      include InstanceStorage end
    assert_equal([], klass.instances)
    assert_equal([klass[:a], klass[:b]], klass.instances)
  end

  it "get all instances name" do
    klass = Class.new do
      include InstanceStorage end
    assert_equal([], klass.instances_name)
    klass[:a]
    klass[:b]
    assert_equal([:a, :b], klass.instances_name)
  end

  it "destroy instance" do
    klass = Class.new do
      include InstanceStorage end
    klass[:a]
    assert(klass.instance_exist? :a)
    klass.destroy(:a)
    assert(! klass.instance_exist?(:a))
  end

  it "get existing instance" do
    klass = Class.new do
      include InstanceStorage end
    assert_nil(klass.instance(:a))
    assert_equal(klass[:a], klass.instance(:a))
  end

  it "should support inherited class" do
    klass = Class.new do
      include InstanceStorage end
    child = Class.new(klass)
    assert_same(child[:foo], child[:foo])
    refute_same(child[:foo], klass[:foo])
  end

end
