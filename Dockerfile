# Make sure to lock your ruby version to a specific one
FROM ruby:3.3-alpine AS dev

# Add dependencies located in the .build-deps file
COPY .build-deps /
RUN cat .build-deps | xargs apk add

WORKDIR /my_cli_app

ENV BUNDLE_PATH=/bundle \
  BUNDLE_BIN=/bundle/bin \
  GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

FROM dev AS ci
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 20 --retry 5
COPY . ./
