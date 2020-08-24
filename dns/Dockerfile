FROM debian:buster

RUN apt-get update
RUN apt-get install -y --no-install-recommends wget xz-utils vim dnsutils nmap dnsmasq

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 53 53/udp
ENTRYPOINT ["dnsmasq", "-k"]

