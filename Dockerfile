FROM ubuntu:24.04

RUN apt update
RUN apt install pipx curl ssh nano iputils-ping -y
RUN pipx install --include-deps ansible
RUN pipx inject ansible passlib

RUN curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh; \
  chmod +x install-opentofu.sh; \
  ./install-opentofu.sh --install-method deb; \
  rm -f install-opentofu.sh

RUN echo "export PATH=$PATH:/root/.local/bin" >> /root/.bashrc

WORKDIR "/data"

COPY . /data
