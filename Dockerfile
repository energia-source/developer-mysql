FROM amd64/alpine:3.15

RUN apk update && \
    apk add --no-cache mysql zip && \
    apk add --no-cache tzdata && \
    rm -rf /var/cache/apk/*

RUN cp -r /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    rm -rf /var/lib/mysql && \
    mkdir -p /var/lib/mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

COPY my.cnf /etc/my.cnf

EXPOSE 3306

VOLUME /var/lib/mysql

ENTRYPOINT mysqld
