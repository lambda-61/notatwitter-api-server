FROM elixir:1.8.1-alpine

RUN apk update && \
      apk upgrade && \
      apk add --no-cache alpine-sdk bash git openssh build-base && \
      rm -rf /var/cache/apk/*

ENV MIX_ENV dev

RUN mix local.hex --force && \
    mix local.rebar --force

COPY . .

RUN mix deps.get && \
    mix compile

CMD mix phx.server
