import {resolve} from "path"
import {toJSON} from "panda-parchment"
import {read as _read} from "panda-quill"
import {yaml} from "panda-serialize"
import AJV from "ajv"

import preprocess from "./preprocess"
import getPolicy from "./policy"
import getTemplate from "./template"

ajv = new AJV()
read = (name) ->
  await _read resolve __dirname, "..", "..", "..", "files", name

create = (SDK, global, meta, local) ->
  schema = yaml await read "schema.yaml"
  schema.definitions = yaml await read "definitions.yaml"
  template = await read "template.yaml"

  unless ajv.validate schema, local
    console.error toJSON ajv.errors, true
    throw new Error "failed to validate mixin configuration"

  config = await preprocess SDK, global, meta, local

  name: "cloudfront"
  policy: getPolicy config
  template: getTemplate config
  vpc: config.vpc

export default create
