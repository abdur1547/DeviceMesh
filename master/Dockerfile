FROM ruby:3.1.4-alpine AS build

ARG RAILS_ROOT=/app
ARG BUILD_PACKAGES="build-base curl-dev git"
ARG DEV_PACKAGES="postgresql-dev yaml-dev zlib-dev"
ARG RUBY_PACKAGES="tzdata"

ENV RAILS_ENV=production
ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"

WORKDIR $RAILS_ROOT

RUN apk update \
  && apk upgrade \
  && apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES

COPY Gemfile Gemfile.lock $RAILS_ROOT/

RUN bundle config set --local path vendor/bundle \
  && bundle config --global frozen \
  && bundle config set --local without development:test:assets \
  && bundle install

COPY . .
RUN rm -rf tmp/cache app/assets vendor/assets spec

FROM ruby:3.1.4-alpine

ARG RAILS_ROOT=/app
ARG PACKAGES="tzdata postgresql-client bash"

ENV RAILS_ENV=production
ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"

WORKDIR $RAILS_ROOT

RUN apk update \
  && apk upgrade \
  && apk add --update --no-cache $PACKAGES

COPY --from=build $RAILS_ROOT $RAILS_ROOT

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]