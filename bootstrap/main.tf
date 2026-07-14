data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "bootstrap" {
  name     = "rg-bootstrap"
  location = "Central India"
}

# User Assigned Identity for GitHub Actions
resource "azurerm_user_assigned_identity" "github_actions" {
  name                = "github-actions-identity"
  resource_group_name = azurerm_resource_group.bootstrap.name
  location            = azurerm_resource_group.bootstrap.location
}

# Federated Identity Credential for GitHub Actions (Main Branch)
resource "azurerm_federated_identity_credential" "github_actions_main" {
  name                      = "github-actions-main"
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = "https://token.actions.githubusercontent.com"
  subject                   = "repo:Sachindra-Cogniviti/agentic-infra:ref:refs/heads/main"
  user_assigned_identity_id = azurerm_user_assigned_identity.github_actions.id
}

# Federated Identity Credential for GitHub Actions (Pull Request)
resource "azurerm_federated_identity_credential" "github_actions_pr" {
  name                      = "github-actions-pr"
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = "https://token.actions.githubusercontent.com"
  subject                   = "repo:Sachindra-Cogniviti/agentic-infra:pull_request"
  user_assigned_identity_id = azurerm_user_assigned_identity.github_actions.id
}


# Assign Contributor role to the User Assigned Identity at Subscription level
resource "azurerm_role_assignment" "github_actions_contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.github_actions.principal_id
}

# Assign User Access Administrator role to the User Assigned Identity at Subscription level
resource "azurerm_role_assignment" "github_actions_user_access_admin" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "User Access Administrator"
  principal_id         = azurerm_user_assigned_identity.github_actions.principal_id
}