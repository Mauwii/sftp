# ACI-Persistence

## Introduction

Mount this Folder to your Azure Container Instance as `/mnt/acipersist`. In this way you can:

* enjoy persistent Hostkeys which makes file transfers more secure for you and your customers
* manage Userconfigurationfile without rebuilding your Container
* manage the SFTP Server's SSH Host keys
* manage the SFTP User's public Keys

If you are prototyping (or just lazy) you can even mount the Folder directly out of this git Repository.

## Configuration

### Persistent Host Keys

Your SFTP Server's SSH Certificates can be placed in [hostkeys](./hostkeys). If this Folder doesn't contain a keyfile which's filename matches `ssh_host_rsa_key` or `ssh_host_ed25519`, the missing Keys will be generated in first run and then copied over.

#### Todo

* add automatic public key generation/update

### Scripts to run

Scripts you want to be executed before SSHD get's started should be placed in [scripts](./scripts). All files ending to .sh will be set to executable automatically, so dont place experiments in it!

### Certificate based Userauthentication

To enable Userauthenticatin via Certificate, create a folder in [/mnt/userkeypubs](./userkeypubs). Name it like the owners Username and copy the keys to be enabled into it:

/mnt/acipersist/userkeypubs/username/keys.pub

### how to remove passwords

#### in users.conf

To use only Certificatabased authorization, just remove the Passwords from [users.conf](./sftp.d/users.conf). It is placed between the first and second colon:

1. from:

        username:password:UID:GID:Folder1,Folder2,Folder3

2. to:

        username::UID:GID:Folder1,Folder2,Folder3

If a User has no password set, certificate based authentication is forced. So if you allow passwords, it is more easy for Hackers to break into your Machine and steal your data or worse! So please make sure to always use Certifiacte based Authentication!

#### Environment Variable SFTP_USERS

You can also set Users in the Environment Variable SFTP_USERS, syntax is similar to [users.conf](./sftp.d/users.conf)
