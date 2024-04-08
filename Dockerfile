FROM ubuntu:jammy
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y sudo software-properties-common
COPY ./build-tools.sh /fake-tool-cache-dir/build-tools.sh
WORKDIR /fake-tool-cache-dir
RUN ./build-tools.sh
ENTRYPOINT ["/bin/bash"]