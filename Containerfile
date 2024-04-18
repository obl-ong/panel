FROM ruby:3.3

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /srv/oblong/

COPY Gemfile Gemfile.lock ./
RUN bundle install
RUN RAILS_ENV=production bin/rails assets:precompile

COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-e", "production", "-b", "0.0.0.0:3000"]