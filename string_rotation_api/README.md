# README

## Problem Statement

Using NodeJS, write an API that accepts a post request with a UTF-8 string payload and returns
a ROT-13 version of the string, storing the original string in a database of your choice (SQLite,
MongoDB, PostgreSQL/MySQL). The API should be capable of accepting a string of 1,000
characters. Then provide an alternate implementation using Ruby on Rails. (No 3rd party
libraries or gems may be used for ROT-13.)
### Built With

* [Ruby](https://www.ruby-lang.org/en/)
* [Ruby on Rails](https://rubyonrails.org/)
* [PostgreSQL](https://www.postgresql.org/)
* [RSpec](https://github.com/rspec/rspec-rails)

------------

## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

* `ruby 2.6.6`
* `rails 6.1.7`
* `postgres`

### Installation

1. Clone the repo and cd into it
```sh
cd string_rotation_api
```
2. Install dependencies
`bundle install`

3. Setup Database
`rails db:create`
`rails db:migrate`

3. Start the server
`rails s`

4. Run test suits
`bundle exec rspec`

## Approach

  * A simple api application to convert the given string to ROT13
  * Created hash of each character with it's ROT-13 version. And then replaced each character of original string
  * API Error Handling added at application level
  * Functional tests added using rspec

## API Docs
### URL:
  ```
    https://API_BASE_URL/api/v1/string_rotation
  ```
  for running local it would become `http://localhost:3000/api/v1/string_rotation`

### Request Payload
  ```
    {
      "string_rotation": {
      "original_string": "This is a test message"
    }
  }
  ```
### Response Payload
  ```
    {
      "string_rotation": {
        "original_string": "This is a test message",
        "rot_string": "Guvf vf n grfg zrffntr"
      }
    }
  ```