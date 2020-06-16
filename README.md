# Open Sauced Goals Template

This is the companion repository to Open Sauced. All data in this repository is a mirror of the data you see on the [opensauced.pizza](https://opensauced.pizza) dashboard.

## How does this work?

Open Sauced uses this GitHub repository as a database. Issues are what you see on the site as repository goals. When a repository is tracked on [opensauced.pizza](https://opensauced.pizza), an issue is opened in this repository. 

## What should I do with this repository?

In short, nothing. As mentioned above, this repo will act as your database for your Open Sauced profile. You can edit issues and the repo data directly if you would like. There may be unintended consequences on [opensauced.pizza](https://opensauced.pizza) for editing or deleting data here, but you can easily revert back to an earlier version using Git. 

## Keep in mind the following:

- This repository was created using a JWT [token generated](https://github.com/bdougie/open-sauced/blob/master/src/lib/identityActions.js) when you logged into [opensauced.pizza](https://opensauced.pizza). 
- Deleting this repo will permanently delete your [opensauced.pizza](https://opensauced.pizza) data, but will not remove access to your GitHub account data. You will need to delete Open Sauced's access to your GitHub account by visiting your GitHub profile's [integration access settings](https://github.com/settings/apps/authorizations).
- If you have issues with this repository, you can open an issue in [open-sauced/goals-template](https://github.com/open-sauced/goals-template/issues). 
- If you have issues with [opensauced.pizza](https://opensauced.pizza), please open an issue in [open-sauced/open-sauced](https://github.com/open-sauced/open-sauced).
