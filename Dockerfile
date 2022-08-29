ARG TAG=8.1

FROM php:${TAG} AS compiler-base
RUN (which apk && apk add $PHPIZE_DEPS) || true
RUN rm -rf /usr/local/lib/php/extensions/**/*.so
RUN rm -rf /usr/local/etc/php/conf.d/*.ini


FROM compiler-base AS xdebug-compiler
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug


FROM scratch AS xdebug-output
COPY --link --from=xdebug-compiler /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --link --from=xdebug-compiler /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d


FROM php:${TAG} AS test
COPY --link --from=xdebug-output / /
RUN php -m | grep "xdebug"
