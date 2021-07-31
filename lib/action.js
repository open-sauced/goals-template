import {Octokit} from "@octokit/rest"
import { request } from "@octokit/request";
import fs from "fs";

const octokit = new Octokit({
  auth: process.env.GITHUB_TOKEN,
})
// fest authenticated users stars
async function getStars(user) {
  const {data} = await octokit.request('GET /users/{user}/starred', {
    user: user,
  }).catch(err => {
    console.log(err)
  })
  return Promise.all(
    data.map(async repo => {
  
    return {
      full_name: repo.full_name,
      stargazers_count: repo.stargazers_count,
      open_issues_count: repo.open_issues_count,
      forks_count: repo.forks_count
    }
  }))
}

async function getRepoGoals(issues) {
  return Promise.all(
    issues.map(async issue => {
      // all goal issues follow the "owner/repo" format 
      let [owner, name] = issue.title.split("/");
  
      const {data} = await octokit.repos.get({
        owner: owner,
        repo: name,
      })
      
      return {
        full_name: data.full_name,
        stargazers_count: data.stargazers_count,
        open_issues_count: data.open_issues_count,
        forks_count: data.forks_count
      }
    }),
  );
}

const starsData = await getStars("bdougie")

// goals fetch and combine that with the stars
// fetch all goal repos
let repoIssues
let stagedIssues
try {
  stagedIssues = await octokit.rest.issues.listForRepo({
    owner: "bdougie",
    repo: "open-sauced-goals" 
  })
  console.log("stagedIssues", stagedIssues)
  repoIssues = await octokit.paginate(stagedIssues);
} catch (err) {
  console.log(err)
}
  
const repoGoalsData = await getRepoGoals(repoIssues)

// create or update the json store
fs.writeFileSync("data.json", JSON.stringify(repoGoalsData, null, 2));
fs.writeFileSync("stars.json", JSON.stringify(starsData, null, 2));