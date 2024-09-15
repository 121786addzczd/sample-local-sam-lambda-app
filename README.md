# sample-front-server-app
API機能を格納するリポジトリ

## 環境構築

### コンテナ作成・起動
以下のコマンドで、Dockerコンテナをビルドしてバックグラウンドで起動します。
```shell
docker-compose up -d --build
```

### Lambda-APIGatewayコンテナにログイン
コンテナ内にアクセスするには、次のコマンドを実行します。
```shell
docker exec -it lambda-apigateway bash
```

## API仕様書の閲覧
ブラウザで以下のURLにアクセスすると、OpenAPIで記述されたAPI仕様書を確認できます。
http://localhost:8080

## DynamoDBの内容の確認
ブラウザで以下のURLにアクセスすると、DynamoDBのデータ内容を確認できます。
http://localhost:8001/