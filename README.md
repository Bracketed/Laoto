# ninjaninja140's Templates - Deno (TypeScript)

Hello and welcome!
This is a template repository made for convenience to others by ninjaninja140!

As the title suggests, this is a Deno based Template.
This Template has been pre-configured with docker so you can go straight into your Dockerized project with little configuration required!

## Getting a copy

To begin on your own project, you can either fork this repository and begin your project or you could select this repository at `bracketed/templates-deno` as a template when creating a new repository or you could just clone it and work locally!

## Setup & Install

### If you aren't using Docker

Just remove the `docker` folder and the `entrypoint.sh` file and you should be good to go!
You may also need to remove the `validate.yml` and `ci.yml` files as they use Docker to check if the project can be compiled with Docker.

### Install using Deno

Just install Deno using these easy commands!

- *Linux & macOS*: `curl -fsSL https://deno.land/install.sh | sh`
- *Windows*: `irm https://deno.land/install.ps1 | iex`

### Running

If you haven't done so, please compile your project now.
To run your application, run `deno task dev` (to run it in dev watch mode), or `deno task run` to run it in its default, production ready mode.

Use CTRL or COMMAND + C to exit.

## Linting & Validating

This project has been pre-configured to use `biome`.
You can change my current Biome config in the `biome.json` file, or you can delete it to use another linter.

## Docker

This project was set up with Docker for convenience to others and myself.
If you do not wish to use Docker in this project, ignore this and go to the `If you aren't using Docker` sub-section of the `Setup & Install` section.
If you are using Docker in this project, I have pre-prepared a `Dockerfile`, change this to your best suit if necessary.
All docker-related content for this project has been set up in the `docker` folder, which includes development compose files, production compose files and a Dockerfile for building your project.

### Building

If you don't already, install Docker Engine or Docker Desktop onto the device you are using to test locally or deploy on.
Running this project in docker is now a bit different as of 08/01/2025, due to the new `docker` folder, we now have new commands:

**Production commands:**

- Building the full project: `docker compose -f docker/prod/main.compose.yaml build`
- Running the full project: `docker compose -f docker/prod/main.compose.yaml up -d`
- Building only services: `docker compose -f docker/prod/services.compose.yaml build`
- Running only services: `docker compose -f docker/prod/services.compose.yaml up -d`

**Development commands:**

- Building the full project: `docker compose -f docker/dev/main.compose.yaml build`
- Running the full project: `docker compose -f docker/dev/main.compose.yaml up -d`
- Building only services: `docker compose -f docker/dev/services.compose.yaml build`
- Running only services: `docker compose -f docker/dev/services.compose.yaml up -d` (Command automatically runs on boot with VSC for development environments)

If this fails for whatever reason, please try troubleshoot it yourself before opening an issue.

### Running

If you haven't already, please build your project before running. Refer to the `Building` sub-section that should be just above on how to build your project.

#### To run as a Docker Stack

Refer to the section above regarding the new deployment commands.

## Thank you

Thank you for using my templates!
If you like to use them frequently, why not consider sponsoring or tipping me!
My GitHub Sponsors profile is at <https://github.com/sponsors/ninjaninja140>!
