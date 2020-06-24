FROM ruby:2.7.1

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

RUN mkdir /sample_app
ENV APP_ROOT /sample_app
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
ADD . $APP_ROOT
RUN mkdir -p tmp/sockets

ARG RAILS_MASTER_KEY
RUN RAILS_MASTER_KEY=${RAILS_MASTER_KEY} RAILS_ENV=production bundle exec rails assets:precompile

VOLUME /sample_app/public
VOLUME /sample_app/tmp
