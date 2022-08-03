# To use with own risk. Remember to change passwords/credentials accordingly
# I am not responsible for any loss or damages occured.

FROM ubuntu:22.04
LABEL Maintainer="anand@adroitts.com"
RUN mkdir /app
WORKDIR /app
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update
RUN apt install -y mariadb-server wget systemctl curl unzip zip openjdk-8-jdk expect
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
EXPOSE 3306 8090
ENV EHRSERVER_REST_SECRET=C7223782-B099-4192-BBA9-892823815BF1
ENV EHRSERVER_ALLOW_WEB_USER_REGISTER=true
ENV EHRSERVER_MYSQL_DB_USERNAME=_ehr_db_admin
ENV EHRSERVER_MYSQL_DB_PASSWORD=Make1t5tr0ng
ENV EHRSERVER_MYSQL_DB_HOST=127.0.0.1
ENV EHRSERVER_MYSQL_DB_PORT=3306
ENV EHRSERVER_DB_NAME=ehrserver2
ENV EHRSERVER_EMAIL_HOST=smtp.office365.com
ENV EHRSERVER_EMAIL_PORT=587
ENV EHRSERVER_EMAIL_USER=demo@demo.com
ENV EHRSERVER_EMAIL_PASS=%TGB6yhn
ENV EHRSERVER_EMAIL_FROM=demo@demo.com

ENTRYPOINT [ "/bin/bash", "/app/run.sh" ]
