# Set::Combination

Defined Set#* and returns a Set::Combination

## Installation

Add this line to your application's Gemfile:

    gem 'set-combination'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install set-combination

## Usage

    # lets say you have a lawn mower with the following dimentions of state

    class LawnMower

      THROTTLE_STATES = Set[:on,   :off]
      CHOAK_STATES    = Set[:open, :closed]
      FUEL_STATES     = Set[:full, :empty]

    end

    # and you want to know all the possible states this lawn mower could be in

    THROTTLE_STATES * CHOAK_STATES * FUEL_STATES # =>
    # #<Set::Combination
    #   #<Set: {:on, :open, :full}>,
    #   #<Set: {:on, :open, :empty}>,
    #   #<Set: {:on, :closed, :full}>,
    #   #<Set: {:on, :closed, :empty}>,
    #   #<Set: {:off, :open, :full}>,
    #   #<Set: {:off, :open, :empty}>,
    #   #<Set: {:off, :closed, :full}>,
    #   #<Set: {:off, :closed, :empty}>
    # >

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
