FROM amanskywalker/my-base-image:latest

# cleaning any dirt left by base image
RUN apt-get clean

# updated ppa's
RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" > /etc/apt/sources.list.d/R.list &&\
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# installing Rstudio server
RUN apt-get update &&\
    apt-get -y install libapparmor1 apparmor-utils libssl1.0.0 libedit2 psmisc wget sudo &&\
    wget http://download2.rstudio.org/rstudio-server-0.99.903-amd64.deb &&\
    dpkg -i rstudio-server-* &&\


# simple scripts to do the startup task
RUN mkdir -p /etc/my_init.d
COPY startup.sh /etc/my_init.d/startup.sh
RUN chmod +x /etc/my_init.d/startup.sh

RUN mkdir -p /etc/my_init
COPY startit.sh /etc/my_init/startit.sh
RUN chmod +x /etc/my_init/startit.sh

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
