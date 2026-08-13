FROM debian:bookworm

RUN apt update && apt install -y nginx openssl

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /etc/nginx/ssl/certs \
	&& openssl req -x509 -noenc -days 356 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/certs/certificate.key \
	-out /etc/nginx/ssl/certs/certificate.crt \
	-subj "/C=MA/ST=khouribga/L=khouribga/O=1337/CN=${DOMAIN_NAME}"

CMD ["nginx", "-g", "daemon off;"]