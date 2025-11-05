# ═══════════════════════════════════════════════════════════
# OFFICIAL NODE 18 ON UBUNTU 24.04 — SHA-LOCKED FOREVER
# ═══════════════════════════════════════════════════════════
FROM node:18@sha256:66460d557b25769b102175144d538d88219c077c678a49af4afca6fbfc1b5252

# Set working directory
WORKDIR /app

# Copy only package files first (caching magic)
COPY package*.json ./
RUN npm ci --only=production

# Copy source code
COPY . .

# Expose port
EXPOSE 3001

# Health check (optional but pro)
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
  CMD curl -f http://localhost:3001/health || exit 1

# Start the app
CMD ["node", "app.js"]