# Pull base image.
FROM ubuntu:18.04

# Timezone for Nepal
ENV TIMEZONE Asia/Kathmandu

# Adding Nepal Repo
ADD sources.list /etc/apt/

# Updating aptitude repository
RUN DEBIAN_FRONTEND=noninteractive apt-get update -yqq && echo "Aptitude Repo Updated"

# Installing basics
RUN apt install curl git libpng-dev zip unzip nginx -yqq && echo "Installing basics completed"

RUN echo "installing php and required extensions" && \
    DEBIAN_FRONTEND=noninteractive apt install -yqq \
        php7.2          php7.2-bcmath       php7.2-mbstring \
        php7.2-curl     php7.2-xml          php-zip \
        php-mysql       php-pgsql           php-fpm  \
    && echo "PHP installation complete"

# Installing Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Installing Node and package managers
RUN apt install nodejs npm -yqq && npm -g i yarn

# Setting up timezones
RUN echo $TIMEZONE > /etc/timezone && echo "date.timezone=$TIMEZONE" > /etc/php/7.2/cli/conf.d/timezone.ini

EXPOSE 80