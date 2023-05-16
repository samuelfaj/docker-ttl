# Use a base image with PHP 7.4 and Apache
FROM php:7.4-apache

USER root

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -

# Update packages and install necessary libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y libssl-dev \
     libzip-dev \
     libpng-dev \
     libxml2-dev \
     libjpeg-dev \
     libfreetype6-dev \
     libwebp-dev libxpm-dev \
     git \
     unzip \
     libpq-dev \
     bash \
     supervisor \
     libonig-dev \
     libmagickwand-dev --no-install-recommends \
     curl \
     gnupg \
     apt-transport-https \
     lsb-release \
     ca-certificates \
     certbot \
     python3-certbot-apache \
     nodejs

RUN pecl install opencensus-alpha imagick
RUN docker-php-ext-enable opencensus imagick

# Configure and install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp --with-xpm

RUN docker-php-ext-install gd \
        zip \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        mysqli \
        bcmath \
        mbstring \
        bcmath \
        ctype \
        fileinfo \
        json \
        mbstring \
        pdo \
        tokenizer \
        xml

# Enable mod_rewrite for Apache
RUN a2enmod rewrite

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set the working directory
WORKDIR /var/www/html/

# Start Apache in the foreground
CMD ["apache2-foreground"]