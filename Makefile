##########################################################
# Makefile: ローカル環境の構築と管理を行うためのファイル
#
# 使用方法:
#   make <ターゲット>
#
# 注意:
#   一部のターゲットを実行する前に、Dockerコンテナが起動していることを確認してください。
##########################################################

.PHONY: help ## make task の説明を表示する

# make コマンドの説明
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sed 's/:.*##/\t/' | awk 'BEGIN {FS = "\t"}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# OSの判別
OS := $(shell uname)

upd: ## Dockerコンテナをバックグラウンドで起動する
	docker-compose up -d

upd-build: ## Dockerコンテナをビルドしてバックグラウンドで起動する
	docker-compose up -d --build

down: ## Dockerコンテナを停止して削除する
	docker-compose down

lambda-login: ## lambda-apigatewayコンテナ内のシェルに入る
	docker exec -it lambda-apigateway bash

open_chrome: ## Google Chromeを開く
ifeq ($(OS), Darwin)
	open -a "Google Chrome"
else
	start chrome
endif

open_api_spec: ## API仕様書をブラウザで閲覧
ifeq ($(OS), Darwin)
	open -a "Google Chrome" http://localhost:8080
else
	start chrome http://localhost:8080
endif

open_dynamodb: ## DynamoDBをブラウザで閲覧
ifeq ($(OS), Darwin)
	open -a "Google Chrome" http://localhost:8001/
else
	start chrome http://localhost:8001/
endif
