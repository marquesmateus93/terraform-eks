output "opensearch-application-acs-url" {
    value = try(
        "https://${aws_opensearch_domain.opensearch[0].endpoint}/_dashboards/_opendistro/_security/saml/acs/idpinitiated",
        null
    )
}

output "opensearch-application-saml-audience" {
    value = try(
        "https://${aws_opensearch_domain.opensearch[0].endpoint}",
        null
    )
}