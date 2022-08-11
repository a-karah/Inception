FROM alpine:3.15

# Install mariadb server and client
RUN apk add --no-cache tini mariadb mariadb-client openrc
RUN rc-status && touch /run/openrc/softlevel

# Copy default server config
COPY ./conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf

# Initialize database
RUN mysql_install_db --datadir=/var/lib/mysql --user=mysql

# Copy script to tmp folder and make executable
COPY ./tools/script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh

# Open port
EXPOSE 3306

# Prepend this to every CMD
ENTRYPOINT ["tini", "-vv", "--"]

# Execute script to launch mysql
CMD ["sh", "/tmp/script.sh"]

# docker exec -it mariadb sh