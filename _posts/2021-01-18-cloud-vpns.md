---
title: Getting a public IP, the hard way
---

Sometimes, it could be because of multiple reasons, you just want to host your things at home, this could be:
- A VPN for your devices so that you always have to access to your LAN wherever you are
- A bigger Web App with a separate database and need for a lot of computing power
- A game server (e.g. Minecraft)
- File storage solution (FreeNAS, Plex, ..,)
- Whatever else that exposes a port to the network

This is all nice and easy, the problem comes when you want to do one of the following:
- DDOS protection
- Hide your IP

Both of these problems can be addressed fairly easily with the help of a VPS and optionally a service like [Cloudflare](https://www.cloudflare.com/). The way you do this is fairly simple, you set up a VPN between the VPS and your local machine and forward a specific (or more) ports on the VPS to target the local computer. This is best done when both of these systems run Linux, I will specifically be using Ubuntu 20.04 LTS on both of my systems, but it will not be hard to change the config to work on any other version/distro.

First things first prepare your VPS, this can be from a cloud provider ([Azure](http://), [GCP](https://cloud.google.com/), [AWS](https://aws.amazon.com/) or a VPS service like [DigitalOcean](https://www.digitalocean.com/), [Linode](https://www.linode.com/), and others. The other important thing to note is to make sure the port you want to forward is accessible through the firewall of the provider, this way your requests won't get blocked. A static IP is also a very useful thing in this scenario, but be aware this may cost you something, but not everywhere. After that make sure you can SSH into the VPS successfully and we shall begin with the process.

First, we install [Zerotier](https://www.zerotier.com/) (you will need to have a Zerotier account for this), when you do, just make a new public network and take a note of the id. Paste the commands below in the terminal and change *mynetworkid* to your id.

VPS:
```bash
curl -s https://install.zerotier.com | sudo bash
sudo zerotier-cli join mynetworkid
```

Local machine:
```bash
curl -s https://install.zerotier.com | sudo bash
sudo zerotier-cli join mynetworkid
```

Now we forward the port *EXTERNAL_PORT* to *LOCAL_PORT*, so for example we can forward port 8080 on the VPS to port 80 in our local machine to route to a web server (if one is set up).

VPS:
```bash
sudo apt update
sudo apt install socat
sudo tmux
sudo socat TCP-LISTEN:EXTERNAL_PORT,fork,reuseaddr TCP:LOCALIP:LOCAL_PORT 
```
Now just exit with `Ctrl+B D`

I hope this little tutorial helped, see you soon!
