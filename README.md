# eks-helm-action

Needed something somewhat specific to a Github Actions CI run for a project. Just want to pass the AWS access key credentials (easier to deal with) instead of tinkering with kubeconfig. This project combines [ianbelcher/eks-kubectl-action](https://github.com/ianbelcher/eks-kubectl-action) and [koslib/helm-eks-action](https://github.com/koslib/helm-eks-action) actions to deploy applications to an EKS cluster using just AWS access key. This Action has a container with `kubectl` and `helm`.

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

