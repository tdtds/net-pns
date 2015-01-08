# Net::PNS

protocol handler of PNS commands for PATLITE NH-FV series

See: https://www.patlite.jp/download/NH-FV-ManualT95100208-C.pdf

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'net-pns'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install net-pns

## Usage

require 'net/pns'

pns = Net::PNS.new(192.168.0.10, 10000)
pns.light({red: :on}) #=> Red ON
pns.light({red: :on, green: :on}) #=> Red and Green ON

## Contributing

1. Fork it ( https://github.com/tdtds/net-pns/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
