# Readme

### Information

When you get the JSON from the API you might think "what the * is this?!" and that's because I've tried to form my responses according to the [JSONAPI](http://jsonapi.org/) standard. Sorry if it's hard to read. 

### Installation

* Clone down this repo
* `bundle install` to install dependencies
* `rake db:setup` to setup database **IMPORTANT!** This application relies on being run on a PostgreSQL database, if you don't have that installed, try testing on the live version that is deployed at the URL: [http://lit-river-92285.herokuapp.com/api](http://lit-river-92285.herokuapp.com/api). Check out the postman file on how to authorize and all that.
* `rails server`

### Tests

Can be run with the command `bundle exec rspec`

### Live version

[Can be tested here](http://lit-river-92285.herokuapp.com/)
