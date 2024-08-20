ARG RUBY_VERSION=3.1.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

RUN mkdir -p /app
WORKDIR /app

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev libvips

RUN gem install bundler

COPY Gemfile* ./

RUN bundle install

COPY . /app

ARG DEFAULT_PORT 3000

EXPOSE ${DEFAULT_PORT}

CMD ["bundle", "exec", "rails", "server"]
