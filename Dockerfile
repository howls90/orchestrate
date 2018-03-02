FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm postgresql
RUN mkdir /oocran
WORKDIR /oocran
ADD . /oocran
RUN bundle install
