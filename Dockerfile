FROM hexpm/elixir:1.15.6-erlang-24.3.4.12-alpine-3.16.6

# The following are build arguments used to change variable parts of the image.
# The name of your application/release (required)
ARG APP_NAME=:data_simulator_api
# The version of the application we are building (required)
ARG APP_VSN=0.1.0
# The environment to build with
ARG MIX_ENV=prod

ENV APP_NAME=${APP_NAME} \
    APP_VSN=${APP_VSN} \
    MIX_ENV=${MIX_ENV} 

# By convention, /opt is typically used for applications
WORKDIR /opt/app

# This step installs all the build tools we'll need
RUN apk update && \
  apk upgrade --no-cache && \
  apk add --no-cache \
    bash \
    nodejs \
    yarn \
    git \
    build-base && \
  mix local.rebar --force && \
  mix local.hex --force

RUN mix do deps.get, deps.compile ranch --force, compile

RUN \
  mkdir -p /opt/built && \
  mix release &&\
  cp _build/${MIX_ENV}/${MIX_ENV}-${APP_VSN}.tar.gz /opt/app && \
  cd /opt/app && \
  tar -xzf ${MIX_ENV}-${APP_VSN}.tar.gz && \
  rm ${MIX_ENV}-${APP_VSN}.tar.gz


ENV REPLACE_OS_VARS=false \
    APP_NAME=${APP_NAME} \
    ERL_CRASH_DUMP='/tmp'

CMD /opt/app/bin/${MIX_ENV} start;