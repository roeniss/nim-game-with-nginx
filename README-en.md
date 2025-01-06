# NIM game with nginx

[한국어](./README.md) | [English](./README-en.md)

I made a NIM game using nginx.

## NIM game?

It's a kind of mathematical mind game where a set number of stones are taken, and the last player to take the last stone wins or loses. (In this game, the last player to take the last stone wins)

## How to play

- Each user can increment the server's counter by 1 using the curl command.
- Each user can send upto 1 request per second (to prevent repeated counting).
- The first user to make the 100th request wins.

```sh
curl http://GAME_HOST_IP/count
```

## How to host

```
echo "SECRET_PRIZE_CODE" > prize.txt # create new prize code
cat prize.txt | md5sum # check the md5 hash
docker run -d --platform=linux/amd64 --network host -v $(pwd)/prize.txt:/usr/local/etc/nginx/prize.txt ghcr.io/roeniss/nim-game-with-nginx/nim-game-with-nginx:latest
```

> [!WARNING]
> Only Linux docker can transfer user's real ip. Other platform (Windows, macOS) will show 127.0.0.1 or something like that, so all users will share the rate limiter (which is another fun game).

## How the game is implemented

- When a request comes in to nginx, a handler written in perl take the request and send a response to client.
  - The perl module uses sqlite3 to update the counter.

## Build from source

There is no automated installation, but you can build your own using the files in this repository.

## Inspired by

[Click a Button, Destroy My Site by Hyperplexed (youtube)](https://youtu.be/dRsuD_ygvOc)
