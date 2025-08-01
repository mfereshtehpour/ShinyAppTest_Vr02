# Use a minimal R base image instead of rocker/shiny (which uses s6-overlay)
FROM rocker/shiny:4.5.1


# Install system dependencies
# Install Linux dependencies for spatial packages
RUN apt-get update && apt-get install -y \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libtbb-dev \
    libnetcdf-dev \
    libglpk-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libsqlite3-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    default-jdk \
    build-essential \
    cmake \
    pkg-config \
    && apt-get clean


# Set JAVA_HOME (helps R find the headers and JVM libs)
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"   
    
# Install R packages needed by the app
RUN R -e "install.packages(c( \
                      'shiny', 'leaflet', 'terra', 'raster', 'sf', 'mapview', 'leafpop', 'RColorBrewer', \
                     'tidyr', 'dplyr', 'DT', 'htmltools', 'stringr', 'shinyWidgets', 'stars', 'shinybusy' \
                      ), dependencies = TRUE, repos = 'https://cloud.r-project.org/', Ncpus = parallel::detectCores())"

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
