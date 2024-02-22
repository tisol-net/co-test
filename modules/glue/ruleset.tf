resource "aws_glue_data_quality_ruleset" "weather_data_quality" {
  name    = "weather_data_quality"
  ruleset = "Rules = [Completeness \"colA\" between 0.4 and 0.8]"
}