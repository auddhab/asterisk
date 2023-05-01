FROM ubuntu:latest

RUN apt-get update -y && apt-get upgrade -y 

RUN apt-get install -y bzip2 unixodbc bison wget openssl libssl-dev libasound2-dev libc6-dev libxml2-dev libsqlite3-dev libnewt-dev libncurses5-dev zlib1g-dev gcc g++ make perl uuid-dev git subversion unixodbc-dev autoconf libedit-dev

WORKDIR /usr/src

RUN wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-20.2.1.tar.gz

RUN tar -xzvf asterisk-20.2.1.tar.gz

WORKDIR asterisk-20.2.1

RUN ./configure --with-jansson-bundled

RUN make menuselect

RUN menuselect/menuselect --disable-all --enable chan_sip \
--enable app_dial menuselect.makeopts

RUN make && make install && make config && make samples

