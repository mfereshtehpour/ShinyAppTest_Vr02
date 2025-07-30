# Use a minimal R base image instead of rocker/shiny (which uses s6-overlay)
FROM rocker/r-ver:4.3.1

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    gdebi-core \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libv8-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    pandoc \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Shiny Server manually
RUN wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.16.958-amd64.deb && \
    gdebi -n shiny-server-1.5.16.958-amd64.deb && \
    rm shiny-server-1.5.16.958-amd64.deb

# Install R packages needed by the app
RUN R -e "install.packages(c('shiny', 'leaflet'), repos='https://cloud.r-project.org/')"

# Copy your app files
COPY . /srv/shiny-server/

# Optional: Add your custom shiny-server.conf if needed
# COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

# Ensure proper permissions
RUN chown -R shiny:shiny /srv/shiny-server

# Expose the port used by Shiny
EXPOSE 3838

# Default command to run Shiny Server
CMD ["/usr/bin/shiny-server"]
