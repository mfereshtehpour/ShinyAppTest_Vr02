# My Shiny App on Heroku (Docker)

This is a simple Shiny app deployed using Heroku + Docker.

## Run locally
```bash
docker build -t shinyapp .
docker run -p 3838:3838 shinyapp
