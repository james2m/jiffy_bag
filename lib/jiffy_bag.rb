require 'base64'
require 'yaml'
require 'zlib'
require "jiffy_bag/version"

# == JiffyBag
# Lets you serialize, zip and encode small Ruby objects for sending between services. The content is not
# encrypted so this is best used for internal app communication between peer services. e.g. over Sidekiq
# or using a private API.
#
# === Example
# You will usually only need JiffyBag.encode and JiffyBag.decode. To send package up a Hash to send to
# another service.
#
#     payload = JiffyBag.encode(my: 'cheeky', payload: 'in a nice little package')
#
#     => "eJzT1dVVUCwqTarULy4pKk0u4cqttFJIzkhNza7kKkiszMlPTLFSyMxTSFTI\ny0xOVShOTEtVKEhMzk5MT+UCAF+4FDw=\n"
#
# Do whatever you got to do get it to the other end and decode it thus;
#
#     hash = JiffyBag.decode(payload)
#
#     => {my: 'cheeky', payload: 'in a nice little package'}
#
#     struct = JiffyBag.decode_as_struct(payload)
#
#     => #<struct my="cheeky", payload="in a nice littke package">
#
module JiffyBag
  # Serialize, Zip and Base64 encode a payload.
  #
  # ==== Parameters
  #
  # * +payload+ The object you want to send. This is
  #   any object that can be serialized with YAML.dump.
  def self.encode(payload)
    Base64.encode64 deflate(payload)
  end

  # Serialize and Zip a payload.
  #
  # ==== Parameters
  #
  # * +payload+ The object you want to send. This is any object that can be
  #   serialized with YAML.dump.
  def self.deflate(payload)
    Zlib::Deflate.deflate serialize(payload)
  end

  # Serialize a payload.
  #
  # ==== Parameters
  #
  # * +payload+ The object you want to send. This is
  #   any object that can be serialized with YAML.dump.
  def self.serialize(payload)
    YAML.dump(payload)
  end

  # De-serialize a payload. The opposite of JiffyBag.serialize.
  #
  # ==== Parameters
  #
  # * +payload+ The received payload you want to de-serialize.
  #   This can any string returned from YAML.dump.
  def self.deserialize(payload)
    YAML.load(payload)
  end

  # De-serialize and unzip a payload. The opposite of JiffyBag.deflate.
  #
  # ==== Parameters
  #
  # * +payload+ The received payload you want to de-serialize and unzip.
  def self.inflate(payload)
    deserialize Zlib::Inflate.inflate(payload)
  end

  # De-serialize and unzip and decode a Base64 encoded payload. The opposite
  # of JiffyBag.encode.
  #
  # ==== Parameters
  #
  # * +payload+ The received payload you want to de-serialize, unzip and decode.
  def self.decode(payload)
    inflate Base64.decode64(payload)
  end

  # De-serialize and unzip and decode a Base64 encoded payload into an anonymous
  # Struct. This is a convenience method for sending a Hash and re-building it
  # into a Struct. Nested Hashes are not returned as Structs.
  #
  # ==== Parameters
  #
  # * +payload+ The received payload you want to de-serialize, unzip and decode.
  #   The original JiffyBag.encoded object needs to be a Hash for a Struct to be
  #   returned, any other class of object will be treated like JiffyBag.decode.
  def self.decode_as_struct(payload)
    object = decode(payload)
    return object unless object.is_a?(Hash)
    Struct.new(*object.keys).new(*object.values)
  end
end
