# Application overview
Suricata

* Signature files located in `/var/lib/suricata/rules`
* Alerts located in `/var/log/suricata` directory
* Reload rules using `$ suricata-update`
* Restart Suricata service using `$ sudo systemctl restart suricata`

## Kali
The Suricata instance on Kali runs in a docker container.  

## Ubuntu
The Suricata instance on Ubuntu runs in a docker container.

# Runtime environment setup
## Kali
1. Download files to build container
    ```
    $ wget https://raw.githubusercontent.com/jhu-information-security-institute/NwSec/master/applications/suricata/suricata_KaliX86-64.sh`
    $ chmod +x suricata_kaliX86-64.sh
    $ ./suricata_kaliX86-64.sh
    ```
1. Build, run, attach to container
    ```
    $ docker build -t tsuricata .
    $ docker run -d --name suricata --hostname jhedid-suricata.netsec.isi.jhu.edu --add-host jhedid-suricata.netsec.isi.jhu.edu:127.0.1.1 --dns 172.16.0.10 --dns-search netsec.isi.jhu.edu --privileged --security-opt seccomp=unconfined --cgroup-parent=docker.slice --cgroupns private --tmpfs /tmp --tmpfs /run --tmpfs /run/lock --network host --cpus=1 tsuricata:latest \n\
    $ docker exec -it suricata bash 
    ```
1. Edit `/var/lib/suricata/rules/test-ping.rules` and update IP addresseses appropriately
1. Reload rules
1. Restart Suricata

## Ubuntu
1. Download files to build container
    ```
    $ wget https://raw.githubusercontent.com/jhu-information-security-institute/NwSec/master/applications/suricata/suricata_UbuntuServerX86-64.sh`
    $ chmod +x suricata_UbuntuServerX86-64.sh
    $ ./suricata_UbuntuServerX86-64.sh
    ```
1. Build, run, attach to container
    ```
    $ docker build -t tsuricata .
    $ docker run -d --name suricata --hostname jhedid-suricata.netsec.isi.jhu.edu --add-host jhedid-suricata.netsec.isi.jhu.edu:127.0.1.1 --dns 172.16.0.10 --dns-search netsec.isi.jhu.edu --privileged --security-opt seccomp=unconfined --cgroup-parent=docker.slice --cgroupns private --tmpfs /tmp --tmpfs /run --tmpfs /run/lock --network host --cpus=1 tsuricata:latest \n\
    $ docker exec -it suricata bash 
    ```
1. Edit `/var/lib/suricata/rules/test-ping.rules` and update IP addresseses appropriately
1. Reload rules
1. Restart Suricata

# Useful websites
