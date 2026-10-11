variable "storage_class_v1s" {
  description = <<EOT
Map of storage_class_v1s, attributes below
Required:
    - storage_provisioner
    - metadata (block):
        - annotations (optional)
        - generate_name (optional)
        - labels (optional)
        - name (optional)
Optional:
    - allow_volume_expansion
    - mount_options
    - parameters
    - reclaim_policy
    - volume_binding_mode
    - allowed_topologies (block):
        - match_label_expressions (optional, block):
            - key (optional)
            - values (optional)
EOT

  type = map(object({
    storage_provisioner    = string
    allow_volume_expansion = optional(bool)
    mount_options          = optional(set(string))
    parameters             = optional(map(string))
    reclaim_policy         = optional(string)
    volume_binding_mode    = optional(string)
    metadata = object({
      annotations   = optional(map(string))
      generate_name = optional(string)
      labels        = optional(map(string))
      name          = optional(string)
    })
    allowed_topologies = optional(object({
      match_label_expressions = optional(list(object({
        key    = optional(string)
        values = optional(set(string))
      })))
    }))
  }))
  # Note: 2 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

