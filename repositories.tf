
# Create infrastructure repository
resource "github_repository" "hcc-infrastructure" {
  name = "hcc-terraform-infrastructure"
  description = "Terraform things"
}

# Add memberships for infrastructure repository
resource "github_team_repository" "hcc-infrastructure" {
  for_each = {
    for team in local.repo_teams_files["hcc-infrastructure"] :
    team.team_name => {
      team_id    = github_team.all[team.team_name].id
      permission = team.permission
    } if lookup(github_team.all, team.team_name, false) != false
  }

  team_id    = each.value.team_id
  repository = github_repository.hcc-infrastructure.id
  permission = each.value.permission
}

# Create application repository
resource "github_repository" "test-application" {
  name = "test-application"
}

# Add memberships for application repository
resource "github_team_repository" "test-application" {
  for_each = {
    for team in local.repo_teams_files["test-application"] :
    team.team_name => {
      team_id    = github_team.all[team.team_name].id
      permission = team.permission
    } if lookup(github_team.all, team.team_name, false) != false
  }

  team_id    = each.value.team_id
  repository = github_repository.test-application.id
  permission = each.value.permission
}