# JiffyBag

A tiny gem to take an object, serialize, zip and Base64 encode it for sending to another system where it can be re-constructed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jiffy_bag'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jiffy_bag

## Usage
Either include or extend JiffyBag in your class depending on whether you want Instance or Class methods. The you get 7 simple methods;

  JiffyBag.serialize(payload)
    Takes an object and serializes it to YAML.

  JiffyBag.deflate(payload)
    Takes an object, serializes it to YAML and Zips it up.

  JiffyBag.encode(payload)
    Takes an object, serializes it to YAML, Zips it up and encodes it in Base64 for safe sending through the ether.

  JiffyBag.deserialize(payload)
    Exactly the inverse of serialize_payload, takes the YAML and de-serializes it back into an instance of the original class if that class exists.

  JiffyBag.inflate(payload)
    Exactly the inverse of deflate_payload, unzips the payload and de-serializes the YAML back into an instance of the original serialized class.

  JiffyBag.decode(payload)
    Exactly the inverse of encode_payload, decodes the Base64 payload, unzips it and de-serializes the YAML back into an instance of the original class.

  JiffyBag.decode_as_struct(payload)
    Decodes the Base64 payload, unzips it and de-serializes the YAML and if it contains a Hash it instantiates an anonymous Struct from it. This is

  for the most part the you really only need JiffyBag.encode

      payload = JiffyBag.encode(my: 'cheeky', payload: 'in a nice little package')

      => "eJzT1dVVUCwqTarULy4pKk0u4cqttFJIzkhNza7kKkiszMlPTLFSyMxTSFTI\ny0xOVShOTEtVKEhMzk5MT+UCAF+4FDw=\n"

  Do whatever you got to to get it to the other end and decode it thus;

      hash = JiffyBag.decode(payload)

      => {my: 'cheeky', payload: 'in a nice little package'}

      struct = JiffyBag.decode_as_struct(payload)

      => #<struct my="cheeky", payload="in a nice littke package">

## Development

After checking out the repo, run `bin/setup` to install depencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Pull requests are welcome on GitHub at https://github.com/james2m/jiffy_bag. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

If you want to contribute, a good place to start is filling in that empty test file!

Bug reports are welcome with clear instructions on how to re-create. If it's a feature request, then package them up as pull requests :).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

