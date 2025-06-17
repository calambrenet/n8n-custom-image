FROM n8nio/n8n:latest

# Cambiar a usuario root para instalar paquetes
USER root

# Actualizar e instalar dependencias
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    python3-pip \
    curl \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# Instalar yt-dlp (versión más reciente)
RUN pip3 install --upgrade yt-dlp

# Instalar herramientas adicionales para video
RUN pip3 install \
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
