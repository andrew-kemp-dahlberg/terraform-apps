module app {
    source = "https://github.com/andrew-kemp-dahlberg/terraform-okta-app" #This is the module this always stays the same.
    label = "Example" #This is the name of the app displayed to users
    admin_note = {
        saas_mgmt_name = "example" #This is the name of the app in Torii
        accounting_name = "Example" #This is the name of the app in Netsuite
        sso_enforced = false #On initial provision this should be set to false. When you are sure you have enforced SSO change to true.
        lifecycle_automations = { 
            provisioning = {  #This is how users are provisioned to the app
                type = "SCIM" #this can equal "SCIM", "ADP", "Okta Workflows fully automated", "Okta workflows Zendesk", "AWS", "None"
                link = "" #this is the link to where the automation is provisioned this can just be the app url or left empty for SCIM or None. 
                }
            user_updates = { #This is how updates to users are pushed to the app ie. email change
                type = "SCIM"
                link = ""
            } 
            deprovisioning = { #this is how users are deprovisioned from the app
                type = "Okta Workflows Fully Automated"
                link = "https://automation.com" 
            } 
        } 
        service_accounts = ["service.account@company.com", "service.account2@company.com"] #This is a list of service accounts
        app_owner = "app.owner@company.com" #this is who owns the app 
        last_access_audit_date = "string" #this is when access to the app was last audited. This should be the date of creation since access needs to be audited before provisioning.
        additional_notes = <<EOT
        These are additional notes that you can add. 
        You can add multiple lines etc. 
        A portion of these notes are uploaded directly to the app. 
        All of the fields you add here are added to confluence. 
        EOT
    }
    sso_url = "https://example.com"#this is the sso url 
    audience_uri = "https://example.com" #This is audience_uri/entity id
}

