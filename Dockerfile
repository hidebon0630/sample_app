FROM ruby:2.7.1

RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends build-essential \
  libpq-dev \
  nodejs \
  fonts-liberation \
  libappindicator3-1 \
  libasound2 \
  libatk-bridge2.0-0 \
  libatspi2.0-0 \
  libgtk-3-0 \
  libnspr4 \
  libnss3 \
  libx11-xcb1 \
  libxss1 \
  libxcb-dri3-0 \
  libgbm1 \
  libdrm2 \
  libxtst6 \
  xdg-utils \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN curl -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb
RUN curl -O https://chromedriver.storage.googleapis.com/2.31/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip

RUN mkdir /sample_app
ENV APP_ROOT /sample_app
WORKDIR $APP_ROOT

COPY ./Gemfile $APP_ROOT/Gemfile
COPY ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
COPY . $APP_ROOT
RUN mkdir -p tmp/sockets
