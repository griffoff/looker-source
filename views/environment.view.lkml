view: environment {
  parameter: environment {
    default_value: "PROD"
    type: unquoted
    allowed_value: {label: "Production Data" value: "PROD"}
    allowed_value: {label: "Lower Environment Data" value: "NONPROD"}
  }
}
