FROM php:7.3.3-fpm

MAINTAINER Petr Klimes <klimes@b2x.cz>

RUN apt-get update && apt-get upgrade -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpq-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libmcrypt-dev \
    libpng-dev \
    libmemcached-dev \
    libssl-dev \
    libssl-doc \
    libsasl2-dev \
    zlib1g-dev \
    libicu-dev \
    g++ \
    libxml2-dev \
    && pear install -a SOAP-0.13.0 \
    && docker-php-ext-install \
        iconv \
        mbstring \
        mysqli \
        pdo_mysql \
        sysvsem \
        sysvshm \
        sysvmsg \
        soap \
    && docker-php-ext-configure intl  \
    && docker-php-ext-install intl \
    && pecl install memcached && docker-php-ext-enable memcached \
    && yes '' | pecl install imagick && docker-php-ext-enable imagick

# install xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.client_host=127.0.0.1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

