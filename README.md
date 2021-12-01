# eks-helm-action

Github Action for deploying applications to a EKS cluster. This Action has a container with `kubectl` and `helm` installed and kubeconfig configured by the AWS access key you provided - yep, no more messing around with kubeconfig.

I need something somewhat specific to a Github Actions CI run and just want to pass the AWS access key credentials (easier to deal with) instead of kubeconfig. So I combine [ianbelcher/eks-kubectl-action](https://github.com/ianbelcher/eks-kubectl-action) and [koslib/helm-eks-action](https://github.com/koslib/helm-eks-action) actions in this action.

## Policy for IAM User

The IAM user whose access key that you pass to this Action must have the permissions to `eks:ListClusters` and `eks:DescribeCluster`. You can add more permissions but start with these two. Here's a sample policy:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "eks:DescribeCluster",
        "eks:ListClusters"
      ],
      "Resource": "*"
    }
  ]
}
```

## Github Actions Configuration

Here's a sample of how you would use this Action in Github Actions:

```yaml
name: ci-workflow
on:
  push:
    branches:
      - main
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: 'Connect to EKS and run helm'
        uses: cybersamx/eks-helm-action@master
        with:
          aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws_region: us-east-2
          cluster_name: ch-dev-eks
          command: kubectl config current-context && helm -h
```


## Credits

This Github Action is inspired and based on the following projects:

* [ianbelcher/eks-kubectl-action](https://github.com/ianbelcher/eks-kubectl-action)
* [koslib/helm-eks-action](https://github.com/koslib/helm-eks-action)

