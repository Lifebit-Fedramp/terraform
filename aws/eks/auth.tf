locals {
  arn_replacement = "//aws-reserved/sso.amazonaws.com/[a-z0-9-]+/"

  # The replace() functions are to replace /aws-reserved/sso.amazonaws.com/<region>/ so the ARNs look like regular ARNs due to https://github.com/kubernetes-sigs/aws-iam-authenticator/issues/268
  aws_auth_roles = concat([for arn in data.aws_iam_roles.sso_administratoraccess.arns : { "rolearn" : replace(arn, local.arn_replacement, ""), "username" : "AWSAdministratorAccess:{{SessionName}}", "groups" : ["system:masters"] }],
    [for arn in data.aws_iam_roles.sso_cloudnexaaccess.arns : { "rolearn" : replace(arn, local.arn_replacement, ""), "username" : "AWSCloudnexaAccess:{{SessionName}}", "groups" : ["system:masters"] }],
    [
      {
        "rolearn" : "<arn>",
        "username" : "<user>:{{SessionName}}",
        "groups" : ["system:masters"]
      },
      {
        "rolearn" : "<arn>",
        "username" : "<user>:{{SessionName}}",
        "groups" : ["system:masters"]
      }
    ],
  var.additional_kubectl_access)
}
