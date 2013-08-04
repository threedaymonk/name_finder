# Name Finder

Find names from a know list in a text, taking account of names that may be a
sub-part of a different, longer name.

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
another, whether they overlap at the start:

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

nf.find_in "Use South Bermondsey station for Millwall FC"
# => "South Bermondsey"
```

It can also find all the matching names, without false positives for names
that are part of a longer name:

```ruby
nf.find_all_in "South Bermondsey and Waterloo East"
# => ["South Bermondsey", "Waterloo East"]
```

Names that are part of a longer name are still found when listed separately,
however:

```ruby
nf.find_all_in "South Bermondsey and Bermondsey"
# => ["South Bermondsey", "Bermondsey"]
```

## Limitations

The present implementation handles only the letters A-Z. This can be customised
by subclassing `NameFinder` and changing the implementation of `normalize`.
The `normalize` method must use the same delimiter between words as is returned
by the `delimiter` method (normally a single space).
