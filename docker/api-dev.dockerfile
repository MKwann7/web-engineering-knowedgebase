FROM alpine:3

# Install packages
RUN apk --no-cache add nano curl nginx p7zip supervisor nghttp2 \
    php8 php8-fpm php8-mysqli php8-json php8-openssl php8-curl \
    php8-zlib php8-xml php8-phar php8-intl php8-dom php8-xmlreader php8-ctype php8-session \
    php8-mbstring php8-gd php8-pdo php8-pdo_pgsql php8-pdo_mysql \
    php8-posix php8-fileinfo php-tokenizer php-xmlwriter

# Configure nginx
COPY docker/setup/config/nginx.conf /etc/nginx/nginx.conf
# Remove default server definition
RUN rm /etc/nginx/http.d/default.conf

# Configure PHP-FPM
COPY docker/setup/config/fpm-pool.conf /etc/php8/php-fpm.d/www.conf
COPY docker/setup/config/php.ini /etc/php8/conf.d/custom.ini

# Configure supervisord
COPY docker/setup/config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup document root
RUN mkdir -p /app/code
RUN mkdir -p /app/logs
RUN mkdir -p /app/k6
RUN mkdir -p /app/ssl
RUN mkdir -p /app/list
RUN mkdir -p /app/storage
RUN mkdir -p /app/storage/ssl
RUN mkdir -p /app/storage/core
RUN mkdir -p /app/storage/uploads
RUN mkdir -p /app/storage/commands
RUN mkdir -p /app/storage/modules
RUN mkdir -p /app/storage/modules/company
RUN mkdir -p /app/tmp
RUN addgroup nobody xfs

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R nobody.nobody /app/code && \
    chown -R nobody.nobody /app/ssl && \
    chown -R nobody.nobody /app/list && \
    chown -R nobody.nobody /app/storage && \
    chown -R nobody.nobody /app/tmp && \
    chown -R nobody.nobody /app/logs && \
    chown -R nobody.nobody /app/k6 && \
    chown -R nobody.nobody /run && \
    chown -R nobody.nobody /var/lib/nginx && \
    chown -R nobody.nobody /var/log/nginx

# Switch to use a non-root user from here on
USER nobody

# Add application
WORKDIR /app/code
COPY --chown=nobody src /app/code

COPY docker/env/app-dev.env /app/code/.env

# Expose the port nginx is reachable on
EXPOSE 8080 4443

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://localhost:8080/fpm-ping
