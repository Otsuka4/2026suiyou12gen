FROM php:8.4-fpm-alpine AS php

RUN docker-php-ext-install pdo_mysql

RUN install -o www-data -g www-data -d /var/www/upload/image/

RUN echo -e "post_max_size = 5M\nupload_max_filesize = 5M" >> ${PHP_INI_DIR}/php.ini
# 1. curlの依存パッケージ、PECLビルドツールに加え、GDに必要な各種画像ライブラリを追加

RUN apk add -U --no-cache \
    curl-dev \
    $PHPIZE_DEPS \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libwebp-dev

# 2. GD拡張機能にJPEG、WebP、FreeType（フォント）のサポートを関連付ける
RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    --with-webp

# 3. コア拡張機能（curl, exif, gd）をまとめてインストール
RUN docker-php-ext-install curl exif gd

# 4. PECLを使ってAPCuをインストールし、有効化する
RUN pecl install apcu && docker-php-ext-enable apcu

# 5. ビルドが終わったら不要になった開発ツールを削除して軽量化
RUN apk del $PHPIZE_DEPS
