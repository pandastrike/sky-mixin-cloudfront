import {isEmpty} from "panda-parchment"

Policy = (config) ->

  if isEmpty config.arns
    []
  else
    [
      Effect: "Allow"
      Action: [ "cloudfront:CreateInvalidation" ]
      Resource: config.arns
    ]

export default Policy
