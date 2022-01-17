# Jamstack Tutorial #4 - Build An Internal API with Gocommerce

## Overview

After experimenting with external APIs, let's roll out an internal API.  Lots of options exist to build out your own API.  As an example, we will look at 
deploying [Gocommerse](https://github.com/netlify/gocommerce), a Go based E-commerce platform that leverages JAMStack technologies to run a E-commerce site.

## Outline

- Internal services
    - Anything that exposes an API that can be queried with Javascript
    - Incredible flexible - it should be a data layer that is rendered by Javascript side code.
- Downsides
    - Security is on the developer.  As the API is fully exposes, must ensure appropriate security is in place to prevent misuse.
- [Gocommerse](https://github.com/netlify/gocommerce)
    - Clone repo as a submodule.  A simple mono-repo module.
    - Look at building docker container.
    - Deploy docker container, and develop yaml to deploy to Civo cluster
    - Adjust front-end to include items for sale