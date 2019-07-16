FROM ruby:2.6.2
# Debian stable ships with nodejs 8 which is too old for rails
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
# For Capybara-webkit gem
RUN apt-get install -y g++ qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x firefox-esr 
# Install geckodriver for firefox, used by selenium/capybara
RUN GK_VERSION="0.24.0" \
  && echo "Using GeckoDriver version: "$GK_VERSION \
  && wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v$GK_VERSION/geckodriver-v$GK_VERSION-linux64.tar.gz \
  && rm -rf /opt/geckodriver \
  && tar -C /opt -zxf /tmp/geckodriver.tar.gz \
  && rm /tmp/geckodriver.tar.gz \
  && mv /opt/geckodriver /opt/geckodriver-$GK_VERSION \
  && chmod 755 /opt/geckodriver-$GK_VERSION \
  && ln -fs /opt/geckodriver-$GK_VERSION /usr/bin/geckodriver
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
