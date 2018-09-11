FROM ubuntu:18.04 AS build

ENV PATH /usr/local/graalvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ARG GRAALVM_VERSION

RUN apt-get update && \
    apt-get install -y \
            curl \
            openjdk-11-jre-headless

RUN curl -L "https://github.com/oracle/graal/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-${GRAALVM_VERSION}-linux-amd64.tar.gz" | \
      tar zx -C /usr/local/ && \
      rm -f /usr/local/graalvm-ce-${GRAALVM_VERSION}/src.zip && \
      ln -s /usr/local/graalvm-ce-${GRAALVM_VERSION} /usr/local/graalvm

RUN cp /usr/lib/jvm/java-11-openjdk-amd64/lib/security/cacerts /usr/local/graalvm/jre/lib/security/cacerts

RUN apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/cache/apt /var/lib/apt/lists

FROM ubuntu:18.04

COPY --from=build /usr/local/graalvm /usr/local/

ADD Dockerfile /
ENV JAVA_HOME /usr/local/graalvm
ENV PATH /usr/local/graalvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

CMD java -version
