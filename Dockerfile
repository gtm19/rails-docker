# syntax=docker/dockerfile:1
FROM ruby:2.6

ARG app_name

EXPOSE 3000

RUN apt-get update -qq && apt-get install -y \
    curl \ 
    postgresql-client &&\
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y nodejs yarn

RUN echo "Creating working directory: $app_name"
WORKDIR /$app_name
COPY . /$app_name

# Install Gems
RUN bundle install --jobs 5

# Install JS packages
RUN yarn install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
