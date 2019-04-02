FROM ruby:2.6.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
# For Capybara-webkit gem
RUN apt-get install -y g++ qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x
RUN mkdir /dojam
WORKDIR /dojam
COPY ./app/Gemfile /dojam/Gemfile
COPY ./app/Gemfile.lock /dojam/Gemfile.lock
# Install bundler 2
RUN gem install bundler -v 2.0.1
RUN bundle install
COPY ./app /dojam
# Recreate directories that are ignored by Docker
RUN mkdir /dojam/log && mkdir /dojam/tmp

# Add a script to be executed every time the container starts.
COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 22333
