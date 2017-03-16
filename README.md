# Docker-Repo

A docker Images for Rstudio and postgresql connected together via bridge network (internal network) and few port are exposed to make use of internet for remote access

## Images on hub.docker.com

[amanskywalker/rstudio-image](https://hub.docker.com/r/amanskywalker/rstudio-image/)

## Images used

In this Repository Official image of postgres is used

Rstudio is built using the Dockerfile which is buit on the top of amanskywalker/my-base-image (a general image build to used as the base of complex images)

Both of this images are made to communicate with each other using docker bridge network

## Live instance

Just of testing purpose a demo instance of Rstudio present at <ip>:8787 which is the same image metioned Here.

## How to Run this?

1. [Install Docker Compose](https://docs.docker.com/compose/install/)
1. Clone this repository
1. Run all containers with `docker-compose up -d`
1. Rstudio web-interface can be accessed via <ip>:8787 using default username:password is aman:aman

To change the username and password change the following line in Dockerfile accordingly
`RUN (adduser --disabled-password --gecos "" aman && echo "aman:aman"|chpasswd)`

## Contribution

1. Fork the Repository.
1. Work out the changes.
1. Create a pull request to add those change in this Repository.

## friendly note
  There is so much here just go ahead a explore it. Any Questions/Suggestion just message me.
