-- https://aws.amazon.com/blogs/mt/best-practices-for-organizational-units-with-aws-organizations/
{ AWSTemplateFormatVersion = "2010-09-09-OC"
, Description = "Default organization blueprint"
, Organization =
  { LogArchiveAccount =
    { Properties =
      { AccountName = "Log Archive Account"
      , Alias = "{{organization-name}}-log-archive"
      , RootEmail = "aws+log-archive@{{email-domain}}"
      , Tags =
        { budget-alarm-threshold = 200
        , budget-alarm-threshold-email-recipient =
            "log-archive@{{email-domain}}"
        }
      }
    , Type = "OC::ORG::Account"
    }
  , ManagementAccount =
    { Properties =
      { AccountId = "{{management-account-id}}"
      , AccountName = "Management Account"
      , Alias = "{{organization-name}}-management"
      , RootEmail = "aws+management@{{email-domain}}"
      , Tags =
        { budget-alarm-threshold = 200
        , budget-alarm-threshold-email-recipient = "me@{{email-domain}}"
        }
      }
    , Type = "OC::ORG::MasterAccount"
    }
  , OrgBuildAccount =
    { Properties =
      { AccountName = "Organization Build Account"
      , Alias = "{{organization-name}}-org-build"
      , RootEmail = "aws+org-build@{{email-domain}}"
      , Tags =
        { budget-alarm-threshold = 200
        , budget-alarm-threshold-email-recipient = "me@{{email-domain}}"
        }
      }
    , Type = "OC::ORG::Account"
    }
  , OrganizationRoot =
    { Properties =
      { DefaultBuildAccessRoleName = "OrganizationFormationBuildAccessRole"
      , DefaultOrganizationAccessRoleName = "OrganizationAccountAccessRole"
      }
    , Type = "OC::ORG::OrganizationRoot"
    }
  , ProdOu =
    { Properties = { Accounts = [] : List <>, OrganizationalUnitName = "prod" }
    , Type = "OC::ORG::OrganizationalUnit"
    }
  , SdlcOu =
    { Properties = { Accounts = [] : List <>, OrganizationalUnitName = "sdlc" }
    , Type = "OC::ORG::OrganizationalUnit"
    }
  , SecurityAccount =
    { Properties =
      { AccountName = "Security Account"
      , Alias = "{{organization-name}}-security"
      , RootEmail = "aws+security@{{email-domain}}"
      , Tags =
        { budget-alarm-threshold = 200
        , budget-alarm-threshold-email-recipient = "security@{{email-domain}}"
        }
      }
    , Type = "OC::ORG::Account"
    }
  , SharedOu =
    { Properties =
      { Accounts =
        [ { Ref = "OrgBuildAccount" }
        , { Ref = "SecurityAccount" }
        , { Ref = "LogArchiveAccount" }
        ]
      , OrganizationalUnitName = "shared"
      }
    , Type = "OC::ORG::OrganizationalUnit"
    }
  , SuspendedOu =
    { Properties =
      { Accounts = [] : List <>, OrganizationalUnitName = "suspended" }
    , Type = "OC::ORG::OrganizationalUnit"
    }
  }
}
