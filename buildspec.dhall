{ phases =
  { build.commands = [ "npm run perform-tasks -- --no-color" ]
  , install.commands
    =
    [ "npm ci", "echo installed dependencies", "npx org-formation -v" ]
  , post_build.commands = [ "echo Build completed" ]
  }
, version = 0.2
}
