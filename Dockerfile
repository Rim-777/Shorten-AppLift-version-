FROM ruby:2.5.1-slim
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
ENV APP_HOME /usr/src/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
RUN bundle install
COPY . $APP_HOME
