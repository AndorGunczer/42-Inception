# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agunczer <agunczer@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/20 12:20:28 by agunczer          #+#    #+#              #
#    Updated: 2024/02/22 16:17:18 by agunczer         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all:
	docker compose -f ./srcs/docker-compose.yml up -d

# clean:
# 	docker compose -f ./srcs/docker-compose.yml down --rmi all
# 	docker system prune -a | yes | head -n 1

fclean:
	@docker system prune --all --force --volumes
	@docker volume prune --force
	@docker network prune --force
	@docker volume rm `docker volume ls -q`
	@echo "MADE CLEAN"

# re: fclean all

down:
	@docker-compose -f ./srcs/docker-compose.yml down

nginx:
	docker compose -f ./srcs/docker-compose.yml up -d

wordpress:
	docker compose -f ./srcs/docker-compose.yml up -d

db:
	docker compose -f ./srcs/docker-compose.yml up -d

ls:
	docker image ls
	docker ps

reimage:
	docker image rm -f srcs_mariadb
	docker image rm -f srcs_nginx
	docker compose -f ./srcs/docker-compose.yml up --remove-orphans

unimage:
	docker compose -f ./srcs/docker-compose.yml down
	docker image rm -f srcs_mariadb
	docker image rm -f srcs_nginx
	
complete_re:
	docker compose -f ./srcs/docker-compose.yml down
	docker system prune -a
	docker compose -f ./srcs/docker-compose.yml up -d

bash:
	docker compose -f ./srcs/docker-compose.yml up exec bash


#  mysql -u root -e "CREATE DATABASE ${WP_DB_NAME};"
# mysql -u root -e "USE '${WP_DB_NAME}'; GRANT ALL PRIVILEGES ON * TO '${MYSQL_USER}'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"
# mariadb -u root -e "CREATE USER '${MYSQL_USER}'@localhost IDENTIFIED BY '${MYSQL_PASSWORD}';"
# mariadb -u root -e "CREATE USER test1@localhost IDENTIFIED BY '${MYSQL_PASSWORD}';"