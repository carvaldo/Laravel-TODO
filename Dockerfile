# Imagem base com PHP 8.3 Composer, NPM e outras ferramentas.

FROM php:8.3-cli

# # Instala extensões comuns
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libicu-dev \
    libmagickwand-dev \
    zip \
    unzip \
    curl \
    nano \
    btop \
    iputils-ping \
    gsfonts \
    wget \
    npm \
    && docker-php-ext-install \
        pdo \
        pdo_mysql \
        mbstring \
        exif \
        pcntl \
        bcmath \
        gd \
        zip \
        intl \
        calendar

# Define locale como UTF-8
RUN apt-get install -y locales \
    && sed -i '/pt_BR.UTF-8/s/^# //g' /etc/locale.gen \
    && locale-gen pt_BR.UTF-8

ENV LANG=pt_BR.UTF-8
ENV LANGUAGE=pt_BR:pt
ENV LC_ALL=pt_BR.UTF-8

# Instala a extensão Imagick via PECL
RUN pecl install imagick && docker-php-ext-enable imagick

# Instala o Composer 2
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 8000

# Define diretório de trabalho
WORKDIR /var/www/html