# JAMStackApp

An example JAMStack app, deployable in any k8s cluster.  This should be fully functaion, but you can [follow along to make your own from scratch](tutorial/)

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/from-referrer/)

## Environments

Environment Setup Below.  All assumes you are running for GitPod, although not necessarily a requirement.

### Civo

One time setup for Civo 

- [Log into your Civo Account](https://www.civo.com/login)
- Obtain your [API Key Here](https://www.civo.com/account/security)
- Run the following to set the Civo API key as a Gitpod Secret

    ```sh
    gp env CIVO_API_KEY=<api key here>
    ```

- Relaunch the environment.  Your Civo environment should be setup, with all active clusters imported in.

