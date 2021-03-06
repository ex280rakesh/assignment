FROM centos
MAINTAINER Maintainer_Name

# Update image
RUN yum install httpd -y && yum clean all

# Add configuration file
RUN sed -i "s/Listen 80/Listen 8080/" /etc/httpd/conf/httpd.conf && \
  chown apache:0 /etc/httpd/conf/httpd.conf && \
  chmod g+r /etc/httpd/conf/httpd.conf && \
  chown apache:0 /var/log/httpd && \
  chmod g+rwX /var/log/httpd && \
  chown apache:0 /var/run/httpd && \
  chmod g+rwX /var/run/httpd
RUN mkdir -p /var/www/html && echo "hello world!" >> /var/www/html/index.html && \
  chown -R apache:0 /var/www/html && \
  chmod -R g+rwX /var/www/html
EXPOSE 8080
USER apache

# Start the service
CMD mkdir /run/httpd ; /usr/bin/printenv HOSTNAME MY_POD_IP > /var/www/html/index.html ; /usr/sbin/httpd -D FOREGROUND
