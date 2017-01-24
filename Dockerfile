FROM ubuntu:16.04
MAINTAINER joshle joshle@qq.com

RUN mv /etc/apt/sources.list /etc/apt/sources.list.1
COPY sources.list /etc/apt/sources.list

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install wget fontconfig xfonts-utils bzip2 -y
ADD MicrosoftYaHei.ttf  /usr/share/fonts/
WORKDIR /usr/share/fonts/
RUN mkfontscale
RUN mkfontdir
RUN fc-cache

WORKDIR /usr/local
RUN wget https://npm.taobao.org/mirrors/node/v6.9.4/node-v6.9.4-linux-x64.tar.gz
RUN tar zxvf node-v6.9.4-linux-x64.tar.gz
RUN rm -f node-v6.9.4-linux-x64.tar.gz
RUN mv node-v6.9.4-linux-x64 node-v6.9.4
RUN mv node-v6.9.4/bin/node bin/node
WORKDIR /usr/local/bin
RUN ln -s /usr/local/node-v6.9.4/lib/node_modules/npm/bin/npm-cli.js npm
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
RUN cnpm install --global pageres-cli

RUN mkdir /pageres
WORKDIR /pageres
RUN addgroup --gid 1000 pageres
RUN adduser --uid 1000 --gid 1000 pageres --home /pageres --no-create-home --disabled-password --gecos ''
RUN chown -R pageres.pageres /pageres

ADD run.sh /run.sh
RUN chmod +x /run.sh

USER pageres
ENTRYPOINT ["/run.sh"]

