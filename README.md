ComboClient
===========

##What is it?##

A simple ruby client library for communicating with [Combo](https://github.com/douglassquirrel/combo)

##Installation##

    gem install comboclient

##Sample usage##

```ruby
require 'comboclient'

client = ComboClient.new "combo-squirrel.herokuapp.com", "sample.topic"
client.add({description: "fact", anything: "you like"})
client.subscribe do |response, manager|
  # response is a new fact
  manager.cancel! # to stop the subscription
end
```
