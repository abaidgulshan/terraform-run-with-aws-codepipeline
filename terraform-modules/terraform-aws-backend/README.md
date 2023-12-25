# create-terrform-backend

Created the infrastructure for a terraform backend to store state files in s3 and dynamoDB

## Usage

The script requires that you pass in your own credentials to make this work

### Script parameters

| Flag  | Description                                                              | Required |
| :---: | ------------------------------------------------------------------------ | :------: |
| a     | This is the account name. Generally the account name. (i.e. dev or prod) | true     |
| d     | The default region where the terraform resources go                      | true     |
| r     | The region where the s3 bucket for terraform is replicated               | true     |
| o     | The name of AWS account owner/client                                     | true     |

### Usage with an AWS profile

```
AWS_PROFILE=example ./create-terraform-backend.sh -a dev-d us-east-1 -r us-east-2 -o whiteplume
```

### Usage with AWS environment keys

```
export AWS_ACCESS_KEY_ID="<access_key>"
export AWS_SECRET_ACCESS_KEY="<secret Key>"
export AWS_SESSION_TOKEN="<session token>"

aws configure --profile whiteplume
export AWS_PROFILE=whiteplume
aws sts get-caller-identity

./create-terraform-backend.sh -a prod -d us-east-1 -r us-west-2 -o wp-mission
```

Output Should be look like this 

```
Terraform S3 Bucket Arn: arn:aws:s3:::whiteplume-prod-terraform-backend-us-east-1
Terraform S3 Bucket Name: whiteplume-terraform-backend-us-east-1
Terraform DynamoDB Table Arn: arn:aws:dynamodb:us-east-1:465743759656:table/terraform-backend.lock
Terraform DynamoDB Table Name: terraform-backend.lock
Terraform KMS ARN: arn:aws:kms:us-east-1:465743759656:key/3908627b-f488-468e-9a71-93fd5c48c2d2
Terraform backend complete
```

We need to copy S3 bucket name and dynamodb to use in terraform backend