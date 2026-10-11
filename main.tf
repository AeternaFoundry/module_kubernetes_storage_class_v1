resource "kubernetes_storage_class_v1" "storage_class_v1s" {
  for_each = var.storage_class_v1s

  storage_provisioner    = each.value.storage_provisioner
  allow_volume_expansion = each.value.allow_volume_expansion
  mount_options          = each.value.mount_options
  parameters             = each.value.parameters
  reclaim_policy         = each.value.reclaim_policy
  volume_binding_mode    = each.value.volume_binding_mode

  metadata {
    annotations   = each.value.metadata.annotations
    generate_name = each.value.metadata.generate_name
    labels        = each.value.metadata.labels
    name          = each.value.metadata.name
  }

  dynamic "allowed_topologies" {
    for_each = each.value.allowed_topologies != null ? [each.value.allowed_topologies] : []
    content {
      dynamic "match_label_expressions" {
        for_each = allowed_topologies.value.match_label_expressions != null ? allowed_topologies.value.match_label_expressions : []
        content {
          key    = match_label_expressions.value.key
          values = match_label_expressions.value.values
        }
      }
    }
  }
}

