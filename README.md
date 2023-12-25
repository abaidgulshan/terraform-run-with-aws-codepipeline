# 🚀 Terraform AWS Developer Tools Pipeline 🚀

This Terraform configuration sets up a comprehensive AWS developer tools pipeline, including AWS CodeCommit, CodePipeline, CodeBuild, IAM roles, and S3 storage for artifacts.

## Prerequisites 🛠️

Before you begin, make sure you have the following:

1. **AWS Credentials and Configure**: Ensure you have AWS credentials configured with the necessary permissions to create resources.
2. **Create AWS CodeCommit and setup**: We recommend that you use the latest versions of Git and other prerequisite software
   * Install Python and pip
   * Install and configure a Git client
   * Install git-remote-codecommit `pip install git-remote-codecommit`
   * Clone the repository:
     ```
     git clone codecommit::us-east-1://terraform-repo
     cd terraform-repo
     ```
3. **Terraform**: Install Terraform on your machine. Refer to the [official Terraform installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) for instructions.
4. **Create Terraform Backend**: Go to the Terraform Backend directory and create the Terraform backend. Refer to the [Create Terraform Backend](./terraform-modules/terraform-aws-backend) for instructions.
5. **Create AWS Pipeline**: Go to the Terraform Pipeline resources directory and create the pipeline resources. Refer to the [Terraform AWS Deveopertools Pipeline](./terraform-modules/terraform-aws-developertools-pipeline) for instructions.

## Usage 🚀

1. **Clone this repository to your local machine:**

   ```bash
   git clone https://github.com/your-username/terraform-aws-developertools-pipeline.git
   cd terraform-aws-developertools-pipeline
   ``
