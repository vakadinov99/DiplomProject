apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${role_arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
%{ if length(users) > 0 }
  mapUsers: |
%{ for user in users ~}
    - userarn: ${user.arn}
      username: ${user.username}
      groups:
%{ for group in split(",", user.groups) ~}
        - ${group}
%{ endfor ~}
%{ endfor ~}
%{ endif ~}
