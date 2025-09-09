FROM openjdk:24-jdk-slim AS base

# Cài tar
RUN apt-get update && apt-get install -y tar && rm -rf /var/lib/apt/lists/*

# Copy Tomcat từ host vào image
COPY apache-tomcat-9.0.112.tar.gz /tmp/

RUN tar xzf /tmp/apache-tomcat-9.0.112.tar.gz \
    && mv apache-tomcat-9.0.112 /usr/local/tomcat \
    && rm /tmp/apache-tomcat-9.0.112.tar.gz

ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH="$CATALINA_HOME/bin:$PATH"

# Copy WAR vào Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*
COPY ch07_ex3_cart.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
