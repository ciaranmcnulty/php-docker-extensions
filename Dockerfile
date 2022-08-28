# Image with shared dependencies for compiling the extensions
FROM php-base AS compiler-base

RUN (which apk && apk add $PHPIZE_DEPS) || true
RUN rm -rf /usr/local/lib/php/extensions/**/*.so
RUN rm -rf /usr/local/etc/php/conf.d/*.ini


# Checks all the extensions are registerable via COPY
FROM php-base AS test

COPY --link --from=xdebug / /
RUN php -m | grep "xdebug"
