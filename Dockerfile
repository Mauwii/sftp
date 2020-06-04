# mauwii's mod of atmoz/sftp
# origin by Adrian Dvergsdal [atmoz.net]

FROM debian:buster

VOLUME  [ "/mnt/acipersist" ]

# Steps done in one RUN layer:
# - Install packages
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys
RUN apt-get update && \
    apt-get -y install openssh-server && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd && \
    rm -f /etc/ssh/ssh_host_*key*

COPY files/sshd_config /etc/ssh/
COPY files/create-sftp-user /usr/local/bin/
COPY files/entrypoint /
COPY files/copy-hostkeys /mnt/acipersist/scripts/copy-hostkeys.sh

EXPOSE 22

ENTRYPOINT /entrypoint
