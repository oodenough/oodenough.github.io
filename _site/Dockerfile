# Use the official Ruby image from the Docker Hub
FROM ruby:latest

# Install Jekyll and Bundler
RUN gem install jekyll bundler

# Set the working directory
WORKDIR /work

# Copy the application files to the working directory
COPY . .

EXPOSE 4000

# Install the required gems
RUN bundle install

# default command, run when container begin to build the site
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
