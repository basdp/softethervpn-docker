FROM ubuntu:18.04
RUN apt-get -y update && apt-get -y upgrade && apt-get -y install ca-certificates build-essential wget
RUN wget -O /softether.tar.gz https://www.softether-download.com/files/softether/v4.29-9680-rtm-2019.02.28-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.29-9680-rtm-2019.02.28-linux-x64-64bit.tar.gz
RUN tar -xzf /softether.tar.gz -C /usr/local && rm /softether.tar.gz
RUN cd /usr/local/vpnserver && make i_read_and_agree_the_license_agreement
RUN mkdir -p /etc/vpnserver && touch /etc/vpnserver/vpn_server.config && ln -sf /etc/vpnserver/vpn_server.config /usr/local/vpnserver/vpn_server.config
EXPOSE 443/tcp 992/tcp 1194/udp 5555/tcp
VOLUME [ "/etc/vpnserver" ]
ENTRYPOINT [ "/usr/local/vpnserver/vpnserver", "execsvc" ]