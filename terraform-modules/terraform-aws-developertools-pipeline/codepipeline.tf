
###########################################
##  AWS CodeBuild Projects Configuration ##
###########################################

resource "aws_codepipeline" "terraform" {
  name = var.codepipeline_name

  role_arn = aws_iam_role.codepipeline.arn

  artifact_store {
    location = module.codepipeline_bucket.s3_bucket_id
    type     = "S3"
  }

  stage {
    name = "Checkout"

    action {
      name     = "Source_Checkout"
      category = "Source"
      owner    = "AWS"
      provider = "CodeCommit"
      version  = "1"
      configuration = {
        RepositoryName = var.codecommit_repo_name
        BranchName     = "master"
      }

      output_artifacts = ["source_artifact"]
    }

  }

  stage {
    name = "TerraformValidate"

    action {
      name            = "Terraform_Validate"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["source_artifact"]
      configuration = {
        ProjectName = aws_codebuild_project.terraform-validate.name
      }
    }
  }

  stage {
    name = "TerraformPlan"

    action {
      name            = "Terraform_Plan"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["source_artifact"]
      configuration = {
        ProjectName = aws_codebuild_project.terraform-plan.name
      }
    }
  }


  stage {
    name = "TerraformApproval"

    action {
      name     = "Manual_Approval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"

      configuration = {
        NotificationArn    = var.approve_sns_arn
        CustomData         = "This action will approve the deployment of resources in ${aws_codebuild_project.terraform-plan.id}. Please ensure that you review the build logs of the plan stage before approving."
        ExternalEntityLink = "https://${data.aws_region.current.name}.console.aws.amazon.com/codesuite/codebuild/${data.aws_caller_identity.current.account_id}/projects/${var.codebuild_project_name}-plan/"

      }
    }
  }

  stage {
    name = "TerraformApply"

    action {
      name            = "Terraform_Apply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["source_artifact"]
      configuration = {
        ProjectName = aws_codebuild_project.terraform-apply.name
      }
    }
  }

}