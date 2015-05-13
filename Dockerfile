########## OS ##########
FROM xtity/docker-centos7-elixir
########## OS ##########


########## DRONE.IO ##########
ENV DRONE_PORT 80

RUN wget downloads.drone.io/master/drone.rpm
RUN yum localinstall -y drone.rpm
########## DRONE.IO ##########


########## ON BOOT ##########
CMD /usr/local/bin/droned --config=/etc/drone/drone.toml
########## ON BOOT ##########

