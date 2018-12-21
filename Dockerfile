# Pull base image.
FROM ubuntu:18.04

# LABELS
LABEL maintainer="me@girisaurav.com.np"
LABEL name="Ubuntu18NP"
LABEL version="!< 0 >!"

# Timezone for Nepal
ENV TIMEZONE Asia/Kathmandu

# Installing mode
ENV DEBIAN_FRONTEND noninteractive

# Adding Nepal Repo
ADD sources.list /etc/apt/

# Updating aptitude repository
RUN DEBIAN_FRONTEND=noninteractive apt-get update -yqq && echo "Aptitude Repo Updated"

# Installing basics
RUN apt install \
	curl \
	git \
	zip unzip \ 
	libpng-dev -yqq && echo "Installing basics completed"

# Install php and required extensions
RUN DEBIAN_FRONTEND=noninteractive apt install -yqq \
        php7.2          php7.2-bcmath       php7.2-mbstring \
        php7.2-curl     php7.2-xml          php-zip \
        php-mysql       php-pgsql           php-fpm  \
    && echo "PHP installation complete"

# Setting up timezones
RUN echo $TIMEZONE > /etc/timezone && echo "date.timezone=$TIMEZONE" > /etc/php/7.2/cli/conf.d/timezone.ini

# Installing Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer


# Installing Node and package managers
RUN apt install nodejs npm -yqq && npm -g i yarn

# Remove apache2 & install nginx
RUN apt-get purge apache2 -yqq && apt-get install nginx -yqq

# Host on port 80
EXPOSE 80