# PHP Extensions for Docker

This repo provides pre-compiled PHP extensions for use with the 'official' PHP images (e.g. `php:latest`)

## Rationale

It's relatively easy to compile PHP extensions from source in the official images, but without additional cacheing this 
can be slow.

If you have the expertise to build the extensions and configure caching, please do that! This project is for people
who are not able to do so, or want to avoid the complexity.

## Usage

Simply `COPY` the relevant image's entire filesystem over the PHP official image (if using a recent buildkit the `--link` 
will make this slightly more efficient).

```Dockerfile
FROM php:8.1

COPY --link --from=ciaranmcnulty/php-ext-xdebug:8.1 / /
COPY --link --from=ciaranmcnulty/php-ext-pcntl:8.1 / /
```

NOTE it is important that the tag for the official image and the extension match

## Supported PHP versions

We support all of the tags on the official image except:

 1. PHP <8.1
 2. Older debian
 3. Older alpine
 4. RC releases

Contributions to expand this support will definitely be considered

## Supported extensions

| PHP extension | Docker image                                                                                          |
|---------------|-------------------------------------------------------------------------------------------------------|
| bcmath        | [ciaranmcnulty/php-ext-bcmath](https://hub.docker.com/repository/docker/ciaranmcnulty/php-ext-bcmath) |
| pcntl         | [ciaranmcnulty/php-ext-pcntl](https://hub.docker.com/repository/docker/ciaranmcnulty/php-ext-pcntl)   |
| xdebug        | [ciaranmcnulty/php-ext-xdebug](https://hub.docker.com/repository/docker/ciaranmcnulty/php-ext-xdebug) |

### Adding an extension

We'd love to see more extensions supported

 * Create a new folder representing the extension's name (e.g. `ext-foo`)
 * Add a Dockerfile to that folder that builds the extension
 * Edit `docker-bake.hcl` to add that image to the build
