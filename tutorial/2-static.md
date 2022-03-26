# Getting Started with JAMStack on Civo - The Stack site

## Overview

Now that a [Gitpod development environment in place](https://www.civo.com/learn/civo-development-environment-with-gitpod), let's setup the groundwork for the **M** part in JAMstack - a markdown oriented static site.  This site will host all our user-accessible static content, as well as our dynamic frontend pieces as they are implemented.

## Environment Setup

We will be utilizing [Hugo](https://gohugo.io/) for our static site generation.  A large part of this tutorial will be based on [Alejandro excellent article on deploying a Hugo site](https://www.civo.com/learn/using-civo-k3s-service-to-host-your-blog-in-hugo-using-github-actions), but leveraging the Gitpod environment to make development and deployment more streamlined

First, ensure your Gitpod environment is setup and has access to Civo:

```sh
civo k3s list  #Ensure no error is reported back 
```

As we are using Hugo, let's set that up in our Gitpod environment.  Your Gitpod environment has access to LinuxBrew, which is the easiest way to install such thing.  

Create a `.gitpod.Dockerfile`, and add the following

```text
FROM quay.io/ssmiller25/gitpod-k8s:latest

# Install hugo
RUN brew install hugo
```
Edit your `.gitpod.yml` configuration, and add the following taskcontents

```yaml
image:
  file: .gitpod.Dockerfile
tasks:
  - name: Login to Cloud Resources
    command: |
      bash $HOME/scripts/00-cloudinit.sh
vscode:
  extensions:
    - ms-azuretools.vscode-docker
    - ms-kubernetes-tools.vscode-kubernetes-tools
```


- Use  https://www.civo.com/learn/using-civo-k3s-servic e-to-host-your-blog-in-hugo-using-github-actions, through gitpod, to build out basic blog
- Demo gitpod addons to let preview happen in developer

## More infomration

- [Using Civo to Host Your Blog in Hugo](https://www.civo.com/learn/using-civo-k3s-service-to-host-your-blog-in-hugo-using-github-actions)
