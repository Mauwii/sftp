# SFTP-User's keys

You should make your Users loging in via ssh key. To force them to do so:

* Create folders here:
* Foldername = Username
* put public keys for this user there
* remove the user's password

## how to remove passwords

### in users.conf

To use only Certificatabased authorization, just remove the Passwords from [users.conf](../sftp.d/users.conf). It's which is placed between the first and second colon:

* make: `username:password:UID:GID:Folders,to,create`
* to: `username:password:UID:GID:Folders,to,create`

If a User has no password, he is forced to authenticate via certificate. If you allow passwords it is pretty easy for Hackers to crack your password and steal your data or worse, so make sure to use Certifiacte based Authentication!

### Environment Variable
