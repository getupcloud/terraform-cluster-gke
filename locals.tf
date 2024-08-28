locals {
  kubeconfig_filename        = abspath(pathexpand(var.kubeconfig_filename))
  api_endpoint               = "https://${module.gke.endpoint}"
  token                      = data.google_client_config.default.access_token
  certificate_authority_data = base64decode(module.gke.ca_certificate)

  modules_result = {
    for name, config in merge(var.modules, local.modules) : name => merge(config, {
      output : config.enabled ? lookup(local.register_modules, name, try(config.output, tomap({}))) : tomap({})
    })
  }

  manifests_template_vars = merge(
    {
      gcp : {
        project_id : var.project_id
        region : var.region
        zones : var.zones
        network : var.network
        subnetwork : var.subnetwork
        network_project_id : var.network_project_id
      }
    },
    var.manifests_template_vars,
    {
      alertmanager_cronitor_id : var.cronitor_id
      alertmanager_opsgenie_integration_api_key : var.opsgenie_integration_api_key
      secret : random_string.secret.result
      suffix : random_string.suffix.result
      modules : local.modules_result
    },
    module.teleport-agent.teleport_agent_config,
    { for k, v in var.manifests_template_vars : k => v if k != "modules" }
  )
}
