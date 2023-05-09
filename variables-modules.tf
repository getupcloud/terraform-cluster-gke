## Provider-specific modules variables
## Copy to toplevel

variable "modules_defaults" {
  description = "Configure GCP modules to install (defaults)"
  type        = object({})
  default     = {}
}

locals {
  register_modules = {}
}
