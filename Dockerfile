
# Step 1 - hex dependencies
#
FROM hexpm/elixir:1.13.2-erlang-24.2.1-alpine-3.15.0 AS otp-dependencies

WORKDIR /app

ENV MIX_ENV="prod"

# Install Alpine dependencies
RUN apk add --no-cache git && \
    apk  --no-cache add build-base

# Install Erlang dependencies
RUN mix local.rebar --force && \
    mix local.hex --force

# Install hex dependencies
# COPY mix.* ./
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod
RUN mix deps.compile

# Compile codebase
COPY config config
COPY lib lib


# Compile assets
COPY priv priv
COPY assets assets

RUN mix assets.deploy

RUN mix compile
# Build OTP release
COPY rel rel
RUN mix release

#
# Step 2 - build a lean runtime container
#
FROM alpine:3.15.0

# Install Alpine dependencies
RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache bash openssl libgcc libstdc++ ncurses-libs

WORKDIR /app

RUN chown nobody /app

# Only copy the final release from the build stage
COPY --from=otp-dependencies --chown=nobody:root /app/_build/prod/rel/brasil_em_dados ./

USER nobody

CMD /app/bin/server