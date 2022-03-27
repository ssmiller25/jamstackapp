# JAMStackApp

An example JAMStack app, deployable in any k8s cluster.  This should be fully functional, but you can [follow along to make your own from scratch](tutorial/)

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/from-referrer/)

## Blog Articles

- [Civo Development Environment with Gitpod](https://www.civo.com/learn/civo-development-environment-with-gitpod)

## Environments

Environment Setup Below.  All assumes you are running for GitPod, although not necessarily a requirement.


### Civo

One time setup for Civo 

- [Log into your Civo Account](https://www.civo.com/login)
- Obtain your [API Key Here](https://www.civo.com/account/security)
- Run the following to set the Civo API key as a Gitpod Secret

    ```sh
    gp env CIVO_API_KEY=<api key here>
    gp env CIVO_REGION=NYC1  # Or any other legitimate region
    gp env DOCKER_USERNAME=docker_username
    gp env DOCKER_PASSWORD=docker_password
    ```

- Relaunch the environment.  Your Civo environment should be setup, with all active clusters imported in.


## Cloning/Updated Repo with Theme Submodule

As the theme is pulled in with a submodule, ensure when you clone this repo it comes down as well

```sh
# Initial Clone
git clone --recurse-submodules https://github.com/ssmiller25/jamestackapp.git
```

If you are missing the submodule in an existing clone

```sh
git submodule update --init --recursive
```

Updating the submodule with the latest upstream changes

```sh
git submodule update --remote --merge
```