# Jamstack Tutorial #5 - Use External API - GitHub to Host Comments

## Overview

With a static site now running, let's look at the **J** and **A** parts of the JAMStack - Javascript and APIs.  A JAMStack site can use a lot of publicly available APIs in order to enhance our site with dynamic content that we don't have to directly host.  In this tutorial, we'll look at adding [Utterances](https://utteranc.es/), which let's you leverage Github issues in order provide comments on a site.

## Outline

- Why use external services
    - Don't have to worry about hosting issues
    - Can leverage another companies Spam and content filters
- Downsides to external services
    - You don't control them, and could potentially run into API limits
    - Could be costly depending on the services
    - We'll look at hosting our own API services in the next article
- [Utterances](https://utteranc.es/)
    - Make sure comments are turned on (if you forked this repo, you will have to turn them on manually)
    - Follow the instructions to [Install Utterances](https://github.com/apps/utterances)
        - Choose the mapping between blog posts and Github issues (Issue title contains page URL - safest in case your repo is cloned)
        - Choose a label for issues created by utterance - not required, but will help filter out acutal issues from just comments.  Label must already exist - so may have to create a dummy issue to tag it with the tag you wish to use
        - Theme - select one that helps match the your blog.
        - Insert this piece of code in the template for your blog posts:

        ```html
        <script src="https://utteranc.es/client.js"
                repo="[ENTER REPO HERE]"
                issue-term="url"
                theme="github-light"
                crossorigin="anonymous"
                async>
        </script>
        ```

    - Commit to main, check it out!
- Notes
  - This does require a github account.  If your audience is more generic, you may wish to look at other Disque or Facebook Messages

