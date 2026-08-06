NAME		= inception

USER		= $(shell whoami)
DATA_DIR	= /home/$(USER)/data
COMPOSE		= docker compose -f srcs/docker-compose.yml

all: $(NAME)

$(NAME): data
	@$(COMPOSE) up --build -d

data:
	@mkdir -p $(DATA_DIR)/mariadb
	@mkdir -p $(DATA_DIR)/wordpress

up: data
	@$(COMPOSE) up --build -d

down:
	@$(COMPOSE) down

clean:
	@$(COMPOSE)  down -v

fclean: clean
	sudo rm -rf $(DATA_DIR)

re: fclean all