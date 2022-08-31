FROM compiler-base AS compiler

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug


FROM scratch AS output

COPY --link --from=compiler /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --link --from=compiler /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d
