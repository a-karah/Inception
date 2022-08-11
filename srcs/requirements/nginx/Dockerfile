FROM alpine:3.15

# Install nginx and openssl
RUN apk add --no-cache tini nginx openssl

# Copy nginx config
COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf

# Copy script to tmp folder and make executable
COPY ./tools/script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh

# Generate certificate
RUN mkdir -p /etc/ssl/nginx && \
	openssl req -x509 -new -newkey rsa:4096 -sha256 -days 365 -nodes \
	-keyout /etc/ssl/nginx/nginx.key \
	-out /etc/ssl/nginx/nginx.crt -subj "/CN=akarahan.42.fr"

# Open port
EXPOSE 443

# Prepend this to every CMD
ENTRYPOINT ["tini", "-vv", "--"]

# Execute script to launch nginx
CMD ["sh", "/tmp/script.sh"]

# docker exec -it nginx sh