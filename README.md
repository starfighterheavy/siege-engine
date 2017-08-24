# Siege Engine

Siege Engine is a performance testing tool based on Sidekiq.

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/starfighterheavy/siege-engine)

# How to test

To run tests in isolation without actually hitting a target server or using Sidekiq.

1. bundle exec cucumber

To Run tests with Sidekiq,

1. From siege-engine: `WEBMOCK=false SIDEKIQ=true rails s -p 3000 -b 0.0.0.0`
1. From siege-engine: `bundle exec rake sidekiq:clear`
1. From siege-engine: `sidekiq`
1. From siege-engine-test: `rails s -b 0.0.0.0 -p 4000`
1. From siege-engine: `bundle exec cucumber features/run_volley.feature`

# Getting started

# How to contribute

1. Fork the project & clone locally.
1. Create an upstream remote and sync your local copy before you branch.
1. Branch for each separate piece of work.
1. Do the work, write good commit messages, and read the CONTRIBUTING file if there is one.
1. Run `bundle exec cucumber` to execute all tests.
1. Push to your origin repository.
1. Create a new PR in GitHub.
1. Respond to any code review feedback.

## License
 
The MIT License (MIT)

Copyright (c) 2017 Jonathan Kirst

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
