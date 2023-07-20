{ AccountCreation =
  { DependsOn = [ "OrganizationBuild" ]
  , Path = "./templates/050-account-creation/_tasks.yml"
  , Type = "include"
  }
, AwsConfigInventory =
  { DependsOn = [ "OrganizationBuild" ]
  , Path = "./templates/080-aws-config-inventory/_tasks.yml"
  , Type = "include"
  }
, AwsSso =
  { DependsOn = [ "OrganizationBuild", "Types", "SeviceControlPolicies" ]
  , Path = "./templates/100-aws-sso/_tasks.yml"
  , Type = "include"
  }
, Budgets =
  { DependsOn = [ "OrganizationBuild" ]
  , Path = "./templates/040-budgets/_tasks.yml"
  , Type = "include"
  }
, CloudTrail =
  { DependsOn = [ "OrganizationBuild" ]
  , Path = "./templates/060-cloud-trail/_tasks.yml"
  , Type = "include"
  }
, GuardDuty =
  { DependsOn = [ "OrganizationBuild", "Types" ]
  , Path = "./templates/070-guard-duty/_tasks.yml"
  , Type = "include"
  }
, OrganizationBuild =
  { DependsOn = "OrganizationUpdate"
  , Path = "./templates/000-org-build/_tasks.yml"
  , Type = "include"
  }
, OrganizationUpdate =
  { Template = "./organization.yml", Type = "update-organization" }
, Parameters.`<<Include` = "./_parameters.yml"
, SecureDefaults =
  { DependsOn = [ "OrganizationBuild", "Types" ]
  , Path = "./templates/020-secure-defaults/_tasks.yml"
  , Type = "include"
  }
, ServiceQuotas =
  { DependsOn = [ "OrganizationBuild", "Types" ]
  , Path = "./templates/030-service-quotas/_tasks.yml"
  , Type = "include"
  }
, SeviceControlPolicies =
  { DependsOn = [ "OrganizationBuild", "Types" ]
  , Path = "./templates/010-scps/_tasks.yml"
  , Type = "include"
  }
, Types =
  { DependsOn = "OrganizationBuild"
  , Path = "./templates/005-types/_tasks.yml"
  , Type = "include"
  }
}
