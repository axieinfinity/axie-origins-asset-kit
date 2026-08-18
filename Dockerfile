# Origins Kit gallery — static site for Coolify.
FROM node:20-bookworm-slim AS build
WORKDIR /src
COPY showcase/package.json showcase/package-lock.json /src/showcase/
WORKDIR /src/showcase
RUN npm ci
WORKDIR /src
COPY showcase /src/showcase
COPY Assets/OriginsKit /src/Assets/OriginsKit
WORKDIR /src/showcase
RUN node scripts/build-catalog.mjs \
  && node scripts/stage-kit-public.mjs \
  && npx vite build

FROM nginx:1.27-alpine
COPY showcase/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /src/showcase/dist /usr/share/nginx/html
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s \
  CMD wget -qO- http://127.0.0.1/ >/dev/null || exit 1
