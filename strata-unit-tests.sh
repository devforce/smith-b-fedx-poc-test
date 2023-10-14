#!/bin/bash -x

# Install build and runtime dependencies your bundle needs.
# You may need to add sqlite3, pq, png, etc.

# Nexus auth setup (can't hit rubygems.org directly)
NU=$(ruby -e 'require "cgi"; puts CGI.escape(ENV["NEXUS_USERNAME"])')
NP=$(ruby -e 'require "cgi"; puts CGI.escape(ENV["NEXUS_PASSWORD"])')

gem sources --remove https://rubygems.org/
gem sources --add https://${NU}:${NP}@nexus-proxy.repo.local.sfdc.net/nexus/content/repositories/rubygems/
source /opt/rh/devtoolset-10/enable
bundle config set --global nexus-proxy.repo.local.sfdc.net $NU:$NP
bundle config unset deployment
bundle config set --local path 'vendor/bundle'
bundle install
bundle config --delete nexus-proxy.repo.local.sfdc.net

bundle exec rspec spec
