#!/bin/bash

# Execute migrations
rake db:migrate

# Start the server
ruby server.rb
