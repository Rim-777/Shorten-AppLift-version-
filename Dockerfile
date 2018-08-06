FROM ruby:2.5.1-slim

RUN apt-get update
RUN apt-get install -y build-essential git libpq-dev

ENV APP_HOME /usr/src/app
RUN mkdir $APP_HOME
ADD . $APP_HOME

WORKDIR $APP_HOME

RUN bundle install
