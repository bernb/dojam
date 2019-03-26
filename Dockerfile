FROM ruby:2.6.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
# For Capybara-webkit gem
RUN apt-get install -y g++ qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x
RUN mkdir /dojam
WORKDIR /dojam
COPY Gemfile /dojam/Gemfile
COPY Gemfile.lock /dojam/Gemfile.lock
RUN bundle install
COPY . /dojam

# Add a script to be executed every time the container starts.
COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
