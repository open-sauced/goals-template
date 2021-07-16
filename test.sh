curl 'https://serve.onegraph.com/graphql?app_id=306cccd5-09ba-4d57-8c76-a3b3af68c36e' \
--compressed \
-X POST \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-H "Accept-Encoding: gzip, deflate" \
-vv \
--data "{
  \"query\": \"query ViewerOpenSaucedGoalsAndStarredRepos(\$gitHubOAuthToken: String!) { gitHub(auths: {gitHubOAuthToken: \$gitHubOAuthToken}) { viewer { starredRepositories(first: 10, orderBy: {field: STARRED_AT, direction: DESC}) { totalCount edges { node { nameWithOwner } } } repository(name: \\\"open-sauced-goals\\\") { issues(first: 10, orderBy: {field: CREATED_AT, direction: DESC}) { edges { node { title } } } } } } }\",
  \"variables\": {\"gitHubOAuthToken\": \"$GITHUB_TOKEN\"},
  \"operationName\": \"ViewerOpenSaucedGoalsAndStarredRepos\"
}"