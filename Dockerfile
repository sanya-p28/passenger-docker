FROM ruby:3.2

WORKDIR /usr/src/app

COPY Gemfile .
RUN rm -f Gemfile.lock
RUN bundle install --jobs 4 --retry 3 --without development test

COPY . .

# Add Sinatra dependencies
RUN gem install sinatra rackup puma

# Copy your Sinatra app
COPY app.rb .

# Expose the port
EXPOSE 8080

# Run the app automatically when the container starts
CMD ["ruby", "app.rb", "-o", "0.0.0.0", "-p", "8080"]
