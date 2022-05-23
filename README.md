# Ghapi

Small phoenix app to identify patterns in GitHub pull request comments as a means to determine coding standards and priorities. Initial page lists all pull requests for the `backend` repo. Each pull request ID links to a page that displays the comments.

TODO: persist the comments to find patterns such as: word frequency, emoji frequency, etc.

Uses HTTPoison to query the GitHub api. Credenials must be available in the environment. User `direnv allow` or export each of the key value pairs into the shell.

```
export TOKEN="my-token"
export USERNAME="my-username"
```
