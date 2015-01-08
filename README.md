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

Net::PNS.new(192.168.0.10, 10000) do |patlite|
  patlite.light({red: :blink1, yellow: :on, green: :blink2})
  puts patlite.stat.unpack('C*') #=> [2, 1, 3, 0, 0, 0]
  sleep 10
  patlite.clear
  puts patlite.stat.unpack('C*') #=> [0, 0, 0, 0, 0, 0]
end

patlite = Net::PNS.new(192.168.0.10)
patlite.light({buzzer: :buzz1}) #=> buzzer start
sleep 3
patlite.clear #=> buzzer stop
patlite.close

## Contributing

1. Fork it ( https://github.com/tdtds/net-pns/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
