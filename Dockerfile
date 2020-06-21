FROM node:13.1.0-alpine as node

FROM ruby:2.7.1-alpine3.12

ENV ROOT="/sample_app"
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        alpine-sdk \
        imagemagick \
        mysql-dev \
        mysql-client \
        vim \
        tzdata && \
    apk add --virtual build-packages --no-cache \
        build-base \
        curl-dev

ENV ENTRYKIT_VERSION 0.4.0

RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && mv entrykit /bin/entrykit \
    && chmod +x /bin/entrykit \
    && entrykit --symlink

ENV YARN_VERSION 1.19.1

COPY --from=node /opt/yarn-v$YARN_VERSION /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/

RUN ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
    && ln -s /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg

WORKDIR ${ROOT}

COPY Gemfile ${ROOT}
COPY Gemfile.lock ${ROOT}

RUN bundle install
ENTRYPOINT ["prehook", "bundle install", "--"]
RUN apk del build-packages
COPY . ${ROOT}
RUN mkdir -p tmp/sockets

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
