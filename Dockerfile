FROM lokalebasen/rubies:2.1.4
MAINTAINER Martin Neiiendam mn@lokalebasen.dk
ENV REFRESHED_AT 2014-08-25

WORKDIR /var/www/lb_dashboard/release

ENV ETCD_ENV lb_dashboard
ENV RACK_ENV production

ADD Gemfile /var/www/lb_dashboard/release/Gemfile
ADD Gemfile.lock /var/www/lb_dashboard/release/Gemfile.lock
RUN bundle install --deployment --without development test
RUN mkdir -p /var/www/lb_dashboard/shared/pids
RUN mkdir -p /var/www/lb_dashboard/shared/log

ENV BUNDLE_GEMFILE /var/www/lb_dashboard/release/Gemfile

ADD build.tar /var/www/lb_dashboard/release

EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/var/www/lb_dashboard/release/config/supervisord.conf"]
