# ClassyJson

This gem takes a stringified JSON response(before parse) and objectifys it.  For the record, I don't really believe in objectification.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'classy_json'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install classy_json

## Usage

Typically you'll be able to handle very large and nested JSON payloads with simplicity:

``ruby
resp = Net::HTTP.get(URI('some_json_api')
results = ClassyJSON.convert(resp)
```


When a single JSON object is in the response
```ruby
resp = Net::HTTP.get(URI('https://jobs.github.com/positions/eef0892e-a555-11e4-903f-115f3ec6fcd0.json'))
results = ClassyJSON.convert(resp, job)
results.job.company
=>"Code Club"
```

If your response is only an array, you'll need to specify the object we're creating with a secondary argument like so:
```ruby
resp = Net::HTTP.get(URI('https://jobs.github.com/positions.json?description=software&location='))
jobs = ClassyJSON.convert(resp, 'jobs')
=> Array of jobs
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/classy_json/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
