FROM denoland/deno:latest AS base
WORKDIR /usr/src/app

COPY --chown=deno:deno src/ src/
COPY --chown=deno:deno deno.lock .
COPY --chown=deno:deno deno.json .

FROM base AS builder
RUN deno cache src/Entrypoint.ts --lock=deno.lock

FROM base AS runner
# COPY --chown=node:node .env .env
COPY --chown=deno:deno entrypoint.sh entrypoint.sh

RUN chown deno:deno /usr/src/app
RUN chmod +x ./entrypoint.sh

ENV NODE_ENV="production"

USER deno

ENTRYPOINT ["./entrypoint.sh"]