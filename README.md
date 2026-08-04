# 前期最終課題

# サービス構築
## vimのインストール
```bash
sudo yum install vim -y
```

- vimをインストールした後、設定ファイルを開き書き込む
```bash
vim ~/.vimrc
```
- 中身の例
 - https://qiita.com/morikooooo/items/9fd41bcd8d1ce9170301

## screenのインストール
```bash
sudo yum install screen -y
```
- screenを起動するscreenは今後常に起動させて作業する

- screenの設定ファイルを書く
```bash
vim ~/.screenrc
```
- 中身の例
 - https://qiita.com/kamykn/items/9939b67e923dbb87f39c

## Dockerのインストール&自動起動化
```bash
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
```
- sudoがなくてもdockerコマンドをたたけるように、dockerグループに追加
```bash
sudo usermod -a -G docker ec2-user
```

- 一度ログアウトして再起動

## Docker Compose インストール
```bash
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v5.1.2/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
```
- インストールができたか確認 バージョンが表示されたらOK
```bash
docker compose version
```

