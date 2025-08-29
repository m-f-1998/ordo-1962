# Build Stage
FROM node:slim AS builder

# There are two builds to do, in client and server
# Each has a package.json
# In client run npm ci && npm run build
# In server run npm ci && npx --yes tsc

WORKDIR /app

COPY client ./client
COPY server ./server

RUN cd ./client && npm i && npm run build && cd ..
RUN cd ./server && npm i && npx --yes tsc && cd ..

FROM node:slim

RUN mkdir -p /home/node
RUN chown -R node:node /home/node

WORKDIR /node

# Copy server output from builder
COPY --from=builder --chown=node:node /app/server/dist /node/server
COPY --from=builder --chown=node:node /app/server/package*.json /node/server

# Copy Angular dist from builder
COPY --from=builder --chown=node:node /app/client/dist/browser /node/client

RUN apt-get update && apt-get install -y --no-install-recommends nano

# Set a non-root user (optional, good practice)
USER node

# Install production dependencies
WORKDIR /node/server
RUN npm ci --omit=dev

EXPOSE 3000
CMD ["node", "index.js"]
