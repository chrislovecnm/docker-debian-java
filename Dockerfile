FROM gcr.io/google_containers/ubuntu-slim:0.6

ARG BUILD_DATE
ARG VCS_REF
ARG JAVA_VERSION

LABEL \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.name="Debian container with Java" \
    org.label-schema.url="https://github.com/vorstella/debian-java" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="https://github.com/vorstella/debian-java"

ENV \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

RUN \
    set -ex \
    && echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get update && apt-get -qq -y --force-yes install --no-install-recommends \
    openjdk-8-jre-headless \
    libjemalloc1 \
    localepurge \
    wget \
    jq \
    && apt-get clean \
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
