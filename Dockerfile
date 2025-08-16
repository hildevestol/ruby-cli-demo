FROM ruby:3.3-alpine AS dev

# Install all packages in the .build-deps file
COPY .build-deps /
RUN cat .build-deps | xargs apk add

# Set workdir in container
WORKDIR /usr/src/app

##################################################################################################################
### Set up Ruby gem related environment variables inside the container                                         ###
##################################################################################################################
### Why this setup is common in Docker + Ruby                                                                  ###
###   * Isolation: Gems are not installed globally; they are contained in /bundle.                             ###
###   * Portability: When you share the Docker image, all gem executables are ready to use.                    ###
###   * Speed: You can cache /bundle between builds to avoid reinstalling gems every time.                     ###
##################################################################################################################

# Tells Bundler (the Ruby dependency manager) where to install gems.
# By default, Bundler installs gems into the system Ruby directories.
# Here, it’s telling Bundler to install everything into /bundle.
# This is useful in Docker because it keeps all gems in a separate directory
# rather than modifying the system Ruby installation.
ENV BUNDLE_PATH=/bundle

# Sets where Bundler will place executables from installed gems.
# With this, any gem you install that has a binary will put it into /bundle/bin
ENV BUNDLE_BIN=/bundle/bin

# Sets the RubyGems home directory.
# GEM_HOME tells Ruby where to look for installed gems.
# Here it is pointing to /bundle, the same as BUNDLE_PATH.
# Ensures all gem-related operations use /bundle instead of the system-wide gem directory.
ENV GEM_HOME=/bundle

# Prepends /bundle/bin to the PATH environment variable.
# Why? So that the executables installed by gems can be run directly in the shell without needing a full path.
# Example: if you installed the rails gem, now you can just run rails anywhere in the container.
ENV PATH="${BUNDLE_BIN}:${PATH}"

##################################################################################################################

FROM dev AS ci
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 20 --retry 5
COPY . ./
