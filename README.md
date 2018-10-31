# Automated Steps to Create an Issue Using GitHub Rest API

Here are the simple steps to automatically create an issue in a repository when another repository in the same organization is deleted.

## How it works

#### Prerequisit
* a Github account
* an organization 
* at least 2 repositories (one to delete, one with the issue for notification of repo deletion)

#### Steps
1. Create a [Webhook](https://developer.github.com/webhooks/creating/#setting-up-a-webhook) for the organization. 
    * Follow the step to [Config the Server](https://developer.github.com/webhooks/configuring/) using **ngrok**
    * Select "**Repositories**" as the event to trigger the webhook
  
2. Run ruby program: *repo_webhook_post_issues.rb* by executing the command "ruby repo_webhook_post_issues.rb" on the command line. The program uses GitHub [Issues REST API](https://developer.github.com/v3/issues/#create-an-issue).
    * Link to install [Ruby](https://www.ruby-lang.org/en/downloads/)
    * This program uses Sinatra. Reference [Sinatra guide](http://sinatrarb.com/) for additional information
    * This program also uses the access token. Please follow the link to setup the [access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/)
    * *GitHub.json* file referenced in the program is not checked in for security reason

3. Manually delete repository "**repo-to-delete**", the deletion would raise the event to trigger the webhook which would automatically create the issue in the repository "**repo-to-keep**".
