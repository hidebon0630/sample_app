FROM ruby:2.7.1

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       yarn

RUN mkdir /sample_app
ENV APP_ROOT /sample_app
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
ADD . $APP_ROOT
RUN mkdir -p tmp/sockets
RUN yarn install --check-files

VOLUME /sample_app/public
VOLUME /sample_app/tmp

RUN RAILS_ENV=production SECRET_KEY_BASE=$SECRET_KEY_BASE bundle exec rake assets:precompile
