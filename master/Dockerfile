FROM ruby:3.1.4-slim-bullseye

ENV PORT=3000
ENV RAILS_ENV=production

RUN apt-get update -y && \
  apt-get install cmake libpq-dev -y

WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle

COPY . .

EXPOSE ${PORT}

CMD [ "/bin/bash", "-c", "bundle exec rails server --port ${PORT}"]