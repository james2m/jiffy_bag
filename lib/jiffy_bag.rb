require 'base64'
require 'yaml'
require 'zlib'
require "jiffy_bag/version"

module JiffyBag
  def encode_payload(payload)
    Base64.encode64 deflate_payload(payload)
  end

  def deflate_payload(payload)
    Zlib::Deflate.deflate serialize_payload(payload)
  end

  def serialize_payload(payload)
    YAML.dump build_payload(payload)
  end

  def build_payload(**attributes)
    Struct.new(*attributes.keys).new(*attributes.values)
  end

  def deserialize_payload(payload)
    YAML.load(payload)
  end

  def inflate_payload(payload)
    deserialize_payload Zlib::Inflate.inflate(payload)
  end

  def decode_payload(payload)
    inflate_payload Base64.decode64(payload)
  end
end
