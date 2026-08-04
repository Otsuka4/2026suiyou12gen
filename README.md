# 前期最終課題

# 手順書
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

# Git
- Gitcloneでリポジトリの内容を持ってくるための作業

## Gitインストール
```bash
sudo yum install git -y
```

## git clon
```bash
git clone https://github.com/Otsuka4/2026suiyou12gen.git
```

- ディレクトリに移動
``` bash
cd 2026suiyou12gen
```

- 更新をする
```bash
docker compose bild
```
- build中にエラーが出た場合は
``` bash
mkdir -p ~/.docker/cli-plugins
ARCH=$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')
BUILDX_URL=$(curl -s https://api.github.com/repos/docker/buildx/releases/latest | grep "browser_download_url.*linux-$ARCH" | cut -d '"' -f 4)
curl -L $BUILDX_URL -o ~/.docker/cli-plugins/docker-buildx
chmod +x ~/.docker/cli-plugins/docker-buildx
```
- この後
```bash
docker compose build
docker compose up
```

## 投稿したデータをMYSQLに保存するための準備

## mysqlの起動

```bash
 docker compose exec mysql mysql example_db
```

## テーブルの作成
``` bash

CREATE TABLE `zenkikadai` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `body` TEXT NOT NULL,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `image_filename` TEXT DEFAULT NULL
);
```
- この後
```bash
docker compose build
docker compose up
```

## ブラウザで最終確認
- ブラウザで開けてみて開くこと　投稿の確認
``` bash
http:// EC2インスタンスのパブリックIPアドレス/zenki.php
```
- 大きい画像ファイルが手元になければ、フリー素材 (例: イメージズラボさま https://imageslabo.com/photo/2082 ) を利用して動作チェック

## mwsqlでデータベースに保存されているのか確認
```bash
select * from zenkikadai;
```

- データが追加されていたら完成

