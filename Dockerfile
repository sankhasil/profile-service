FROM maven:3-openjdk-11 AS artifactory

ADD ./ /root/profile-service
WORKDIR /root/profile-service
RUN mvn clean package


FROM openjdk:11-jdk-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    netbase \
    netcat \
    wget \
    bzip2 \
    unzip \
    xz-utils \
    dialog \
    apt-utils \
	&& set -ex; \
    if ! command -v gpg > /dev/null; then \
    apt-get install -y --no-install-recommends \
    gnupg \
    dirmngr \
    ; \
    fi

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home

# do some fancy footwork to create a JAVA_HOME that's cross-architecture-safe
RUN ln -svT "/usr/lib/jvm/java-8-openjdk-$(dpkg --print-architecture)" /docker-java-home
ENV JAVA_HOME /docker-java-home

COPY --from=artifactory /root/profile-service/target/profile-service-*.jar /opt/profile-service-rest/
COPY profile-service-entrypoint.sh /usr/local/bin/
COPY goss.yaml /opt/profile-service-rest/

RUN cd /opt/profile-service-rest && \
    chmod +x /usr/local/bin/profile-service-entrypoint.sh

ENTRYPOINT ["profile-service-entrypoint.sh"]
