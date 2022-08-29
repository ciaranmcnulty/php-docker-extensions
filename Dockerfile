ARG TAG=8.1

FROM php:${TAG} AS php-base

FROM php-base AS compiler-base
RUN (which apk && apk add $PHPIZE_DEPS) || true
RUN rm -rf /usr/local/lib/php/extensions/**/*.so
RUN rm -rf /usr/local/etc/php/conf.d/*.ini


FROM compiler-base AS xdebug-compiler
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug


FROM scratch AS xdebug
COPY --link --from=xdebug-compiler /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --link --from=xdebug-compiler /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d


FROM php-base AS test
COPY --link --from=xdebug / /
RUN php -m | grep "xdebug"
