# Copyright (c) 2016-present Mattermost, Inc. All Rights Reserved.
# See License.txt for license information.
FROM mysql:5.7

RUN apt-get update && apt-get install -y ca-certificates

#
# Configure SQL
#

ENV MYSQL_ROOT_PASSWORD=mostest
ENV MYSQL_USER=mmuser
ENV MYSQL_PASSWORD=mostest
ENV MYSQL_DATABASE=mattermost_test

#
# Configure Mattermost
#
WORKDIR /mm

# Copy over files
ADD https://github.com/nafisfaysal/mogiteams/releases/download/v1.0/mogiteams-v1.tar.gz .
RUN tar -zxvf ./mogiteams-v1.tar.gz
ADD config_docker.json ./mattermost/config/config_docker.json
ADD docker-entry.sh .

RUN chmod +x ./docker-entry.sh
ENTRYPOINT ./docker-entry.sh

# Mattermost environment variables
ENV PATH="/mm/mattermost/bin:${PATH}"

# Create default storage directory
RUN mkdir ./mattermost-data
VOLUME /mm/mattermost-data

# Ports
EXPOSE 8065
