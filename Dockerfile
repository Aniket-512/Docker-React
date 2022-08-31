# Tag as builder phase/step
FROM node:16-alpine as builder

WORKDIR '/app'
# Copy and install dependencies first
COPY package.json .
RUN npm install
# No need for volumes in prod.
COPY . .
RUN npm run build

# Next phase - serve web content
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# Default command in base image starts up nginx for us