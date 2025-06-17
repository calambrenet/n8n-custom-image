FROM n8nio/n8n:latest

# Cambiar a usuario root
USER root

# Actualizar e instalar dependencias del sistema
RUN apk update && apk add --no-cache \
    ffmpeg \
    python3 \
    py3-pip \
    curl \
    wget \
    git \
    bash \
    build-base \
    python3-dev

# Crear enlace simbólico para python
RUN ln -sf python3 /usr/bin/python

# Instalar paquetes Python usando --break-system-packages (seguro en contenedor)
RUN pip3 install --upgrade --no-cache-dir --break-system-packages \
    yt-dlp \
    openai-whisper \
    moviepy \
    pillow \
    requests

# Crear directorio para archivos temporales
RUN mkdir -p /tmp/n8n-media && \
    chown -R node:node /tmp/n8n-media && \
    chmod 755 /tmp/n8n-media

# Volver al usuario node
USER node

# Verificar que todo funciona
RUN ffmpeg -version
RUN yt-dlp --version
RUN python3 --version

LABEL org.opencontainers.image.source="https://github.com/TU_USUARIO/n8n-custom-image"
LABEL org.opencontainers.image.description="N8N with yt-dlp, ffmpeg and video processing tools"
LABEL org.opencontainers.image.licenses="MIT"
