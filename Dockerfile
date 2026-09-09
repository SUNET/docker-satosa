FROM python:3.11-trixie

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    libffi-dev \
    libssl-dev \
    xmlsec1 \
    libyaml-dev
RUN python -m pip install --upgrade pip setuptools
COPY .requirements.txt requirements.txt
RUN python -m pip install -r requirements.txt

# Set language to prevent errors when breaking
# into the container to run satosa-saml-metadata.
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

COPY start.sh /tmp/satosa/start.sh
COPY attributemaps /tmp/satosa/attributemaps
ENTRYPOINT ["/tmp/satosa/start.sh"]
