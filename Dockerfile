FROM n8nio/n8n:latest

# Cambiar a usuario root para instalar paquetes
USER root

# Actualizar e instalar dependencias (Alpine Linux usa apk)
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

# Crear enlace simbólico para python (por compatibilidad)
RUN ln -sf python3 /usr/bin/python

# Instalar yt-dlp
RUN pip3 install --upgrade --no-cache-dir \
    yt-dlp \
    whisper \
    moviepy \
    pillow

# Crear directorio para archivos temporales
RUN mkdir -p /tmp/n8n-media && chown -R node:node /tmp/n8n-media

# Volver al usuario n8n
USER node

# Verificar instalaciones
RUN ffmpeg -version
RUN yt-dlp --version
RUN python3 --version

# Etiquetas de la imagen
LABEL org.opencontainers.image.source="https://github.com/TU_USUARIO/n8n-custom-image"
LABEL org.opencontainers.image.description="N8N with yt-dlp, ffmpeg and video processing tools"
LABEL org.opencontainers.image.licenses="MIT"
