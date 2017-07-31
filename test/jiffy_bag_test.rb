require 'test_helper'

class JiffyBagTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::JiffyBag::VERSION
  end

  def test_it_serializes_and_de_serializes
    obj = { my: 'Hash' }
    serialized = JiffyBag.serialize(obj)
    assert_equal obj, JiffyBag.deserialize(serialized)
  end

  def test_it_deflates_and_inflates
    obj = { my: 'Hash' }
    deflated = JiffyBag.deflate(obj)
    assert_equal obj, JiffyBag.inflate(deflated)
  end

  def test_it_encodes_and_decodes
    obj = { my: 'Hash' }
    encoded = JiffyBag.encode(obj)
    assert_equal obj, JiffyBag.decode(encoded)
  end

  def test_it_encodes_and_decodes_objects
    obj = MyTestClass.new('TestObject')
    encoded = JiffyBag.encode(obj)
    assert_equal obj, JiffyBag.decode(encoded)
  end

  def test_it_encodes_a_hash_and_decodes_to_a_struct
    obj = { my: 'Hash' }
    encoded = JiffyBag.encode(obj)
    struct = JiffyBag.decode_as_struct(encoded)
    assert_equal obj[:my], struct.my
  end

  def test_it_does_not_decode_non_hashes_to_a_struct
    obj = [:my, 'Array']
    encoded = JiffyBag.encode(obj)
    decoded = JiffyBag.decode_as_struct(encoded)
    assert_equal obj, decoded
  end

  class MyTestClass
    attr_reader :attribute

    def initialize(attribute)
      @attribute = attribute
    end

    def ==(other)
      @attribute == attribute
    end
  end
end
