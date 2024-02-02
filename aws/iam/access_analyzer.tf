resource "aws_accessanalyzer_analyzer" "analyzer" {
  count         = var.enable_analyzer == true ? 1 : 0
  analyzer_name = "<org>"
  type          = "ORGANIZATION"
}
