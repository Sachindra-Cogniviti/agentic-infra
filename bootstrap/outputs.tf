output "github_actions_client_id" {
  description = "The Client ID of the User Assigned Identity for GitHub Actions."
  value       = azurerm_user_assigned_identity.github_actions.client_id
}

output "tenant_id" {
  description = "The Tenant ID of the Azure AD directory."
  value       = azurerm_user_assigned_identity.github_actions.tenant_id
}

output "subscription_id" {
  description = "The Subscription ID."
  value       = data.azurerm_subscription.current.subscription_id
}
