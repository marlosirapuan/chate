FROM bitwalker/alpine-elixir-phoenix:1.8.1

# Set exposed ports
EXPOSE 4001
ENV PORT=4001 MIX_ENV=prod

# Postgres
RUN apk update && apk upgrade && \
    apk add --no-cache \
    bash \
    tzdata postgresql-client vim

ENV APP_HOME /src/app

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# Cache elixir deps
COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

COPY assets/package.json assets/
RUN cd assets && \
    npm install

COPY . ./

# Run frontend build, compile, and digest assets
RUN cd assets/ && \
    npm run deploy && \
    cd - && \
    mix do compile, phx.digest

USER default

CMD ["mix", "phoenix.server"]