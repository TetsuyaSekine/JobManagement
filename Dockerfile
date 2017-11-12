FROM ruby:2.4

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    mysql-client \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile* ./
RUN bundle install
COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
