FROM ruby:2.7-slim

WORKDIR /app

COPY Gemfile ./
COPY Gemfile.lock ./
RUN bundle config --local set path 'vendor/bundle'
RUN bundle install

CMD bundle exec ruby index.rb

