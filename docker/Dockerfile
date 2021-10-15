FROM ruby:3.0.1 AS base
# Debian stable ships with nodejs 8 which is too old for rails
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /dojam
WORKDIR /dojam
COPY ./app/Gemfile /dojam/Gemfile
COPY ./app/Gemfile.lock /dojam/Gemfile.lock
# Install bundler 2
RUN gem install bundler -v 2.1.4
RUN bundle update
RUN bundle install
COPY ./app /dojam
# Recreate directories that are ignored by Docker
RUN mkdir /dojam/log && mkdir /dojam/tmp

# Add a script to be executed every time the container starts
# Also add a script for a first deploy that can be used as an alternative entrypoint
COPY docker/build-files/app-entrypoint.sh /usr/bin/
COPY docker/build-files/app-first-deploy-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/app-entrypoint.sh
RUN chmod +x /usr/bin/app-first-deploy-entrypoint.sh
ENTRYPOINT ["/usr/bin/app-entrypoint.sh"]
EXPOSE 22333

FROM base AS dev
RUN apt-get install -y chromium-driver chromium