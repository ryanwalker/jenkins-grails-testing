FROM ubuntu:14.04

RUN apt-get update &&\
    apt-get install -y wget &&\
    apt-get install -y tar

# Get server JRE, verify checksm and unpack 
RUN wget --progress=dot \
         --no-check-certificate \
         -O /tmp/server-jre-7u65-linux-x64.tar.gz \
         --header "Cookie: oraclelicense=a" \
         http://download.oracle.com/otn-pub/java/jdk/7u65-b17/jdk-7u65-linux-x64.tar.gz && \
    echo "c223bdbaf706f986f7a5061a204f641f /tmp/server-jre-7u65-linux-x64.tar.gz" | \
    md5sum -c > /dev/null 2>&1 || echo "ERROR: MD5SUM MISMATCH" && \
    tar xzf /tmp/server-jre-7u65-linux-x64.tar.gz && \
    mkdir -p /usr/lib/jvm/java-7-oracle && \
    mv jdk1.7.0_65/jre /usr/lib/jvm/java-7-oracle/jre && \
    rm -rf jdk1.7.0_65 && rm /tmp/server-jre-7u65-linux-x64.tar.gz && \
    chown root:root -R /usr/lib/jvm/java-7-oracle

# Set java version to use
RUN update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-7-oracle/jre/bin/java 1 && \
    update-alternatives --set java /usr/lib/jvm/java-7-oracle/jre/bin/java

# Install tomcat
RUN wget -O /tmp/tomcat7.tar.gz http://mirror.cogentco.com/pub/apache/tomcat/tomcat-7/v7.0.55/bin/apache-tomcat-7.0.55.tar.gz && \
    cd /opt && \
    tar zxf /tmp/tomcat7.tar.gz && \
    rm /tmp/tomcat7.tar.gz && \
    mv /opt/apache-tomcat* /opt/tomcat && \
    rm -rf /opt/tomcat/webapps/docs /opt/tomcat/webapps/examples /opt/tomcat/webapps/ROOT

ADD /opt/jenkins/data/jobs/ryans-grails-test-job/workspace//target/docker-grails.war /opt/tomcat/webapps/ROOT.war

CMD ["/opt/tomcat/bin/catalina.sh", "run"]