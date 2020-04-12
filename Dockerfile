FROM python:3.7-alpine

LABEL maintener="Xavier Petit <nuxion@gmail.com>"
#RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
#RUN apt-get install -y build-essential nodejs nodejs-legacy
COPY jupyter.tar /tmp/
RUN  apk add --no-cache build-base python3-dev build-base libzmq musl-dev zeromq-dev nodejs npm \
	&& adduser -Dhsk jupyter \
	&& mkdir -p /home/jupyter 
RUN tar xvf /tmp/jupyter.tar -C /home/jupyter/ \
	&& pip3 install --no-cache -r /home/jupyter/requirements.txt \
    	&& chown -R jupyter:jupyter /usr/local/share/jupyter \
    	&& chown -R jupyter:jupyter /home/jupyter \
	&& rm /tmp/jupyter.tar
USER jupyter
WORKDIR /home/jupyter/
RUN /home/jupyter/src/postBuild
EXPOSE 8888
#CMD ["jupyter", "lab", "--app-dir=/home/jupyter"]
CMD ["jupyter-lab", "--config=/home/jupyter/src/jupyter_notebook_config.py"]

