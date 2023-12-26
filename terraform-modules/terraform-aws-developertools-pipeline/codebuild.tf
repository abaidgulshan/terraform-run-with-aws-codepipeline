
###########################################
##  AWS CodeBuild Projects Configuration ##
###########################################

resource "aws_codebuild_project" "terraform-validate" {
  name         = "${var.codebuild_project_name}-validate"
  service_role = aws_iam_role.codebuild.arn
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type         = "LINUX_CONTAINER"
  }
  source {
    type            = "CODECOMMIT"
    location        = data.aws_codecommit_repository.repo.clone_url_http
    git_clone_depth = 1
    buildspec       = "./buildspec-templates/buildspec_validate.yml"
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
  source_version = "master"
}


###########################################
##  AWS CodeBuild Projects Configuration ##
###########################################

resource "aws_codebuild_project" "terraform-plan" {
  name         = "${var.codebuild_project_name}-plan"
  service_role = aws_iam_role.codebuild.arn
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type         = "LINUX_CONTAINER"
  }
  source {
    type            = "CODECOMMIT"
    location        = data.aws_codecommit_repository.repo.clone_url_http
    git_clone_depth = 1
    buildspec       = "./buildspec-templates/buildspec_plan.yml"
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
  source_version = "master"
}

###########################################
##  AWS CodeBuild Projects Configuration ##
###########################################

resource "aws_codebuild_project" "terraform-apply" {
  name         = "${var.codebuild_project_name}-apply"
  service_role = aws_iam_role.codebuild.arn
  environment {
    # compute_type = "BUILD_GENERAL1_SMALL"
    # image        = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    # type         = "LINUX_CONTAINER"
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    image_pull_credentials_type = "CODEBUILD"
  }
  source {
    type            = "CODECOMMIT"
    location        = data.aws_codecommit_repository.repo.clone_url_http
    git_clone_depth = 1
    buildspec       = "./buildspec-templates/buildspec_apply.yml"
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
  source_version = "master"
}