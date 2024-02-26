FROM debian:buster

RUN apt-get update -y

# RUN service mysql stop
# RUN apt-get purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-* -y
RUN apt-get install mariadb-server mariadb-client -y

COPY ./conf/script.sh script.sh
RUN chmod +x ./script.sh
# # USER root

# # TESTING
# # RUN apt-get install net-tools iputils-ping -y

ENTRYPOINT ["./script.sh"]