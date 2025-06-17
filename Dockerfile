FROM n8nio/n8n:latest

USER root

# Instalar dependencias del sistema (sin Puppeteer, ya está incluido)
RUN apk update && apk add --no-cache \
    ffmpeg \
    python3 \
    py3-pip \
    curl \
    wget \
    git \
    bash \
    build-base \
    python3-dev \
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# Crear enlace simbólico para python
RUN ln -sf python3 /usr/bin/python

# Instalar paquetes Python
RUN pip3 install --upgrade --no-cache-dir --break-system-packages \
    yt-dlp \
    moviepy \
    pillow \
    requests \
    beautifulsoup4 \
    lxml

# Configurar Puppeteer para usar Chromium del sistema
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Crear directorios para archivos temporales
RUN mkdir -p /tmp/n8n-media && \
    mkdir -p /tmp/puppeteer && \
    chown -R node:node /tmp/n8n-media && \
    chown -R node:node /tmp/puppeteer && \
    chmod 755 /tmp/n8n-media && \
    chmod 755 /tmp/puppeteer

USER node

# Verificar instalaciones (sin instalar Puppeteer adicional)
RUN ffmpeg -version
RUN yt-dlp --version
RUN python3 -c "import moviepy; print('MoviePy OK')"
RUN python3 -c "import PIL; print('Pillow OK')"
RUN node -e "console.log('Node.js version:', process.version)"
RUN node -e "const puppeteer = require('puppeteer'); console.log('Puppeteer disponible');"

LABEL org.opencontainers.image.source="https://github.com/TU_USUARIO/n8n-custom-image"
LABEL org.opencontainers.image.description="N8N with yt-dlp, ffmpeg, video processing tools and existing Puppeteer"
LABEL org.opencontainers.image.licenses="MIT"
