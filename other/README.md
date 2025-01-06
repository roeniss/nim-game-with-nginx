For OS, I used ubuntu 24.04.1 LTS. I'm using Apple silicon macOS but intentionally used x86 architecture just in case.

```sh
docker run -d --platform=linux/amd64 ubuntu:24.04
```

For nginx, `nginx-extras` is recommended because it contains perl dynamic module.

```sh
apt install -y nginx-extras
```

For sqlite3, I just used `sqlite3` package.

```sh
apt install -y sqlite3
```

To make proper docker image, I followed these steps:

1. Run new empty ubuntu container
2. Inside it, install nginx, perl, and sqlite3. Then, create and edit all necessary files.
3. Outside the container, commit the container to make new image.

```sh
docker commit --change='ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]' the_container nim_game
```
