locals {
  BG = {
    blue  = aws_iam_access_key.blue
    green = aws_iam_access_key.green
  }
}

resource "rotating_blue_green" "this" {
  rotate_after_days = var.rotation_days
}

resource "random_pet" "blue" {
  keepers = {
    uuid = rotating_blue_green.this.blue_uuid
  }
}

resource "random_pet" "green" {
  keepers = {
    uuid = rotating_blue_green.this.green_uuid
  }
}

resource "aws_iam_user" "this" {
  name = var.name
}

resource "aws_iam_access_key" "blue" {
  user = aws_iam_user.this.name

  lifecycle {
    replace_triggered_by = [
      random_pet.blue
    ]
  }
}

resource "aws_iam_access_key" "green" {
  user = aws_iam_user.this.name

  lifecycle {
    replace_triggered_by = [
      random_pet.green
    ]
  }
}

