FROM n8nio/n8n:latest

USER root

# Instalar dependencias del sistema
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

# Instalar solo los paquetes esenciales (sin whisper para evitar conflictos)
RUN pip3 install --upgrade --no-cache-dir --break-system-packages \
    yt-dlp \
    moviepy \
    pillow \
    requests \
    beautifulsoup4 \
    lxml

# Crear directorio para archivos temporales
RUN mkdir -p /tmp/n8n-media && \
    chown -R node:node /tmp/n8n-media && \
    chmod 755 /tmp/n8n-media

USER node

# Verificar instalaciones
RUN ffmpeg -version
RUN yt-dlp --version
RUN python3 -c "import moviepy; print('MoviePy OK')"
RUN python3 -c "import PIL; print('Pillow OK')"

LABEL org.opencontainers.image.source="https://github.com/TU_USUARIO/n8n-custom-image"
LABEL org.opencontainers.image.description="N8N with yt-dlp, ffmpeg and video processing tools"
