FROM ruby:3.2.2
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    libxi6 \
    libgconf-2-4 \
    default-jre-headless \
    && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install
COPY . .
CMD [ "ruby", "server.rb" ]
