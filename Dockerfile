FROM ruby:2.4.2-alpine

LABEL com.tomasbasham.maintainer "Tomas Basham <me@tomasbasham.co.uk>" \
      com.tomasbasham.description "Ruby on Rails 4 API" \
      com.tomasbasham.docker.cmd "docker run --rm -p 3000:3000 guarded" \
      com.tomasbasham.docker.cmd.test "docker run --rm guarded rspec"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apk add --update \
  g++ \
  git \
  libc-dev \
  libxml2-dev \
  libxslt-dev \
  make \
  postgresql \
  postgresql-dev \
  tzdata \
  && rm -rf /var/cache/apk/*

ADD lib lib
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install

ADD . /usr/src/app

ENTRYPOINT ["bundle", "exec"]

CMD ["puma", "-C", "config/puma.rb"]
