FROM ruby:2.4.0-slim
# Install app dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  libsqlite3-dev \
  unzip \
  telnet \
  vim \
  nodejs \
  git \
  imagemagick \
  libmagickcore-dev \
  libmagickwand-dev
RUN echo 'gem: --no-document' >> ~/.gemrc
ENV APP_HOME /app
ENV PORT 3000
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
    BUNDLE_JOBS=4 \
    BUNDLE_PATH=/bundle
COPY Gemfile* $APP_HOME/
RUN bundle install
COPY . $APP_HOME
VOLUME ["$APP_HOME/public"]
COPY ./run.sh run.sh
EXPOSE $PORT
CMD ./run.sh

