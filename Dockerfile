#
# -- build minimal redmine image and patch it for reply emails --
#
FROM redmine:4.1.1-alpine
 
ENV PYTHONUNBUFFERED=1
 
RUN echo "**** install Python ****" && \
   apk update; \
   apk add --no-cache python3 && \
   if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
   \
   echo "**** install pip ****" && \
   python3 -m ensurepip && \
   rm -r /usr/lib/python*/ensurepip && \
   pip3 install --no-cache --upgrade pip setuptools wheel && \
   if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi
 
WORKDIR /usr/src/redmine
 
COPY requirements.txt /usr/src/redmine
RUN  pip install -r /usr/src/redmine/requirements.txt
 
COPY get_projects.py /usr/src/redmine/
COPY createissue.sh /usr/src/redmine/
COPY mail_handler.rb /usr/src/redmine/app/models/mail_handler.rb
COPY database.yml /usr/src/redmine/config/database.yml
COPY  secrets.yml /usr/src/redmine/config/secrets.yml
 
RUN chmod +x /usr/src/redmine/get_projects.py
RUN chmod +x /usr/src/redmine/createissue.sh


CMD ["rails", "server", "-b", "0.0.0.0"]
 
