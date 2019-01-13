FROM hitalos/laravel

MAINTAINER Popsana Barida <popsyjunior@gmail.com>

#Update apt-get repos
RUN apk update && apk upgrade

#Disable user interaction
ENV DEBIAN_FRONTEND=noninteractive
  
#Install Composer
RUN curl -sS https://getcomposer.org/installer  | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

#Set Environment
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

VOLUME [ "/var/www/html" ]
WORKDIR /var/www/html


# Install Cron
#RUN apt-get install --assume-yes cron
#RUN apk -u add cron


# Add crontab file in the cron directory
#ADD crontab /etc/cron.d/animata-cron

# Give execution rights on the cron job
#RUN chmod a+x 0644 /etc/cron.d/animata-cron
#RUN chmod a+x /etc/cron.d/animata-cron

#RUN echo "* * * * * php /var/www/html/artisan schedule:run >> /dev/null 2>&1 >> /dev/null 2>&1" >> /etc/cron.d/animata-cron

# Put the command in the crontab
#RUN crontab /etc/cron.d/animata-cron

#RUN cron

#RUN cron status



#Final Checks
#RUN rc-service apache2 restart

EXPOSE 80
#EXPOSE 443

ENTRYPOINT [ "/usr/sbin/apache2" ]
CMD ["-D", "FOREGROUND"]
