FROM alpine:3.8

MAINTAINER geotaru <geotaru.dev@gmail.com>

ENV PATH /usr/local/texlive/2018/bin/x86_64-linuxmusl:$PATH

ENV USER geotaru
ENV HOME /home/${USER}

RUN apk --no-cache --update add bash
ENV SHELL /bin/bash
RUN adduser -S ${USER}

WORKDIR /root
RUN apk --no-cache --update add wget perl xz tar fontconfig-dev && \
    wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz  && \
    mkdir install-tl-unx && \
    tar xf install-tl-unx.tar.gz --strip-components 1 -C install-tl-unx

COPY texlive.profile /root/install-tl-unx/
RUN /root/install-tl-unx/install-tl \
    --repository=http://mirror.ctan.org/systems/texlive/tlnet/ \
    --profile=/root/install-tl-unx/texlive.profile && \
    tlmgr install \
        collection-basic collection-latex \
        collection-latexrecommended collection-latexextra \
        collection-fontsrecommended collection-langjapanese latexmk && \
    ( tlmgr install xetex || exit 0 ) && \
    rm -rf /root/install-tl-unx && \
    apk --no-cache del wget xz tar fontconfig-dev && \
    rm -rf /root/install-tl-unx

COPY ./compile.sh /opt/compile
RUN chmod 777 /opt/compile

USER ${USER}
WORKDIR ${HOME}/workdir
ENV target ${HOME}/target.tex

CMD /opt/compile ${target}
