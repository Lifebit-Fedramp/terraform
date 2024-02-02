locals {
  self_managed_node_groups = merge({
    default_node_group = {
      name = replace(var.cluster_name, "<org>-", "")
    }
  }, var.additional_self_managed_node_groups)


  additional_security_group_rules = merge({
    ingress_control_plane = {
      description = "Allow inbound traffic from control plane"

      protocol                      = "-1"
      from_port                     = 0
      to_port                       = 0
      type                          = "ingress"
      source_cluster_security_group = true
    }
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }, var.additional_node_security_group_rules)
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.5"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false
  #  cluster_endpoint_public_access_cidrs = [
  #    "0.0.0.0/32",
  #  ]

  cluster_addons = var.enable_cluster_addons == true ? {
    # TODO: Migrate control of coredns from fluxCD to eks managed addons
    # coredns = {
    #   resolve_conflicts = "OVERWRITE"
    #   most_recent       = true
    # }
    kube-proxy = {
      resolve_conflicts = "OVERWRITE"
      most_recent       = true
    }
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
      most_recent       = true
    }
  } : {}

  cluster_encryption_config = {
    provider_key_arn = aws_kms_key.eks.arn
    resources        = ["secrets"]
  }

  cluster_enabled_log_types = [
    "audit",
    "api",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  tags       = var.tags

  enable_irsa = true

  # Self Managed Node Group(s)
  self_managed_node_group_defaults = {
    instance_type              = var.instance_type
    max_size                   = var.mng_max_size
    desired_size               = var.mng_desired_size
    ami_id                     = var.ami_id == "" ? data.aws_ami.eks_worker.id : var.ami_id
    enable_bootstrap_user_data = true

    #pre_bootstrap_user_data = <<-EOT
    #  /etc/eks/cleanup_preboot.sh
    #EOT

    bootstrap_extra_args = "--kubelet-extra-args '--image-credential-provider-config /etc/eks/ecr-credential-provider/ecr-credential-provider-config --image-credential-provider-bin-dir /etc/eks/ecr-credential-provider'"

    pre_bootstrap_user_data = <<-EOT
    export PATH="/workdir/binaries/:/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin"
    EOT

    post_bootstrap_user_data = <<-EOT
    echo "All done"
    EOT

    update_launch_template_default_version = true
    iam_role_additional_policies = {
      SSM_MANAGED_CORE = "arn:aws-us-gov:iam::aws:policy/AmazonSSMManagedInstanceCore"
    }
    tags = {
      "k8s.io/cluster-autoscaler/enabled"             = "true",
      "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    }
    block_device_mappings = [
      {
        device_name = "/dev/xvda"
        ebs = {
          volume_size = var.volume_size
          volume_type = "gp2"
        }
      }
    ]
  }

  self_managed_node_groups = local.self_managed_node_groups

  node_security_group_additional_rules = local.additional_security_group_rules

  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      description                = "Allow inbound from node groups"
      protocol                   = "-1"
      from_port                  = 0
      to_port                    = 0
      type                       = "egress"
      source_node_security_group = true
    }
    ingress_all = {
      description = "Ingress all from vpc"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      cidr_blocks = var.control_plane_allowed_cidrs
    }
  }

  # Self managed node groups will not automatically create the aws-auth configmap so we need to
  create_aws_auth_configmap = true
  manage_aws_auth_configmap = true

  aws_auth_roles = local.aws_auth_roles

}
