FROM ubuntu
LABEL tag="mauwii/sftp:ubuntu"
# originally by Adrian Dvergsdal [atmoz.net]

# Steps done in one RUN layer:
# - Install packages
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys
RUN apt-get update && \
    apt-get -y install openssh-server && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd && \
    mkdir -p /var/run/sftp/ && \
    rm -f /etc/ssh/ssh_host_*key*


VOLUME [ "/acipersist" ]
ADD acipersist/sshd_config /etc/ssh/sshd_config
ADD acipersist/create-sftp-user /usr/local/bin/
ADD acipersist/entrypoint /
ADD acipersist/sftp-users.conf /etc/sftp/users.conf


EXPOSE 22

ENTRYPOINT ["/entrypoint"]
