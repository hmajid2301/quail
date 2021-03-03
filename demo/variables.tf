variable "profile" {
  type        = string
  default     = "default"
  description = "AWS configuration profile used with terraform"
}

variable "region-primary" {
  type        = string
  default     = "us-east-1"
  description = "AWS region where resources will be deployed"
}

variable "project-name" {
  type        = string
  default     = "quail"
  description = "Project name, used for resource naming"
}

variable "notification-email" {
  type        = string
  description = "Email address from which notifications will be sent. Needs to be verified in SES."
}

variable "admin-email" {
  type        = string
  description = "Email address where email failure emails will be CCed to."
}

variable "cleanup-notice-notification-hours" {
  type        = list(number)
  default     = [12]
  description = "Controls how many advance notifications should be sent out before resources are cleaned up. E.g. [1,6,12] means the users will receive three warnings: 12, 6 and one hour before the resources get cleaned up."
}

variable "external-sns-failure-topic-arn" {
  type        = string
  default     = ""
  description = "If set, this topic will be notified of provisioning failures or lambda execution failures. If unset, a new topic will be created"
}

variable "sso-apps-metadata" {
  type        = map
  description = "Map of user-group name to metadata url of the associated SSO SAML app, required for the Cognito SAML identity providers."
}

variable "logout-url" {
  type        = string
  description = "User will be redirected to this url upon logout"
}

variable "support-localhost-urls" {
  type        = bool
  default     = false
  description = "Should Api Gateway cors policy and Cognito app support localhost URL. Used for development"
}

variable "hosting-domain" {
  type        = string
  description = "The domain where the application is going to be hosted, e.g. `www.quail.click`. It needs to have an ACM certificate associated with it."
}

variable "hosted-zone-name" {
  type        = string
  description = "The name of the hosted zone where the record will be added to point the `hosting-domain` to the Load Balancer, e.g. quail.click."
}

variable "instance-tags" {
  type = list(object({
    tag-name  = string,
    tag-value = string,
  }))
  default = [
    {
      tag-name : "user",
      tag-value : "$email"
    },
    {
      tag-name : "group",
      tag-value : "profile"
  }]
  description = "Tags to assign to the EC2 instances provisioned by end users. Values starting with $ will refer to the user's attributes."

  validation {
    condition     = length(var.instance-tags) == 2
    error_message = "You must have exactly two instance tags defined."
  }
}

variable "resource-tags" {
  type        = map(string)
  default     = {}
  description = "Tags to assign to resources provisioned by terraform. Apart from the listed tags, a {part_of: $${project-name}} tag is assigned to all resources."
}
