# Bookingz

Admin interface and API for conference room booking system. This project is accompanied by an Android application that you can find [here](https://github.com/CraftAcademy/bookingz_client).

This was also the final project for the June-16 cohort of [Craft Academy](https://github.com/CraftAcademy)s coding bootcamp.



#### Build
[![Build Status](https://semaphoreci.com/api/v1/craftacademy/bookingz/branches/develop/badge.svg)](https://semaphoreci.com/craftacademy/bookingz)
[![Code Climate](https://codeclimate.com/github/CraftAcademy/bookingz/badges/gpa.svg)](https://codeclimate.com/github/CraftAcademy/bookingz)
#### Coverage
Develop [![Coverage Status](https://coveralls.io/repos/github/CraftAcademy/bookingz/badge.svg?branch=develop)](https://coveralls.io/github/CraftAcademy/bookingz?branch=develop)

Master [![Coverage Status](https://coveralls.io/repos/github/CraftAcademy/bookingz/badge.svg?branch=master)](https://coveralls.io/github/CraftAcademy/bookingz?branch=master)



## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisities

To be able to install and run the application you need to have Rails 5 and PostgreSQL installed.

### Installing

```
Fork and clone the repository
```

run:

```
$ bundle install
```
and then:
```
$ rake db:migrate db:seed
```


## Running the tests

To run tests:

```
$ rake
```
## Deployment

In this project we used [Semaphore](https://semaphoreci.com/) for continuous integration and [Heroku](https://www.heroku.com/) for hosting.

## Customization
In order to cutomize the slots you need to pass in an `:increment` param to the jbuilder view. I.e.:

```
 #slots = create_hour_range(increment: 4.hours, start_time: 8.hours, end_time: 16.hours)
```

## Built With

* Ruby on Rails - 5
* Ruby - 2.3.1
* PostgreSQL
* High Voltage - For static pages.
* Rack Cors - For API coveralls.
* Redcarpet - A markdown parser.
* Haml-Rails - Because haml is better than html.
* Foundation-Rails - For your styling purposes.
* Foundation-icons
* Foundation-Datetimepicker-Rails
* Foundation-icons-sass-rails
* Devise - User authentication.
* Devise-i18n
* Acts_as_bookable - Since this is a booking application.
* Rails-i18n - Internationalization (multiple languages).

For testing purposes we used:

* Pry
* Pry-byebug
* Rspec-rails
* Shoulda-matchers
* Factory_girl_rails
* Cucumber-rails
* Database_cleaner
* Coveralls
* Launchy
* Guard-rspec
* Guard-cucumber
* Guard-livereload
* Capybara
* Capybara-screenshot
* Poltergeist
* Phantomjs require: phantomjs/poltergeist
* Timecop

## Authors

* [Thomas](https://github.com/tochman)
* [Raoul](https://github.com/diraulo)
* [Lucia](https://github.com/luciademoja)
* [Lara](https://github.com/lollypop27)
* [Calle](https://github.com/callea2)
* [Mikael](https://github.com/MikaelFeher)


## Acknowledgments

The entire project is comprised of open source code so a huge **THANKS!** to the open source community.

## Copyright and license

Code and documentation copyright 2016 Craft Academy Labs (Pragmatic Sweden AB).
Code released under [the MIT license](https://opensource.org/licenses/MIT). Docs released under [Creative Commons](https://creativecommons.org/licenses/by-nc/3.0/).
