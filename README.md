# docker-openssh-server

## Description

This is a simple Docker container for an OpenSSH server.

The container is based on [Debian](https://www.debian.org) slim Docker image.

Here are some specifics of this container:

- This image only allows key based authentication.
- The system user name is `sshuser`.
- `sshuser` is able to `sudo` any command as any user.

| :exclamation:  Don't use this in production |
| ------------------------------------------- |
Although is applies some best practices, this image is not intended to be used in production use it at your own risk.

## Usage

### Add authorized keys

The image uses the `SSHUSER_AUTH_KEYS` environment variable to set the authorized public keys. Keys can be one after the other with a comma separation e.g.:

```shell
SSHUSER_AUTH_KEYS="ssh-rsa ABCD[...]xwz90= test1@localhost, ssh-rsa EFGH[...]lmn12= test2@localhost, ssh-rsa ABCD[...]456= test3@localhost"
```

or just with one key:

```shell
SSHUSER_AUTH_KEYS="ssh-rsa ABCD[...]xwz90= test1@localhost"
```

### Run Docker container

To run the Docker container you will need to:

- Expose the SSH port
- Set the `SSHUSER_AUTH_KEYS` environment variable

Here is an example command:

```shell
docker run -p 52222:22 -e SSHUSER_AUTH_KEYS="ssh-rsa ABCD[...]xwz90= test1@localhost" hiroru/docker-openssh-server
```
