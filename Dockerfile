FROM ubuntu:14.04
MAINTAINER Luca Versari <veluca93@gmail.com>

RUN apt-get update
RUN apt-get -y install g++
#RUN apt-get -y install fpc
RUN apt-get -y install postgresql-client
RUN apt-get -y install gettext
RUN apt-get -y install python2.7
RUN apt-get -y install iso-codes
RUN apt-get -y install shared-mime-info
RUN apt-get -y install stl-manual
RUN apt-get -y install cgroup-lite
RUN apt-get -y install supervisor
RUN apt-get -y install python-pip

COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD cgroups-mount && /usr/bin/supervisord

EXPOSE 8888 8889 8890

# This apt-get is necessary until the following adopt python wheels:
#   * psycopg2
#   * pycups
#   * PyYAML
# (And until python wheels will support Linux binaries)
RUN apt-get -y install python-dev
RUN apt-get -y install libpq-dev
RUN apt-get -y install libcups2-dev
RUN apt-get -y install libyaml-dev

ADD . /cms
RUN cd /cms && pip install -r requirements.txt && ./prerequisites.py install --as-root && ./setup.py install
WORKDIR /cms

# See above about python wheels
RUN apt-get -y remove python-dev
RUN apt-get -y remove libpq-dev
RUN apt-get -y remove libcups2-dev
RUN apt-get -y remove libyaml-dev
