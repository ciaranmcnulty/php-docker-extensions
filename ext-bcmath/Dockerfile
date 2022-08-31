FROM compiler-base AS compiler

RUN docker-php-ext-install bcmath


FROM scratch AS output

COPY --link --from=compiler /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --link --from=compiler /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d
