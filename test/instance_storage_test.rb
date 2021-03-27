# -*- coding: utf-8 -*-

require 'bundler/setup'
require 'minitest/autorun'

require 'instance_storage'

class InstanceStorageTest < MiniTest::Unit::TestCase
  def test_get_and_create_instance
    klass = Class.new do
      include InstanceStorage end
    assert_same(klass[:foo], klass[:foo])
    refute_same(klass[:foo], klass[:bar])
  end

  def test_get_all_instances
    klass = Class.new do
      include InstanceStorage end
    assert_equal([], klass.instances)
    assert_equal([klass[:a], klass[:b]], klass.instances)
  end

  def test_get_all_instances_name
    klass = Class.new do
      include InstanceStorage end
    assert_equal([], klass.instances_name)
    klass[:a]
    klass[:b]
    assert_equal([:a, :b], klass.instances_name)
  end

  def test_destroy_instance
    klass = Class.new do
      include InstanceStorage end
    klass[:a]
    assert(klass.instance_exist? :a)
    klass.destroy(:a)
    assert(! klass.instance_exist?(:a))
  end

  def test_get_existing_instance
    klass = Class.new do
      include InstanceStorage end
    assert_nil(klass.instance(:a))
    assert_equal(klass[:a], klass.instance(:a))
  end

  def test_should_support_inherited_class
    klass = Class.new do
      include InstanceStorage end
    child = Class.new(klass)
    assert_same(child[:foo], child[:foo])
    refute_same(child[:foo], klass[:foo])
  end

end
