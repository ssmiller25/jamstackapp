# Getting Started with JAMStack on Civo - The Stack site

## Overview

Now that a [Gitpod development environment in place](https://www.civo.com/learn/civo-development-environment-with-gitpod), let's setup the groundwork for the **M** part in JAMstack - a markdown oriented static site.  This site will host all our user-accessible static content, as well as our dynamic frontend pieces as they are implemented.

## Enviornment Setup 

We will be utilizing [Hugo](https://gohugo.io/) for our static site generation.  A large part of this tutorial will be based on [Alejandro's excellent article on deploying a Hugo site](https://www.civo.com/learn/using-civo-k3s-service-to-host-your-blog-in-hugo-using-github-actions), but leveraging the Gitpod environment for development and deployment.

First, ensure your Gitpod environment is setup and has access to Civo:

```sh
civo k3s list  #Ensure no error is reported back 
```

As we are using Hugo, let's set that up in our Gitpod environment.  Your Gitpod environment has access to Homebrew, so we will use that.  Although there are several ways to install in a Gitpod environment, I prefer to embed software that will be used regularly into a custom Docker image for my environment.  Create a `.gitpod.Dockerfile`, and add the following:

```text
FROM quay.io/ssmiller25/gitpod-k8s:latest

# Install hugo
RUN brew install hugo
```

Edit your `.gitpod.yml` configuration, and change the `image` link to match below.  (the rest of the file was setup in the [first article](https://www.civo.com/learn/civo-development-environment-with-gitpod))

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

Save and commit all your changes.  Then relaunch Gitpod for your repository.  The first time you open **will take a while (several minutes)!**  Once the new container is build, the launch time should be drastically reduced.  Once up, let's verify we have Hugo installed.  Run this from the terminal in your Gitpod instance

```sh
hugo version
```

If that returns a version number, we are good

## Initial Site Development

Let's use hugo to setup an initial site:

```sh
hugo new site jamstacksite -f yml
```

A new `jamstackapp` directory will be created in your repo, with the standard layout for a hugo site.  We are going to use the [PaperMod theme](https://github.com/adityatelange/hugo-PaperMod) to get started, but most others should work.

```sh
git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git jamstacksite/themes/papermod
```

Update `jamstacksite/config.yml` to match the following:

```yaml
baseURL: http://example.org/
languageCode: en-us
title: "My JamStack Site"
theme: "papermod"
```

Now let's make sure we have a functional site.  Run the following commands in the gitpod terminal:

```sh
cd jamstacksite/
hugo serve
```

Once hugo begin serving, Gitpod will detect the newly open port and give you a chance to preview the site.

![Gitpod Open Port](images/2-gitpod-hugo-serve.png)

Click the "Open Browser", and a new window should appear with the website as it is now:

![Initial Hugo Site](images/2-initial-site.png)

Press `Ctrl + C` to exit the hugo session when finished.

If everything looks good, let's tell Hugo to build the site:

```sh
hugo
```

## Hosting on Civo

Ok, now let's leverage Gitpod to push a docker container to Civo.  In production you would normally embed this into a pipeline [as described in Alejandro's article](https://www.civo.com/learn/using-civo-k3s-service-to-host-your-blog-in-hugo-using-github-actions), but we'll leave this as a manual deployment as we are developing our new app.  First, let's create a new Civo cluster.  From the Gitpod command interface:

```sh
cd ${GITPOD_REPO_ROOT}
civo k3s create jamstacksite -n 2 --wait
civo k3s config jamstacksite --save --merge
kubectl config use-context jamstacksite
kubectl get nodes  #Ensure we are seeing nodes from the new cluster
```

Create a `Dockerfile` in the root of your repository:

```Dockerfile
FROM nginx
COPY ./jamstacksite/public /usr/share/nginx/html
```

Create a `k8s.yaml` to deploy the site.  Make sure to change the `ssmiller25` to a your username

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jamstackapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: jamstackapp
  template:
    metadata:
      labels:
        app: jamstackapp
    spec:
      containers:
        - image: ssmiller25/jamstackapp:latest
          name: jamstackapp
          imagePullPolicy: Always
---
apiVersion: v1
kind: Service
metadata:
  name: jamstackapp
  labels:
    app: jamstackapp
spec:
  ports:
    - name: "http"
      port: 80
  selector:
    app: jamstackapp
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: jamstackapp-ingress
  labels:
    app: jamstackapp
  annotations:
    kubernetes.io/ingress.class: traefik
spec:
  rules:
    - http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: jamstackapp
                port: 
                  number: 80
      # Not required, but useful if serving multiple hostnames through the same ingress
      #host: CLUSTER_ID.k8s.civo.com
```

How, let's build and push our docker container.  Make sure to substitute `ssmiller25` with your dockerhub username:

```sh
docker buildx build --push -t ssmiller25/jamstackapp:latest .
```

Deploy the kubernetes manifests

```sh
kubectl apply -f k8s.yaml
```

Now let's check out the site.  Find out the public IP of your cluster by running `civo k3s show jamstacksite` and look for the "DNS A record".  Go to that address, and you should see the site that you previews on your Gitpod environment!

![Initial Hugo Site](images/2-hosted-site.png)

## Conclusion

We now have a static site, hosted on Civo: The **M** In our JAMStack.  With this basis, we can begin exploring implementing more dynamic content leveraging Javascript and APIs - both externally as well as internally.

## More Information

- [Using Civo to Host Your Blog in Hugo](https://www.civo.com/learn/using-civo-k3s-service-to-host-your-blog-in-hugo-using-github-actions)
