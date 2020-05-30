# ACI-Persistence

## Configuration

Mount this Folder to your Azure Container Instance as /mnt/acipersist. In this way you can enjoy persistent Hostkeys which makes your (or your customers) file transfers more secure.

If you are prototyping (or just lazy) you can even mount the Folder directly out of this git Repository.

### Persistent Host Keys

Your SFTP Server's SSH Certificates can be placed in [userkeypubs](./userkeypubs). If this Folder doesn't contain a keyfile which's filename beginns with `ssh_host_`, the Keys which are automatically generated in first run will be copied there.

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
