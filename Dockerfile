FROM gcr.io/google_containers/ubuntu-slim:0.14

ARG BUILD_DATE
ARG JAVA_VERSION
ARG VCS_REF

ENV \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    DI_VERSION=1.2.0 \
    DI_SHA=81231da1cd074fdc81af62789fead8641ef3f24b6b07366a1c34e5b059faf363
 
LABEL \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="Apache License 2.0" \
    org.label-schema.name="Ubuntu Slim container with Java" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.url=https://github.com/vorstella/docker-java \
    org.label-schema.vcs-url=https://github.com/vorstella/docker-java 

RUN \
    set -ex \
    && echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get update \
    && apt-get -qq -y --force-yes install --no-install-recommends \
      openjdk-8-jre-headless=$JAVA_VERSION \
      libjemalloc1 \
      localepurge \
      wget \
    && wget -q -O - https://github.com/Yelp/dumb-init/releases/download/v${DI_VERSION}/dumb-init_${DI_VERSION}_amd64 > /sbin/dumb-init \
    && echo "$DI_SHA  /sbin/dumb-init" | sha256sum -c - \
    && chmod +x /sbin/dumb-init \
    && apt-get clean \
    && apt-get -y purge localepurge wget \
    && rm -rf \
        ~/.bashrc \
        /etc/systemd \
        /lib/lsb \
        /lib/udev \
        /usr/share/doc/ \
        /usr/share/doc-base/ \
        /usr/share/man/ \
        /tmp/* \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/plugin \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/javaws \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/jjs \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/orbd \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/pack200 \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/policytool \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/rmid \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/rmiregistry \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/servertool \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/tnameserv \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/unpack200 \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/javaws.jar \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/deploy* \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/desktop \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/*javafx* \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/*jfx* \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/libdecora_sse.so \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/libprism_*.so \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/libfxplugins.so \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/libglass.so \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/libgstreamer-lite.so \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/libjavafx*.so \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/libjfx*.so \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/ext/jfxrt.jar \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/ext/nashorn.jar \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/oblique-fonts \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/plugin.jar \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/man \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/images \
        /usr/lib/jvm/java-8-openjdk-amd64/man \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/THIRD_PARTY_README \
        /usr/lib/jvm/java-8-openjdk-amd64/jre/ASSEMBLY_EXCEPTION

CMD ["/bin/sh"]
