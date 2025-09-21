FROM rocker/shiny:4.5.1

LABEL org.opencontainers.image.source=https://github.com/jansim/nightingale
LABEL org.opencontainers.image.description="A docker image to run the Nightingale Shiny app"
LABEL org.opencontainers.image.licenses=MIT

# Install system dependencies for graphics packages
RUN apt-get update && apt-get install -y \
    libwebp-dev \
    libwebpmux3 \
    libwebpdemux2 \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN install2.r --error devtools

# Copy the package files
COPY . /home/nightingale

# Install the nightingale package
RUN R -e "devtools::install('/home/nightingale', dependencies = TRUE)"

# Expose port for Shiny
EXPOSE 3838

# Create startup script
RUN echo 'library(nightingale)\nshow_shiny_app()' > /srv/shiny-server/app.R

# CMD is already set by the rocker/shiny image to run shiny-server
