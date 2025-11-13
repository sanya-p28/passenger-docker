# Use a stable Ruby base image
FROM ruby:3.2

# Set the working directory inside the container
WORKDIR /usr/src/app

# --- FIX START: Configure Bundler environment ---
# Set ENV vars to put gem executables in the system PATH
ENV BUNDLE_PATH=/usr/local/bundle
ENV PATH $BUNDLE_PATH/bin:$BUNDLE_PATH/gems/bin:$PATH
# --- FIX END ---

# Copy ONLY the Gemfile
COPY Gemfile .

# Optional: Delete the lockfile if it exists (Ensures Bundler generates a fresh one)
RUN rm -f Gemfile.lock

# Install the Ruby dependencies (Bundler 2.4.19 will run and create a NEW lockfile)
RUN bundle install --jobs 4 --retry 3 --without development test

# Copy the rest of the application source code into the container
COPY . .

# Expose the port the Ruby web server will listen on
EXPOSE 8080

# Define the command to run the application when the container starts
CMD ["bundle", "exec", "rackup", "--port", "8080", "--host", "0.0.0.0"]