---
layout: post
title: "Fix node.js cannot update to 8.x or other version on ubuntu 16.04"
description: "Troubleshooting with the node.js upgrade issue: Already up-to-date"
tags: [nodejs]
---

## Node.js upgrade issue 

When I was working with few projects with latest npm or related dependencies, sometimes we have to upgrade our node.js version in order to jump out of the dependencies hell especially you are migrating to the latest node.js.

However, when I am updating the node.js with the command `apt-get upgrade` or `apt-get install nodejs` on ubuntu 16.04 or other linux distrubition. It always telling me that my nodejs is already up-to-date.

Therefore, here are my few notes regarding the upgrade issue and troubleshooting footprint, hope it would be helpful to you:

### 0. Check the node.js version and download the latest version via package manager

You can use the option `-v` to check your current node.js version in your system.

```bash
node -v
```

Also, you may try to [install/upgrade your node.js via the package manager][1]:

```bash
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
```

If your node.js still stay at the oldest version, please check the next steps.

### 1. Check `/etc/apt/sources.list.d/nodesource.list`

If you installed the node.js before, or ran the update command before. In the `/etc/apt/sources.list.d/nodesource.list`, you may see the following contents:
```
deb https://deb.nodesource.com/node_5.x trusty main
deb-src https://deb.nodesource.com/node_5.x trusty main
```

If you are cuurently using the version `5.x`, congratulations, that's why your nodejs always telling you that your node.js is up-to-date but it actually not.

Please change the version to `8.x` as the example below:
```
deb https://deb.nodesource.com/node_8.x trusty main
deb-src https://deb.nodesource.com/node_8.x trusty main
```

Now, you can install the latest node.js via the following command (Debian and Ubuntu based Linux distributions).
```
sudo apt-get update
sudo apt-get install -y nodejs
```

For more detail on other distributions, you can read the document on node.js.


Reference:

- [Installing Node.js via package manager][1]


[1]: https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
