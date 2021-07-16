
set -e
PROGNAME=$0

OPERATION_NAME=ViewerOpenSaucedGoalsAndStarredRepos
VERBOSE_LEVEL=

usage() {
    cat << EOF >&2
Usage: $PROGNAME [-v] [-o <operationName>] [json-variables]

-o <operationName>: Operation to execute, e.g. -o ${OPERATION_NAME}
                -v: Verbose output for curl

operations available:
  ViewerOpenSaucedGoalsAndStarredRepos

json-variables: '{"gitHubOAuthToken": "foo"}'
EOF
    exit 1
}

OPERATIONS=$(cat <<EOF
query ViewerOpenSaucedGoalsAndStarredRepos(\$gitHubOAuthToken: String!) {
  gitHub(auths: {gitHubOAuthToken: \$gitHubOAuthToken}) {
    viewer {
      stars: starredRepositories(
        first: 10
        orderBy: {field: STARRED_AT, direction: DESC}
      ) {
        totalCount
        edges {
          node {
            nameWithOwner
          }
        }
      }
      repository(name: \"open-sauced-goals\") {
        issues(first: 10, orderBy: {field: CREATED_AT, direction: DESC}) {
          goals: edges {
            node {
              title
            }
          }
        }
      }
    }
  }
}
EOF
)

while getopts o:vh o; do
    case $o in
        (o) OPERATION_NAME=$OPTARG;;
        (v) VERBOSE_LEVEL="--verbose";;
        (h) usage;;
        (*) usage
    esac
done
shift "$((OPTIND - 1))"



VARIABLES=${1:-null}

CURL_DATA="{\"query\":\"${OPERATIONS}\",\"variables\":${VARIABLES},\"operationName\":\"${OPERATION_NAME}\"}"

curl 'https://serve.onegraph.com/graphql?app_id=06238984-0a96-4774-95ad-d7b654c980c5' --data "${CURL_DATA}"  \
${VERBOSE_LEVEL} --compressed \
-X POST \
-H "Content-Type: application/json" \
-H "Accept: application/json" \
-H "Accept-Encoding: gzip, deflate" \
