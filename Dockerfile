FROM debian:buster
# mod of atmoz/sftp
# origin by Adrian Dvergsdal [atmoz.net]

LABEL repository="mauwii"
LABEL tag="sftp:acipersist"
LABEL maintainer="mauwii@outlook.de"
LABEL description="SFTP Server with persistent Host keys. Ready for hosting as a Azure Container Instance"

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
