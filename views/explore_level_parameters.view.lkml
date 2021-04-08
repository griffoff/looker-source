view: explore_level_parameters {
  parameter: schema_name {
    label: "Environment"
    hidden: no
    type: unquoted
    allowed_value: {
      label: "Production"
      value: "PROD"
    }
    allowed_value: {
      label: "Staging"
      value: "NONPROD"
    }

    default_value: "PROD"
    description: "Schema name"
  }
}
