// ignore_for_file: prefer_single_quotes
const Map<String, Map<String, dynamic>> shapesJson = {
  "AcceptTermsAndConditions": {"type": "boolean", "flattened": false},
  "Account": {"type": "string", "flattened": false},
  "AccountFilterType": {"type": "string", "flattened": false},
  "AccountGateResult": {
    "type": "structure",
    "members": {
      "Status": {"shape": "AccountGateStatus", "flattened": false},
      "StatusReason": {"shape": "AccountGateStatusReason", "flattened": false}
    },
    "flattened": false
  },
  "AccountGateStatus": {"type": "string", "flattened": false},
  "AccountGateStatusReason": {"type": "string", "flattened": false},
  "AccountLimit": {
    "type": "structure",
    "members": {
      "Name": {"shape": "LimitName", "flattened": false},
      "Value": {"shape": "LimitValue", "flattened": false}
    },
    "flattened": false
  },
  "AccountLimitList": {
    "type": "list",
    "member": {"shape": "AccountLimit"},
    "flattened": false
  },
  "AccountList": {
    "type": "list",
    "member": {"shape": "Account"},
    "flattened": false
  },
  "AccountsUrl": {"type": "string", "flattened": false},
  "ActivateTypeInput": {
    "type": "structure",
    "members": {
      "Type": {"shape": "ThirdPartyType", "flattened": false},
      "PublicTypeArn": {"shape": "ThirdPartyTypeArn", "flattened": false},
      "PublisherId": {"shape": "PublisherId", "flattened": false},
      "TypeName": {"shape": "TypeName", "flattened": false},
      "TypeNameAlias": {"shape": "TypeName", "flattened": false},
      "AutoUpdate": {"shape": "AutoUpdate", "flattened": false},
      "LoggingConfig": {"shape": "LoggingConfig", "flattened": false},
      "ExecutionRoleArn": {"shape": "RoleArn", "flattened": false},
      "VersionBump": {"shape": "VersionBump", "flattened": false},
      "MajorVersion": {"shape": "MajorVersion", "flattened": false}
    },
    "flattened": false
  },
  "ActivateTypeOutput": {
    "type": "structure",
    "members": {
      "Arn": {"shape": "PrivateTypeArn", "flattened": false}
    },
    "flattened": false
  },
  "AllowedValue": {"type": "string", "flattened": false},
  "AllowedValues": {
    "type": "list",
    "member": {"shape": "AllowedValue"},
    "flattened": false
  },
  "Arn": {"type": "string", "flattened": false},
  "AutoDeployment": {
    "type": "structure",
    "members": {
      "Enabled": {"shape": "AutoDeploymentNullable", "flattened": false},
      "RetainStacksOnAccountRemoval": {
        "shape": "RetainStacksOnAccountRemovalNullable",
        "flattened": false
      }
    },
    "flattened": false
  },
  "AutoDeploymentNullable": {"type": "boolean", "flattened": false},
  "AutoUpdate": {"type": "boolean", "flattened": false},
  "BatchDescribeTypeConfigurationsError": {
    "type": "structure",
    "members": {
      "ErrorCode": {"shape": "ErrorCode", "flattened": false},
      "ErrorMessage": {"shape": "ErrorMessage", "flattened": false},
      "TypeConfigurationIdentifier": {
        "shape": "TypeConfigurationIdentifier",
        "flattened": false
      }
    },
    "flattened": false
  },
  "BatchDescribeTypeConfigurationsErrors": {
    "type": "list",
    "member": {"shape": "BatchDescribeTypeConfigurationsError"},
    "flattened": false
  },
  "BatchDescribeTypeConfigurationsInput": {
    "type": "structure",
    "members": {
      "TypeConfigurationIdentifiers": {
        "shape": "TypeConfigurationIdentifiers",
        "flattened": false
      }
    },
    "flattened": false
  },
  "BatchDescribeTypeConfigurationsOutput": {
    "type": "structure",
    "members": {
      "Errors": {
        "shape": "BatchDescribeTypeConfigurationsErrors",
        "flattened": false
      },
      "UnprocessedTypeConfigurations": {
        "shape": "UnprocessedTypeConfigurations",
        "flattened": false
      },
      "TypeConfigurations": {
        "shape": "TypeConfigurationDetailsList",
        "flattened": false
      }
    },
    "flattened": false
  },
  "BoxedInteger": {"type": "integer", "flattened": false},
  "BoxedMaxResults": {"type": "integer", "flattened": false},
  "CallAs": {"type": "string", "flattened": false},
  "CancelUpdateStackInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackName", "flattened": false},
      "ClientRequestToken": {"shape": "ClientRequestToken", "flattened": false}
    },
    "flattened": false
  },
  "Capabilities": {
    "type": "list",
    "member": {"shape": "Capability"},
    "flattened": false
  },
  "CapabilitiesReason": {"type": "string", "flattened": false},
  "Capability": {"type": "string", "flattened": false},
  "Category": {"type": "string", "flattened": false},
  "CausingEntity": {"type": "string", "flattened": false},
  "Change": {
    "type": "structure",
    "members": {
      "Type": {"shape": "ChangeType", "flattened": false},
      "HookInvocationCount": {
        "shape": "HookInvocationCount",
        "flattened": false
      },
      "ResourceChange": {"shape": "ResourceChange", "flattened": false}
    },
    "flattened": false
  },
  "ChangeAction": {"type": "string", "flattened": false},
  "ChangeSetHook": {
    "type": "structure",
    "members": {
      "InvocationPoint": {"shape": "HookInvocationPoint", "flattened": false},
      "FailureMode": {"shape": "HookFailureMode", "flattened": false},
      "TypeName": {"shape": "HookTypeName", "flattened": false},
      "TypeVersionId": {"shape": "HookTypeVersionId", "flattened": false},
      "TypeConfigurationVersionId": {
        "shape": "HookTypeConfigurationVersionId",
        "flattened": false
      },
      "TargetDetails": {
        "shape": "ChangeSetHookTargetDetails",
        "flattened": false
      }
    },
    "flattened": false
  },
  "ChangeSetHookResourceTargetDetails": {
    "type": "structure",
    "members": {
      "LogicalResourceId": {"shape": "LogicalResourceId", "flattened": false},
      "ResourceType": {"shape": "HookTargetTypeName", "flattened": false},
      "ResourceAction": {"shape": "ChangeAction", "flattened": false}
    },
    "flattened": false
  },
  "ChangeSetHookTargetDetails": {
    "type": "structure",
    "members": {
      "TargetType": {"shape": "HookTargetType", "flattened": false},
      "ResourceTargetDetails": {
        "shape": "ChangeSetHookResourceTargetDetails",
        "flattened": false
      }
    },
    "flattened": false
  },
  "ChangeSetHooks": {
    "type": "list",
    "member": {"shape": "ChangeSetHook"},
    "flattened": false
  },
  "ChangeSetHooksStatus": {"type": "string", "flattened": false},
  "ChangeSetId": {"type": "string", "flattened": false},
  "ChangeSetName": {"type": "string", "flattened": false},
  "ChangeSetNameOrId": {"type": "string", "flattened": false},
  "ChangeSetStatus": {"type": "string", "flattened": false},
  "ChangeSetStatusReason": {"type": "string", "flattened": false},
  "ChangeSetSummaries": {
    "type": "list",
    "member": {"shape": "ChangeSetSummary"},
    "flattened": false
  },
  "ChangeSetSummary": {
    "type": "structure",
    "members": {
      "StackId": {"shape": "StackId", "flattened": false},
      "StackName": {"shape": "StackName", "flattened": false},
      "ChangeSetId": {"shape": "ChangeSetId", "flattened": false},
      "ChangeSetName": {"shape": "ChangeSetName", "flattened": false},
      "ExecutionStatus": {"shape": "ExecutionStatus", "flattened": false},
      "Status": {"shape": "ChangeSetStatus", "flattened": false},
      "StatusReason": {"shape": "ChangeSetStatusReason", "flattened": false},
      "CreationTime": {"shape": "CreationTime", "flattened": false},
      "Description": {"shape": "Description", "flattened": false},
      "IncludeNestedStacks": {
        "shape": "IncludeNestedStacks",
        "flattened": false
      },
      "ParentChangeSetId": {"shape": "ChangeSetId", "flattened": false},
      "RootChangeSetId": {"shape": "ChangeSetId", "flattened": false}
    },
    "flattened": false
  },
  "ChangeSetType": {"type": "string", "flattened": false},
  "ChangeSource": {"type": "string", "flattened": false},
  "ChangeType": {"type": "string", "flattened": false},
  "Changes": {
    "type": "list",
    "member": {"shape": "Change"},
    "flattened": false
  },
  "ClientRequestToken": {"type": "string", "flattened": false},
  "ClientToken": {"type": "string", "flattened": false},
  "ConfigurationSchema": {"type": "string", "flattened": false},
  "ConnectionArn": {"type": "string", "flattened": false},
  "ContinueUpdateRollbackInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackNameOrId", "flattened": false},
      "RoleARN": {"shape": "RoleARN", "flattened": false},
      "ResourcesToSkip": {"shape": "ResourcesToSkip", "flattened": false},
      "ClientRequestToken": {"shape": "ClientRequestToken", "flattened": false}
    },
    "flattened": false
  },
  "ContinueUpdateRollbackOutput": {
    "type": "structure",
    "members": {},
    "flattened": false
  },
  "CreateChangeSetInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackNameOrId", "flattened": false},
      "TemplateBody": {"shape": "TemplateBody", "flattened": false},
      "TemplateURL": {"shape": "TemplateURL", "flattened": false},
      "UsePreviousTemplate": {
        "shape": "UsePreviousTemplate",
        "flattened": false
      },
      "Parameters": {"shape": "Parameters", "flattened": false},
      "Capabilities": {"shape": "Capabilities", "flattened": false},
      "ResourceTypes": {"shape": "ResourceTypes", "flattened": false},
      "RoleARN": {"shape": "RoleARN", "flattened": false},
      "RollbackConfiguration": {
        "shape": "RollbackConfiguration",
        "flattened": false
      },
      "NotificationARNs": {"shape": "NotificationARNs", "flattened": false},
      "Tags": {"shape": "Tags", "flattened": false},
      "ChangeSetName": {"shape": "ChangeSetName", "flattened": false},
      "ClientToken": {"shape": "ClientToken", "flattened": false},
      "Description": {"shape": "Description", "flattened": false},
      "ChangeSetType": {"shape": "ChangeSetType", "flattened": false},
      "ResourcesToImport": {"shape": "ResourcesToImport", "flattened": false},
      "IncludeNestedStacks": {
        "shape": "IncludeNestedStacks",
        "flattened": false
      }
    },
    "flattened": false
  },
  "CreateChangeSetOutput": {
    "type": "structure",
    "members": {
      "Id": {"shape": "ChangeSetId", "flattened": false},
      "StackId": {"shape": "StackId", "flattened": false}
    },
    "flattened": false
  },
  "CreateStackInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackName", "flattened": false},
      "TemplateBody": {"shape": "TemplateBody", "flattened": false},
      "TemplateURL": {"shape": "TemplateURL", "flattened": false},
      "Parameters": {"shape": "Parameters", "flattened": false},
      "DisableRollback": {"shape": "DisableRollback", "flattened": false},
      "RollbackConfiguration": {
        "shape": "RollbackConfiguration",
        "flattened": false
      },
      "TimeoutInMinutes": {"shape": "TimeoutMinutes", "flattened": false},
      "NotificationARNs": {"shape": "NotificationARNs", "flattened": false},
      "Capabilities": {"shape": "Capabilities", "flattened": false},
      "ResourceTypes": {"shape": "ResourceTypes", "flattened": false},
      "RoleARN": {"shape": "RoleARN", "flattened": false},
      "OnFailure": {"shape": "OnFailure", "flattened": false},
      "StackPolicyBody": {"shape": "StackPolicyBody", "flattened": false},
      "StackPolicyURL": {"shape": "StackPolicyURL", "flattened": false},
      "Tags": {"shape": "Tags", "flattened": false},
      "ClientRequestToken": {"shape": "ClientRequestToken", "flattened": false},
      "EnableTerminationProtection": {
        "shape": "EnableTerminationProtection",
        "flattened": false
      }
    },
    "flattened": false
  },
  "CreateStackInstancesInput": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetName", "flattened": false},
      "Accounts": {"shape": "AccountList", "flattened": false},
      "DeploymentTargets": {"shape": "DeploymentTargets", "flattened": false},
      "Regions": {"shape": "RegionList", "flattened": false},
      "ParameterOverrides": {"shape": "Parameters", "flattened": false},
      "OperationPreferences": {
        "shape": "StackSetOperationPreferences",
        "flattened": false
      },
      "OperationId": {"shape": "ClientRequestToken", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false}
    },
    "flattened": false
  },
  "CreateStackInstancesOutput": {
    "type": "structure",
    "members": {
      "OperationId": {"shape": "ClientRequestToken", "flattened": false}
    },
    "flattened": false
  },
  "CreateStackOutput": {
    "type": "structure",
    "members": {
      "StackId": {"shape": "StackId", "flattened": false}
    },
    "flattened": false
  },
  "CreateStackSetInput": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetName", "flattened": false},
      "Description": {"shape": "Description", "flattened": false},
      "TemplateBody": {"shape": "TemplateBody", "flattened": false},
      "TemplateURL": {"shape": "TemplateURL", "flattened": false},
      "StackId": {"shape": "StackId", "flattened": false},
      "Parameters": {"shape": "Parameters", "flattened": false},
      "Capabilities": {"shape": "Capabilities", "flattened": false},
      "Tags": {"shape": "Tags", "flattened": false},
      "AdministrationRoleARN": {"shape": "RoleARN", "flattened": false},
      "ExecutionRoleName": {"shape": "ExecutionRoleName", "flattened": false},
      "PermissionModel": {"shape": "PermissionModels", "flattened": false},
      "AutoDeployment": {"shape": "AutoDeployment", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false},
      "ClientRequestToken": {"shape": "ClientRequestToken", "flattened": false},
      "ManagedExecution": {"shape": "ManagedExecution", "flattened": false}
    },
    "flattened": false
  },
  "CreateStackSetOutput": {
    "type": "structure",
    "members": {
      "StackSetId": {"shape": "StackSetId", "flattened": false}
    },
    "flattened": false
  },
  "CreationTime": {"type": "timestamp", "flattened": false},
  "DeactivateTypeInput": {
    "type": "structure",
    "members": {
      "TypeName": {"shape": "TypeName", "flattened": false},
      "Type": {"shape": "ThirdPartyType", "flattened": false},
      "Arn": {"shape": "PrivateTypeArn", "flattened": false}
    },
    "flattened": false
  },
  "DeactivateTypeOutput": {
    "type": "structure",
    "members": {},
    "flattened": false
  },
  "DeleteChangeSetInput": {
    "type": "structure",
    "members": {
      "ChangeSetName": {"shape": "ChangeSetNameOrId", "flattened": false},
      "StackName": {"shape": "StackNameOrId", "flattened": false}
    },
    "flattened": false
  },
  "DeleteChangeSetOutput": {
    "type": "structure",
    "members": {},
    "flattened": false
  },
  "DeleteStackInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackName", "flattened": false},
      "RetainResources": {"shape": "RetainResources", "flattened": false},
      "RoleARN": {"shape": "RoleARN", "flattened": false},
      "ClientRequestToken": {"shape": "ClientRequestToken", "flattened": false}
    },
    "flattened": false
  },
  "DeleteStackInstancesInput": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetName", "flattened": false},
      "Accounts": {"shape": "AccountList", "flattened": false},
      "DeploymentTargets": {"shape": "DeploymentTargets", "flattened": false},
      "Regions": {"shape": "RegionList", "flattened": false},
      "OperationPreferences": {
        "shape": "StackSetOperationPreferences",
        "flattened": false
      },
      "RetainStacks": {"shape": "RetainStacks", "flattened": false},
      "OperationId": {"shape": "ClientRequestToken", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false}
    },
    "flattened": false
  },
  "DeleteStackInstancesOutput": {
    "type": "structure",
    "members": {
      "OperationId": {"shape": "ClientRequestToken", "flattened": false}
    },
    "flattened": false
  },
  "DeleteStackSetInput": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetName", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false}
    },
    "flattened": false
  },
  "DeleteStackSetOutput": {
    "type": "structure",
    "members": {},
    "flattened": false
  },
  "DeletionTime": {"type": "timestamp", "flattened": false},
  "DeploymentTargets": {
    "type": "structure",
    "members": {
      "Accounts": {"shape": "AccountList", "flattened": false},
      "AccountsUrl": {"shape": "AccountsUrl", "flattened": false},
      "OrganizationalUnitIds": {
        "shape": "OrganizationalUnitIdList",
        "flattened": false
      },
      "AccountFilterType": {"shape": "AccountFilterType", "flattened": false}
    },
    "flattened": false
  },
  "DeprecatedStatus": {"type": "string", "flattened": false},
  "DeregisterTypeInput": {
    "type": "structure",
    "members": {
      "Arn": {"shape": "PrivateTypeArn", "flattened": false},
      "Type": {"shape": "RegistryType", "flattened": false},
      "TypeName": {"shape": "TypeName", "flattened": false},
      "VersionId": {"shape": "TypeVersionId", "flattened": false}
    },
    "flattened": false
  },
  "DeregisterTypeOutput": {
    "type": "structure",
    "members": {},
    "flattened": false
  },
  "DescribeAccountLimitsInput": {
    "type": "structure",
    "members": {
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "DescribeAccountLimitsOutput": {
    "type": "structure",
    "members": {
      "AccountLimits": {"shape": "AccountLimitList", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "DescribeChangeSetHooksInput": {
    "type": "structure",
    "members": {
      "ChangeSetName": {"shape": "ChangeSetNameOrId", "flattened": false},
      "StackName": {"shape": "StackNameOrId", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false},
      "LogicalResourceId": {"shape": "LogicalResourceId", "flattened": false}
    },
    "flattened": false
  },
  "DescribeChangeSetHooksOutput": {
    "type": "structure",
    "members": {
      "ChangeSetId": {"shape": "ChangeSetId", "flattened": false},
      "ChangeSetName": {"shape": "ChangeSetName", "flattened": false},
      "Hooks": {"shape": "ChangeSetHooks", "flattened": false},
      "Status": {"shape": "ChangeSetHooksStatus", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false},
      "StackId": {"shape": "StackId", "flattened": false},
      "StackName": {"shape": "StackName", "flattened": false}
    },
    "flattened": false
  },
  "DescribeChangeSetInput": {
    "type": "structure",
    "members": {
      "ChangeSetName": {"shape": "ChangeSetNameOrId", "flattened": false},
      "StackName": {"shape": "StackNameOrId", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "DescribeChangeSetOutput": {
    "type": "structure",
    "members": {
      "ChangeSetName": {"shape": "ChangeSetName", "flattened": false},
      "ChangeSetId": {"shape": "ChangeSetId", "flattened": false},
      "StackId": {"shape": "StackId", "flattened": false},
      "StackName": {"shape": "StackName", "flattened": false},
      "Description": {"shape": "Description", "flattened": false},
      "Parameters": {"shape": "Parameters", "flattened": false},
      "CreationTime": {"shape": "CreationTime", "flattened": false},
      "ExecutionStatus": {"shape": "ExecutionStatus", "flattened": false},
      "Status": {"shape": "ChangeSetStatus", "flattened": false},
      "StatusReason": {"shape": "ChangeSetStatusReason", "flattened": false},
      "NotificationARNs": {"shape": "NotificationARNs", "flattened": false},
      "RollbackConfiguration": {
        "shape": "RollbackConfiguration",
        "flattened": false
      },
      "Capabilities": {"shape": "Capabilities", "flattened": false},
      "Tags": {"shape": "Tags", "flattened": false},
      "Changes": {"shape": "Changes", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false},
      "IncludeNestedStacks": {
        "shape": "IncludeNestedStacks",
        "flattened": false
      },
      "ParentChangeSetId": {"shape": "ChangeSetId", "flattened": false},
      "RootChangeSetId": {"shape": "ChangeSetId", "flattened": false}
    },
    "flattened": false
  },
  "DescribePublisherInput": {
    "type": "structure",
    "members": {
      "PublisherId": {"shape": "PublisherId", "flattened": false}
    },
    "flattened": false
  },
  "DescribePublisherOutput": {
    "type": "structure",
    "members": {
      "PublisherId": {"shape": "PublisherId", "flattened": false},
      "PublisherStatus": {"shape": "PublisherStatus", "flattened": false},
      "IdentityProvider": {"shape": "IdentityProvider", "flattened": false},
      "PublisherProfile": {"shape": "PublisherProfile", "flattened": false}
    },
    "flattened": false
  },
  "DescribeStackDriftDetectionStatusInput": {
    "type": "structure",
    "members": {
      "StackDriftDetectionId": {
        "shape": "StackDriftDetectionId",
        "flattened": false
      }
    },
    "flattened": false
  },
  "DescribeStackDriftDetectionStatusOutput": {
    "type": "structure",
    "members": {
      "StackId": {"shape": "StackId", "flattened": false},
      "StackDriftDetectionId": {
        "shape": "StackDriftDetectionId",
        "flattened": false
      },
      "StackDriftStatus": {"shape": "StackDriftStatus", "flattened": false},
      "DetectionStatus": {
        "shape": "StackDriftDetectionStatus",
        "flattened": false
      },
      "DetectionStatusReason": {
        "shape": "StackDriftDetectionStatusReason",
        "flattened": false
      },
      "DriftedStackResourceCount": {
        "shape": "BoxedInteger",
        "flattened": false
      },
      "Timestamp": {"shape": "Timestamp", "flattened": false}
    },
    "flattened": false
  },
  "DescribeStackEventsInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackName", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "DescribeStackEventsOutput": {
    "type": "structure",
    "members": {
      "StackEvents": {"shape": "StackEvents", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "DescribeStackInstanceInput": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetName", "flattened": false},
      "StackInstanceAccount": {"shape": "Account", "flattened": false},
      "StackInstanceRegion": {"shape": "Region", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false}
    },
    "flattened": false
  },
  "DescribeStackInstanceOutput": {
    "type": "structure",
    "members": {
      "StackInstance": {"shape": "StackInstance", "flattened": false}
    },
    "flattened": false
  },
  "DescribeStackResourceDriftsInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackNameOrId", "flattened": false},
      "StackResourceDriftStatusFilters": {
        "shape": "StackResourceDriftStatusFilters",
        "flattened": false
      },
      "NextToken": {"shape": "NextToken", "flattened": false},
      "MaxResults": {"shape": "BoxedMaxResults", "flattened": false}
    },
    "flattened": false
  },
  "DescribeStackResourceDriftsOutput": {
    "type": "structure",
    "members": {
      "StackResourceDrifts": {
        "shape": "StackResourceDrifts",
        "flattened": false
      },
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "DescribeStackResourceInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackName", "flattened": false},
      "LogicalResourceId": {"shape": "LogicalResourceId", "flattened": false}
    },
    "flattened": false
  },
  "DescribeStackResourceOutput": {
    "type": "structure",
    "members": {
      "StackResourceDetail": {
        "shape": "StackResourceDetail",
        "flattened": false
      }
    },
    "flattened": false
  },
  "DescribeStackResourcesInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackName", "flattened": false},
      "LogicalResourceId": {"shape": "LogicalResourceId", "flattened": false},
      "PhysicalResourceId": {"shape": "PhysicalResourceId", "flattened": false}
    },
    "flattened": false
  },
  "DescribeStackResourcesOutput": {
    "type": "structure",
    "members": {
      "StackResources": {"shape": "StackResources", "flattened": false}
    },
    "flattened": false
  },
  "DescribeStackSetInput": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetName", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false}
    },
    "flattened": false
  },
  "DescribeStackSetOperationInput": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetName", "flattened": false},
      "OperationId": {"shape": "ClientRequestToken", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false}
    },
    "flattened": false
  },
  "DescribeStackSetOperationOutput": {
    "type": "structure",
    "members": {
      "StackSetOperation": {"shape": "StackSetOperation", "flattened": false}
    },
    "flattened": false
  },
  "DescribeStackSetOutput": {
    "type": "structure",
    "members": {
      "StackSet": {"shape": "StackSet", "flattened": false}
    },
    "flattened": false
  },
  "DescribeStacksInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackName", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "DescribeStacksOutput": {
    "type": "structure",
    "members": {
      "Stacks": {"shape": "Stacks", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "DescribeTypeInput": {
    "type": "structure",
    "members": {
      "Type": {"shape": "RegistryType", "flattened": false},
      "TypeName": {"shape": "TypeName", "flattened": false},
      "Arn": {"shape": "TypeArn", "flattened": false},
      "VersionId": {"shape": "TypeVersionId", "flattened": false},
      "PublisherId": {"shape": "PublisherId", "flattened": false},
      "PublicVersionNumber": {
        "shape": "PublicVersionNumber",
        "flattened": false
      }
    },
    "flattened": false
  },
  "DescribeTypeOutput": {
    "type": "structure",
    "members": {
      "Arn": {"shape": "TypeArn", "flattened": false},
      "Type": {"shape": "RegistryType", "flattened": false},
      "TypeName": {"shape": "TypeName", "flattened": false},
      "DefaultVersionId": {"shape": "TypeVersionId", "flattened": false},
      "IsDefaultVersion": {"shape": "IsDefaultVersion", "flattened": false},
      "TypeTestsStatus": {"shape": "TypeTestsStatus", "flattened": false},
      "TypeTestsStatusDescription": {
        "shape": "TypeTestsStatusDescription",
        "flattened": false
      },
      "Description": {"shape": "Description", "flattened": false},
      "Schema": {"shape": "TypeSchema", "flattened": false},
      "ProvisioningType": {"shape": "ProvisioningType", "flattened": false},
      "DeprecatedStatus": {"shape": "DeprecatedStatus", "flattened": false},
      "LoggingConfig": {"shape": "LoggingConfig", "flattened": false},
      "RequiredActivatedTypes": {
        "shape": "RequiredActivatedTypes",
        "flattened": false
      },
      "ExecutionRoleArn": {"shape": "RoleArn", "flattened": false},
      "Visibility": {"shape": "Visibility", "flattened": false},
      "SourceUrl": {"shape": "OptionalSecureUrl", "flattened": false},
      "DocumentationUrl": {"shape": "OptionalSecureUrl", "flattened": false},
      "LastUpdated": {"shape": "Timestamp", "flattened": false},
      "TimeCreated": {"shape": "Timestamp", "flattened": false},
      "ConfigurationSchema": {
        "shape": "ConfigurationSchema",
        "flattened": false
      },
      "PublisherId": {"shape": "PublisherId", "flattened": false},
      "OriginalTypeName": {"shape": "TypeName", "flattened": false},
      "OriginalTypeArn": {"shape": "TypeArn", "flattened": false},
      "PublicVersionNumber": {
        "shape": "PublicVersionNumber",
        "flattened": false
      },
      "LatestPublicVersion": {
        "shape": "PublicVersionNumber",
        "flattened": false
      },
      "IsActivated": {"shape": "IsActivated", "flattened": false},
      "AutoUpdate": {"shape": "AutoUpdate", "flattened": false}
    },
    "flattened": false
  },
  "DescribeTypeRegistrationInput": {
    "type": "structure",
    "members": {
      "RegistrationToken": {"shape": "RegistrationToken", "flattened": false}
    },
    "flattened": false
  },
  "DescribeTypeRegistrationOutput": {
    "type": "structure",
    "members": {
      "ProgressStatus": {"shape": "RegistrationStatus", "flattened": false},
      "Description": {"shape": "Description", "flattened": false},
      "TypeArn": {"shape": "TypeArn", "flattened": false},
      "TypeVersionArn": {"shape": "TypeArn", "flattened": false}
    },
    "flattened": false
  },
  "Description": {"type": "string", "flattened": false},
  "DetectStackDriftInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackNameOrId", "flattened": false},
      "LogicalResourceIds": {"shape": "LogicalResourceIds", "flattened": false}
    },
    "flattened": false
  },
  "DetectStackDriftOutput": {
    "type": "structure",
    "members": {
      "StackDriftDetectionId": {
        "shape": "StackDriftDetectionId",
        "flattened": false
      }
    },
    "flattened": false
  },
  "DetectStackResourceDriftInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackNameOrId", "flattened": false},
      "LogicalResourceId": {"shape": "LogicalResourceId", "flattened": false}
    },
    "flattened": false
  },
  "DetectStackResourceDriftOutput": {
    "type": "structure",
    "members": {
      "StackResourceDrift": {"shape": "StackResourceDrift", "flattened": false}
    },
    "flattened": false
  },
  "DetectStackSetDriftInput": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetNameOrId", "flattened": false},
      "OperationPreferences": {
        "shape": "StackSetOperationPreferences",
        "flattened": false
      },
      "OperationId": {"shape": "ClientRequestToken", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false}
    },
    "flattened": false
  },
  "DetectStackSetDriftOutput": {
    "type": "structure",
    "members": {
      "OperationId": {"shape": "ClientRequestToken", "flattened": false}
    },
    "flattened": false
  },
  "DifferenceType": {"type": "string", "flattened": false},
  "DisableRollback": {"type": "boolean", "flattened": false},
  "DriftedStackInstancesCount": {"type": "integer", "flattened": false},
  "EnableTerminationProtection": {"type": "boolean", "flattened": false},
  "ErrorCode": {"type": "string", "flattened": false},
  "ErrorMessage": {"type": "string", "flattened": false},
  "EstimateTemplateCostInput": {
    "type": "structure",
    "members": {
      "TemplateBody": {"shape": "TemplateBody", "flattened": false},
      "TemplateURL": {"shape": "TemplateURL", "flattened": false},
      "Parameters": {"shape": "Parameters", "flattened": false}
    },
    "flattened": false
  },
  "EstimateTemplateCostOutput": {
    "type": "structure",
    "members": {
      "Url": {"shape": "Url", "flattened": false}
    },
    "flattened": false
  },
  "EvaluationType": {"type": "string", "flattened": false},
  "EventId": {"type": "string", "flattened": false},
  "ExecuteChangeSetInput": {
    "type": "structure",
    "members": {
      "ChangeSetName": {"shape": "ChangeSetNameOrId", "flattened": false},
      "StackName": {"shape": "StackNameOrId", "flattened": false},
      "ClientRequestToken": {"shape": "ClientRequestToken", "flattened": false},
      "DisableRollback": {"shape": "DisableRollback", "flattened": false}
    },
    "flattened": false
  },
  "ExecuteChangeSetOutput": {
    "type": "structure",
    "members": {},
    "flattened": false
  },
  "ExecutionRoleName": {"type": "string", "flattened": false},
  "ExecutionStatus": {"type": "string", "flattened": false},
  "Export": {
    "type": "structure",
    "members": {
      "ExportingStackId": {"shape": "StackId", "flattened": false},
      "Name": {"shape": "ExportName", "flattened": false},
      "Value": {"shape": "ExportValue", "flattened": false}
    },
    "flattened": false
  },
  "ExportName": {"type": "string", "flattened": false},
  "ExportValue": {"type": "string", "flattened": false},
  "Exports": {
    "type": "list",
    "member": {"shape": "Export"},
    "flattened": false
  },
  "FailedStackInstancesCount": {"type": "integer", "flattened": false},
  "FailureToleranceCount": {"type": "integer", "flattened": false},
  "FailureTolerancePercentage": {"type": "integer", "flattened": false},
  "GetStackPolicyInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackName", "flattened": false}
    },
    "flattened": false
  },
  "GetStackPolicyOutput": {
    "type": "structure",
    "members": {
      "StackPolicyBody": {"shape": "StackPolicyBody", "flattened": false}
    },
    "flattened": false
  },
  "GetTemplateInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackName", "flattened": false},
      "ChangeSetName": {"shape": "ChangeSetNameOrId", "flattened": false},
      "TemplateStage": {"shape": "TemplateStage", "flattened": false}
    },
    "flattened": false
  },
  "GetTemplateOutput": {
    "type": "structure",
    "members": {
      "TemplateBody": {"shape": "TemplateBody", "flattened": false},
      "StagesAvailable": {"shape": "StageList", "flattened": false}
    },
    "flattened": false
  },
  "GetTemplateSummaryInput": {
    "type": "structure",
    "members": {
      "TemplateBody": {"shape": "TemplateBody", "flattened": false},
      "TemplateURL": {"shape": "TemplateURL", "flattened": false},
      "StackName": {"shape": "StackNameOrId", "flattened": false},
      "StackSetName": {"shape": "StackSetNameOrId", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false}
    },
    "flattened": false
  },
  "GetTemplateSummaryOutput": {
    "type": "structure",
    "members": {
      "Parameters": {"shape": "ParameterDeclarations", "flattened": false},
      "Description": {"shape": "Description", "flattened": false},
      "Capabilities": {"shape": "Capabilities", "flattened": false},
      "CapabilitiesReason": {"shape": "CapabilitiesReason", "flattened": false},
      "ResourceTypes": {"shape": "ResourceTypes", "flattened": false},
      "Version": {"shape": "Version", "flattened": false},
      "Metadata": {"shape": "Metadata", "flattened": false},
      "DeclaredTransforms": {"shape": "TransformsList", "flattened": false},
      "ResourceIdentifierSummaries": {
        "shape": "ResourceIdentifierSummaries",
        "flattened": false
      }
    },
    "flattened": false
  },
  "HandlerErrorCode": {"type": "string", "flattened": false},
  "HookFailureMode": {"type": "string", "flattened": false},
  "HookInvocationCount": {"type": "integer", "flattened": false},
  "HookInvocationPoint": {"type": "string", "flattened": false},
  "HookStatus": {"type": "string", "flattened": false},
  "HookStatusReason": {"type": "string", "flattened": false},
  "HookTargetType": {"type": "string", "flattened": false},
  "HookTargetTypeName": {"type": "string", "flattened": false},
  "HookType": {"type": "string", "flattened": false},
  "HookTypeConfigurationVersionId": {"type": "string", "flattened": false},
  "HookTypeName": {"type": "string", "flattened": false},
  "HookTypeVersionId": {"type": "string", "flattened": false},
  "IdentityProvider": {"type": "string", "flattened": false},
  "ImportStacksToStackSetInput": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetNameOrId", "flattened": false},
      "StackIds": {"shape": "StackIdList", "flattened": false},
      "StackIdsUrl": {"shape": "StackIdsUrl", "flattened": false},
      "OrganizationalUnitIds": {
        "shape": "OrganizationalUnitIdList",
        "flattened": false
      },
      "OperationPreferences": {
        "shape": "StackSetOperationPreferences",
        "flattened": false
      },
      "OperationId": {"shape": "ClientRequestToken", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false}
    },
    "flattened": false
  },
  "ImportStacksToStackSetOutput": {
    "type": "structure",
    "members": {
      "OperationId": {"shape": "ClientRequestToken", "flattened": false}
    },
    "flattened": false
  },
  "Imports": {
    "type": "list",
    "member": {"shape": "StackName"},
    "flattened": false
  },
  "InProgressStackInstancesCount": {"type": "integer", "flattened": false},
  "InSyncStackInstancesCount": {"type": "integer", "flattened": false},
  "IncludeNestedStacks": {"type": "boolean", "flattened": false},
  "IsActivated": {"type": "boolean", "flattened": false},
  "IsDefaultConfiguration": {"type": "boolean", "flattened": false},
  "IsDefaultVersion": {"type": "boolean", "flattened": false},
  "Key": {"type": "string", "flattened": false},
  "LastUpdatedTime": {"type": "timestamp", "flattened": false},
  "LimitName": {"type": "string", "flattened": false},
  "LimitValue": {"type": "integer", "flattened": false},
  "ListChangeSetsInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackNameOrId", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListChangeSetsOutput": {
    "type": "structure",
    "members": {
      "Summaries": {"shape": "ChangeSetSummaries", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListExportsInput": {
    "type": "structure",
    "members": {
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListExportsOutput": {
    "type": "structure",
    "members": {
      "Exports": {"shape": "Exports", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListImportsInput": {
    "type": "structure",
    "members": {
      "ExportName": {"shape": "ExportName", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListImportsOutput": {
    "type": "structure",
    "members": {
      "Imports": {"shape": "Imports", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListStackInstancesInput": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetName", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false},
      "MaxResults": {"shape": "MaxResults", "flattened": false},
      "Filters": {"shape": "StackInstanceFilters", "flattened": false},
      "StackInstanceAccount": {"shape": "Account", "flattened": false},
      "StackInstanceRegion": {"shape": "Region", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false}
    },
    "flattened": false
  },
  "ListStackInstancesOutput": {
    "type": "structure",
    "members": {
      "Summaries": {"shape": "StackInstanceSummaries", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListStackResourcesInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackName", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListStackResourcesOutput": {
    "type": "structure",
    "members": {
      "StackResourceSummaries": {
        "shape": "StackResourceSummaries",
        "flattened": false
      },
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListStackSetOperationResultsInput": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetName", "flattened": false},
      "OperationId": {"shape": "ClientRequestToken", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false},
      "MaxResults": {"shape": "MaxResults", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false}
    },
    "flattened": false
  },
  "ListStackSetOperationResultsOutput": {
    "type": "structure",
    "members": {
      "Summaries": {
        "shape": "StackSetOperationResultSummaries",
        "flattened": false
      },
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListStackSetOperationsInput": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetName", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false},
      "MaxResults": {"shape": "MaxResults", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false}
    },
    "flattened": false
  },
  "ListStackSetOperationsOutput": {
    "type": "structure",
    "members": {
      "Summaries": {"shape": "StackSetOperationSummaries", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListStackSetsInput": {
    "type": "structure",
    "members": {
      "NextToken": {"shape": "NextToken", "flattened": false},
      "MaxResults": {"shape": "MaxResults", "flattened": false},
      "Status": {"shape": "StackSetStatus", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false}
    },
    "flattened": false
  },
  "ListStackSetsOutput": {
    "type": "structure",
    "members": {
      "Summaries": {"shape": "StackSetSummaries", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListStacksInput": {
    "type": "structure",
    "members": {
      "NextToken": {"shape": "NextToken", "flattened": false},
      "StackStatusFilter": {"shape": "StackStatusFilter", "flattened": false}
    },
    "flattened": false
  },
  "ListStacksOutput": {
    "type": "structure",
    "members": {
      "StackSummaries": {"shape": "StackSummaries", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListTypeRegistrationsInput": {
    "type": "structure",
    "members": {
      "Type": {"shape": "RegistryType", "flattened": false},
      "TypeName": {"shape": "TypeName", "flattened": false},
      "TypeArn": {"shape": "TypeArn", "flattened": false},
      "RegistrationStatusFilter": {
        "shape": "RegistrationStatus",
        "flattened": false
      },
      "MaxResults": {"shape": "MaxResults", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListTypeRegistrationsOutput": {
    "type": "structure",
    "members": {
      "RegistrationTokenList": {
        "shape": "RegistrationTokenList",
        "flattened": false
      },
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListTypeVersionsInput": {
    "type": "structure",
    "members": {
      "Type": {"shape": "RegistryType", "flattened": false},
      "TypeName": {"shape": "TypeName", "flattened": false},
      "Arn": {"shape": "TypeArn", "flattened": false},
      "MaxResults": {"shape": "MaxResults", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false},
      "DeprecatedStatus": {"shape": "DeprecatedStatus", "flattened": false},
      "PublisherId": {"shape": "PublisherId", "flattened": false}
    },
    "flattened": false
  },
  "ListTypeVersionsOutput": {
    "type": "structure",
    "members": {
      "TypeVersionSummaries": {
        "shape": "TypeVersionSummaries",
        "flattened": false
      },
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListTypesInput": {
    "type": "structure",
    "members": {
      "Visibility": {"shape": "Visibility", "flattened": false},
      "ProvisioningType": {"shape": "ProvisioningType", "flattened": false},
      "DeprecatedStatus": {"shape": "DeprecatedStatus", "flattened": false},
      "Type": {"shape": "RegistryType", "flattened": false},
      "Filters": {"shape": "TypeFilters", "flattened": false},
      "MaxResults": {"shape": "MaxResults", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "ListTypesOutput": {
    "type": "structure",
    "members": {
      "TypeSummaries": {"shape": "TypeSummaries", "flattened": false},
      "NextToken": {"shape": "NextToken", "flattened": false}
    },
    "flattened": false
  },
  "LogGroupName": {"type": "string", "flattened": false},
  "LoggingConfig": {
    "type": "structure",
    "members": {
      "LogRoleArn": {"shape": "RoleArn", "flattened": false},
      "LogGroupName": {"shape": "LogGroupName", "flattened": false}
    },
    "flattened": false
  },
  "LogicalIdHierarchy": {"type": "string", "flattened": false},
  "LogicalResourceId": {"type": "string", "flattened": false},
  "LogicalResourceIds": {
    "type": "list",
    "member": {"shape": "LogicalResourceId"},
    "flattened": false
  },
  "MajorVersion": {"type": "long", "flattened": false},
  "ManagedExecution": {
    "type": "structure",
    "members": {
      "Active": {"shape": "ManagedExecutionNullable", "flattened": false}
    },
    "flattened": false
  },
  "ManagedExecutionNullable": {"type": "boolean", "flattened": false},
  "MaxConcurrentCount": {"type": "integer", "flattened": false},
  "MaxConcurrentPercentage": {"type": "integer", "flattened": false},
  "MaxResults": {"type": "integer", "flattened": false},
  "Metadata": {"type": "string", "flattened": false},
  "ModuleInfo": {
    "type": "structure",
    "members": {
      "TypeHierarchy": {"shape": "TypeHierarchy", "flattened": false},
      "LogicalIdHierarchy": {"shape": "LogicalIdHierarchy", "flattened": false}
    },
    "flattened": false
  },
  "MonitoringTimeInMinutes": {"type": "integer", "flattened": false},
  "NextToken": {"type": "string", "flattened": false},
  "NoEcho": {"type": "boolean", "flattened": false},
  "NotificationARN": {"type": "string", "flattened": false},
  "NotificationARNs": {
    "type": "list",
    "member": {"shape": "NotificationARN"},
    "flattened": false
  },
  "OnFailure": {"type": "string", "flattened": false},
  "OperationStatus": {"type": "string", "flattened": false},
  "OptionalSecureUrl": {"type": "string", "flattened": false},
  "OrganizationalUnitId": {"type": "string", "flattened": false},
  "OrganizationalUnitIdList": {
    "type": "list",
    "member": {"shape": "OrganizationalUnitId"},
    "flattened": false
  },
  "Output": {
    "type": "structure",
    "members": {
      "OutputKey": {"shape": "OutputKey", "flattened": false},
      "OutputValue": {"shape": "OutputValue", "flattened": false},
      "Description": {"shape": "Description", "flattened": false},
      "ExportName": {"shape": "ExportName", "flattened": false}
    },
    "flattened": false
  },
  "OutputKey": {"type": "string", "flattened": false},
  "OutputValue": {"type": "string", "flattened": false},
  "Outputs": {
    "type": "list",
    "member": {"shape": "Output"},
    "flattened": false
  },
  "Parameter": {
    "type": "structure",
    "members": {
      "ParameterKey": {"shape": "ParameterKey", "flattened": false},
      "ParameterValue": {"shape": "ParameterValue", "flattened": false},
      "UsePreviousValue": {"shape": "UsePreviousValue", "flattened": false},
      "ResolvedValue": {"shape": "ParameterValue", "flattened": false}
    },
    "flattened": false
  },
  "ParameterConstraints": {
    "type": "structure",
    "members": {
      "AllowedValues": {"shape": "AllowedValues", "flattened": false}
    },
    "flattened": false
  },
  "ParameterDeclaration": {
    "type": "structure",
    "members": {
      "ParameterKey": {"shape": "ParameterKey", "flattened": false},
      "DefaultValue": {"shape": "ParameterValue", "flattened": false},
      "ParameterType": {"shape": "ParameterType", "flattened": false},
      "NoEcho": {"shape": "NoEcho", "flattened": false},
      "Description": {"shape": "Description", "flattened": false},
      "ParameterConstraints": {
        "shape": "ParameterConstraints",
        "flattened": false
      }
    },
    "flattened": false
  },
  "ParameterDeclarations": {
    "type": "list",
    "member": {"shape": "ParameterDeclaration"},
    "flattened": false
  },
  "ParameterKey": {"type": "string", "flattened": false},
  "ParameterType": {"type": "string", "flattened": false},
  "ParameterValue": {"type": "string", "flattened": false},
  "Parameters": {
    "type": "list",
    "member": {"shape": "Parameter"},
    "flattened": false
  },
  "PermissionModels": {"type": "string", "flattened": false},
  "PhysicalResourceId": {"type": "string", "flattened": false},
  "PhysicalResourceIdContext": {
    "type": "list",
    "member": {"shape": "PhysicalResourceIdContextKeyValuePair"},
    "flattened": false
  },
  "PhysicalResourceIdContextKeyValuePair": {
    "type": "structure",
    "members": {
      "Key": {"shape": "Key", "flattened": false},
      "Value": {"shape": "Value", "flattened": false}
    },
    "flattened": false
  },
  "PrivateTypeArn": {"type": "string", "flattened": false},
  "Properties": {"type": "string", "flattened": false},
  "PropertyDifference": {
    "type": "structure",
    "members": {
      "PropertyPath": {"shape": "PropertyPath", "flattened": false},
      "ExpectedValue": {"shape": "PropertyValue", "flattened": false},
      "ActualValue": {"shape": "PropertyValue", "flattened": false},
      "DifferenceType": {"shape": "DifferenceType", "flattened": false}
    },
    "flattened": false
  },
  "PropertyDifferences": {
    "type": "list",
    "member": {"shape": "PropertyDifference"},
    "flattened": false
  },
  "PropertyName": {"type": "string", "flattened": false},
  "PropertyPath": {"type": "string", "flattened": false},
  "PropertyValue": {"type": "string", "flattened": false},
  "ProvisioningType": {"type": "string", "flattened": false},
  "PublicVersionNumber": {"type": "string", "flattened": false},
  "PublishTypeInput": {
    "type": "structure",
    "members": {
      "Type": {"shape": "ThirdPartyType", "flattened": false},
      "Arn": {"shape": "PrivateTypeArn", "flattened": false},
      "TypeName": {"shape": "TypeName", "flattened": false},
      "PublicVersionNumber": {
        "shape": "PublicVersionNumber",
        "flattened": false
      }
    },
    "flattened": false
  },
  "PublishTypeOutput": {
    "type": "structure",
    "members": {
      "PublicTypeArn": {"shape": "TypeArn", "flattened": false}
    },
    "flattened": false
  },
  "PublisherId": {"type": "string", "flattened": false},
  "PublisherName": {"type": "string", "flattened": false},
  "PublisherProfile": {"type": "string", "flattened": false},
  "PublisherStatus": {"type": "string", "flattened": false},
  "Reason": {"type": "string", "flattened": false},
  "RecordHandlerProgressInput": {
    "type": "structure",
    "members": {
      "BearerToken": {"shape": "ClientToken", "flattened": false},
      "OperationStatus": {"shape": "OperationStatus", "flattened": false},
      "CurrentOperationStatus": {
        "shape": "OperationStatus",
        "flattened": false
      },
      "StatusMessage": {"shape": "StatusMessage", "flattened": false},
      "ErrorCode": {"shape": "HandlerErrorCode", "flattened": false},
      "ResourceModel": {"shape": "ResourceModel", "flattened": false},
      "ClientRequestToken": {"shape": "ClientRequestToken", "flattened": false}
    },
    "flattened": false
  },
  "RecordHandlerProgressOutput": {
    "type": "structure",
    "members": {},
    "flattened": false
  },
  "Region": {"type": "string", "flattened": false},
  "RegionConcurrencyType": {"type": "string", "flattened": false},
  "RegionList": {
    "type": "list",
    "member": {"shape": "Region"},
    "flattened": false
  },
  "RegisterPublisherInput": {
    "type": "structure",
    "members": {
      "AcceptTermsAndConditions": {
        "shape": "AcceptTermsAndConditions",
        "flattened": false
      },
      "ConnectionArn": {"shape": "ConnectionArn", "flattened": false}
    },
    "flattened": false
  },
  "RegisterPublisherOutput": {
    "type": "structure",
    "members": {
      "PublisherId": {"shape": "PublisherId", "flattened": false}
    },
    "flattened": false
  },
  "RegisterTypeInput": {
    "type": "structure",
    "members": {
      "Type": {"shape": "RegistryType", "flattened": false},
      "TypeName": {"shape": "TypeName", "flattened": false},
      "SchemaHandlerPackage": {"shape": "S3Url", "flattened": false},
      "LoggingConfig": {"shape": "LoggingConfig", "flattened": false},
      "ExecutionRoleArn": {"shape": "RoleArn", "flattened": false},
      "ClientRequestToken": {"shape": "RequestToken", "flattened": false}
    },
    "flattened": false
  },
  "RegisterTypeOutput": {
    "type": "structure",
    "members": {
      "RegistrationToken": {"shape": "RegistrationToken", "flattened": false}
    },
    "flattened": false
  },
  "RegistrationStatus": {"type": "string", "flattened": false},
  "RegistrationToken": {"type": "string", "flattened": false},
  "RegistrationTokenList": {
    "type": "list",
    "member": {"shape": "RegistrationToken"},
    "flattened": false
  },
  "RegistryType": {"type": "string", "flattened": false},
  "Replacement": {"type": "string", "flattened": false},
  "RequestToken": {"type": "string", "flattened": false},
  "RequiredActivatedType": {
    "type": "structure",
    "members": {
      "TypeNameAlias": {"shape": "TypeName", "flattened": false},
      "OriginalTypeName": {"shape": "TypeName", "flattened": false},
      "PublisherId": {"shape": "PublisherId", "flattened": false},
      "SupportedMajorVersions": {
        "shape": "SupportedMajorVersions",
        "flattened": false
      }
    },
    "flattened": false
  },
  "RequiredActivatedTypes": {
    "type": "list",
    "member": {"shape": "RequiredActivatedType"},
    "flattened": false
  },
  "RequiresRecreation": {"type": "string", "flattened": false},
  "ResourceAttribute": {"type": "string", "flattened": false},
  "ResourceChange": {
    "type": "structure",
    "members": {
      "Action": {"shape": "ChangeAction", "flattened": false},
      "LogicalResourceId": {"shape": "LogicalResourceId", "flattened": false},
      "PhysicalResourceId": {"shape": "PhysicalResourceId", "flattened": false},
      "ResourceType": {"shape": "ResourceType", "flattened": false},
      "Replacement": {"shape": "Replacement", "flattened": false},
      "Scope": {"shape": "Scope", "flattened": false},
      "Details": {"shape": "ResourceChangeDetails", "flattened": false},
      "ChangeSetId": {"shape": "ChangeSetId", "flattened": false},
      "ModuleInfo": {"shape": "ModuleInfo", "flattened": false}
    },
    "flattened": false
  },
  "ResourceChangeDetail": {
    "type": "structure",
    "members": {
      "Target": {"shape": "ResourceTargetDefinition", "flattened": false},
      "Evaluation": {"shape": "EvaluationType", "flattened": false},
      "ChangeSource": {"shape": "ChangeSource", "flattened": false},
      "CausingEntity": {"shape": "CausingEntity", "flattened": false}
    },
    "flattened": false
  },
  "ResourceChangeDetails": {
    "type": "list",
    "member": {"shape": "ResourceChangeDetail"},
    "flattened": false
  },
  "ResourceIdentifierProperties": {
    "type": "map",
    "key": {"shape": "ResourceIdentifierPropertyKey"},
    "value": {"shape": "ResourceIdentifierPropertyValue"},
    "flattened": false
  },
  "ResourceIdentifierPropertyKey": {"type": "string", "flattened": false},
  "ResourceIdentifierPropertyValue": {"type": "string", "flattened": false},
  "ResourceIdentifierSummaries": {
    "type": "list",
    "member": {"shape": "ResourceIdentifierSummary"},
    "flattened": false
  },
  "ResourceIdentifierSummary": {
    "type": "structure",
    "members": {
      "ResourceType": {"shape": "ResourceType", "flattened": false},
      "LogicalResourceIds": {"shape": "LogicalResourceIds", "flattened": false},
      "ResourceIdentifiers": {
        "shape": "ResourceIdentifiers",
        "flattened": false
      }
    },
    "flattened": false
  },
  "ResourceIdentifiers": {
    "type": "list",
    "member": {"shape": "ResourceIdentifierPropertyKey"},
    "flattened": false
  },
  "ResourceModel": {"type": "string", "flattened": false},
  "ResourceProperties": {"type": "string", "flattened": false},
  "ResourceSignalStatus": {"type": "string", "flattened": false},
  "ResourceSignalUniqueId": {"type": "string", "flattened": false},
  "ResourceStatus": {"type": "string", "flattened": false},
  "ResourceStatusReason": {"type": "string", "flattened": false},
  "ResourceTargetDefinition": {
    "type": "structure",
    "members": {
      "Attribute": {"shape": "ResourceAttribute", "flattened": false},
      "Name": {"shape": "PropertyName", "flattened": false},
      "RequiresRecreation": {"shape": "RequiresRecreation", "flattened": false}
    },
    "flattened": false
  },
  "ResourceToImport": {
    "type": "structure",
    "members": {
      "ResourceType": {"shape": "ResourceType", "flattened": false},
      "LogicalResourceId": {"shape": "LogicalResourceId", "flattened": false},
      "ResourceIdentifier": {
        "shape": "ResourceIdentifierProperties",
        "flattened": false
      }
    },
    "flattened": false
  },
  "ResourceToSkip": {"type": "string", "flattened": false},
  "ResourceType": {"type": "string", "flattened": false},
  "ResourceTypes": {
    "type": "list",
    "member": {"shape": "ResourceType"},
    "flattened": false
  },
  "ResourcesToImport": {
    "type": "list",
    "member": {"shape": "ResourceToImport"},
    "flattened": false
  },
  "ResourcesToSkip": {
    "type": "list",
    "member": {"shape": "ResourceToSkip"},
    "flattened": false
  },
  "RetainResources": {
    "type": "list",
    "member": {"shape": "LogicalResourceId"},
    "flattened": false
  },
  "RetainStacks": {"type": "boolean", "flattened": false},
  "RetainStacksNullable": {"type": "boolean", "flattened": false},
  "RetainStacksOnAccountRemovalNullable": {
    "type": "boolean",
    "flattened": false
  },
  "RoleARN": {"type": "string", "flattened": false},
  "RoleArn": {"type": "string", "flattened": false},
  "RollbackConfiguration": {
    "type": "structure",
    "members": {
      "RollbackTriggers": {"shape": "RollbackTriggers", "flattened": false},
      "MonitoringTimeInMinutes": {
        "shape": "MonitoringTimeInMinutes",
        "flattened": false
      }
    },
    "flattened": false
  },
  "RollbackStackInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackNameOrId", "flattened": false},
      "RoleARN": {"shape": "RoleARN", "flattened": false},
      "ClientRequestToken": {"shape": "ClientRequestToken", "flattened": false}
    },
    "flattened": false
  },
  "RollbackStackOutput": {
    "type": "structure",
    "members": {
      "StackId": {"shape": "StackId", "flattened": false}
    },
    "flattened": false
  },
  "RollbackTrigger": {
    "type": "structure",
    "members": {
      "Arn": {"shape": "Arn", "flattened": false},
      "Type": {"shape": "Type", "flattened": false}
    },
    "flattened": false
  },
  "RollbackTriggers": {
    "type": "list",
    "member": {"shape": "RollbackTrigger"},
    "flattened": false
  },
  "S3Bucket": {"type": "string", "flattened": false},
  "S3Url": {"type": "string", "flattened": false},
  "Scope": {
    "type": "list",
    "member": {"shape": "ResourceAttribute"},
    "flattened": false
  },
  "SetStackPolicyInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackName", "flattened": false},
      "StackPolicyBody": {"shape": "StackPolicyBody", "flattened": false},
      "StackPolicyURL": {"shape": "StackPolicyURL", "flattened": false}
    },
    "flattened": false
  },
  "SetTypeConfigurationInput": {
    "type": "structure",
    "members": {
      "TypeArn": {"shape": "TypeArn", "flattened": false},
      "Configuration": {"shape": "TypeConfiguration", "flattened": false},
      "ConfigurationAlias": {
        "shape": "TypeConfigurationAlias",
        "flattened": false
      },
      "TypeName": {"shape": "TypeName", "flattened": false},
      "Type": {"shape": "ThirdPartyType", "flattened": false}
    },
    "flattened": false
  },
  "SetTypeConfigurationOutput": {
    "type": "structure",
    "members": {
      "ConfigurationArn": {"shape": "TypeConfigurationArn", "flattened": false}
    },
    "flattened": false
  },
  "SetTypeDefaultVersionInput": {
    "type": "structure",
    "members": {
      "Arn": {"shape": "PrivateTypeArn", "flattened": false},
      "Type": {"shape": "RegistryType", "flattened": false},
      "TypeName": {"shape": "TypeName", "flattened": false},
      "VersionId": {"shape": "TypeVersionId", "flattened": false}
    },
    "flattened": false
  },
  "SetTypeDefaultVersionOutput": {
    "type": "structure",
    "members": {},
    "flattened": false
  },
  "SignalResourceInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackNameOrId", "flattened": false},
      "LogicalResourceId": {"shape": "LogicalResourceId", "flattened": false},
      "UniqueId": {"shape": "ResourceSignalUniqueId", "flattened": false},
      "Status": {"shape": "ResourceSignalStatus", "flattened": false}
    },
    "flattened": false
  },
  "Stack": {
    "type": "structure",
    "members": {
      "StackId": {"shape": "StackId", "flattened": false},
      "StackName": {"shape": "StackName", "flattened": false},
      "ChangeSetId": {"shape": "ChangeSetId", "flattened": false},
      "Description": {"shape": "Description", "flattened": false},
      "Parameters": {"shape": "Parameters", "flattened": false},
      "CreationTime": {"shape": "CreationTime", "flattened": false},
      "DeletionTime": {"shape": "DeletionTime", "flattened": false},
      "LastUpdatedTime": {"shape": "LastUpdatedTime", "flattened": false},
      "RollbackConfiguration": {
        "shape": "RollbackConfiguration",
        "flattened": false
      },
      "StackStatus": {"shape": "StackStatus", "flattened": false},
      "StackStatusReason": {"shape": "StackStatusReason", "flattened": false},
      "DisableRollback": {"shape": "DisableRollback", "flattened": false},
      "NotificationARNs": {"shape": "NotificationARNs", "flattened": false},
      "TimeoutInMinutes": {"shape": "TimeoutMinutes", "flattened": false},
      "Capabilities": {"shape": "Capabilities", "flattened": false},
      "Outputs": {"shape": "Outputs", "flattened": false},
      "RoleARN": {"shape": "RoleARN", "flattened": false},
      "Tags": {"shape": "Tags", "flattened": false},
      "EnableTerminationProtection": {
        "shape": "EnableTerminationProtection",
        "flattened": false
      },
      "ParentId": {"shape": "StackId", "flattened": false},
      "RootId": {"shape": "StackId", "flattened": false},
      "DriftInformation": {"shape": "StackDriftInformation", "flattened": false}
    },
    "flattened": false
  },
  "StackDriftDetectionId": {"type": "string", "flattened": false},
  "StackDriftDetectionStatus": {"type": "string", "flattened": false},
  "StackDriftDetectionStatusReason": {"type": "string", "flattened": false},
  "StackDriftInformation": {
    "type": "structure",
    "members": {
      "StackDriftStatus": {"shape": "StackDriftStatus", "flattened": false},
      "LastCheckTimestamp": {"shape": "Timestamp", "flattened": false}
    },
    "flattened": false
  },
  "StackDriftInformationSummary": {
    "type": "structure",
    "members": {
      "StackDriftStatus": {"shape": "StackDriftStatus", "flattened": false},
      "LastCheckTimestamp": {"shape": "Timestamp", "flattened": false}
    },
    "flattened": false
  },
  "StackDriftStatus": {"type": "string", "flattened": false},
  "StackEvent": {
    "type": "structure",
    "members": {
      "StackId": {"shape": "StackId", "flattened": false},
      "EventId": {"shape": "EventId", "flattened": false},
      "StackName": {"shape": "StackName", "flattened": false},
      "LogicalResourceId": {"shape": "LogicalResourceId", "flattened": false},
      "PhysicalResourceId": {"shape": "PhysicalResourceId", "flattened": false},
      "ResourceType": {"shape": "ResourceType", "flattened": false},
      "Timestamp": {"shape": "Timestamp", "flattened": false},
      "ResourceStatus": {"shape": "ResourceStatus", "flattened": false},
      "ResourceStatusReason": {
        "shape": "ResourceStatusReason",
        "flattened": false
      },
      "ResourceProperties": {"shape": "ResourceProperties", "flattened": false},
      "ClientRequestToken": {"shape": "ClientRequestToken", "flattened": false},
      "HookType": {"shape": "HookType", "flattened": false},
      "HookStatus": {"shape": "HookStatus", "flattened": false},
      "HookStatusReason": {"shape": "HookStatusReason", "flattened": false},
      "HookInvocationPoint": {
        "shape": "HookInvocationPoint",
        "flattened": false
      },
      "HookFailureMode": {"shape": "HookFailureMode", "flattened": false}
    },
    "flattened": false
  },
  "StackEvents": {
    "type": "list",
    "member": {"shape": "StackEvent"},
    "flattened": false
  },
  "StackId": {"type": "string", "flattened": false},
  "StackIdList": {
    "type": "list",
    "member": {"shape": "StackId"},
    "flattened": false
  },
  "StackIdsUrl": {"type": "string", "flattened": false},
  "StackInstance": {
    "type": "structure",
    "members": {
      "StackSetId": {"shape": "StackSetId", "flattened": false},
      "Region": {"shape": "Region", "flattened": false},
      "Account": {"shape": "Account", "flattened": false},
      "StackId": {"shape": "StackId", "flattened": false},
      "ParameterOverrides": {"shape": "Parameters", "flattened": false},
      "Status": {"shape": "StackInstanceStatus", "flattened": false},
      "StackInstanceStatus": {
        "shape": "StackInstanceComprehensiveStatus",
        "flattened": false
      },
      "StatusReason": {"shape": "Reason", "flattened": false},
      "OrganizationalUnitId": {
        "shape": "OrganizationalUnitId",
        "flattened": false
      },
      "DriftStatus": {"shape": "StackDriftStatus", "flattened": false},
      "LastDriftCheckTimestamp": {"shape": "Timestamp", "flattened": false}
    },
    "flattened": false
  },
  "StackInstanceComprehensiveStatus": {
    "type": "structure",
    "members": {
      "DetailedStatus": {
        "shape": "StackInstanceDetailedStatus",
        "flattened": false
      }
    },
    "flattened": false
  },
  "StackInstanceDetailedStatus": {"type": "string", "flattened": false},
  "StackInstanceFilter": {
    "type": "structure",
    "members": {
      "Name": {"shape": "StackInstanceFilterName", "flattened": false},
      "Values": {"shape": "StackInstanceFilterValues", "flattened": false}
    },
    "flattened": false
  },
  "StackInstanceFilterName": {"type": "string", "flattened": false},
  "StackInstanceFilterValues": {"type": "string", "flattened": false},
  "StackInstanceFilters": {
    "type": "list",
    "member": {"shape": "StackInstanceFilter"},
    "flattened": false
  },
  "StackInstanceStatus": {"type": "string", "flattened": false},
  "StackInstanceSummaries": {
    "type": "list",
    "member": {"shape": "StackInstanceSummary"},
    "flattened": false
  },
  "StackInstanceSummary": {
    "type": "structure",
    "members": {
      "StackSetId": {"shape": "StackSetId", "flattened": false},
      "Region": {"shape": "Region", "flattened": false},
      "Account": {"shape": "Account", "flattened": false},
      "StackId": {"shape": "StackId", "flattened": false},
      "Status": {"shape": "StackInstanceStatus", "flattened": false},
      "StatusReason": {"shape": "Reason", "flattened": false},
      "StackInstanceStatus": {
        "shape": "StackInstanceComprehensiveStatus",
        "flattened": false
      },
      "OrganizationalUnitId": {
        "shape": "OrganizationalUnitId",
        "flattened": false
      },
      "DriftStatus": {"shape": "StackDriftStatus", "flattened": false},
      "LastDriftCheckTimestamp": {"shape": "Timestamp", "flattened": false}
    },
    "flattened": false
  },
  "StackName": {"type": "string", "flattened": false},
  "StackNameOrId": {"type": "string", "flattened": false},
  "StackPolicyBody": {"type": "string", "flattened": false},
  "StackPolicyDuringUpdateBody": {"type": "string", "flattened": false},
  "StackPolicyDuringUpdateURL": {"type": "string", "flattened": false},
  "StackPolicyURL": {"type": "string", "flattened": false},
  "StackResource": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackName", "flattened": false},
      "StackId": {"shape": "StackId", "flattened": false},
      "LogicalResourceId": {"shape": "LogicalResourceId", "flattened": false},
      "PhysicalResourceId": {"shape": "PhysicalResourceId", "flattened": false},
      "ResourceType": {"shape": "ResourceType", "flattened": false},
      "Timestamp": {"shape": "Timestamp", "flattened": false},
      "ResourceStatus": {"shape": "ResourceStatus", "flattened": false},
      "ResourceStatusReason": {
        "shape": "ResourceStatusReason",
        "flattened": false
      },
      "Description": {"shape": "Description", "flattened": false},
      "DriftInformation": {
        "shape": "StackResourceDriftInformation",
        "flattened": false
      },
      "ModuleInfo": {"shape": "ModuleInfo", "flattened": false}
    },
    "flattened": false
  },
  "StackResourceDetail": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackName", "flattened": false},
      "StackId": {"shape": "StackId", "flattened": false},
      "LogicalResourceId": {"shape": "LogicalResourceId", "flattened": false},
      "PhysicalResourceId": {"shape": "PhysicalResourceId", "flattened": false},
      "ResourceType": {"shape": "ResourceType", "flattened": false},
      "LastUpdatedTimestamp": {"shape": "Timestamp", "flattened": false},
      "ResourceStatus": {"shape": "ResourceStatus", "flattened": false},
      "ResourceStatusReason": {
        "shape": "ResourceStatusReason",
        "flattened": false
      },
      "Description": {"shape": "Description", "flattened": false},
      "Metadata": {"shape": "Metadata", "flattened": false},
      "DriftInformation": {
        "shape": "StackResourceDriftInformation",
        "flattened": false
      },
      "ModuleInfo": {"shape": "ModuleInfo", "flattened": false}
    },
    "flattened": false
  },
  "StackResourceDrift": {
    "type": "structure",
    "members": {
      "StackId": {"shape": "StackId", "flattened": false},
      "LogicalResourceId": {"shape": "LogicalResourceId", "flattened": false},
      "PhysicalResourceId": {"shape": "PhysicalResourceId", "flattened": false},
      "PhysicalResourceIdContext": {
        "shape": "PhysicalResourceIdContext",
        "flattened": false
      },
      "ResourceType": {"shape": "ResourceType", "flattened": false},
      "ExpectedProperties": {"shape": "Properties", "flattened": false},
      "ActualProperties": {"shape": "Properties", "flattened": false},
      "PropertyDifferences": {
        "shape": "PropertyDifferences",
        "flattened": false
      },
      "StackResourceDriftStatus": {
        "shape": "StackResourceDriftStatus",
        "flattened": false
      },
      "Timestamp": {"shape": "Timestamp", "flattened": false},
      "ModuleInfo": {"shape": "ModuleInfo", "flattened": false}
    },
    "flattened": false
  },
  "StackResourceDriftInformation": {
    "type": "structure",
    "members": {
      "StackResourceDriftStatus": {
        "shape": "StackResourceDriftStatus",
        "flattened": false
      },
      "LastCheckTimestamp": {"shape": "Timestamp", "flattened": false}
    },
    "flattened": false
  },
  "StackResourceDriftInformationSummary": {
    "type": "structure",
    "members": {
      "StackResourceDriftStatus": {
        "shape": "StackResourceDriftStatus",
        "flattened": false
      },
      "LastCheckTimestamp": {"shape": "Timestamp", "flattened": false}
    },
    "flattened": false
  },
  "StackResourceDriftStatus": {"type": "string", "flattened": false},
  "StackResourceDriftStatusFilters": {
    "type": "list",
    "member": {"shape": "StackResourceDriftStatus"},
    "flattened": false
  },
  "StackResourceDrifts": {
    "type": "list",
    "member": {"shape": "StackResourceDrift"},
    "flattened": false
  },
  "StackResourceSummaries": {
    "type": "list",
    "member": {"shape": "StackResourceSummary"},
    "flattened": false
  },
  "StackResourceSummary": {
    "type": "structure",
    "members": {
      "LogicalResourceId": {"shape": "LogicalResourceId", "flattened": false},
      "PhysicalResourceId": {"shape": "PhysicalResourceId", "flattened": false},
      "ResourceType": {"shape": "ResourceType", "flattened": false},
      "LastUpdatedTimestamp": {"shape": "Timestamp", "flattened": false},
      "ResourceStatus": {"shape": "ResourceStatus", "flattened": false},
      "ResourceStatusReason": {
        "shape": "ResourceStatusReason",
        "flattened": false
      },
      "DriftInformation": {
        "shape": "StackResourceDriftInformationSummary",
        "flattened": false
      },
      "ModuleInfo": {"shape": "ModuleInfo", "flattened": false}
    },
    "flattened": false
  },
  "StackResources": {
    "type": "list",
    "member": {"shape": "StackResource"},
    "flattened": false
  },
  "StackSet": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetName", "flattened": false},
      "StackSetId": {"shape": "StackSetId", "flattened": false},
      "Description": {"shape": "Description", "flattened": false},
      "Status": {"shape": "StackSetStatus", "flattened": false},
      "TemplateBody": {"shape": "TemplateBody", "flattened": false},
      "Parameters": {"shape": "Parameters", "flattened": false},
      "Capabilities": {"shape": "Capabilities", "flattened": false},
      "Tags": {"shape": "Tags", "flattened": false},
      "StackSetARN": {"shape": "StackSetARN", "flattened": false},
      "AdministrationRoleARN": {"shape": "RoleARN", "flattened": false},
      "ExecutionRoleName": {"shape": "ExecutionRoleName", "flattened": false},
      "StackSetDriftDetectionDetails": {
        "shape": "StackSetDriftDetectionDetails",
        "flattened": false
      },
      "AutoDeployment": {"shape": "AutoDeployment", "flattened": false},
      "PermissionModel": {"shape": "PermissionModels", "flattened": false},
      "OrganizationalUnitIds": {
        "shape": "OrganizationalUnitIdList",
        "flattened": false
      },
      "ManagedExecution": {"shape": "ManagedExecution", "flattened": false}
    },
    "flattened": false
  },
  "StackSetARN": {"type": "string", "flattened": false},
  "StackSetDriftDetectionDetails": {
    "type": "structure",
    "members": {
      "DriftStatus": {"shape": "StackSetDriftStatus", "flattened": false},
      "DriftDetectionStatus": {
        "shape": "StackSetDriftDetectionStatus",
        "flattened": false
      },
      "LastDriftCheckTimestamp": {"shape": "Timestamp", "flattened": false},
      "TotalStackInstancesCount": {
        "shape": "TotalStackInstancesCount",
        "flattened": false
      },
      "DriftedStackInstancesCount": {
        "shape": "DriftedStackInstancesCount",
        "flattened": false
      },
      "InSyncStackInstancesCount": {
        "shape": "InSyncStackInstancesCount",
        "flattened": false
      },
      "InProgressStackInstancesCount": {
        "shape": "InProgressStackInstancesCount",
        "flattened": false
      },
      "FailedStackInstancesCount": {
        "shape": "FailedStackInstancesCount",
        "flattened": false
      }
    },
    "flattened": false
  },
  "StackSetDriftDetectionStatus": {"type": "string", "flattened": false},
  "StackSetDriftStatus": {"type": "string", "flattened": false},
  "StackSetId": {"type": "string", "flattened": false},
  "StackSetName": {"type": "string", "flattened": false},
  "StackSetNameOrId": {"type": "string", "flattened": false},
  "StackSetOperation": {
    "type": "structure",
    "members": {
      "OperationId": {"shape": "ClientRequestToken", "flattened": false},
      "StackSetId": {"shape": "StackSetId", "flattened": false},
      "Action": {"shape": "StackSetOperationAction", "flattened": false},
      "Status": {"shape": "StackSetOperationStatus", "flattened": false},
      "OperationPreferences": {
        "shape": "StackSetOperationPreferences",
        "flattened": false
      },
      "RetainStacks": {"shape": "RetainStacksNullable", "flattened": false},
      "AdministrationRoleARN": {"shape": "RoleARN", "flattened": false},
      "ExecutionRoleName": {"shape": "ExecutionRoleName", "flattened": false},
      "CreationTimestamp": {"shape": "Timestamp", "flattened": false},
      "EndTimestamp": {"shape": "Timestamp", "flattened": false},
      "DeploymentTargets": {"shape": "DeploymentTargets", "flattened": false},
      "StackSetDriftDetectionDetails": {
        "shape": "StackSetDriftDetectionDetails",
        "flattened": false
      },
      "StatusReason": {
        "shape": "StackSetOperationStatusReason",
        "flattened": false
      }
    },
    "flattened": false
  },
  "StackSetOperationAction": {"type": "string", "flattened": false},
  "StackSetOperationPreferences": {
    "type": "structure",
    "members": {
      "RegionConcurrencyType": {
        "shape": "RegionConcurrencyType",
        "flattened": false
      },
      "RegionOrder": {"shape": "RegionList", "flattened": false},
      "FailureToleranceCount": {
        "shape": "FailureToleranceCount",
        "flattened": false
      },
      "FailureTolerancePercentage": {
        "shape": "FailureTolerancePercentage",
        "flattened": false
      },
      "MaxConcurrentCount": {"shape": "MaxConcurrentCount", "flattened": false},
      "MaxConcurrentPercentage": {
        "shape": "MaxConcurrentPercentage",
        "flattened": false
      }
    },
    "flattened": false
  },
  "StackSetOperationResultStatus": {"type": "string", "flattened": false},
  "StackSetOperationResultSummaries": {
    "type": "list",
    "member": {"shape": "StackSetOperationResultSummary"},
    "flattened": false
  },
  "StackSetOperationResultSummary": {
    "type": "structure",
    "members": {
      "Account": {"shape": "Account", "flattened": false},
      "Region": {"shape": "Region", "flattened": false},
      "Status": {"shape": "StackSetOperationResultStatus", "flattened": false},
      "StatusReason": {"shape": "Reason", "flattened": false},
      "AccountGateResult": {"shape": "AccountGateResult", "flattened": false},
      "OrganizationalUnitId": {
        "shape": "OrganizationalUnitId",
        "flattened": false
      }
    },
    "flattened": false
  },
  "StackSetOperationStatus": {"type": "string", "flattened": false},
  "StackSetOperationStatusReason": {"type": "string", "flattened": false},
  "StackSetOperationSummaries": {
    "type": "list",
    "member": {"shape": "StackSetOperationSummary"},
    "flattened": false
  },
  "StackSetOperationSummary": {
    "type": "structure",
    "members": {
      "OperationId": {"shape": "ClientRequestToken", "flattened": false},
      "Action": {"shape": "StackSetOperationAction", "flattened": false},
      "Status": {"shape": "StackSetOperationStatus", "flattened": false},
      "CreationTimestamp": {"shape": "Timestamp", "flattened": false},
      "EndTimestamp": {"shape": "Timestamp", "flattened": false},
      "StatusReason": {
        "shape": "StackSetOperationStatusReason",
        "flattened": false
      }
    },
    "flattened": false
  },
  "StackSetStatus": {"type": "string", "flattened": false},
  "StackSetSummaries": {
    "type": "list",
    "member": {"shape": "StackSetSummary"},
    "flattened": false
  },
  "StackSetSummary": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetName", "flattened": false},
      "StackSetId": {"shape": "StackSetId", "flattened": false},
      "Description": {"shape": "Description", "flattened": false},
      "Status": {"shape": "StackSetStatus", "flattened": false},
      "AutoDeployment": {"shape": "AutoDeployment", "flattened": false},
      "PermissionModel": {"shape": "PermissionModels", "flattened": false},
      "DriftStatus": {"shape": "StackDriftStatus", "flattened": false},
      "LastDriftCheckTimestamp": {"shape": "Timestamp", "flattened": false},
      "ManagedExecution": {"shape": "ManagedExecution", "flattened": false}
    },
    "flattened": false
  },
  "StackStatus": {"type": "string", "flattened": false},
  "StackStatusFilter": {
    "type": "list",
    "member": {"shape": "StackStatus"},
    "flattened": false
  },
  "StackStatusReason": {"type": "string", "flattened": false},
  "StackSummaries": {
    "type": "list",
    "member": {"shape": "StackSummary"},
    "flattened": false
  },
  "StackSummary": {
    "type": "structure",
    "members": {
      "StackId": {"shape": "StackId", "flattened": false},
      "StackName": {"shape": "StackName", "flattened": false},
      "TemplateDescription": {
        "shape": "TemplateDescription",
        "flattened": false
      },
      "CreationTime": {"shape": "CreationTime", "flattened": false},
      "LastUpdatedTime": {"shape": "LastUpdatedTime", "flattened": false},
      "DeletionTime": {"shape": "DeletionTime", "flattened": false},
      "StackStatus": {"shape": "StackStatus", "flattened": false},
      "StackStatusReason": {"shape": "StackStatusReason", "flattened": false},
      "ParentId": {"shape": "StackId", "flattened": false},
      "RootId": {"shape": "StackId", "flattened": false},
      "DriftInformation": {
        "shape": "StackDriftInformationSummary",
        "flattened": false
      }
    },
    "flattened": false
  },
  "Stacks": {
    "type": "list",
    "member": {"shape": "Stack"},
    "flattened": false
  },
  "StageList": {
    "type": "list",
    "member": {"shape": "TemplateStage"},
    "flattened": false
  },
  "StatusMessage": {"type": "string", "flattened": false},
  "StopStackSetOperationInput": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetName", "flattened": false},
      "OperationId": {"shape": "ClientRequestToken", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false}
    },
    "flattened": false
  },
  "StopStackSetOperationOutput": {
    "type": "structure",
    "members": {},
    "flattened": false
  },
  "SupportedMajorVersion": {"type": "integer", "flattened": false},
  "SupportedMajorVersions": {
    "type": "list",
    "member": {"shape": "SupportedMajorVersion"},
    "flattened": false
  },
  "Tag": {
    "type": "structure",
    "members": {
      "Key": {"shape": "TagKey", "flattened": false},
      "Value": {"shape": "TagValue", "flattened": false}
    },
    "flattened": false
  },
  "TagKey": {"type": "string", "flattened": false},
  "TagValue": {"type": "string", "flattened": false},
  "Tags": {
    "type": "list",
    "member": {"shape": "Tag"},
    "flattened": false
  },
  "TemplateBody": {"type": "string", "flattened": false},
  "TemplateDescription": {"type": "string", "flattened": false},
  "TemplateParameter": {
    "type": "structure",
    "members": {
      "ParameterKey": {"shape": "ParameterKey", "flattened": false},
      "DefaultValue": {"shape": "ParameterValue", "flattened": false},
      "NoEcho": {"shape": "NoEcho", "flattened": false},
      "Description": {"shape": "Description", "flattened": false}
    },
    "flattened": false
  },
  "TemplateParameters": {
    "type": "list",
    "member": {"shape": "TemplateParameter"},
    "flattened": false
  },
  "TemplateStage": {"type": "string", "flattened": false},
  "TemplateURL": {"type": "string", "flattened": false},
  "TestTypeInput": {
    "type": "structure",
    "members": {
      "Arn": {"shape": "TypeArn", "flattened": false},
      "Type": {"shape": "ThirdPartyType", "flattened": false},
      "TypeName": {"shape": "TypeName", "flattened": false},
      "VersionId": {"shape": "TypeVersionId", "flattened": false},
      "LogDeliveryBucket": {"shape": "S3Bucket", "flattened": false}
    },
    "flattened": false
  },
  "TestTypeOutput": {
    "type": "structure",
    "members": {
      "TypeVersionArn": {"shape": "TypeArn", "flattened": false}
    },
    "flattened": false
  },
  "ThirdPartyType": {"type": "string", "flattened": false},
  "ThirdPartyTypeArn": {"type": "string", "flattened": false},
  "TimeoutMinutes": {"type": "integer", "flattened": false},
  "Timestamp": {"type": "timestamp", "flattened": false},
  "TotalStackInstancesCount": {"type": "integer", "flattened": false},
  "TransformName": {"type": "string", "flattened": false},
  "TransformsList": {
    "type": "list",
    "member": {"shape": "TransformName"},
    "flattened": false
  },
  "Type": {"type": "string", "flattened": false},
  "TypeArn": {"type": "string", "flattened": false},
  "TypeConfiguration": {"type": "string", "flattened": false},
  "TypeConfigurationAlias": {"type": "string", "flattened": false},
  "TypeConfigurationArn": {"type": "string", "flattened": false},
  "TypeConfigurationDetails": {
    "type": "structure",
    "members": {
      "Arn": {"shape": "TypeConfigurationArn", "flattened": false},
      "Alias": {"shape": "TypeConfigurationAlias", "flattened": false},
      "Configuration": {"shape": "TypeConfiguration", "flattened": false},
      "LastUpdated": {"shape": "Timestamp", "flattened": false},
      "TypeArn": {"shape": "TypeArn", "flattened": false},
      "TypeName": {"shape": "TypeName", "flattened": false},
      "IsDefaultConfiguration": {
        "shape": "IsDefaultConfiguration",
        "flattened": false
      }
    },
    "flattened": false
  },
  "TypeConfigurationDetailsList": {
    "type": "list",
    "member": {"shape": "TypeConfigurationDetails"},
    "flattened": false
  },
  "TypeConfigurationIdentifier": {
    "type": "structure",
    "members": {
      "TypeArn": {"shape": "TypeArn", "flattened": false},
      "TypeConfigurationAlias": {
        "shape": "TypeConfigurationAlias",
        "flattened": false
      },
      "TypeConfigurationArn": {
        "shape": "TypeConfigurationArn",
        "flattened": false
      },
      "Type": {"shape": "ThirdPartyType", "flattened": false},
      "TypeName": {"shape": "TypeName", "flattened": false}
    },
    "flattened": false
  },
  "TypeConfigurationIdentifiers": {
    "type": "list",
    "member": {"shape": "TypeConfigurationIdentifier"},
    "flattened": false
  },
  "TypeFilters": {
    "type": "structure",
    "members": {
      "Category": {"shape": "Category", "flattened": false},
      "PublisherId": {"shape": "PublisherId", "flattened": false},
      "TypeNamePrefix": {"shape": "TypeNamePrefix", "flattened": false}
    },
    "flattened": false
  },
  "TypeHierarchy": {"type": "string", "flattened": false},
  "TypeName": {"type": "string", "flattened": false},
  "TypeNamePrefix": {"type": "string", "flattened": false},
  "TypeSchema": {"type": "string", "flattened": false},
  "TypeSummaries": {
    "type": "list",
    "member": {"shape": "TypeSummary"},
    "flattened": false
  },
  "TypeSummary": {
    "type": "structure",
    "members": {
      "Type": {"shape": "RegistryType", "flattened": false},
      "TypeName": {"shape": "TypeName", "flattened": false},
      "DefaultVersionId": {"shape": "TypeVersionId", "flattened": false},
      "TypeArn": {"shape": "TypeArn", "flattened": false},
      "LastUpdated": {"shape": "Timestamp", "flattened": false},
      "Description": {"shape": "Description", "flattened": false},
      "PublisherId": {"shape": "PublisherId", "flattened": false},
      "OriginalTypeName": {"shape": "TypeName", "flattened": false},
      "PublicVersionNumber": {
        "shape": "PublicVersionNumber",
        "flattened": false
      },
      "LatestPublicVersion": {
        "shape": "PublicVersionNumber",
        "flattened": false
      },
      "PublisherIdentity": {"shape": "IdentityProvider", "flattened": false},
      "PublisherName": {"shape": "PublisherName", "flattened": false},
      "IsActivated": {"shape": "IsActivated", "flattened": false}
    },
    "flattened": false
  },
  "TypeTestsStatus": {"type": "string", "flattened": false},
  "TypeTestsStatusDescription": {"type": "string", "flattened": false},
  "TypeVersionId": {"type": "string", "flattened": false},
  "TypeVersionSummaries": {
    "type": "list",
    "member": {"shape": "TypeVersionSummary"},
    "flattened": false
  },
  "TypeVersionSummary": {
    "type": "structure",
    "members": {
      "Type": {"shape": "RegistryType", "flattened": false},
      "TypeName": {"shape": "TypeName", "flattened": false},
      "VersionId": {"shape": "TypeVersionId", "flattened": false},
      "IsDefaultVersion": {"shape": "IsDefaultVersion", "flattened": false},
      "Arn": {"shape": "TypeArn", "flattened": false},
      "TimeCreated": {"shape": "Timestamp", "flattened": false},
      "Description": {"shape": "Description", "flattened": false},
      "PublicVersionNumber": {
        "shape": "PublicVersionNumber",
        "flattened": false
      }
    },
    "flattened": false
  },
  "UnprocessedTypeConfigurations": {
    "type": "list",
    "member": {"shape": "TypeConfigurationIdentifier"},
    "flattened": false
  },
  "UpdateStackInput": {
    "type": "structure",
    "members": {
      "StackName": {"shape": "StackName", "flattened": false},
      "TemplateBody": {"shape": "TemplateBody", "flattened": false},
      "TemplateURL": {"shape": "TemplateURL", "flattened": false},
      "UsePreviousTemplate": {
        "shape": "UsePreviousTemplate",
        "flattened": false
      },
      "StackPolicyDuringUpdateBody": {
        "shape": "StackPolicyDuringUpdateBody",
        "flattened": false
      },
      "StackPolicyDuringUpdateURL": {
        "shape": "StackPolicyDuringUpdateURL",
        "flattened": false
      },
      "Parameters": {"shape": "Parameters", "flattened": false},
      "Capabilities": {"shape": "Capabilities", "flattened": false},
      "ResourceTypes": {"shape": "ResourceTypes", "flattened": false},
      "RoleARN": {"shape": "RoleARN", "flattened": false},
      "RollbackConfiguration": {
        "shape": "RollbackConfiguration",
        "flattened": false
      },
      "StackPolicyBody": {"shape": "StackPolicyBody", "flattened": false},
      "StackPolicyURL": {"shape": "StackPolicyURL", "flattened": false},
      "NotificationARNs": {"shape": "NotificationARNs", "flattened": false},
      "Tags": {"shape": "Tags", "flattened": false},
      "DisableRollback": {"shape": "DisableRollback", "flattened": false},
      "ClientRequestToken": {"shape": "ClientRequestToken", "flattened": false}
    },
    "flattened": false
  },
  "UpdateStackInstancesInput": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetNameOrId", "flattened": false},
      "Accounts": {"shape": "AccountList", "flattened": false},
      "DeploymentTargets": {"shape": "DeploymentTargets", "flattened": false},
      "Regions": {"shape": "RegionList", "flattened": false},
      "ParameterOverrides": {"shape": "Parameters", "flattened": false},
      "OperationPreferences": {
        "shape": "StackSetOperationPreferences",
        "flattened": false
      },
      "OperationId": {"shape": "ClientRequestToken", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false}
    },
    "flattened": false
  },
  "UpdateStackInstancesOutput": {
    "type": "structure",
    "members": {
      "OperationId": {"shape": "ClientRequestToken", "flattened": false}
    },
    "flattened": false
  },
  "UpdateStackOutput": {
    "type": "structure",
    "members": {
      "StackId": {"shape": "StackId", "flattened": false}
    },
    "flattened": false
  },
  "UpdateStackSetInput": {
    "type": "structure",
    "members": {
      "StackSetName": {"shape": "StackSetName", "flattened": false},
      "Description": {"shape": "Description", "flattened": false},
      "TemplateBody": {"shape": "TemplateBody", "flattened": false},
      "TemplateURL": {"shape": "TemplateURL", "flattened": false},
      "UsePreviousTemplate": {
        "shape": "UsePreviousTemplate",
        "flattened": false
      },
      "Parameters": {"shape": "Parameters", "flattened": false},
      "Capabilities": {"shape": "Capabilities", "flattened": false},
      "Tags": {"shape": "Tags", "flattened": false},
      "OperationPreferences": {
        "shape": "StackSetOperationPreferences",
        "flattened": false
      },
      "AdministrationRoleARN": {"shape": "RoleARN", "flattened": false},
      "ExecutionRoleName": {"shape": "ExecutionRoleName", "flattened": false},
      "DeploymentTargets": {"shape": "DeploymentTargets", "flattened": false},
      "PermissionModel": {"shape": "PermissionModels", "flattened": false},
      "AutoDeployment": {"shape": "AutoDeployment", "flattened": false},
      "OperationId": {"shape": "ClientRequestToken", "flattened": false},
      "Accounts": {"shape": "AccountList", "flattened": false},
      "Regions": {"shape": "RegionList", "flattened": false},
      "CallAs": {"shape": "CallAs", "flattened": false},
      "ManagedExecution": {"shape": "ManagedExecution", "flattened": false}
    },
    "flattened": false
  },
  "UpdateStackSetOutput": {
    "type": "structure",
    "members": {
      "OperationId": {"shape": "ClientRequestToken", "flattened": false}
    },
    "flattened": false
  },
  "UpdateTerminationProtectionInput": {
    "type": "structure",
    "members": {
      "EnableTerminationProtection": {
        "shape": "EnableTerminationProtection",
        "flattened": false
      },
      "StackName": {"shape": "StackNameOrId", "flattened": false}
    },
    "flattened": false
  },
  "UpdateTerminationProtectionOutput": {
    "type": "structure",
    "members": {
      "StackId": {"shape": "StackId", "flattened": false}
    },
    "flattened": false
  },
  "Url": {"type": "string", "flattened": false},
  "UsePreviousTemplate": {"type": "boolean", "flattened": false},
  "UsePreviousValue": {"type": "boolean", "flattened": false},
  "ValidateTemplateInput": {
    "type": "structure",
    "members": {
      "TemplateBody": {"shape": "TemplateBody", "flattened": false},
      "TemplateURL": {"shape": "TemplateURL", "flattened": false}
    },
    "flattened": false
  },
  "ValidateTemplateOutput": {
    "type": "structure",
    "members": {
      "Parameters": {"shape": "TemplateParameters", "flattened": false},
      "Description": {"shape": "Description", "flattened": false},
      "Capabilities": {"shape": "Capabilities", "flattened": false},
      "CapabilitiesReason": {"shape": "CapabilitiesReason", "flattened": false},
      "DeclaredTransforms": {"shape": "TransformsList", "flattened": false}
    },
    "flattened": false
  },
  "Value": {"type": "string", "flattened": false},
  "Version": {"type": "string", "flattened": false},
  "VersionBump": {"type": "string", "flattened": false},
  "Visibility": {"type": "string", "flattened": false}
};
