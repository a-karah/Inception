FROM alpine:3.15

RUN apk add --no-cache tini php7-fpm php7-mysqli php7-gd php7-mbstring php7-xml php7 php7-phar php7-openssl php-curl php7-tokenizer php7-json mariadb-client curl

# Download and install wp-cli
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/bin/wp --silent
RUN chmod +x /usr/bin/wp

# Download wordpress
RUN mkdir -p /var/www/wordpress && wp core download --path=/var/www/wordpress

# Copy script to tmp folder and make executable
COPY ./tools/script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh

# Copy config files
COPY ./conf/www.conf /etc/php7/php-fpm.d/www.conf

# Open port
EXPOSE 9000

# Prepend this to every CMD
ENTRYPOINT ["tini", "-vv", "--"]
# ENTRYPOINT ["tail", "-f"]

# Execute script to launch wordpress
CMD ["sh", "/tmp/script.sh"]

# docker exec -it wordpress sh