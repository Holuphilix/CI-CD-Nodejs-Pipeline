# Stage 1 — Install dependencies
FROM node:18-alpine AS dependencies

WORKDIR /app

COPY package*.json ./
RUN npm install

# Stage 2 — Run tests
FROM dependencies AS test

COPY . .
RUN npm test

# Stage 3 — Production build
FROM node:18-alpine AS production

WORKDIR /app

COPY package*.json ./
RUN npm install --omit=dev

COPY src ./src

CMD ["node", "src/calculator.js"]
