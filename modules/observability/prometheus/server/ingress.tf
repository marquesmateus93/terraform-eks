resource "kubernetes_ingress_v1" "internal-ingress" {
    count           = var.is_enabled ? 1:0
    metadata {
        name        = local.internal-ingress.metadata.name
        namespace   = var.helm.namespace
        annotations = {
            "alb.ingress.kubernetes.io/load-balancer-name"  = local.internal-ingress.metadata.name
            #"alb.ingress.kubernetes.io/certificate-arn"     = ""
            #"alb.ingress.kubernetes.io/ssl-redirect"        = ""
            "alb.ingress.kubernetes.io/listen-ports"        = local.internal-ingress.metadata.annotations.listen-ports
            "alb.ingress.kubernetes.io/target-type"         = local.internal-ingress.metadata.annotations.target-type
            "alb.ingress.kubernetes.io/scheme"              = local.internal-ingress.metadata.annotations.scheme
            "alb.ingress.kubernetes.io/ip-address-type"     = local.internal-ingress.metadata.annotations.ip-address-type
        }
    }

    spec {
        ingress_class_name = "alb"
        rule {
            http {
                path {
                    path      = "/*"
                    path_type = "ImplementationSpecific"
                    backend {
                        service {
                            name = local.prometheus-helm.name
                            port {
                                name = "http"
                            }
                        }
                    }
                }
            }
        }
    }

    depends_on = [
        helm_release.prometheus
    ]
}