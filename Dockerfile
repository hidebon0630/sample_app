FROM ruby:2.7.1

RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends build-essential \
  libpq-dev \
  nodejs \
  vim \
  yarn \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /sample_app
ENV APP_ROOT /sample_app
WORKDIR $APP_ROOT

COPY ./Gemfile $APP_ROOT/Gemfile
COPY ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
COPY . $APP_ROOT
RUN mkdir -p tmp/sockets
