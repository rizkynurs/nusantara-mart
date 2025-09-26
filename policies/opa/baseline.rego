package k8s.security
deny[msg] {
  input.kind.kind == "Deployment"
  endswith(input.spec.template.spec.containers[_].image, ":latest")
  msg := "Disallow :latest"
}
deny[msg] {
  input.kind.kind == "Deployment"
  not input.spec.template.spec.containers[_].resources.limits
  msg := "Limits must be set"
}
