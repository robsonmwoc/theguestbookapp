# Guestbook

This is a very simple Guestbook application. Here you have some instructions about the environment used to create it, and how to setup/run on your own machine.

## Requirements
* Ruby: 2.2.x
* System: Ubuntu 10.04
* Database: SQLite3

There is a `Vagrantfile` in the project that will do most of steps for you.

    $ vagrant up

## Installation

In order to install the application you just need to follow these small steps:

    $ bundle install
    $ rake db:migrate db:test:prepare
    $ ./bin/rails server

* That's it!

## Testing

All the tests were writen using RSpec. Everything you need to run them, inside the app folder, execute:

    $ rspec

## Rubocop

Rubocop is a tool used to validate the code according with the Ruby Style Guide, the configuration for it is saved in the `.rubocop.yml`.

The only cop turned off was Styles/Documentation.

To execute Rubocop over the code, just run, inside the app folder:

    $ rubocop

## Author

Robson Mendonça <robsonmwoc at gmail>
