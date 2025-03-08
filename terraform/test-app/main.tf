module app {
  source  = "andrew-kemp-dahlberg/app/okta"
  version = ">=0.1.4"
  environment = var.environment
    name = "Figma"                                         #This is the name of the app. It will be defaulted as how users view it. All auth policies and groups will have this name
    admin_note = {                                         #These notes are shortened and added to admin notes. They also are uploaded to confluence.
    saas_mgmt_name  = "Figma"                            #This is the name of the app in Torii
    accounting_name = "Paid App, not in list from Carly" #This is the name of the app in Netsuite
    sso_enforced    = false                              #On initial provision this should be set to false. When you are sure you have enforced SSO change to true.
    lifecycle_automations = {
        provisioning = { #This is how users are provisioned to the app
        type = "None"  #this can equal "SCIM", "ADP", "Okta Workflows fully automated", "Okta workflows Zendesk", "AWS", "None"
        link = ""      #this is the link to where the automation is provisioned this can just be the app url or left empty for SCIM or None. 
        }
        user_updates = { #This is how updates to users are pushed to the app ie. email change
        type = "None"
        link = ""
        }
        deprovisioning = { #this is how users are deprovisioned from the app
        type = "None"
        link = ""
        }
    }
    service_accounts       = []                           #This is a list of service accounts not in Okta
    app_owner              = "anirudh.bhutani@unison.com" #this is who owns the app 
    last_access_audit_date = "2025-03-10"                 #this is when access to the app was last audited. Must be YYYY-MM-DD format. This should be the date of creation since access needs to be audited before provisioning.
    additional_notes       = <<EOT
            SCIM is available but we will likely not upgrade due to cost. Therefore
            a zendesk workflow needs to be created to make sure we stay on top of access. 
            EOT
    }
    saml_app = {
    logo     = "/Users/Andrew.KempDahlberg/Desktop" #app logo
    sso_url  = "https://example.com"   #this is the sso url 
    audience = "https://example.com"   #This is audience_uri/entity id

    user_attribute_statements = [
        {
        type        = "user"
        name        = "givenName"
        name_format = "scim"
        values      = ["user.firstName"]
        },

        {
        type        = "user"
        name        = "familyName"
        name_format = "scim"
        values      = ["user.lastName"]
        },

        {
        type        = "user"
        name        = "displayName"
        name_format = "scim"
        values      = ["user.displayName"]
        },

    ]
    }
}

terraform { 
  cloud { 
    
    organization = "Kemp-Cleaning" 

    workspaces { 
      name = "Figma" 
    } 
  } 
}

variable "environment" {
  description = "Information to authenticate with Okta Provider"
  type = object({
    org_name       = string
    base_url       = string
    client_id      = string
    private_key_id = string
    private_key    = string
    device_assurance_policy_ids = object({
      Mac     = optional(string)
      Windows = optional(string)
      iOS     = optional(string)
      Android = optional(string)
    })
  })
  sensitive = true

}
