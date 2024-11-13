output "cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "eks_version" {
  value = aws_eks_cluster.eks.version
}

output "oidc" {
  value = data.tls_certificate.certificate.url
}

output "oidc_without_protocol" {
  value = tostring(element(split("https://", data.tls_certificate.certificate.url), 1))
}

output "thumbprint" {
  value = data.tls_certificate.certificate.certificates[0].sha1_fingerprint
}