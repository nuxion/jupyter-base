FROM python:3.7-buster

LABEL maintener="Xavier Petit <nuxion@gmail.com>"
#RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
#RUN apt-get install -y build-essential nodejs nodejs-legacy

# PYTHON DATA SCIENCE PACKAGES
ENV PYTHON_PACKAGES="\
    numpy \
    matplotlib \
    scipy \
    scikit-learn \
    pandas \
    nltk \
    spacy \
" 
ENV PACKAGES="\
	musl \
	libc6-compat \
	linux-headers \
	build-base \
	git \
	ca-certificates \
	freetype \
	libgfortran \
	libgcc \
	libstdc++ \
	openblas \
	tcl \
	tk \
	libzmq \
"
# libssl1.0 \ error missing dependency
COPY jupyter.tar /tmp/
RUN apt-get update && apt-get install -y --no-install-recommends \
		python3-dev libczmq-dev libczmq4 libzmq3-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get install -y --no-install-recommends curl \
	&& curl -sL https://deb.nodesource.com/setup_12.x | bash - \
	&& apt-get update && apt-get install -y nodejs \
	&& useradd jupyter \
	&& mkdir -p /home/jupyter \
	&& tar xvf /tmp/jupyter.tar -C /home/jupyter/ \
	&& pip3 install --no-cache-dir -r /home/jupyter/requirements.txt \
	&& pip3 install --no-cache-dir $PYTHON_PACKAGES \
    	&& chown -R jupyter:jupyter /usr/local/share/jupyter \
    	&& chown -R jupyter:jupyter /home/jupyter \
	&& rm /tmp/jupyter.tar 
USER jupyter
WORKDIR /home/jupyter/
RUN /home/jupyter/src/postBuild
EXPOSE 8888
#CMD ["jupyter", "lab", "--app-dir=/home/jupyter"]
CMD ["jupyter-lab", "--config=/home/jupyter/src/jupyter_notebook_config.py"]

