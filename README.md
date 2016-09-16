# JiffyBag

A tiny litte gem to take a single level hash of parameters, put them into an anonymous Struct, serialize, zip and Base64 encode it for sing to another service where it can be restored on the other .

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
Either include or extend JiffyBag in your class depending on whether you want Instance or Class methods. The you get 6 simple methods;

  build_payload(**attributes)
    Takes a hash and turns it into an anonymous Struct.

  serialize_payload(payload)
    Takes a hash, turns it into an anonymous Struct and serializes it to YAML.

  deflate_payload(payload)
    Takes a hash, turns it into an anonymous Struct, serializes it to YAML and Zips it up.

  encode_payload(payload)
    Takes a hash, turns it into an anonymous Struct, serializes it to YAML, Zips it up and encodes it in Base64 for safe sending through the ether.

  deserialize_payload(payload)
    Exactly the inverse of serialize_payload, takes the YAML and de-serializes it back into an anonymous Struct.

  inflate_payload(payload)
    Exactly the inverse of deflate_payload, unzips the payload and de-serializes the  YAML back into an anonymous Struct.

  decode_payload(payload)
    Exactly the inverse of encode_payload, decodes the Base64 payload, unzips it and de-serializes the YAML back into an anonymous Struct.

  for the most part the you really only need encode_payload

      payload = encode_payload(my: 'cheeky', payload: 'in a nice safe package')

      => "eJzT1dVVUCwqTarULy4pKk0u4cqttFJIzkhNza7kKkiszMlPTLFSyMxTSFTI\ny0xOVShOTEtVKEhMzk5MT+UCAF+4FDw=\n"

  Do whatever you got to to get it to the other end and decode it thus;

      struct = decode_payload(payload)

      => #<struct my="cheeky", payload="in a nice safe package">

## Development

After checking out the repo, run `bin/setup` to install depencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Pull requests are welcome on GitHub at https://github.com/james2m/jiffy_bag. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

If you want to contribute, a good place to start is filling in that empty test file!

Bug reports are welcome with clear instructions on how to re-create. If it's a feature request, then package them up as pull requests :).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

