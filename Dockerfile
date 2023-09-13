# ----------------------------------------------------------------------------------------
# IMAGE RESIZE
# ----------------------------------------------------------------------------------------
FROM ubuntu as imagetool
LABEL maintainer="aus der Technik"
LABEL Description="image processor"

# Install OS updates and, if needed
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true
RUN apt-get update && apt-get install -y apt-utils apt-transport-https ca-certificates
RUN apt update \
    && apt dist-upgrade -y
RUN apt install -y \
    procps \
    curl gnupg \
    ffmpeg

RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
    | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
ENV NODE_MAJOR=20
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main"\
    | tee /etc/apt/sources.list.d/nodesource.list
RUN apt update && \
    apt-get install -y nodejs

RUN npm install -g avif

WORKDIR /

# Add the entrypoint
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
