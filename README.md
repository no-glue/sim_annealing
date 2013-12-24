# SimAnnealing

Simulated annealing to solve travelling salesman

## Installation

Add this line to your application's Gemfile:

    gem 'sim_annealing'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sim_annealing

## Usage

    SimAnnealing::SimAnnealing.new.search([[565,575],[25,185]], 2000, 100000.0, 0.98)
    2000 - max iterations
    100000.0 - starting temperature
    0.98 - temperature drop

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
