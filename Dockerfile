FROM nate/pageres:latest 
MAINTAINER nate@endot.org

USER root
RUN apt-get update
RUN mkdir -p /usr/share/fonts/chinese/TrueType
ADD MicrosoftYaHei.ttf /usr/share/fonts/chinese/TrueType
RUN chmod 755 /usr/share/fonts/chinese/TrueType/*.ttf
RUN apt-get install xfonts-utils fontconfig -y
RUN mkfontscale
RUN mkfontdir
RUN fc-cache -fv

USER pageres
ENTRYPOINT ["/run.sh"]
