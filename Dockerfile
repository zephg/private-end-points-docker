FROM ubuntu:16.04
ARG pep_repo=${pep_repo:-git+https://github.com/encryptme/private-end-points.git}

RUN apt-get update && \
    apt-get install -y python python-pip python3 python3-pip git && \
    apt-get install -y unbound cron openvpn strongswan kmod letsencrypt && \
    apt-get install -y knot-dnsutils jq vim iputils-ping curl socat && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && \
    pip install "$pep_repo" jinja2

RUN pip3 install git+https://gitlab.toybox.ca/krayola/encryptme-metrics.git

ENV DISABLE_LETSENCRYPT 0

ADD files/ /

ENTRYPOINT ["/run.sh"]
