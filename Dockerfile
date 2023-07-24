FROM ruby:3.2.2
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .
CMD ["bash", "-c", "rake db:migrate && ruby server.rb"]
