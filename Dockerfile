########## OS ##########
FROM centos:centos7

RUN yum update -y && yum clean all 
RUN yum reinstall -y glibc-common
########## OS ##########


########## ENV ##########
# Set the locale(en_US.UTF-8)
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Set the locale(ja_JP.UTF-8)
#ENV LANG ja_JP.UTF-8
#ENV LANGUAGE ja_JP:ja
#ENV LC_ALL ja_JP.UTF-8

# Set app env
ENV HOME /root
ENV ELIXIR_VERSION 1.0.3
ENV DRONE_PORT 80
########## ENV ##########


########## MIDDLEWARE ##########
WORKDIR /usr/local/src

RUN yum install -y gcc gcc-c++ make openssl-devel ncurses-devel
RUN yum install -y epel-release && yum clean all 
RUN yum install -y http://packages.erlang-solutions.com/site/esl/esl-erlang/FLAVOUR_3_general/esl-erlang_17.4-1~centos~7_amd64.rpm && yum clean all 
RUN yum install -y wget && yum clean all 
RUN yum install -y git && yum clean all 
RUN yum install -y nodejs
RUN yum install -y npm 
########## MIDDLEWARE ##########

########## DRONE.IO ##########
RUN wget downloads.drone.io/master/drone.rpm
RUN yum localinstall -y drone.rpm
########## DRONE.IO ##########

########## ELIXIR ##########
# Build Elixir
RUN git clone https://github.com/elixir-lang/elixir.git
WORKDIR /usr/local/src/elixir
RUN git checkout refs/tags/v${ELIXIR_VERSION}
RUN make clean install

# Build Dialyxir
WORKDIR /usr/local/src
RUN git clone https://github.com/jeremyjh/dialyxir.git
WORKDIR /usr/local/src/dialyxir
RUN git checkout refs/tags/v${ELIXIR_VERSION}
RUN make clean install
########## ELIXIR ##########


########## ON BOOT ##########
CMD /usr/local/bin/droned --config=/etc/drone/drone.toml
########## ON BOOT ##########

