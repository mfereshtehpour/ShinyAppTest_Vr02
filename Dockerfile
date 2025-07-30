# Use a minimal R base image instead of rocker/shiny (which uses s6-overlay)
FROM rocker/shiny:latest


# Install system dependencies
RUN apt-get update && apt-get install -y \
    libudunits2-dev libgdal-dev libgeos-dev libproj-dev libv8-dev \
    libcurl4-openssl-dev libssl-dev libxml2-dev libglpk-dev gdebi-core
    
    
# Install R packages needed by the app
RUN R -e "install.packages(c('shiny', 'leaflet', 'raster', 'sf', 'terra'), repos='https://cloud.r-project.org/')"

#RUN install2.r --error shiny 

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
