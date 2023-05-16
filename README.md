# PHP 7.4 Apache Docker Container

This repository contains a Dockerfile for building a PHP 7.4 Apache Docker container with a variety of PHP extensions, libraries, and tools installed.

docker buildx build --platform linux/amd64 -t samuelfaj/docker-ttl:latest .
docker push samuelfaj/docker-ttl:latest