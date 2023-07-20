{ allRegions = { Default = [ "{{primary-aws-region}}" ], Type = "List<String>" }
, organizationPrincipalId =
  { Default.Ref = "ORG::PrincipalOrgID", Type = "String" }
, primaryRegion = { Default = "{{primary-aws-region}}", Type = "String" }
, resourcePrefix = { Default = "{{organization-name}}", Type = "String" }
}
