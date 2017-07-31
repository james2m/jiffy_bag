require 'base64'
require 'yaml'
require 'zlib'
require "jiffy_bag/version"

module JiffyBag
  def self.encode(payload)
    Base64.encode64 deflate(payload)
  end

  def self.deflate(payload)
    Zlib::Deflate.deflate serialize(payload)
  end

  def self.serialize(payload)
    YAML.dump(payload)
  end

  def self.deserialize(payload)
    YAML.load(payload)
  end

  def self.inflate(payload)
    deserialize Zlib::Inflate.inflate(payload)
  end

  def self.decode(payload)
    inflate Base64.decode64(payload)
  end

  def self.decode_as_struct(payload)
    object = decode(payload)
    return object unless object.is_a?(Hash)
    Struct.new(*object.keys).new(*object.values)
  end
end
