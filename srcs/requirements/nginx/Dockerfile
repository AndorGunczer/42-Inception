FROM debian:bookworm

RUN apt-get update -y && apt-get install nginx -y

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# TESTING
# RUN apt-get install net-tools iputils-ping less -y

CMD ["nginx", "-g", "daemon off;"]