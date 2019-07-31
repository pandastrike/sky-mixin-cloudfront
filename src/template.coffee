import PandaTemplate from "panda-template"

T = new PandaTemplate()

getTemplate = (config) ->

  if config.vpc
    T.render template, config
  else
    false

export default getTemplate
