# mod of atmoz/sftp by Adrian Dvergsdal [atmoz.net]
FROM debian:stretch

# Steps done in one RUN layer:
# - Install packages
# - OpenSSH needs /var/run/sshd to run
RUN apt-get update \
    && apt-get -y install openssh-server \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/run/sshd \
    && rm -f /etc/ssh/ssh_host_*key*

COPY files/sshd_config /etc/ssh/sshd_config
COPY files/create-sftp-user /usr/local/bin/
COPY files/entrypoint /

VOLUME [ "/home/acipersist" ]
EXPOSE 2222
ENTRYPOINT ["/entrypoint"]

LABEL tag=mauwii/sftp:acipersist