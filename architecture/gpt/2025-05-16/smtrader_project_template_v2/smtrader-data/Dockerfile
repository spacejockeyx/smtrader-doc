FROM postgres:15-alpine

ENV POSTGRES_USER=smtrader
ENV POSTGRES_PASSWORD=smtraderpass
ENV POSTGRES_DB=smtraderdb

COPY ./sql /docker-entrypoint-initdb.d

COPY ./init-db.sh /docker-entrypoint-initdb.d/init-db.sh
RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh