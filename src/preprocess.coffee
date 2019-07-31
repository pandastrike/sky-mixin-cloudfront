import Sundog from "sundog"

preprocess = (SDK, global, meta, local) ->
  if meta.vpc
    throw new Error "sky-mixin-cloudfront does not currently support linking a lambda to the CloudFront service through a VPC endpoint"

  {get} = (Sundog SDK).AWS.CloudFront()

  arns = []
  for {hostname} in local.distributions
    if distro = await get hostname
      arns.push distro.ARN
    else
      console.warn "Did not find a CloudFront distribution for #{hostname}"

  arns: arns
  vpc: meta.vpc

export default preprocess
