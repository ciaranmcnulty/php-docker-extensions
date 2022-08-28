ARG TAG=8.1

FROM php:${TAG} AS compiler-base
RUN (which apk && apk add $PHPIZE_DEPS) || true

FROM compiler-base AS compiler
RUN pecl install xdebug
COPY --link <<EOF /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
zend_extension=xdebug
EOF

FROM scratch AS xdebug-output
COPY --link --from=compiler /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --link --from=compiler /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d


FROM php:${TAG} AS xdebug-test
COPY --link --from=xdebug-output / /
RUN php -m | grep "xdebug"
