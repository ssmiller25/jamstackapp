# Jamstack Alternative #3 - PocketBase for ALL https://pocketbase.io/

 Let's explore the A in JAMStack, the API.  While lots of public APIs exist, sometimes we don't want to necessarily allow users to access ALL our APIs without some sort of credentials.  In the JAMStack world, authentication becomes a bit tricky.  We sometimes call multiple independent services.  How do we authenticate to those services in a consistent manner?


- Pocket base with Oauth2 with Github (easiest to setup)
- Stick with [plain javascript](https://plainjs.com/).  While advantages to using Typescript, or larger front-end frameworks, sticking with basics for this tutorial


# Jamstack Tutorial #3 - Authentication

A
## Enter the JWT

JWT, or [JSON Web Token](https://jwt.io/) is a industry standard to provide authentication and authorization in a decentralized manner.  Once a user is authenticated, they are provided a "JWT" token - a signed token that verifies that this user was authenticated, and includes metadata on what they have access too.  As the token is cryptographically signed, there isn't any way an end-user can manipulate the token without failing authorization checks.  As the user can take submit the token to other microservices, it's ideal for passing around authorization information.

For this session, we will be setting up an authorization service that will let a user authticate with their Github credentials, and will provide that user with a JWT token for our website.  In future sessions we will built out a service that can leverage that JWT token

## GoTrue

## Futher Reading

- [JSON Web Tokens](https://jwt.io/)
- External Authentication Providers
  - [Auth0](https://auth0.com/)
  - [Okta](https://www.okta.com/)
