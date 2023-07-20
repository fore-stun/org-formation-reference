{ phases =
  { build.commands
    =
    [ "npm run print-tasks -- --no-color"
    , "npm run validate-tasks -- --no-color"
    , "npm run cfn-lint"
    ]
  , install.commands
    =
    [ "npm ci"
    , "echo installed dependencies"
    , "npx org-formation -v"
    , "pip install cfn-lint"
    ]
  }
, version = 0.2
}
