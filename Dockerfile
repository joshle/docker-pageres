FROM ubuntu:16.04
MAINTAINER nate@endot.org

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install libfontconfig libfreetype6 software-properties-common -y
RUN add-apt-repository ppa:chris-lea/node.js -y
RUN apt-get update
RUN apt-get install nodejs -y

RUN npm install --global pageres

RUN mkdir /pageres
WORKDIR /pageres
RUN addgroup --gid 1000 pageres
RUN adduser --uid 1000 --gid 1000 pageres --home /pageres --no-create-home --disabled-password --gecos ''
RUN chown -R pageres.pageres /pageres

RUN mkdir -p /usr/share/fonts/chinese/TrueType
ADD MicrosoftYaHei.ttf /usr/share/fonts/chinese/TrueType
RUN chmod 755 /usr/share/fonts/chinese/TrueType/*.ttf
RUN apt-get install xfonts-utils fontconfig -y
RUN mkfontscale
RUN mkfontdir
RUN fc-cache -fv

ADD run.sh /run.sh
RUN chmod +x /run.sh

USER pageres
ENTRYPOINT ["/run.sh"]

