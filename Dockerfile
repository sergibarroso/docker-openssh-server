FROM debian:11-slim

ENV SSHUSER_AUTH_KEYS=

RUN apt-get update && apt-get -y install openssh-server sudo

RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config \
  && sed -i 's/PermitRootLogin\ without-password/PermitRootLogin\ no/' /etc/ssh/sshd_config

RUN mkdir /run/sshd \
  && useradd -m -d /home/sshuser sshuser \
  && cd /home/sshuser && mkdir .ssh \
  && chmod 700 .ssh \
  && chown -R sshuser:sshuser .ssh \
  && sudo adduser sshuser sudo \
  && echo "sshuser ALL=NOPASSWD: ALL">>/etc/sudoers

COPY entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh

EXPOSE 22

ENTRYPOINT [ "/entrypoint.sh" ]
