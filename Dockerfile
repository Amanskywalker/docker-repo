#FROM quantumobject/docker-baseimage:16.04
FROM amanskywalker/my-base-image:latest

# updated ppa's
RUN echo "deb http://archive.ubuntu.com/ubuntu `cat /etc/container_environment/DISTRIB_CODENAME`-backports main restricted universe" >> /etc/apt/sources.list
RUN (echo "deb http://cran.mtu.edu/bin/linux/ubuntu `cat /etc/container_environment/DISTRIB_CODENAME`/" >> /etc/apt/sources.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9)
RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" > /etc/apt/sources.list.d/R.list &&\
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# adding required packages for this image
RUN apt-get update &&\
    apt-get install -y \
    gdebi-core \
    libapparmor1 \
    libcurl4-openssl-dev \
    libssl1.0.0 \
    r-base \
    r-base-dev \
    sudo \
    wget

RUN update-locale

# install the latest version of Rstudio
RUN wget http://download2.rstudio.org/rstudio-server-0.99.903-amd64.deb &&\
#   dpkg -i rstudio-server-*
    gdebi -n rstudio-server-0.99.903-amd64.deb

# simple scripts to do the startup task
RUN mkdir -p /etc/my_init.d
COPY startup.sh /etc/my_init.d/startup.sh
RUN chmod +x /etc/my_init.d/startup.sh

# adding demons
RUN mkdir -p /etc/service/rserver &&\
    mkdir -p /var/log/corn/config &&\
    mkdir -p /var/log/rserver ; sync
COPY rserver.sh /etc/service/rserver/run
RUN chmod +x /etc/service/rserver/run \
    && cp /var/log/cron/config /var/log/rserver/ \
    && chown -R rstudio-server /var/log/rserver

# adding user
RUN (adduser --disabled-password --gecos "" aman && echo "aman:aman"|chpasswd)

# setting up the port
EXPOSE 10010

# init system.
CMD ["/sbin/my_init"]
