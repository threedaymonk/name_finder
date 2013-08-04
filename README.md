# Name Finder

Find the longest matching name from a list in a text.

## Examples

```ruby
require "name_finder"

stations = [
  "Bermondsey",
  "South Bermondsey",
  "Southwark",
  "Waterloo",
  "Waterloo East"
]

nf = NameFinder.new
stations.each do |station|
  nf.add station
end
```

It can find the best matching name even when one name is the same as part of
another, either at the start:

```ruby
nf.find_in "Change here for trains from Waterloo East"
# => "Waterloo East"

nf.find_in "This train terminates at Waterloo"
# => "Waterloo"
```

or at the end:

```ruby
nf.find_in "Escalator closed at Bermondsey station"
# => "Bermondsey"

nf.find_in "Use South Bermondsey station for Millwall"
# => "South Bermondsey"
```

## Limitations

The present implementation handles only the letters A-Z. This can be customised
by subclassing `NameFinder` and changing the implementation of `normalize`.
The `normalize` method must emit a single space as the delimiter between words.
