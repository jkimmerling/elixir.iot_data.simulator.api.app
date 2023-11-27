# DataSimulatorApi

## Description

A simple API that simulates a configurable number of readings for a fake device.

This is for testing IoT/HVAC ingestion pipelines.

The application is setup to create a docker container, but it can be also be run using `iex -S mix`

## Configuration

The configuration variables that need to be filled out:  
 * `NUMBER_OF_POINTS` - The number of simulated point readings returned per api call
 * `POINT_PREFIX` - The prefix to add to each point
 * `PORT_NUMBER` - The port number used by `Cowboy` to run the API. This has to match the port settings in the `docker-compose.yml` file 
  
  
The configuration method is different based on whether you want to run it in Docker, or via `iex`.  
 * Docker configuration is done via the `docker.env` file in the `config` directory.  
 * The `iex` configuration is done via the `set_envs.sh` file in the root directory. This needs to
 be ran before you fire up the `iex console`, as it sets the ENV vars that will be used. 

## How to run it
  
### Via Docker  

#### On Linux  
Steps needed to run it in a docker container:
 1. Clone the repo
 2. Set the variables in `config/docker.env`
 3. run `sudo make build` (Disregard the deprecation warnings)
 4. run `docker-compose up`
  
  
  
### Via IEx
The steps below assume you have the following installed on your system :  
 * `Elixir` version `1.14` or higher  
 * `Erlang` with `OTP` version `24` or higher  
  
Steps to run it via `iex`:
 1. Clone the repo
 2. Set the variables in `set_envs.sh`
 3. run `chmod +x set_envs.sh` - this only needs to be done once
 4. run `. ./set_envs.sh`
 5. run `mix deps.get`
 6. run `iex -S mix`

## How to interface with it

The endpoint is simple, you only need to add the fake "device name" to the end of the url.

For example, if you want readings for `fake_device_1`, and the container is accessable at `172.20.0.2`  
with a port of `8008`, you would hit the endpoint like this:  
`curl 172.20.0.2:8008/fake_device_1`  
  
The result should be similar to:  
```
{"test":[{"device":"point_1","reading":"87","time":"2023-11-27 15:54:01.265694Z"},{"device":"point_2","reading":"56","time":"2023-11-27 15:54:01.265710Z"},{"device":"point_3","reading":"80","time":"2023-11-27 15:54:01.265715Z"},{"device":"point_4","reading":"94","time":"2023-11-27 15:54:01.265718Z"},{"device":"point_5","reading":"94","time":"2023-11-27 15:54:01.265720Z"}...]}
```