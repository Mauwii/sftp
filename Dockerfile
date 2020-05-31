# mod of atmoz/sftp
# origin by Adrian Dvergsdal [atmoz.net]
FROM debian:buster
LABEL tag="mauwii/sftp:acipersist"
LABEL description="SFTP Server with persistent Host keys, prepared to be hosted as ACI (Azure Container Istance)"

VOLUME ["/mnt/acipersist"]

# Steps done in one RUN layer:
# - Install packages
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys
RUN apt-get update && \
    apt-get -y install openssh-server && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd && \
    rm -f /etc/ssh/ssh_host_*key*

COPY AciPersist/sshd/sshd_config /etc/ssh/sshd_config
COPY files/create-sftp-user /usr/local/bin/
COPY files/entrypoint /

EXPOSE 22

ENTRYPOINT ["/entrypoint"]
