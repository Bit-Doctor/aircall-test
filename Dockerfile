# Use the alpine version of Ruby 2.3.
# https://hub.docker.com/r/library/ruby/
FROM ruby:2.3-alpine

# Configure the main working directory for our app.
ENV APP_HOME /aircall
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Copy the Gemfile as well as the Gemfile.lock.
COPY ./sources/Gemfile* $APP_HOME/

# Groups excluded from bundle installation.
ARG bundle-without

ENV \
    # Dependencies needed for native gems building
    # - build-base: To ensure certain gems can be compiled
    # - postgresql-dev: to compile the `pg` gem
    BUILD_PACKAGES="build-base postgresql-dev" \
    # Dependencies required to run Rails.
    # - nodejs: JavaScript Runtime
    # - libpq: PostgreSQL library
    RUNTIME_PACKAGES="libpq nodejs tzdata"


RUN \
    # Install ruby packages needed for runtime
    apk add --no-cache $RUNTIME_PACKAGES && \
    # Install ruby packages needed for native gems building
    apk add --no-cache --virtual build-dependencies $BUILD_PACKAGES && \
    # Install the RubyGems.
    BUNDLE_WITHOUT=$bundle-without bundle install && \
    # Remove native gem building dependencies to ease weight on docker image
    apk del build-dependencies && \
    # Also remove cache to gain even more
    rm -rf /var/cache/apk/*

# Copy the main application.
COPY ./sources $APP_HOME

# Expose server port.
EXPOSE 3000
# Configure an entry point, so we don't need to specify "bundle exec" for each of our commands.
ENTRYPOINT ["bin/bundle", "exec"]
# The main command to run when the container starts.
CMD ["rails", "server", "--port", "3000", "--binding", "0.0.0.0"]
