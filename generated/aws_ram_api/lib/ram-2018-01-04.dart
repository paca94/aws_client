// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name

import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_aws_api/shared.dart' as _s;
import 'package:shared_aws_api/shared.dart'
    show
        rfc822ToJson,
        iso8601ToJson,
        unixTimestampToJson,
        nonNullableTimeStampFromJson,
        timeStampFromJson;

export 'package:shared_aws_api/shared.dart' show AwsClientCredentials;

/// This is the <i>Resource Access Manager API Reference</i>. This documentation
/// provides descriptions and syntax for each of the actions and data types in
/// RAM. RAM is a service that helps you securely share your Amazon Web Services
/// resources across Amazon Web Services accounts. If you have multiple Amazon
/// Web Services accounts, you can use RAM to share those resources with other
/// accounts. If you use Organizations to manage your accounts, then you share
/// your resources with your organization or organizational units (OUs). For
/// supported resource types, you can also share resources with individual
/// Identity and Access Management (IAM) roles an users.
///
/// To learn more about RAM, see the following resources:
///
/// <ul>
/// <li>
/// <a href="http://aws.amazon.com/ram">Resource Access Manager product page</a>
/// </li>
/// <li>
/// <a href="https://docs.aws.amazon.com/ram/latest/userguide/">Resource Access
/// Manager User Guide</a>
/// </li>
/// </ul>
class RAM {
  final _s.RestJsonProtocol _protocol;
  RAM({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.AwsClientCredentialsProvider? credentialsProvider,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.RestJsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'ram',
          ),
          region: region,
          credentials: credentials,
          credentialsProvider: credentialsProvider,
          endpointUrl: endpointUrl,
        );

  /// Closes the internal HTTP client if none was provided at creation.
  /// If a client was passed as a constructor argument, this becomes a noop.
  ///
  /// It's important to close all clients when it's done being used; failing to
  /// do so can cause the Dart process to hang.
  void close() {
    _protocol.close();
  }

  /// Accepts an invitation to a resource share from another Amazon Web Services
  /// account. After you accept the invitation, the resources included in the
  /// resource share are available to interact with in the relevant Amazon Web
  /// Services Management Consoles and tools.
  ///
  /// May throw [MalformedArnException].
  /// May throw [OperationNotPermittedException].
  /// May throw [ResourceShareInvitationArnNotFoundException].
  /// May throw [ResourceShareInvitationAlreadyAcceptedException].
  /// May throw [ResourceShareInvitationAlreadyRejectedException].
  /// May throw [ResourceShareInvitationExpiredException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  /// May throw [InvalidClientTokenException].
  /// May throw [IdempotentParameterMismatchException].
  ///
  /// Parameter [resourceShareInvitationArn] :
  /// The <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the invitation that you want to accept.
  ///
  /// Parameter [clientToken] :
  /// Specifies a unique, case-sensitive identifier that you provide to ensure
  /// the idempotency of the request. This lets you safely retry the request
  /// without accidentally performing the same operation a second time. Passing
  /// the same value to a later call to an operation requires that you also pass
  /// the same value for all other parameters. We recommend that you use a <a
  /// href="https://wikipedia.org/wiki/Universally_unique_identifier">UUID type
  /// of value.</a>.
  ///
  /// If you don't provide this value, then Amazon Web Services generates a
  /// random one for you.
  Future<AcceptResourceShareInvitationResponse> acceptResourceShareInvitation({
    required String resourceShareInvitationArn,
    String? clientToken,
  }) async {
    ArgumentError.checkNotNull(
        resourceShareInvitationArn, 'resourceShareInvitationArn');
    final $payload = <String, dynamic>{
      'resourceShareInvitationArn': resourceShareInvitationArn,
      if (clientToken != null) 'clientToken': clientToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/acceptresourceshareinvitation',
      exceptionFnMap: _exceptionFns,
    );
    return AcceptResourceShareInvitationResponse.fromJson(response);
  }

  /// Adds the specified list of principals and list of resources to a resource
  /// share. Principals that already have access to this resource share
  /// immediately receive access to the added resources. Newly added principals
  /// immediately receive access to the resources shared in this resource share.
  ///
  /// May throw [IdempotentParameterMismatchException].
  /// May throw [UnknownResourceException].
  /// May throw [InvalidStateTransitionException].
  /// May throw [ResourceShareLimitExceededException].
  /// May throw [MalformedArnException].
  /// May throw [InvalidStateTransitionException].
  /// May throw [InvalidClientTokenException].
  /// May throw [InvalidParameterException].
  /// May throw [OperationNotPermittedException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  /// May throw [UnknownResourceException].
  /// May throw [ThrottlingException].
  ///
  /// Parameter [resourceShareArn] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource share that you want to add
  /// principals or resources to.
  ///
  /// Parameter [clientToken] :
  /// Specifies a unique, case-sensitive identifier that you provide to ensure
  /// the idempotency of the request. This lets you safely retry the request
  /// without accidentally performing the same operation a second time. Passing
  /// the same value to a later call to an operation requires that you also pass
  /// the same value for all other parameters. We recommend that you use a <a
  /// href="https://wikipedia.org/wiki/Universally_unique_identifier">UUID type
  /// of value.</a>.
  ///
  /// If you don't provide this value, then Amazon Web Services generates a
  /// random one for you.
  ///
  /// Parameter [principals] :
  /// Specifies a list of principals to whom you want to the resource share.
  /// This can be <code>null</code> if you want to add only resources.
  ///
  /// What the principals can do with the resources in the share is determined
  /// by the RAM permissions that you associate with the resource share. See
  /// <a>AssociateResourceSharePermission</a>.
  ///
  /// You can include the following values:
  ///
  /// <ul>
  /// <li>
  /// An Amazon Web Services account ID, for example: <code>123456789012</code>
  /// </li>
  /// <li>
  /// An <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of an organization in Organizations, for example:
  /// <code>organizations::123456789012:organization/o-exampleorgid</code>
  /// </li>
  /// <li>
  /// An ARN of an organizational unit (OU) in Organizations, for example:
  /// <code>organizations::123456789012:ou/o-exampleorgid/ou-examplerootid-exampleouid123</code>
  /// </li>
  /// <li>
  /// An ARN of an IAM role, for example:
  /// <code>iam::123456789012:role/rolename</code>
  /// </li>
  /// <li>
  /// An ARN of an IAM user, for example:
  /// <code>iam::123456789012user/username</code>
  /// </li>
  /// </ul> <note>
  /// Not all resource types can be shared with IAM roles and users. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/ram/latest/userguide/permissions.html#permissions-rbp-supported-resource-types">Sharing
  /// with IAM roles and users</a> in the <i>Resource Access Manager User
  /// Guide</i>.
  /// </note>
  ///
  /// Parameter [resourceArns] :
  /// Specifies a list of <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resource Names (ARNs)</a> of the resources that you want to share. This
  /// can be <code>null</code> if you want to add only principals.
  Future<AssociateResourceShareResponse> associateResourceShare({
    required String resourceShareArn,
    String? clientToken,
    List<String>? principals,
    List<String>? resourceArns,
  }) async {
    ArgumentError.checkNotNull(resourceShareArn, 'resourceShareArn');
    final $payload = <String, dynamic>{
      'resourceShareArn': resourceShareArn,
      if (clientToken != null) 'clientToken': clientToken,
      if (principals != null) 'principals': principals,
      if (resourceArns != null) 'resourceArns': resourceArns,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/associateresourceshare',
      exceptionFnMap: _exceptionFns,
    );
    return AssociateResourceShareResponse.fromJson(response);
  }

  /// Adds or replaces the RAM permission for a resource type included in a
  /// resource share. You can have exactly one permission associated with each
  /// resource type in the resource share. You can add a new RAM permission only
  /// if there are currently no resources of that resource type currently in the
  /// resource share.
  ///
  /// May throw [MalformedArnException].
  /// May throw [UnknownResourceException].
  /// May throw [InvalidParameterException].
  /// May throw [InvalidClientTokenException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  /// May throw [OperationNotPermittedException].
  ///
  /// Parameter [permissionArn] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the RAM permission to associate with the
  /// resource share. To find the ARN for a permission, use either the
  /// <a>ListPermissions</a> operation or go to the <a
  /// href="https://console.aws.amazon.com/ram/home#Permissions:">Permissions
  /// library</a> page in the RAM console and then choose the name of the
  /// permission. The ARN is displayed on the detail page.
  ///
  /// Parameter [resourceShareArn] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource share to which you want to add or
  /// replace permissions.
  ///
  /// Parameter [clientToken] :
  /// Specifies a unique, case-sensitive identifier that you provide to ensure
  /// the idempotency of the request. This lets you safely retry the request
  /// without accidentally performing the same operation a second time. Passing
  /// the same value to a later call to an operation requires that you also pass
  /// the same value for all other parameters. We recommend that you use a <a
  /// href="https://wikipedia.org/wiki/Universally_unique_identifier">UUID type
  /// of value.</a>.
  ///
  /// If you don't provide this value, then Amazon Web Services generates a
  /// random one for you.
  ///
  /// Parameter [permissionVersion] :
  /// Specifies the version of the RAM permission to associate with the resource
  /// share. If you don't specify this parameter, the operation uses the version
  /// designated as the default. You can use the <a>ListPermissionVersions</a>
  /// operation to discover the available versions of a permission.
  ///
  /// Parameter [replace] :
  /// Specifies whether the specified permission should replace or add to the
  /// existing permission associated with the resource share. Use
  /// <code>true</code> to replace the current permissions. Use
  /// <code>false</code> to add the permission to the current permission. The
  /// default value is <code>false</code>.
  /// <note>
  /// A resource share can have only one permission per resource type. If a
  /// resource share already has a permission for the specified resource type
  /// and you don't set <code>replace</code> to <code>true</code> then the
  /// operation returns an error. This helps prevent accidental overwriting of a
  /// permission.
  /// </note>
  Future<AssociateResourceSharePermissionResponse>
      associateResourceSharePermission({
    required String permissionArn,
    required String resourceShareArn,
    String? clientToken,
    int? permissionVersion,
    bool? replace,
  }) async {
    ArgumentError.checkNotNull(permissionArn, 'permissionArn');
    ArgumentError.checkNotNull(resourceShareArn, 'resourceShareArn');
    final $payload = <String, dynamic>{
      'permissionArn': permissionArn,
      'resourceShareArn': resourceShareArn,
      if (clientToken != null) 'clientToken': clientToken,
      if (permissionVersion != null) 'permissionVersion': permissionVersion,
      if (replace != null) 'replace': replace,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/associateresourcesharepermission',
      exceptionFnMap: _exceptionFns,
    );
    return AssociateResourceSharePermissionResponse.fromJson(response);
  }

  /// Creates a resource share. You can provide a list of the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resource Names (ARNs)</a> for the resources that you want to share, a list
  /// of principals you want to share the resources with, and the permissions to
  /// grant those principals.
  /// <note>
  /// Sharing a resource makes it available for use by principals outside of the
  /// Amazon Web Services account that created the resource. Sharing doesn't
  /// change any permissions or quotas that apply to the resource in the account
  /// that created it.
  /// </note>
  ///
  /// May throw [IdempotentParameterMismatchException].
  /// May throw [InvalidStateTransitionException].
  /// May throw [UnknownResourceException].
  /// May throw [MalformedArnException].
  /// May throw [InvalidClientTokenException].
  /// May throw [InvalidParameterException].
  /// May throw [OperationNotPermittedException].
  /// May throw [ResourceShareLimitExceededException].
  /// May throw [TagPolicyViolationException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [name] :
  /// Specifies the name of the resource share.
  ///
  /// Parameter [allowExternalPrincipals] :
  /// Specifies whether principals outside your organization in Organizations
  /// can be associated with a resource share. A value of <code>true</code> lets
  /// you share with individual Amazon Web Services accounts that are <i>not</i>
  /// in your organization. A value of <code>false</code> only has meaning if
  /// your account is a member of an Amazon Web Services Organization. The
  /// default value is <code>true</code>.
  ///
  /// Parameter [clientToken] :
  /// Specifies a unique, case-sensitive identifier that you provide to ensure
  /// the idempotency of the request. This lets you safely retry the request
  /// without accidentally performing the same operation a second time. Passing
  /// the same value to a later call to an operation requires that you also pass
  /// the same value for all other parameters. We recommend that you use a <a
  /// href="https://wikipedia.org/wiki/Universally_unique_identifier">UUID type
  /// of value.</a>.
  ///
  /// If you don't provide this value, then Amazon Web Services generates a
  /// random one for you.
  ///
  /// Parameter [permissionArns] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resource Names (ARNs)</a> of the RAM permission to associate with the
  /// resource share. If you do not specify an ARN for the permission, RAM
  /// automatically attaches the default version of the permission for each
  /// resource type. You can associate only one permission with each resource
  /// type included in the resource share.
  ///
  /// Parameter [principals] :
  /// Specifies a list of one or more principals to associate with the resource
  /// share.
  ///
  /// You can include the following values:
  ///
  /// <ul>
  /// <li>
  /// An Amazon Web Services account ID, for example: <code>123456789012</code>
  /// </li>
  /// <li>
  /// An <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of an organization in Organizations, for example:
  /// <code>organizations::123456789012:organization/o-exampleorgid</code>
  /// </li>
  /// <li>
  /// An ARN of an organizational unit (OU) in Organizations, for example:
  /// <code>organizations::123456789012:ou/o-exampleorgid/ou-examplerootid-exampleouid123</code>
  /// </li>
  /// <li>
  /// An ARN of an IAM role, for example:
  /// <code>iam::123456789012:role/rolename</code>
  /// </li>
  /// <li>
  /// An ARN of an IAM user, for example:
  /// <code>iam::123456789012user/username</code>
  /// </li>
  /// </ul> <note>
  /// Not all resource types can be shared with IAM roles and users. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/ram/latest/userguide/permissions.html#permissions-rbp-supported-resource-types">Sharing
  /// with IAM roles and users</a> in the <i>Resource Access Manager User
  /// Guide</i>.
  /// </note>
  ///
  /// Parameter [resourceArns] :
  /// Specifies a list of one or more ARNs of the resources to associate with
  /// the resource share.
  ///
  /// Parameter [tags] :
  /// Specifies one or more tags to attach to the resource share itself. It
  /// doesn't attach the tags to the resources associated with the resource
  /// share.
  Future<CreateResourceShareResponse> createResourceShare({
    required String name,
    bool? allowExternalPrincipals,
    String? clientToken,
    List<String>? permissionArns,
    List<String>? principals,
    List<String>? resourceArns,
    List<Tag>? tags,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    final $payload = <String, dynamic>{
      'name': name,
      if (allowExternalPrincipals != null)
        'allowExternalPrincipals': allowExternalPrincipals,
      if (clientToken != null) 'clientToken': clientToken,
      if (permissionArns != null) 'permissionArns': permissionArns,
      if (principals != null) 'principals': principals,
      if (resourceArns != null) 'resourceArns': resourceArns,
      if (tags != null) 'tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/createresourceshare',
      exceptionFnMap: _exceptionFns,
    );
    return CreateResourceShareResponse.fromJson(response);
  }

  /// Deletes the specified resource share. This doesn't delete any of the
  /// resources that were associated with the resource share; it only stops the
  /// sharing of those resources outside of the Amazon Web Services account that
  /// created them.
  ///
  /// May throw [OperationNotPermittedException].
  /// May throw [IdempotentParameterMismatchException].
  /// May throw [InvalidStateTransitionException].
  /// May throw [UnknownResourceException].
  /// May throw [MalformedArnException].
  /// May throw [InvalidClientTokenException].
  /// May throw [InvalidParameterException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [resourceShareArn] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource share to delete.
  ///
  /// Parameter [clientToken] :
  /// Specifies a unique, case-sensitive identifier that you provide to ensure
  /// the idempotency of the request. This lets you safely retry the request
  /// without accidentally performing the same operation a second time. Passing
  /// the same value to a later call to an operation requires that you also pass
  /// the same value for all other parameters. We recommend that you use a <a
  /// href="https://wikipedia.org/wiki/Universally_unique_identifier">UUID type
  /// of value.</a>.
  ///
  /// If you don't provide this value, then Amazon Web Services generates a
  /// random one for you.
  Future<DeleteResourceShareResponse> deleteResourceShare({
    required String resourceShareArn,
    String? clientToken,
  }) async {
    ArgumentError.checkNotNull(resourceShareArn, 'resourceShareArn');
    final $query = <String, List<String>>{
      'resourceShareArn': [resourceShareArn],
      if (clientToken != null) 'clientToken': [clientToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/deleteresourceshare',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return DeleteResourceShareResponse.fromJson(response);
  }

  /// Disassociates the specified principals or resources from the specified
  /// resource share.
  ///
  /// May throw [IdempotentParameterMismatchException].
  /// May throw [ResourceShareLimitExceededException].
  /// May throw [MalformedArnException].
  /// May throw [InvalidStateTransitionException].
  /// May throw [InvalidClientTokenException].
  /// May throw [InvalidParameterException].
  /// May throw [OperationNotPermittedException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  /// May throw [UnknownResourceException].
  ///
  /// Parameter [resourceShareArn] :
  /// Specifies <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource share that you want to remove
  /// resources from.
  ///
  /// Parameter [clientToken] :
  /// Specifies a unique, case-sensitive identifier that you provide to ensure
  /// the idempotency of the request. This lets you safely retry the request
  /// without accidentally performing the same operation a second time. Passing
  /// the same value to a later call to an operation requires that you also pass
  /// the same value for all other parameters. We recommend that you use a <a
  /// href="https://wikipedia.org/wiki/Universally_unique_identifier">UUID type
  /// of value.</a>.
  ///
  /// If you don't provide this value, then Amazon Web Services generates a
  /// random one for you.
  ///
  /// Parameter [principals] :
  /// Specifies a list of one or more principals that no longer are to have
  /// access to the resources in this resource share.
  ///
  /// You can include the following values:
  ///
  /// <ul>
  /// <li>
  /// An Amazon Web Services account ID, for example: <code>123456789012</code>
  /// </li>
  /// <li>
  /// An <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of an organization in Organizations, for example:
  /// <code>organizations::123456789012:organization/o-exampleorgid</code>
  /// </li>
  /// <li>
  /// An ARN of an organizational unit (OU) in Organizations, for example:
  /// <code>organizations::123456789012:ou/o-exampleorgid/ou-examplerootid-exampleouid123</code>
  /// </li>
  /// <li>
  /// An ARN of an IAM role, for example:
  /// <code>iam::123456789012:role/rolename</code>
  /// </li>
  /// <li>
  /// An ARN of an IAM user, for example:
  /// <code>iam::123456789012user/username</code>
  /// </li>
  /// </ul> <note>
  /// Not all resource types can be shared with IAM roles and users. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/ram/latest/userguide/permissions.html#permissions-rbp-supported-resource-types">Sharing
  /// with IAM roles and users</a> in the <i>Resource Access Manager User
  /// Guide</i>.
  /// </note>
  ///
  /// Parameter [resourceArns] :
  /// Specifies a list of <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resource Names (ARNs)</a> for one or more resources that you want to
  /// remove from the resource share. After the operation runs, these resources
  /// are no longer shared with principals outside of the Amazon Web Services
  /// account that created the resources.
  Future<DisassociateResourceShareResponse> disassociateResourceShare({
    required String resourceShareArn,
    String? clientToken,
    List<String>? principals,
    List<String>? resourceArns,
  }) async {
    ArgumentError.checkNotNull(resourceShareArn, 'resourceShareArn');
    final $payload = <String, dynamic>{
      'resourceShareArn': resourceShareArn,
      if (clientToken != null) 'clientToken': clientToken,
      if (principals != null) 'principals': principals,
      if (resourceArns != null) 'resourceArns': resourceArns,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/disassociateresourceshare',
      exceptionFnMap: _exceptionFns,
    );
    return DisassociateResourceShareResponse.fromJson(response);
  }

  /// Disassociates an RAM permission from a resource share. Permission changes
  /// take effect immediately. You can remove a RAM permission from a resource
  /// share only if there are currently no resources of the relevant resource
  /// type currently attached to the resource share.
  ///
  /// May throw [MalformedArnException].
  /// May throw [UnknownResourceException].
  /// May throw [InvalidParameterException].
  /// May throw [InvalidClientTokenException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  /// May throw [OperationNotPermittedException].
  /// May throw [InvalidStateTransitionException].
  ///
  /// Parameter [permissionArn] :
  /// The <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the permission to disassociate from the resource
  /// share. Changes to permissions take effect immediately.
  ///
  /// Parameter [resourceShareArn] :
  /// The <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource share from which you want to
  /// disassociate a permission.
  ///
  /// Parameter [clientToken] :
  /// Specifies a unique, case-sensitive identifier that you provide to ensure
  /// the idempotency of the request. This lets you safely retry the request
  /// without accidentally performing the same operation a second time. Passing
  /// the same value to a later call to an operation requires that you also pass
  /// the same value for all other parameters. We recommend that you use a <a
  /// href="https://wikipedia.org/wiki/Universally_unique_identifier">UUID type
  /// of value.</a>.
  ///
  /// If you don't provide this value, then Amazon Web Services generates a
  /// random one for you.
  Future<DisassociateResourceSharePermissionResponse>
      disassociateResourceSharePermission({
    required String permissionArn,
    required String resourceShareArn,
    String? clientToken,
  }) async {
    ArgumentError.checkNotNull(permissionArn, 'permissionArn');
    ArgumentError.checkNotNull(resourceShareArn, 'resourceShareArn');
    final $payload = <String, dynamic>{
      'permissionArn': permissionArn,
      'resourceShareArn': resourceShareArn,
      if (clientToken != null) 'clientToken': clientToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/disassociateresourcesharepermission',
      exceptionFnMap: _exceptionFns,
    );
    return DisassociateResourceSharePermissionResponse.fromJson(response);
  }

  /// Enables resource sharing within your organization in Organizations.
  /// Calling this operation enables RAM to retrieve information about the
  /// organization and its structure. This lets you share resources with all of
  /// the accounts in an organization by specifying the organization's ID, or
  /// all of the accounts in an organizational unit (OU) by specifying the OU's
  /// ID. Until you enable sharing within the organization, you can specify only
  /// individual Amazon Web Services accounts, or for supported resource types,
  /// IAM users and roles.
  ///
  /// You must call this operation from an IAM user or role in the
  /// organization's management account.
  ///
  /// May throw [OperationNotPermittedException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  Future<EnableSharingWithAwsOrganizationResponse>
      enableSharingWithAwsOrganization() async {
    final response = await _protocol.send(
      payload: null,
      method: 'POST',
      requestUri: '/enablesharingwithawsorganization',
      exceptionFnMap: _exceptionFns,
    );
    return EnableSharingWithAwsOrganizationResponse.fromJson(response);
  }

  /// Gets the contents of an RAM permission in JSON format.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [MalformedArnException].
  /// May throw [UnknownResourceException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  /// May throw [OperationNotPermittedException].
  ///
  /// Parameter [permissionArn] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the permission whose contents you want to
  /// retrieve. To find the ARN for a permission, use either the
  /// <a>ListPermissions</a> operation or go to the <a
  /// href="https://console.aws.amazon.com/ram/home#Permissions:">Permissions
  /// library</a> page in the RAM console and then choose the name of the
  /// permission. The ARN is displayed on the detail page.
  ///
  /// Parameter [permissionVersion] :
  /// Specifies identifier for the version of the RAM permission to retrieve. If
  /// you don't specify this parameter, the operation retrieves the default
  /// version.
  Future<GetPermissionResponse> getPermission({
    required String permissionArn,
    int? permissionVersion,
  }) async {
    ArgumentError.checkNotNull(permissionArn, 'permissionArn');
    final $payload = <String, dynamic>{
      'permissionArn': permissionArn,
      if (permissionVersion != null) 'permissionVersion': permissionVersion,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/getpermission',
      exceptionFnMap: _exceptionFns,
    );
    return GetPermissionResponse.fromJson(response);
  }

  /// Retrieves the resource policies for the specified resources that you own
  /// and have shared.
  ///
  /// May throw [MalformedArnException].
  /// May throw [InvalidNextTokenException].
  /// May throw [InvalidParameterException].
  /// May throw [ResourceArnNotFoundException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [resourceArns] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resource Names (ARNs)</a> of the resources whose policies you want to
  /// retrieve.
  ///
  /// Parameter [maxResults] :
  /// Specifies the total number of results that you want included on each page
  /// of the response. If you do not include this parameter, it defaults to a
  /// value that is specific to the operation. If additional items exist beyond
  /// the number you specify, the <code>NextToken</code> response element is
  /// returned with a value (not null). Include the specified value as the
  /// <code>NextToken</code> request parameter in the next call to the operation
  /// to get the next part of the results. Note that the service might return
  /// fewer results than the maximum even when there are more results available.
  /// You should check <code>NextToken</code> after every operation to ensure
  /// that you receive all of the results.
  ///
  /// Parameter [nextToken] :
  /// Specifies that you want to receive the next page of results. Valid only if
  /// you received a <code>NextToken</code> response in the previous request. If
  /// you did, it indicates that more output is available. Set this parameter to
  /// the value provided by the previous call's <code>NextToken</code> response
  /// to request the next page of results.
  ///
  /// Parameter [principal] :
  /// Specifies the principal.
  Future<GetResourcePoliciesResponse> getResourcePolicies({
    required List<String> resourceArns,
    int? maxResults,
    String? nextToken,
    String? principal,
  }) async {
    ArgumentError.checkNotNull(resourceArns, 'resourceArns');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      500,
    );
    final $payload = <String, dynamic>{
      'resourceArns': resourceArns,
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
      if (principal != null) 'principal': principal,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/getresourcepolicies',
      exceptionFnMap: _exceptionFns,
    );
    return GetResourcePoliciesResponse.fromJson(response);
  }

  /// Retrieves the resource and principal associations for resource shares that
  /// you own.
  ///
  /// May throw [UnknownResourceException].
  /// May throw [MalformedArnException].
  /// May throw [InvalidNextTokenException].
  /// May throw [InvalidParameterException].
  /// May throw [OperationNotPermittedException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [associationType] :
  /// Specifies whether you want to retrieve the associations that involve a
  /// specified resource or principal.
  ///
  /// <ul>
  /// <li>
  /// <code>PRINCIPAL</code> – list the principals that are associated with the
  /// specified resource share.
  /// </li>
  /// <li>
  /// <code>RESOURCE</code> – list the resources that are associated with the
  /// specified resource share.
  /// </li>
  /// </ul>
  ///
  /// Parameter [associationStatus] :
  /// Specifies that you want to retrieve only associations with this status.
  ///
  /// Parameter [maxResults] :
  /// Specifies the total number of results that you want included on each page
  /// of the response. If you do not include this parameter, it defaults to a
  /// value that is specific to the operation. If additional items exist beyond
  /// the number you specify, the <code>NextToken</code> response element is
  /// returned with a value (not null). Include the specified value as the
  /// <code>NextToken</code> request parameter in the next call to the operation
  /// to get the next part of the results. Note that the service might return
  /// fewer results than the maximum even when there are more results available.
  /// You should check <code>NextToken</code> after every operation to ensure
  /// that you receive all of the results.
  ///
  /// Parameter [nextToken] :
  /// Specifies that you want to receive the next page of results. Valid only if
  /// you received a <code>NextToken</code> response in the previous request. If
  /// you did, it indicates that more output is available. Set this parameter to
  /// the value provided by the previous call's <code>NextToken</code> response
  /// to request the next page of results.
  ///
  /// Parameter [principal] :
  /// Specifies the ID of the principal whose resource shares you want to
  /// retrieve. This can be an Amazon Web Services account ID, an organization
  /// ID, an organizational unit ID, or the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of an individual IAM user or role.
  ///
  /// You cannot specify this parameter if the association type is
  /// <code>RESOURCE</code>.
  ///
  /// Parameter [resourceArn] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource whose resource shares you want to
  /// retrieve.
  ///
  /// You cannot specify this parameter if the association type is
  /// <code>PRINCIPAL</code>.
  ///
  /// Parameter [resourceShareArns] :
  /// Specifies a list of <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resource Names (ARNs)</a> of the resource share whose associations you
  /// want to retrieve.
  Future<GetResourceShareAssociationsResponse> getResourceShareAssociations({
    required ResourceShareAssociationType associationType,
    ResourceShareAssociationStatus? associationStatus,
    int? maxResults,
    String? nextToken,
    String? principal,
    String? resourceArn,
    List<String>? resourceShareArns,
  }) async {
    ArgumentError.checkNotNull(associationType, 'associationType');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      500,
    );
    final $payload = <String, dynamic>{
      'associationType': associationType.toValue(),
      if (associationStatus != null)
        'associationStatus': associationStatus.toValue(),
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
      if (principal != null) 'principal': principal,
      if (resourceArn != null) 'resourceArn': resourceArn,
      if (resourceShareArns != null) 'resourceShareArns': resourceShareArns,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/getresourceshareassociations',
      exceptionFnMap: _exceptionFns,
    );
    return GetResourceShareAssociationsResponse.fromJson(response);
  }

  /// Retrieves details about invitations that you have received for resource
  /// shares.
  ///
  /// May throw [ResourceShareInvitationArnNotFoundException].
  /// May throw [InvalidMaxResultsException].
  /// May throw [MalformedArnException].
  /// May throw [UnknownResourceException].
  /// May throw [InvalidNextTokenException].
  /// May throw [InvalidParameterException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [maxResults] :
  /// Specifies the total number of results that you want included on each page
  /// of the response. If you do not include this parameter, it defaults to a
  /// value that is specific to the operation. If additional items exist beyond
  /// the number you specify, the <code>NextToken</code> response element is
  /// returned with a value (not null). Include the specified value as the
  /// <code>NextToken</code> request parameter in the next call to the operation
  /// to get the next part of the results. Note that the service might return
  /// fewer results than the maximum even when there are more results available.
  /// You should check <code>NextToken</code> after every operation to ensure
  /// that you receive all of the results.
  ///
  /// Parameter [nextToken] :
  /// Specifies that you want to receive the next page of results. Valid only if
  /// you received a <code>NextToken</code> response in the previous request. If
  /// you did, it indicates that more output is available. Set this parameter to
  /// the value provided by the previous call's <code>NextToken</code> response
  /// to request the next page of results.
  ///
  /// Parameter [resourceShareArns] :
  /// Specifies that you want details about invitations only for the resource
  /// shares described by this list of <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resource Names (ARNs)</a>
  ///
  /// Parameter [resourceShareInvitationArns] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resource Names (ARNs)</a> of the resource share invitations you want
  /// information about.
  Future<GetResourceShareInvitationsResponse> getResourceShareInvitations({
    int? maxResults,
    String? nextToken,
    List<String>? resourceShareArns,
    List<String>? resourceShareInvitationArns,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      500,
    );
    final $payload = <String, dynamic>{
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
      if (resourceShareArns != null) 'resourceShareArns': resourceShareArns,
      if (resourceShareInvitationArns != null)
        'resourceShareInvitationArns': resourceShareInvitationArns,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/getresourceshareinvitations',
      exceptionFnMap: _exceptionFns,
    );
    return GetResourceShareInvitationsResponse.fromJson(response);
  }

  /// Retrieves details about the resource shares that you own or that are
  /// shared with you.
  ///
  /// May throw [UnknownResourceException].
  /// May throw [MalformedArnException].
  /// May throw [InvalidNextTokenException].
  /// May throw [InvalidParameterException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [resourceOwner] :
  /// Specifies that you want to retrieve details of only those resource shares
  /// that match the following:
  ///
  /// <ul>
  /// <li>
  /// <b> <code>SELF</code> </b> – resource shares that your account shares with
  /// other accounts
  /// </li>
  /// <li>
  /// <b> <code>OTHER-ACCOUNTS</code> </b> – resource shares that other accounts
  /// share with your account
  /// </li>
  /// </ul>
  ///
  /// Parameter [maxResults] :
  /// Specifies the total number of results that you want included on each page
  /// of the response. If you do not include this parameter, it defaults to a
  /// value that is specific to the operation. If additional items exist beyond
  /// the number you specify, the <code>NextToken</code> response element is
  /// returned with a value (not null). Include the specified value as the
  /// <code>NextToken</code> request parameter in the next call to the operation
  /// to get the next part of the results. Note that the service might return
  /// fewer results than the maximum even when there are more results available.
  /// You should check <code>NextToken</code> after every operation to ensure
  /// that you receive all of the results.
  ///
  /// Parameter [name] :
  /// Specifies the name of an individual resource share that you want to
  /// retrieve details about.
  ///
  /// Parameter [nextToken] :
  /// Specifies that you want to receive the next page of results. Valid only if
  /// you received a <code>NextToken</code> response in the previous request. If
  /// you did, it indicates that more output is available. Set this parameter to
  /// the value provided by the previous call's <code>NextToken</code> response
  /// to request the next page of results.
  ///
  /// Parameter [permissionArn] :
  /// Specifies that you want to retrieve details of only those resource shares
  /// that use the RAM permission with this <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a>.
  ///
  /// Parameter [resourceShareArns] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resource Names (ARNs)</a> of individual resource shares that you want
  /// information about.
  ///
  /// Parameter [resourceShareStatus] :
  /// Specifies that you want to retrieve details of only those resource shares
  /// that have this status.
  ///
  /// Parameter [tagFilters] :
  /// Specifies that you want to retrieve details of only those resource shares
  /// that match the specified tag keys and values.
  Future<GetResourceSharesResponse> getResourceShares({
    required ResourceOwner resourceOwner,
    int? maxResults,
    String? name,
    String? nextToken,
    String? permissionArn,
    List<String>? resourceShareArns,
    ResourceShareStatus? resourceShareStatus,
    List<TagFilter>? tagFilters,
  }) async {
    ArgumentError.checkNotNull(resourceOwner, 'resourceOwner');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      500,
    );
    final $payload = <String, dynamic>{
      'resourceOwner': resourceOwner.toValue(),
      if (maxResults != null) 'maxResults': maxResults,
      if (name != null) 'name': name,
      if (nextToken != null) 'nextToken': nextToken,
      if (permissionArn != null) 'permissionArn': permissionArn,
      if (resourceShareArns != null) 'resourceShareArns': resourceShareArns,
      if (resourceShareStatus != null)
        'resourceShareStatus': resourceShareStatus.toValue(),
      if (tagFilters != null) 'tagFilters': tagFilters,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/getresourceshares',
      exceptionFnMap: _exceptionFns,
    );
    return GetResourceSharesResponse.fromJson(response);
  }

  /// Lists the resources in a resource share that is shared with you but for
  /// which the invitation is still <code>PENDING</code>. That means that you
  /// haven't accepted or rejected the invitation and the invitation hasn't
  /// expired.
  ///
  /// May throw [MalformedArnException].
  /// May throw [InvalidNextTokenException].
  /// May throw [InvalidParameterException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  /// May throw [ResourceShareInvitationArnNotFoundException].
  /// May throw [MissingRequiredParameterException].
  /// May throw [ResourceShareInvitationAlreadyRejectedException].
  /// May throw [ResourceShareInvitationExpiredException].
  ///
  /// Parameter [resourceShareInvitationArn] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the invitation. You can use
  /// <a>GetResourceShareInvitations</a> to find the ARN of the invitation.
  ///
  /// Parameter [maxResults] :
  /// Specifies the total number of results that you want included on each page
  /// of the response. If you do not include this parameter, it defaults to a
  /// value that is specific to the operation. If additional items exist beyond
  /// the number you specify, the <code>NextToken</code> response element is
  /// returned with a value (not null). Include the specified value as the
  /// <code>NextToken</code> request parameter in the next call to the operation
  /// to get the next part of the results. Note that the service might return
  /// fewer results than the maximum even when there are more results available.
  /// You should check <code>NextToken</code> after every operation to ensure
  /// that you receive all of the results.
  ///
  /// Parameter [nextToken] :
  /// Specifies that you want to receive the next page of results. Valid only if
  /// you received a <code>NextToken</code> response in the previous request. If
  /// you did, it indicates that more output is available. Set this parameter to
  /// the value provided by the previous call's <code>NextToken</code> response
  /// to request the next page of results.
  ///
  /// Parameter [resourceRegionScope] :
  /// Specifies that you want the results to include only resources that have
  /// the specified scope.
  ///
  /// <ul>
  /// <li>
  /// <code>ALL</code> – the results include both global and regional resources
  /// or resource types.
  /// </li>
  /// <li>
  /// <code>GLOBAL</code> – the results include only global resources or
  /// resource types.
  /// </li>
  /// <li>
  /// <code>REGIONAL</code> – the results include only regional resources or
  /// resource types.
  /// </li>
  /// </ul>
  /// The default value is <code>ALL</code>.
  Future<ListPendingInvitationResourcesResponse>
      listPendingInvitationResources({
    required String resourceShareInvitationArn,
    int? maxResults,
    String? nextToken,
    ResourceRegionScopeFilter? resourceRegionScope,
  }) async {
    ArgumentError.checkNotNull(
        resourceShareInvitationArn, 'resourceShareInvitationArn');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      500,
    );
    final $payload = <String, dynamic>{
      'resourceShareInvitationArn': resourceShareInvitationArn,
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
      if (resourceRegionScope != null)
        'resourceRegionScope': resourceRegionScope.toValue(),
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/listpendinginvitationresources',
      exceptionFnMap: _exceptionFns,
    );
    return ListPendingInvitationResourcesResponse.fromJson(response);
  }

  /// Lists the available versions of the specified RAM permission.
  ///
  /// May throw [MalformedArnException].
  /// May throw [UnknownResourceException].
  /// May throw [InvalidNextTokenException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  /// May throw [OperationNotPermittedException].
  /// May throw [InvalidParameterException].
  ///
  /// Parameter [permissionArn] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the RAM permission whose versions you want to
  /// list. You can use the <code>permissionVersion</code> parameter on the
  /// <a>AssociateResourceSharePermission</a> operation to specify a non-default
  /// version to attach.
  ///
  /// Parameter [maxResults] :
  /// Specifies the total number of results that you want included on each page
  /// of the response. If you do not include this parameter, it defaults to a
  /// value that is specific to the operation. If additional items exist beyond
  /// the number you specify, the <code>NextToken</code> response element is
  /// returned with a value (not null). Include the specified value as the
  /// <code>NextToken</code> request parameter in the next call to the operation
  /// to get the next part of the results. Note that the service might return
  /// fewer results than the maximum even when there are more results available.
  /// You should check <code>NextToken</code> after every operation to ensure
  /// that you receive all of the results.
  ///
  /// Parameter [nextToken] :
  /// Specifies that you want to receive the next page of results. Valid only if
  /// you received a <code>NextToken</code> response in the previous request. If
  /// you did, it indicates that more output is available. Set this parameter to
  /// the value provided by the previous call's <code>NextToken</code> response
  /// to request the next page of results.
  Future<ListPermissionVersionsResponse> listPermissionVersions({
    required String permissionArn,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(permissionArn, 'permissionArn');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      500,
    );
    final $payload = <String, dynamic>{
      'permissionArn': permissionArn,
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/listpermissionversions',
      exceptionFnMap: _exceptionFns,
    );
    return ListPermissionVersionsResponse.fromJson(response);
  }

  /// Retrieves a list of available RAM permissions that you can use for the
  /// supported resource types.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [InvalidNextTokenException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  /// May throw [OperationNotPermittedException].
  ///
  /// Parameter [maxResults] :
  /// Specifies the total number of results that you want included on each page
  /// of the response. If you do not include this parameter, it defaults to a
  /// value that is specific to the operation. If additional items exist beyond
  /// the number you specify, the <code>NextToken</code> response element is
  /// returned with a value (not null). Include the specified value as the
  /// <code>NextToken</code> request parameter in the next call to the operation
  /// to get the next part of the results. Note that the service might return
  /// fewer results than the maximum even when there are more results available.
  /// You should check <code>NextToken</code> after every operation to ensure
  /// that you receive all of the results.
  ///
  /// Parameter [nextToken] :
  /// Specifies that you want to receive the next page of results. Valid only if
  /// you received a <code>NextToken</code> response in the previous request. If
  /// you did, it indicates that more output is available. Set this parameter to
  /// the value provided by the previous call's <code>NextToken</code> response
  /// to request the next page of results.
  ///
  /// Parameter [resourceType] :
  /// Specifies that you want to list permissions for only the specified
  /// resource type. For example, to list only permissions that apply to EC2
  /// subnets, specify <code>ec2:Subnet</code>. You can use the
  /// <a>ListResourceTypes</a> operation to get the specific string required.
  Future<ListPermissionsResponse> listPermissions({
    int? maxResults,
    String? nextToken,
    String? resourceType,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      500,
    );
    final $payload = <String, dynamic>{
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
      if (resourceType != null) 'resourceType': resourceType,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/listpermissions',
      exceptionFnMap: _exceptionFns,
    );
    return ListPermissionsResponse.fromJson(response);
  }

  /// Lists the principals that you are sharing resources with or that are
  /// sharing resources with you.
  ///
  /// May throw [MalformedArnException].
  /// May throw [UnknownResourceException].
  /// May throw [InvalidNextTokenException].
  /// May throw [InvalidParameterException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [resourceOwner] :
  /// Specifies that you want to list information for only resource shares that
  /// match the following:
  ///
  /// <ul>
  /// <li>
  /// <b> <code>SELF</code> </b> – principals that your account is sharing
  /// resources with
  /// </li>
  /// <li>
  /// <b> <code>OTHER-ACCOUNTS</code> </b> – principals that are sharing
  /// resources with your account
  /// </li>
  /// </ul>
  ///
  /// Parameter [maxResults] :
  /// Specifies the total number of results that you want included on each page
  /// of the response. If you do not include this parameter, it defaults to a
  /// value that is specific to the operation. If additional items exist beyond
  /// the number you specify, the <code>NextToken</code> response element is
  /// returned with a value (not null). Include the specified value as the
  /// <code>NextToken</code> request parameter in the next call to the operation
  /// to get the next part of the results. Note that the service might return
  /// fewer results than the maximum even when there are more results available.
  /// You should check <code>NextToken</code> after every operation to ensure
  /// that you receive all of the results.
  ///
  /// Parameter [nextToken] :
  /// Specifies that you want to receive the next page of results. Valid only if
  /// you received a <code>NextToken</code> response in the previous request. If
  /// you did, it indicates that more output is available. Set this parameter to
  /// the value provided by the previous call's <code>NextToken</code> response
  /// to request the next page of results.
  ///
  /// Parameter [principals] :
  /// Specifies that you want to list information for only the listed
  /// principals.
  ///
  /// You can include the following values:
  ///
  /// <ul>
  /// <li>
  /// An Amazon Web Services account ID, for example: <code>123456789012</code>
  /// </li>
  /// <li>
  /// An <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of an organization in Organizations, for example:
  /// <code>organizations::123456789012:organization/o-exampleorgid</code>
  /// </li>
  /// <li>
  /// An ARN of an organizational unit (OU) in Organizations, for example:
  /// <code>organizations::123456789012:ou/o-exampleorgid/ou-examplerootid-exampleouid123</code>
  /// </li>
  /// <li>
  /// An ARN of an IAM role, for example:
  /// <code>iam::123456789012:role/rolename</code>
  /// </li>
  /// <li>
  /// An ARN of an IAM user, for example:
  /// <code>iam::123456789012user/username</code>
  /// </li>
  /// </ul> <note>
  /// Not all resource types can be shared with IAM roles and users. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/ram/latest/userguide/permissions.html#permissions-rbp-supported-resource-types">Sharing
  /// with IAM roles and users</a> in the <i>Resource Access Manager User
  /// Guide</i>.
  /// </note>
  ///
  /// Parameter [resourceArn] :
  /// Specifies that you want to list principal information for the resource
  /// share with the specified <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a>.
  ///
  /// Parameter [resourceShareArns] :
  /// Specifies that you want to list information for only principals associated
  /// with the resource shares specified by a list the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resource Names (ARNs)</a>.
  ///
  /// Parameter [resourceType] :
  /// Specifies that you want to list information for only principals associated
  /// with resource shares that include the specified resource type.
  ///
  /// For a list of valid values, query the <a>ListResourceTypes</a> operation.
  Future<ListPrincipalsResponse> listPrincipals({
    required ResourceOwner resourceOwner,
    int? maxResults,
    String? nextToken,
    List<String>? principals,
    String? resourceArn,
    List<String>? resourceShareArns,
    String? resourceType,
  }) async {
    ArgumentError.checkNotNull(resourceOwner, 'resourceOwner');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      500,
    );
    final $payload = <String, dynamic>{
      'resourceOwner': resourceOwner.toValue(),
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
      if (principals != null) 'principals': principals,
      if (resourceArn != null) 'resourceArn': resourceArn,
      if (resourceShareArns != null) 'resourceShareArns': resourceShareArns,
      if (resourceType != null) 'resourceType': resourceType,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/listprincipals',
      exceptionFnMap: _exceptionFns,
    );
    return ListPrincipalsResponse.fromJson(response);
  }

  /// Lists the RAM permissions that are associated with a resource share.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [MalformedArnException].
  /// May throw [UnknownResourceException].
  /// May throw [InvalidNextTokenException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  /// May throw [OperationNotPermittedException].
  ///
  /// Parameter [resourceShareArn] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource share for which you want to
  /// retrieve the associated permissions.
  ///
  /// Parameter [maxResults] :
  /// Specifies the total number of results that you want included on each page
  /// of the response. If you do not include this parameter, it defaults to a
  /// value that is specific to the operation. If additional items exist beyond
  /// the number you specify, the <code>NextToken</code> response element is
  /// returned with a value (not null). Include the specified value as the
  /// <code>NextToken</code> request parameter in the next call to the operation
  /// to get the next part of the results. Note that the service might return
  /// fewer results than the maximum even when there are more results available.
  /// You should check <code>NextToken</code> after every operation to ensure
  /// that you receive all of the results.
  ///
  /// Parameter [nextToken] :
  /// Specifies that you want to receive the next page of results. Valid only if
  /// you received a <code>NextToken</code> response in the previous request. If
  /// you did, it indicates that more output is available. Set this parameter to
  /// the value provided by the previous call's <code>NextToken</code> response
  /// to request the next page of results.
  Future<ListResourceSharePermissionsResponse> listResourceSharePermissions({
    required String resourceShareArn,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(resourceShareArn, 'resourceShareArn');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      500,
    );
    final $payload = <String, dynamic>{
      'resourceShareArn': resourceShareArn,
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/listresourcesharepermissions',
      exceptionFnMap: _exceptionFns,
    );
    return ListResourceSharePermissionsResponse.fromJson(response);
  }

  /// Lists the resource types that can be shared by RAM.
  ///
  /// May throw [InvalidNextTokenException].
  /// May throw [InvalidParameterException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [maxResults] :
  /// Specifies the total number of results that you want included on each page
  /// of the response. If you do not include this parameter, it defaults to a
  /// value that is specific to the operation. If additional items exist beyond
  /// the number you specify, the <code>NextToken</code> response element is
  /// returned with a value (not null). Include the specified value as the
  /// <code>NextToken</code> request parameter in the next call to the operation
  /// to get the next part of the results. Note that the service might return
  /// fewer results than the maximum even when there are more results available.
  /// You should check <code>NextToken</code> after every operation to ensure
  /// that you receive all of the results.
  ///
  /// Parameter [nextToken] :
  /// Specifies that you want to receive the next page of results. Valid only if
  /// you received a <code>NextToken</code> response in the previous request. If
  /// you did, it indicates that more output is available. Set this parameter to
  /// the value provided by the previous call's <code>NextToken</code> response
  /// to request the next page of results.
  ///
  /// Parameter [resourceRegionScope] :
  /// Specifies that you want the results to include only resources that have
  /// the specified scope.
  ///
  /// <ul>
  /// <li>
  /// <code>ALL</code> – the results include both global and regional resources
  /// or resource types.
  /// </li>
  /// <li>
  /// <code>GLOBAL</code> – the results include only global resources or
  /// resource types.
  /// </li>
  /// <li>
  /// <code>REGIONAL</code> – the results include only regional resources or
  /// resource types.
  /// </li>
  /// </ul>
  /// The default value is <code>ALL</code>.
  Future<ListResourceTypesResponse> listResourceTypes({
    int? maxResults,
    String? nextToken,
    ResourceRegionScopeFilter? resourceRegionScope,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      500,
    );
    final $payload = <String, dynamic>{
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
      if (resourceRegionScope != null)
        'resourceRegionScope': resourceRegionScope.toValue(),
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/listresourcetypes',
      exceptionFnMap: _exceptionFns,
    );
    return ListResourceTypesResponse.fromJson(response);
  }

  /// Lists the resources that you added to a resource share or the resources
  /// that are shared with you.
  ///
  /// May throw [InvalidResourceTypeException].
  /// May throw [UnknownResourceException].
  /// May throw [MalformedArnException].
  /// May throw [InvalidNextTokenException].
  /// May throw [InvalidParameterException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [resourceOwner] :
  /// Specifies that you want to list only the resource shares that match the
  /// following:
  ///
  /// <ul>
  /// <li>
  /// <b> <code>SELF</code> </b> – resources that your account shares with other
  /// accounts
  /// </li>
  /// <li>
  /// <b> <code>OTHER-ACCOUNTS</code> </b> – resources that other accounts share
  /// with your account
  /// </li>
  /// </ul>
  ///
  /// Parameter [maxResults] :
  /// Specifies the total number of results that you want included on each page
  /// of the response. If you do not include this parameter, it defaults to a
  /// value that is specific to the operation. If additional items exist beyond
  /// the number you specify, the <code>NextToken</code> response element is
  /// returned with a value (not null). Include the specified value as the
  /// <code>NextToken</code> request parameter in the next call to the operation
  /// to get the next part of the results. Note that the service might return
  /// fewer results than the maximum even when there are more results available.
  /// You should check <code>NextToken</code> after every operation to ensure
  /// that you receive all of the results.
  ///
  /// Parameter [nextToken] :
  /// Specifies that you want to receive the next page of results. Valid only if
  /// you received a <code>NextToken</code> response in the previous request. If
  /// you did, it indicates that more output is available. Set this parameter to
  /// the value provided by the previous call's <code>NextToken</code> response
  /// to request the next page of results.
  ///
  /// Parameter [principal] :
  /// Specifies that you want to list only the resource shares that are
  /// associated with the specified principal.
  ///
  /// Parameter [resourceArns] :
  /// Specifies that you want to list only the resource shares that include
  /// resources with the specified <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resource Names (ARNs)</a>.
  ///
  /// Parameter [resourceRegionScope] :
  /// Specifies that you want the results to include only resources that have
  /// the specified scope.
  ///
  /// <ul>
  /// <li>
  /// <code>ALL</code> – the results include both global and regional resources
  /// or resource types.
  /// </li>
  /// <li>
  /// <code>GLOBAL</code> – the results include only global resources or
  /// resource types.
  /// </li>
  /// <li>
  /// <code>REGIONAL</code> – the results include only regional resources or
  /// resource types.
  /// </li>
  /// </ul>
  /// The default value is <code>ALL</code>.
  ///
  /// Parameter [resourceShareArns] :
  /// Specifies that you want to list only resources in the resource shares
  /// identified by the specified <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resource Names (ARNs)</a>.
  ///
  /// Parameter [resourceType] :
  /// Specifies that you want to list only the resource shares that include
  /// resources of the specified resource type.
  ///
  /// For valid values, query the <a>ListResourceTypes</a> operation.
  Future<ListResourcesResponse> listResources({
    required ResourceOwner resourceOwner,
    int? maxResults,
    String? nextToken,
    String? principal,
    List<String>? resourceArns,
    ResourceRegionScopeFilter? resourceRegionScope,
    List<String>? resourceShareArns,
    String? resourceType,
  }) async {
    ArgumentError.checkNotNull(resourceOwner, 'resourceOwner');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      500,
    );
    final $payload = <String, dynamic>{
      'resourceOwner': resourceOwner.toValue(),
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
      if (principal != null) 'principal': principal,
      if (resourceArns != null) 'resourceArns': resourceArns,
      if (resourceRegionScope != null)
        'resourceRegionScope': resourceRegionScope.toValue(),
      if (resourceShareArns != null) 'resourceShareArns': resourceShareArns,
      if (resourceType != null) 'resourceType': resourceType,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/listresources',
      exceptionFnMap: _exceptionFns,
    );
    return ListResourcesResponse.fromJson(response);
  }

  /// When you attach a resource-based permission policy to a resource, it
  /// automatically creates a resource share. However, resource shares created
  /// this way are visible only to the resource share owner, and the resource
  /// share can't be modified in RAM.
  ///
  /// You can use this operation to promote the resource share to a full RAM
  /// resource share. When you promote a resource share, you can then manage the
  /// resource share in RAM and it becomes visible to all of the principals you
  /// shared it with.
  ///
  /// May throw [MalformedArnException].
  /// May throw [ResourceShareLimitExceededException].
  /// May throw [OperationNotPermittedException].
  /// May throw [InvalidParameterException].
  /// May throw [MissingRequiredParameterException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  /// May throw [UnknownResourceException].
  ///
  /// Parameter [resourceShareArn] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource share to promote.
  Future<PromoteResourceShareCreatedFromPolicyResponse>
      promoteResourceShareCreatedFromPolicy({
    required String resourceShareArn,
  }) async {
    ArgumentError.checkNotNull(resourceShareArn, 'resourceShareArn');
    final $query = <String, List<String>>{
      'resourceShareArn': [resourceShareArn],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'POST',
      requestUri: '/promoteresourcesharecreatedfrompolicy',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return PromoteResourceShareCreatedFromPolicyResponse.fromJson(response);
  }

  /// Rejects an invitation to a resource share from another Amazon Web Services
  /// account.
  ///
  /// May throw [MalformedArnException].
  /// May throw [OperationNotPermittedException].
  /// May throw [ResourceShareInvitationArnNotFoundException].
  /// May throw [ResourceShareInvitationAlreadyAcceptedException].
  /// May throw [ResourceShareInvitationAlreadyRejectedException].
  /// May throw [ResourceShareInvitationExpiredException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  /// May throw [InvalidClientTokenException].
  /// May throw [IdempotentParameterMismatchException].
  ///
  /// Parameter [resourceShareInvitationArn] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the invitation that you want to reject.
  ///
  /// Parameter [clientToken] :
  /// Specifies a unique, case-sensitive identifier that you provide to ensure
  /// the idempotency of the request. This lets you safely retry the request
  /// without accidentally performing the same operation a second time. Passing
  /// the same value to a later call to an operation requires that you also pass
  /// the same value for all other parameters. We recommend that you use a <a
  /// href="https://wikipedia.org/wiki/Universally_unique_identifier">UUID type
  /// of value.</a>.
  ///
  /// If you don't provide this value, then Amazon Web Services generates a
  /// random one for you.
  Future<RejectResourceShareInvitationResponse> rejectResourceShareInvitation({
    required String resourceShareInvitationArn,
    String? clientToken,
  }) async {
    ArgumentError.checkNotNull(
        resourceShareInvitationArn, 'resourceShareInvitationArn');
    final $payload = <String, dynamic>{
      'resourceShareInvitationArn': resourceShareInvitationArn,
      if (clientToken != null) 'clientToken': clientToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/rejectresourceshareinvitation',
      exceptionFnMap: _exceptionFns,
    );
    return RejectResourceShareInvitationResponse.fromJson(response);
  }

  /// Adds the specified tag keys and values to the specified resource share.
  /// The tags are attached only to the resource share, not to the resources
  /// that are in the resource share.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [MalformedArnException].
  /// May throw [UnknownResourceException].
  /// May throw [TagLimitExceededException].
  /// May throw [ResourceArnNotFoundException].
  /// May throw [TagPolicyViolationException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [resourceShareArn] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource share that you want to add tags to.
  ///
  /// Parameter [tags] :
  /// A list of one or more tag key and value pairs. The tag key must be present
  /// and not be an empty string. The tag value must be present but can be an
  /// empty string.
  Future<void> tagResource({
    required String resourceShareArn,
    required List<Tag> tags,
  }) async {
    ArgumentError.checkNotNull(resourceShareArn, 'resourceShareArn');
    ArgumentError.checkNotNull(tags, 'tags');
    final $payload = <String, dynamic>{
      'resourceShareArn': resourceShareArn,
      'tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/tagresource',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Removes the specified tag key and value pairs from the specified resource
  /// share.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [resourceShareArn] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource share that you want to remove tags
  /// from. The tags are removed from the resource share, not the resources in
  /// the resource share.
  ///
  /// Parameter [tagKeys] :
  /// Specifies a list of one or more tag keys that you want to remove.
  Future<void> untagResource({
    required String resourceShareArn,
    required List<String> tagKeys,
  }) async {
    ArgumentError.checkNotNull(resourceShareArn, 'resourceShareArn');
    ArgumentError.checkNotNull(tagKeys, 'tagKeys');
    final $payload = <String, dynamic>{
      'resourceShareArn': resourceShareArn,
      'tagKeys': tagKeys,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/untagresource',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Modifies some of the properties of the specified resource share.
  ///
  /// May throw [IdempotentParameterMismatchException].
  /// May throw [MissingRequiredParameterException].
  /// May throw [UnknownResourceException].
  /// May throw [MalformedArnException].
  /// May throw [InvalidClientTokenException].
  /// May throw [InvalidParameterException].
  /// May throw [OperationNotPermittedException].
  /// May throw [ServerInternalException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [resourceShareArn] :
  /// Specifies the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource share that you want to modify.
  ///
  /// Parameter [allowExternalPrincipals] :
  /// Specifies whether principals outside your organization in Organizations
  /// can be associated with a resource share.
  ///
  /// Parameter [clientToken] :
  /// Specifies a unique, case-sensitive identifier that you provide to ensure
  /// the idempotency of the request. This lets you safely retry the request
  /// without accidentally performing the same operation a second time. Passing
  /// the same value to a later call to an operation requires that you also pass
  /// the same value for all other parameters. We recommend that you use a <a
  /// href="https://wikipedia.org/wiki/Universally_unique_identifier">UUID type
  /// of value.</a>.
  ///
  /// If you don't provide this value, then Amazon Web Services generates a
  /// random one for you.
  ///
  /// Parameter [name] :
  /// If specified, the new name that you want to attach to the resource share.
  Future<UpdateResourceShareResponse> updateResourceShare({
    required String resourceShareArn,
    bool? allowExternalPrincipals,
    String? clientToken,
    String? name,
  }) async {
    ArgumentError.checkNotNull(resourceShareArn, 'resourceShareArn');
    final $payload = <String, dynamic>{
      'resourceShareArn': resourceShareArn,
      if (allowExternalPrincipals != null)
        'allowExternalPrincipals': allowExternalPrincipals,
      if (clientToken != null) 'clientToken': clientToken,
      if (name != null) 'name': name,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/updateresourceshare',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateResourceShareResponse.fromJson(response);
  }
}

class AcceptResourceShareInvitationResponse {
  /// The idempotency identifier associated with this request. If you want to
  /// repeat the same operation in an idempotent manner then you must include this
  /// value in the <code>clientToken</code> request parameter of that later call.
  /// All other parameters must also have the same values that you used in the
  /// first call.
  final String? clientToken;

  /// An object that contains information about the specified invitation.
  final ResourceShareInvitation? resourceShareInvitation;

  AcceptResourceShareInvitationResponse({
    this.clientToken,
    this.resourceShareInvitation,
  });
  factory AcceptResourceShareInvitationResponse.fromJson(
      Map<String, dynamic> json) {
    return AcceptResourceShareInvitationResponse(
      clientToken: json['clientToken'] as String?,
      resourceShareInvitation: json['resourceShareInvitation'] != null
          ? ResourceShareInvitation.fromJson(
              json['resourceShareInvitation'] as Map<String, dynamic>)
          : null,
    );
  }
}

class AssociateResourceSharePermissionResponse {
  /// The idempotency identifier associated with this request. If you want to
  /// repeat the same operation in an idempotent manner then you must include this
  /// value in the <code>clientToken</code> request parameter of that later call.
  /// All other parameters must also have the same values that you used in the
  /// first call.
  final String? clientToken;

  /// A return value of <code>true</code> indicates that the request succeeded. A
  /// value of <code>false</code> indicates that the request failed.
  final bool? returnValue;

  AssociateResourceSharePermissionResponse({
    this.clientToken,
    this.returnValue,
  });
  factory AssociateResourceSharePermissionResponse.fromJson(
      Map<String, dynamic> json) {
    return AssociateResourceSharePermissionResponse(
      clientToken: json['clientToken'] as String?,
      returnValue: json['returnValue'] as bool?,
    );
  }
}

class AssociateResourceShareResponse {
  /// The idempotency identifier associated with this request. If you want to
  /// repeat the same operation in an idempotent manner then you must include this
  /// value in the <code>clientToken</code> request parameter of that later call.
  /// All other parameters must also have the same values that you used in the
  /// first call.
  final String? clientToken;

  /// An array of objects that contain information about the associations.
  final List<ResourceShareAssociation>? resourceShareAssociations;

  AssociateResourceShareResponse({
    this.clientToken,
    this.resourceShareAssociations,
  });
  factory AssociateResourceShareResponse.fromJson(Map<String, dynamic> json) {
    return AssociateResourceShareResponse(
      clientToken: json['clientToken'] as String?,
      resourceShareAssociations: (json['resourceShareAssociations'] as List?)
          ?.whereNotNull()
          .map((e) =>
              ResourceShareAssociation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CreateResourceShareResponse {
  /// The idempotency identifier associated with this request. If you want to
  /// repeat the same operation in an idempotent manner then you must include this
  /// value in the <code>clientToken</code> request parameter of that later call.
  /// All other parameters must also have the same values that you used in the
  /// first call.
  final String? clientToken;

  /// An object with information about the new resource share.
  final ResourceShare? resourceShare;

  CreateResourceShareResponse({
    this.clientToken,
    this.resourceShare,
  });
  factory CreateResourceShareResponse.fromJson(Map<String, dynamic> json) {
    return CreateResourceShareResponse(
      clientToken: json['clientToken'] as String?,
      resourceShare: json['resourceShare'] != null
          ? ResourceShare.fromJson(
              json['resourceShare'] as Map<String, dynamic>)
          : null,
    );
  }
}

class DeleteResourceShareResponse {
  /// The idempotency identifier associated with this request. If you want to
  /// repeat the same operation in an idempotent manner then you must include this
  /// value in the <code>clientToken</code> request parameter of that later call.
  /// All other parameters must also have the same values that you used in the
  /// first call.
  final String? clientToken;

  /// A return value of <code>true</code> indicates that the request succeeded. A
  /// value of <code>false</code> indicates that the request failed.
  final bool? returnValue;

  DeleteResourceShareResponse({
    this.clientToken,
    this.returnValue,
  });
  factory DeleteResourceShareResponse.fromJson(Map<String, dynamic> json) {
    return DeleteResourceShareResponse(
      clientToken: json['clientToken'] as String?,
      returnValue: json['returnValue'] as bool?,
    );
  }
}

class DisassociateResourceSharePermissionResponse {
  /// The idempotency identifier associated with this request. If you want to
  /// repeat the same operation in an idempotent manner then you must include this
  /// value in the <code>clientToken</code> request parameter of that later call.
  /// All other parameters must also have the same values that you used in the
  /// first call.
  final String? clientToken;

  /// A return value of <code>true</code> indicates that the request succeeded. A
  /// value of <code>false</code> indicates that the request failed.
  final bool? returnValue;

  DisassociateResourceSharePermissionResponse({
    this.clientToken,
    this.returnValue,
  });
  factory DisassociateResourceSharePermissionResponse.fromJson(
      Map<String, dynamic> json) {
    return DisassociateResourceSharePermissionResponse(
      clientToken: json['clientToken'] as String?,
      returnValue: json['returnValue'] as bool?,
    );
  }
}

class DisassociateResourceShareResponse {
  /// The idempotency identifier associated with this request. If you want to
  /// repeat the same operation in an idempotent manner then you must include this
  /// value in the <code>clientToken</code> request parameter of that later call.
  /// All other parameters must also have the same values that you used in the
  /// first call.
  final String? clientToken;

  /// An array of objects that contain information about the updated associations
  /// for this resource share.
  final List<ResourceShareAssociation>? resourceShareAssociations;

  DisassociateResourceShareResponse({
    this.clientToken,
    this.resourceShareAssociations,
  });
  factory DisassociateResourceShareResponse.fromJson(
      Map<String, dynamic> json) {
    return DisassociateResourceShareResponse(
      clientToken: json['clientToken'] as String?,
      resourceShareAssociations: (json['resourceShareAssociations'] as List?)
          ?.whereNotNull()
          .map((e) =>
              ResourceShareAssociation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class EnableSharingWithAwsOrganizationResponse {
  /// A return value of <code>true</code> indicates that the request succeeded. A
  /// value of <code>false</code> indicates that the request failed.
  final bool? returnValue;

  EnableSharingWithAwsOrganizationResponse({
    this.returnValue,
  });
  factory EnableSharingWithAwsOrganizationResponse.fromJson(
      Map<String, dynamic> json) {
    return EnableSharingWithAwsOrganizationResponse(
      returnValue: json['returnValue'] as bool?,
    );
  }
}

class GetPermissionResponse {
  /// An object that contains information about the permission.
  final ResourceSharePermissionDetail? permission;

  GetPermissionResponse({
    this.permission,
  });
  factory GetPermissionResponse.fromJson(Map<String, dynamic> json) {
    return GetPermissionResponse(
      permission: json['permission'] != null
          ? ResourceSharePermissionDetail.fromJson(
              json['permission'] as Map<String, dynamic>)
          : null,
    );
  }
}

class GetResourcePoliciesResponse {
  /// If present, this value indicates that more output is available than is
  /// included in the current response. Use this value in the
  /// <code>NextToken</code> request parameter in a subsequent call to the
  /// operation to get the next part of the output. You should repeat this until
  /// the <code>NextToken</code> response element comes back as <code>null</code>.
  /// This indicates that this is the last page of results.
  final String? nextToken;

  /// An array of resource policy documents in JSON format.
  final List<String>? policies;

  GetResourcePoliciesResponse({
    this.nextToken,
    this.policies,
  });
  factory GetResourcePoliciesResponse.fromJson(Map<String, dynamic> json) {
    return GetResourcePoliciesResponse(
      nextToken: json['nextToken'] as String?,
      policies: (json['policies'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }
}

class GetResourceShareAssociationsResponse {
  /// If present, this value indicates that more output is available than is
  /// included in the current response. Use this value in the
  /// <code>NextToken</code> request parameter in a subsequent call to the
  /// operation to get the next part of the output. You should repeat this until
  /// the <code>NextToken</code> response element comes back as <code>null</code>.
  /// This indicates that this is the last page of results.
  final String? nextToken;

  /// An array of objects that contain the details about the associations.
  final List<ResourceShareAssociation>? resourceShareAssociations;

  GetResourceShareAssociationsResponse({
    this.nextToken,
    this.resourceShareAssociations,
  });
  factory GetResourceShareAssociationsResponse.fromJson(
      Map<String, dynamic> json) {
    return GetResourceShareAssociationsResponse(
      nextToken: json['nextToken'] as String?,
      resourceShareAssociations: (json['resourceShareAssociations'] as List?)
          ?.whereNotNull()
          .map((e) =>
              ResourceShareAssociation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GetResourceShareInvitationsResponse {
  /// If present, this value indicates that more output is available than is
  /// included in the current response. Use this value in the
  /// <code>NextToken</code> request parameter in a subsequent call to the
  /// operation to get the next part of the output. You should repeat this until
  /// the <code>NextToken</code> response element comes back as <code>null</code>.
  /// This indicates that this is the last page of results.
  final String? nextToken;

  /// An array of objects that contain the details about the invitations.
  final List<ResourceShareInvitation>? resourceShareInvitations;

  GetResourceShareInvitationsResponse({
    this.nextToken,
    this.resourceShareInvitations,
  });
  factory GetResourceShareInvitationsResponse.fromJson(
      Map<String, dynamic> json) {
    return GetResourceShareInvitationsResponse(
      nextToken: json['nextToken'] as String?,
      resourceShareInvitations: (json['resourceShareInvitations'] as List?)
          ?.whereNotNull()
          .map((e) =>
              ResourceShareInvitation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GetResourceSharesResponse {
  /// If present, this value indicates that more output is available than is
  /// included in the current response. Use this value in the
  /// <code>NextToken</code> request parameter in a subsequent call to the
  /// operation to get the next part of the output. You should repeat this until
  /// the <code>NextToken</code> response element comes back as <code>null</code>.
  /// This indicates that this is the last page of results.
  final String? nextToken;

  /// An array of objects that contain the information about the resource shares.
  final List<ResourceShare>? resourceShares;

  GetResourceSharesResponse({
    this.nextToken,
    this.resourceShares,
  });
  factory GetResourceSharesResponse.fromJson(Map<String, dynamic> json) {
    return GetResourceSharesResponse(
      nextToken: json['nextToken'] as String?,
      resourceShares: (json['resourceShares'] as List?)
          ?.whereNotNull()
          .map((e) => ResourceShare.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListPendingInvitationResourcesResponse {
  /// If present, this value indicates that more output is available than is
  /// included in the current response. Use this value in the
  /// <code>NextToken</code> request parameter in a subsequent call to the
  /// operation to get the next part of the output. You should repeat this until
  /// the <code>NextToken</code> response element comes back as <code>null</code>.
  /// This indicates that this is the last page of results.
  final String? nextToken;

  /// An array of objects that contain the information about the resources
  /// included the specified resource share.
  final List<Resource>? resources;

  ListPendingInvitationResourcesResponse({
    this.nextToken,
    this.resources,
  });
  factory ListPendingInvitationResourcesResponse.fromJson(
      Map<String, dynamic> json) {
    return ListPendingInvitationResourcesResponse(
      nextToken: json['nextToken'] as String?,
      resources: (json['resources'] as List?)
          ?.whereNotNull()
          .map((e) => Resource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListPermissionVersionsResponse {
  /// If present, this value indicates that more output is available than is
  /// included in the current response. Use this value in the
  /// <code>NextToken</code> request parameter in a subsequent call to the
  /// operation to get the next part of the output. You should repeat this until
  /// the <code>NextToken</code> response element comes back as <code>null</code>.
  /// This indicates that this is the last page of results.
  final String? nextToken;

  /// An array of objects that contain details for each of the available versions.
  final List<ResourceSharePermissionSummary>? permissions;

  ListPermissionVersionsResponse({
    this.nextToken,
    this.permissions,
  });
  factory ListPermissionVersionsResponse.fromJson(Map<String, dynamic> json) {
    return ListPermissionVersionsResponse(
      nextToken: json['nextToken'] as String?,
      permissions: (json['permissions'] as List?)
          ?.whereNotNull()
          .map((e) => ResourceSharePermissionSummary.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListPermissionsResponse {
  /// If present, this value indicates that more output is available than is
  /// included in the current response. Use this value in the
  /// <code>NextToken</code> request parameter in a subsequent call to the
  /// operation to get the next part of the output. You should repeat this until
  /// the <code>NextToken</code> response element comes back as <code>null</code>.
  /// This indicates that this is the last page of results.
  final String? nextToken;

  /// An array of objects with information about the permissions.
  final List<ResourceSharePermissionSummary>? permissions;

  ListPermissionsResponse({
    this.nextToken,
    this.permissions,
  });
  factory ListPermissionsResponse.fromJson(Map<String, dynamic> json) {
    return ListPermissionsResponse(
      nextToken: json['nextToken'] as String?,
      permissions: (json['permissions'] as List?)
          ?.whereNotNull()
          .map((e) => ResourceSharePermissionSummary.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListPrincipalsResponse {
  /// If present, this value indicates that more output is available than is
  /// included in the current response. Use this value in the
  /// <code>NextToken</code> request parameter in a subsequent call to the
  /// operation to get the next part of the output. You should repeat this until
  /// the <code>NextToken</code> response element comes back as <code>null</code>.
  /// This indicates that this is the last page of results.
  final String? nextToken;

  /// An array of objects that contain the details about the principals.
  final List<Principal>? principals;

  ListPrincipalsResponse({
    this.nextToken,
    this.principals,
  });
  factory ListPrincipalsResponse.fromJson(Map<String, dynamic> json) {
    return ListPrincipalsResponse(
      nextToken: json['nextToken'] as String?,
      principals: (json['principals'] as List?)
          ?.whereNotNull()
          .map((e) => Principal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListResourceSharePermissionsResponse {
  /// If present, this value indicates that more output is available than is
  /// included in the current response. Use this value in the
  /// <code>NextToken</code> request parameter in a subsequent call to the
  /// operation to get the next part of the output. You should repeat this until
  /// the <code>NextToken</code> response element comes back as <code>null</code>.
  /// This indicates that this is the last page of results.
  final String? nextToken;

  /// An array of objects that describe the permissions associated with the
  /// resource share.
  final List<ResourceSharePermissionSummary>? permissions;

  ListResourceSharePermissionsResponse({
    this.nextToken,
    this.permissions,
  });
  factory ListResourceSharePermissionsResponse.fromJson(
      Map<String, dynamic> json) {
    return ListResourceSharePermissionsResponse(
      nextToken: json['nextToken'] as String?,
      permissions: (json['permissions'] as List?)
          ?.whereNotNull()
          .map((e) => ResourceSharePermissionSummary.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListResourceTypesResponse {
  /// If present, this value indicates that more output is available than is
  /// included in the current response. Use this value in the
  /// <code>NextToken</code> request parameter in a subsequent call to the
  /// operation to get the next part of the output. You should repeat this until
  /// the <code>NextToken</code> response element comes back as <code>null</code>.
  /// This indicates that this is the last page of results.
  final String? nextToken;

  /// An array of objects that contain information about the resource types that
  /// can be shared using RAM.
  final List<ServiceNameAndResourceType>? resourceTypes;

  ListResourceTypesResponse({
    this.nextToken,
    this.resourceTypes,
  });
  factory ListResourceTypesResponse.fromJson(Map<String, dynamic> json) {
    return ListResourceTypesResponse(
      nextToken: json['nextToken'] as String?,
      resourceTypes: (json['resourceTypes'] as List?)
          ?.whereNotNull()
          .map((e) =>
              ServiceNameAndResourceType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListResourcesResponse {
  /// If present, this value indicates that more output is available than is
  /// included in the current response. Use this value in the
  /// <code>NextToken</code> request parameter in a subsequent call to the
  /// operation to get the next part of the output. You should repeat this until
  /// the <code>NextToken</code> response element comes back as <code>null</code>.
  /// This indicates that this is the last page of results.
  final String? nextToken;

  /// An array of objects that contain information about the resources.
  final List<Resource>? resources;

  ListResourcesResponse({
    this.nextToken,
    this.resources,
  });
  factory ListResourcesResponse.fromJson(Map<String, dynamic> json) {
    return ListResourcesResponse(
      nextToken: json['nextToken'] as String?,
      resources: (json['resources'] as List?)
          ?.whereNotNull()
          .map((e) => Resource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Describes a principal for use with Resource Access Manager.
class Principal {
  /// The date and time when the principal was associated with the resource share.
  final DateTime? creationTime;

  /// Indicates whether the principal belongs to the same organization in
  /// Organizations as the Amazon Web Services account that owns the resource
  /// share.
  final bool? external;

  /// The ID of the principal.
  final String? id;

  /// The date and time when the association was last updated.
  final DateTime? lastUpdatedTime;

  /// The <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of a resource share the principal is associated with.
  final String? resourceShareArn;

  Principal({
    this.creationTime,
    this.external,
    this.id,
    this.lastUpdatedTime,
    this.resourceShareArn,
  });
  factory Principal.fromJson(Map<String, dynamic> json) {
    return Principal(
      creationTime: timeStampFromJson(json['creationTime']),
      external: json['external'] as bool?,
      id: json['id'] as String?,
      lastUpdatedTime: timeStampFromJson(json['lastUpdatedTime']),
      resourceShareArn: json['resourceShareArn'] as String?,
    );
  }
}

class PromoteResourceShareCreatedFromPolicyResponse {
  /// A return value of <code>true</code> indicates that the request succeeded. A
  /// value of <code>false</code> indicates that the request failed.
  final bool? returnValue;

  PromoteResourceShareCreatedFromPolicyResponse({
    this.returnValue,
  });
  factory PromoteResourceShareCreatedFromPolicyResponse.fromJson(
      Map<String, dynamic> json) {
    return PromoteResourceShareCreatedFromPolicyResponse(
      returnValue: json['returnValue'] as bool?,
    );
  }
}

class RejectResourceShareInvitationResponse {
  /// The idempotency identifier associated with this request. If you want to
  /// repeat the same operation in an idempotent manner then you must include this
  /// value in the <code>clientToken</code> request parameter of that later call.
  /// All other parameters must also have the same values that you used in the
  /// first call.
  final String? clientToken;

  /// An object that contains the details about the rejected invitation.
  final ResourceShareInvitation? resourceShareInvitation;

  RejectResourceShareInvitationResponse({
    this.clientToken,
    this.resourceShareInvitation,
  });
  factory RejectResourceShareInvitationResponse.fromJson(
      Map<String, dynamic> json) {
    return RejectResourceShareInvitationResponse(
      clientToken: json['clientToken'] as String?,
      resourceShareInvitation: json['resourceShareInvitation'] != null
          ? ResourceShareInvitation.fromJson(
              json['resourceShareInvitation'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Describes a resource associated with a resource share in RAM.
class Resource {
  /// The <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource.
  final String? arn;

  /// The date and time when the resource was associated with the resource share.
  final DateTime? creationTime;

  /// The date an time when the association was last updated.
  final DateTime? lastUpdatedTime;

  /// The <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource group. This value is available only
  /// if the resource is part of a resource group.
  final String? resourceGroupArn;

  /// Specifies the scope of visibility of this resource:
  ///
  /// <ul>
  /// <li>
  /// <b>REGIONAL</b> – The resource can be accessed only by using requests that
  /// target the Amazon Web Services Region in which the resource exists.
  /// </li>
  /// <li>
  /// <b>GLOBAL</b> – The resource can be accessed from any Amazon Web Services
  /// Region.
  /// </li>
  /// </ul>
  final ResourceRegionScope? resourceRegionScope;

  /// The <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource share this resource is associated
  /// with.
  final String? resourceShareArn;

  /// The current status of the resource.
  final ResourceStatus? status;

  /// A message about the status of the resource.
  final String? statusMessage;

  /// The resource type. This takes the form of:
  /// <code>service-code</code>:<code>resource-code</code>
  final String? type;

  Resource({
    this.arn,
    this.creationTime,
    this.lastUpdatedTime,
    this.resourceGroupArn,
    this.resourceRegionScope,
    this.resourceShareArn,
    this.status,
    this.statusMessage,
    this.type,
  });
  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      arn: json['arn'] as String?,
      creationTime: timeStampFromJson(json['creationTime']),
      lastUpdatedTime: timeStampFromJson(json['lastUpdatedTime']),
      resourceGroupArn: json['resourceGroupArn'] as String?,
      resourceRegionScope:
          (json['resourceRegionScope'] as String?)?.toResourceRegionScope(),
      resourceShareArn: json['resourceShareArn'] as String?,
      status: (json['status'] as String?)?.toResourceStatus(),
      statusMessage: json['statusMessage'] as String?,
      type: json['type'] as String?,
    );
  }
}

enum ResourceOwner {
  self,
  otherAccounts,
}

extension on ResourceOwner {
  String toValue() {
    switch (this) {
      case ResourceOwner.self:
        return 'SELF';
      case ResourceOwner.otherAccounts:
        return 'OTHER-ACCOUNTS';
    }
  }
}

extension on String {
  ResourceOwner toResourceOwner() {
    switch (this) {
      case 'SELF':
        return ResourceOwner.self;
      case 'OTHER-ACCOUNTS':
        return ResourceOwner.otherAccounts;
    }
    throw Exception('$this is not known in enum ResourceOwner');
  }
}

enum ResourceRegionScope {
  regional,
  global,
}

extension on ResourceRegionScope {
  String toValue() {
    switch (this) {
      case ResourceRegionScope.regional:
        return 'REGIONAL';
      case ResourceRegionScope.global:
        return 'GLOBAL';
    }
  }
}

extension on String {
  ResourceRegionScope toResourceRegionScope() {
    switch (this) {
      case 'REGIONAL':
        return ResourceRegionScope.regional;
      case 'GLOBAL':
        return ResourceRegionScope.global;
    }
    throw Exception('$this is not known in enum ResourceRegionScope');
  }
}

enum ResourceRegionScopeFilter {
  all,
  regional,
  global,
}

extension on ResourceRegionScopeFilter {
  String toValue() {
    switch (this) {
      case ResourceRegionScopeFilter.all:
        return 'ALL';
      case ResourceRegionScopeFilter.regional:
        return 'REGIONAL';
      case ResourceRegionScopeFilter.global:
        return 'GLOBAL';
    }
  }
}

extension on String {
  ResourceRegionScopeFilter toResourceRegionScopeFilter() {
    switch (this) {
      case 'ALL':
        return ResourceRegionScopeFilter.all;
      case 'REGIONAL':
        return ResourceRegionScopeFilter.regional;
      case 'GLOBAL':
        return ResourceRegionScopeFilter.global;
    }
    throw Exception('$this is not known in enum ResourceRegionScopeFilter');
  }
}

/// Describes a resource share in RAM.
class ResourceShare {
  /// Indicates whether principals outside your organization in Organizations can
  /// be associated with a resource share.
  final bool? allowExternalPrincipals;

  /// The date and time when the resource share was created.
  final DateTime? creationTime;

  /// Indicates how the resource share was created. Possible values include:
  ///
  /// <ul>
  /// <li>
  /// <code>CREATED_FROM_POLICY</code> - Indicates that the resource share was
  /// created from an Identity and Access Management (IAM) resource-based
  /// permission policy attached to the resource. This type of resource share is
  /// visible only to the Amazon Web Services account that created it. You can't
  /// modify it in RAM unless you promote it. For more information, see
  /// <a>PromoteResourceShareCreatedFromPolicy</a>.
  /// </li>
  /// <li>
  /// <code>PROMOTING_TO_STANDARD</code> - The resource share is in the process of
  /// being promoted. For more information, see
  /// <a>PromoteResourceShareCreatedFromPolicy</a>.
  /// </li>
  /// <li>
  /// <code>STANDARD</code> - Indicates that the resource share was created in RAM
  /// using the console or APIs. These resource shares are visible to all
  /// principals you share the resource share with. You can modify these resource
  /// shares in RAM using the console or APIs.
  /// </li>
  /// </ul>
  final ResourceShareFeatureSet? featureSet;

  /// The date and time when the resource share was last updated.
  final DateTime? lastUpdatedTime;

  /// The name of the resource share.
  final String? name;

  /// The ID of the Amazon Web Services account that owns the resource share.
  final String? owningAccountId;

  /// The <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource share
  final String? resourceShareArn;

  /// The current status of the resource share.
  final ResourceShareStatus? status;

  /// A message about the status of the resource share.
  final String? statusMessage;

  /// The tag key and value pairs attached to the resource share.
  final List<Tag>? tags;

  ResourceShare({
    this.allowExternalPrincipals,
    this.creationTime,
    this.featureSet,
    this.lastUpdatedTime,
    this.name,
    this.owningAccountId,
    this.resourceShareArn,
    this.status,
    this.statusMessage,
    this.tags,
  });
  factory ResourceShare.fromJson(Map<String, dynamic> json) {
    return ResourceShare(
      allowExternalPrincipals: json['allowExternalPrincipals'] as bool?,
      creationTime: timeStampFromJson(json['creationTime']),
      featureSet: (json['featureSet'] as String?)?.toResourceShareFeatureSet(),
      lastUpdatedTime: timeStampFromJson(json['lastUpdatedTime']),
      name: json['name'] as String?,
      owningAccountId: json['owningAccountId'] as String?,
      resourceShareArn: json['resourceShareArn'] as String?,
      status: (json['status'] as String?)?.toResourceShareStatus(),
      statusMessage: json['statusMessage'] as String?,
      tags: (json['tags'] as List?)
          ?.whereNotNull()
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Describes an association with a resource share and either a principal or a
/// resource.
class ResourceShareAssociation {
  /// The associated entity. This can be either of the following:
  ///
  /// <ul>
  /// <li>
  /// For a resource association, this is the <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource.
  /// </li>
  /// <li>
  /// For principal associations, this is one of the following:
  ///
  /// <ul>
  /// <li>
  /// The ID of an Amazon Web Services account
  /// </li>
  /// <li>
  /// The <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of an organization in Organizations
  /// </li>
  /// <li>
  /// The ARN of an organizational unit (OU) in Organizations
  /// </li>
  /// <li>
  /// The ARN of an IAM role
  /// </li>
  /// <li>
  /// The ARN of an IAM user
  /// </li>
  /// </ul> </li>
  /// </ul>
  final String? associatedEntity;

  /// The type of entity included in this association.
  final ResourceShareAssociationType? associationType;

  /// The date and time when the association was created.
  final DateTime? creationTime;

  /// Indicates whether the principal belongs to the same organization in
  /// Organizations as the Amazon Web Services account that owns the resource
  /// share.
  final bool? external;

  /// The date and time when the association was last updated.
  final DateTime? lastUpdatedTime;

  /// The <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource share.
  final String? resourceShareArn;

  /// The name of the resource share.
  final String? resourceShareName;

  /// The current status of the association.
  final ResourceShareAssociationStatus? status;

  /// A message about the status of the association.
  final String? statusMessage;

  ResourceShareAssociation({
    this.associatedEntity,
    this.associationType,
    this.creationTime,
    this.external,
    this.lastUpdatedTime,
    this.resourceShareArn,
    this.resourceShareName,
    this.status,
    this.statusMessage,
  });
  factory ResourceShareAssociation.fromJson(Map<String, dynamic> json) {
    return ResourceShareAssociation(
      associatedEntity: json['associatedEntity'] as String?,
      associationType: (json['associationType'] as String?)
          ?.toResourceShareAssociationType(),
      creationTime: timeStampFromJson(json['creationTime']),
      external: json['external'] as bool?,
      lastUpdatedTime: timeStampFromJson(json['lastUpdatedTime']),
      resourceShareArn: json['resourceShareArn'] as String?,
      resourceShareName: json['resourceShareName'] as String?,
      status: (json['status'] as String?)?.toResourceShareAssociationStatus(),
      statusMessage: json['statusMessage'] as String?,
    );
  }
}

enum ResourceShareAssociationStatus {
  associating,
  associated,
  failed,
  disassociating,
  disassociated,
}

extension on ResourceShareAssociationStatus {
  String toValue() {
    switch (this) {
      case ResourceShareAssociationStatus.associating:
        return 'ASSOCIATING';
      case ResourceShareAssociationStatus.associated:
        return 'ASSOCIATED';
      case ResourceShareAssociationStatus.failed:
        return 'FAILED';
      case ResourceShareAssociationStatus.disassociating:
        return 'DISASSOCIATING';
      case ResourceShareAssociationStatus.disassociated:
        return 'DISASSOCIATED';
    }
  }
}

extension on String {
  ResourceShareAssociationStatus toResourceShareAssociationStatus() {
    switch (this) {
      case 'ASSOCIATING':
        return ResourceShareAssociationStatus.associating;
      case 'ASSOCIATED':
        return ResourceShareAssociationStatus.associated;
      case 'FAILED':
        return ResourceShareAssociationStatus.failed;
      case 'DISASSOCIATING':
        return ResourceShareAssociationStatus.disassociating;
      case 'DISASSOCIATED':
        return ResourceShareAssociationStatus.disassociated;
    }
    throw Exception(
        '$this is not known in enum ResourceShareAssociationStatus');
  }
}

enum ResourceShareAssociationType {
  principal,
  resource,
}

extension on ResourceShareAssociationType {
  String toValue() {
    switch (this) {
      case ResourceShareAssociationType.principal:
        return 'PRINCIPAL';
      case ResourceShareAssociationType.resource:
        return 'RESOURCE';
    }
  }
}

extension on String {
  ResourceShareAssociationType toResourceShareAssociationType() {
    switch (this) {
      case 'PRINCIPAL':
        return ResourceShareAssociationType.principal;
      case 'RESOURCE':
        return ResourceShareAssociationType.resource;
    }
    throw Exception('$this is not known in enum ResourceShareAssociationType');
  }
}

enum ResourceShareFeatureSet {
  createdFromPolicy,
  promotingToStandard,
  standard,
}

extension on ResourceShareFeatureSet {
  String toValue() {
    switch (this) {
      case ResourceShareFeatureSet.createdFromPolicy:
        return 'CREATED_FROM_POLICY';
      case ResourceShareFeatureSet.promotingToStandard:
        return 'PROMOTING_TO_STANDARD';
      case ResourceShareFeatureSet.standard:
        return 'STANDARD';
    }
  }
}

extension on String {
  ResourceShareFeatureSet toResourceShareFeatureSet() {
    switch (this) {
      case 'CREATED_FROM_POLICY':
        return ResourceShareFeatureSet.createdFromPolicy;
      case 'PROMOTING_TO_STANDARD':
        return ResourceShareFeatureSet.promotingToStandard;
      case 'STANDARD':
        return ResourceShareFeatureSet.standard;
    }
    throw Exception('$this is not known in enum ResourceShareFeatureSet');
  }
}

/// Describes an invitation for an Amazon Web Services account to join a
/// resource share.
class ResourceShareInvitation {
  /// The date and time when the invitation was sent.
  final DateTime? invitationTimestamp;

  /// The ID of the Amazon Web Services account that received the invitation.
  final String? receiverAccountId;

  /// The <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the IAM user or role that received the invitation.
  final String? receiverArn;

  /// The <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the resource share
  final String? resourceShareArn;

  /// To view the resources associated with a pending resource share invitation,
  /// use <a>ListPendingInvitationResources</a>.
  final List<ResourceShareAssociation>? resourceShareAssociations;

  /// The <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the invitation.
  final String? resourceShareInvitationArn;

  /// The name of the resource share.
  final String? resourceShareName;

  /// The ID of the Amazon Web Services account that sent the invitation.
  final String? senderAccountId;

  /// The current status of the invitation.
  final ResourceShareInvitationStatus? status;

  ResourceShareInvitation({
    this.invitationTimestamp,
    this.receiverAccountId,
    this.receiverArn,
    this.resourceShareArn,
    this.resourceShareAssociations,
    this.resourceShareInvitationArn,
    this.resourceShareName,
    this.senderAccountId,
    this.status,
  });
  factory ResourceShareInvitation.fromJson(Map<String, dynamic> json) {
    return ResourceShareInvitation(
      invitationTimestamp: timeStampFromJson(json['invitationTimestamp']),
      receiverAccountId: json['receiverAccountId'] as String?,
      receiverArn: json['receiverArn'] as String?,
      resourceShareArn: json['resourceShareArn'] as String?,
      resourceShareAssociations: (json['resourceShareAssociations'] as List?)
          ?.whereNotNull()
          .map((e) =>
              ResourceShareAssociation.fromJson(e as Map<String, dynamic>))
          .toList(),
      resourceShareInvitationArn: json['resourceShareInvitationArn'] as String?,
      resourceShareName: json['resourceShareName'] as String?,
      senderAccountId: json['senderAccountId'] as String?,
      status: (json['status'] as String?)?.toResourceShareInvitationStatus(),
    );
  }
}

enum ResourceShareInvitationStatus {
  pending,
  accepted,
  rejected,
  expired,
}

extension on ResourceShareInvitationStatus {
  String toValue() {
    switch (this) {
      case ResourceShareInvitationStatus.pending:
        return 'PENDING';
      case ResourceShareInvitationStatus.accepted:
        return 'ACCEPTED';
      case ResourceShareInvitationStatus.rejected:
        return 'REJECTED';
      case ResourceShareInvitationStatus.expired:
        return 'EXPIRED';
    }
  }
}

extension on String {
  ResourceShareInvitationStatus toResourceShareInvitationStatus() {
    switch (this) {
      case 'PENDING':
        return ResourceShareInvitationStatus.pending;
      case 'ACCEPTED':
        return ResourceShareInvitationStatus.accepted;
      case 'REJECTED':
        return ResourceShareInvitationStatus.rejected;
      case 'EXPIRED':
        return ResourceShareInvitationStatus.expired;
    }
    throw Exception('$this is not known in enum ResourceShareInvitationStatus');
  }
}

/// Information about an RAM permission.
class ResourceSharePermissionDetail {
  /// The <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of this RAM permission.
  final String? arn;

  /// The date and time when the permission was created.
  final DateTime? creationTime;

  /// Specifies whether the version of the permission represented in this
  /// structure is the default version for this permission.
  final bool? defaultVersion;

  /// Specifies whether the version of the permission represented in this
  /// structure is the default version for all resources of this resource type.
  final bool? isResourceTypeDefault;

  /// The date and time when the permission was last updated.
  final DateTime? lastUpdatedTime;

  /// The name of this permission.
  final String? name;

  /// The permission's effect and actions in JSON format. The <code>effect</code>
  /// indicates whether the specified actions are allowed or denied. The
  /// <code>actions</code> list the operations to which the principal is granted
  /// or denied access.
  final String? permission;

  /// The resource type to which this permission applies.
  final String? resourceType;

  /// The version of the permission represented in this structure.
  final String? version;

  ResourceSharePermissionDetail({
    this.arn,
    this.creationTime,
    this.defaultVersion,
    this.isResourceTypeDefault,
    this.lastUpdatedTime,
    this.name,
    this.permission,
    this.resourceType,
    this.version,
  });
  factory ResourceSharePermissionDetail.fromJson(Map<String, dynamic> json) {
    return ResourceSharePermissionDetail(
      arn: json['arn'] as String?,
      creationTime: timeStampFromJson(json['creationTime']),
      defaultVersion: json['defaultVersion'] as bool?,
      isResourceTypeDefault: json['isResourceTypeDefault'] as bool?,
      lastUpdatedTime: timeStampFromJson(json['lastUpdatedTime']),
      name: json['name'] as String?,
      permission: json['permission'] as String?,
      resourceType: json['resourceType'] as String?,
      version: json['version'] as String?,
    );
  }
}

/// Information about an RAM permission that is associated with a resource share
/// and any of its resources of a specified type.
class ResourceSharePermissionSummary {
  /// The <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon
  /// Resoure Name (ARN)</a> of the permission you want information about.
  final String? arn;

  /// The date and time when the permission was created.
  final DateTime? creationTime;

  /// Specifies whether the version of the permission represented in this
  /// structure is the default version for this permission.
  final bool? defaultVersion;

  /// Specifies whether the version of the permission represented in this
  /// structure is the default version for all resources of this resource type.
  final bool? isResourceTypeDefault;

  /// The date and time when the permission was last updated.
  final DateTime? lastUpdatedTime;

  /// The name of this permission.
  final String? name;

  /// The type of resource to which this permission applies.
  final String? resourceType;

  /// The current status of the permission.
  final String? status;

  /// The version of the permission represented in this structure.
  final String? version;

  ResourceSharePermissionSummary({
    this.arn,
    this.creationTime,
    this.defaultVersion,
    this.isResourceTypeDefault,
    this.lastUpdatedTime,
    this.name,
    this.resourceType,
    this.status,
    this.version,
  });
  factory ResourceSharePermissionSummary.fromJson(Map<String, dynamic> json) {
    return ResourceSharePermissionSummary(
      arn: json['arn'] as String?,
      creationTime: timeStampFromJson(json['creationTime']),
      defaultVersion: json['defaultVersion'] as bool?,
      isResourceTypeDefault: json['isResourceTypeDefault'] as bool?,
      lastUpdatedTime: timeStampFromJson(json['lastUpdatedTime']),
      name: json['name'] as String?,
      resourceType: json['resourceType'] as String?,
      status: json['status'] as String?,
      version: json['version'] as String?,
    );
  }
}

enum ResourceShareStatus {
  pending,
  active,
  failed,
  deleting,
  deleted,
}

extension on ResourceShareStatus {
  String toValue() {
    switch (this) {
      case ResourceShareStatus.pending:
        return 'PENDING';
      case ResourceShareStatus.active:
        return 'ACTIVE';
      case ResourceShareStatus.failed:
        return 'FAILED';
      case ResourceShareStatus.deleting:
        return 'DELETING';
      case ResourceShareStatus.deleted:
        return 'DELETED';
    }
  }
}

extension on String {
  ResourceShareStatus toResourceShareStatus() {
    switch (this) {
      case 'PENDING':
        return ResourceShareStatus.pending;
      case 'ACTIVE':
        return ResourceShareStatus.active;
      case 'FAILED':
        return ResourceShareStatus.failed;
      case 'DELETING':
        return ResourceShareStatus.deleting;
      case 'DELETED':
        return ResourceShareStatus.deleted;
    }
    throw Exception('$this is not known in enum ResourceShareStatus');
  }
}

enum ResourceStatus {
  available,
  zonalResourceInaccessible,
  limitExceeded,
  unavailable,
  pending,
}

extension on ResourceStatus {
  String toValue() {
    switch (this) {
      case ResourceStatus.available:
        return 'AVAILABLE';
      case ResourceStatus.zonalResourceInaccessible:
        return 'ZONAL_RESOURCE_INACCESSIBLE';
      case ResourceStatus.limitExceeded:
        return 'LIMIT_EXCEEDED';
      case ResourceStatus.unavailable:
        return 'UNAVAILABLE';
      case ResourceStatus.pending:
        return 'PENDING';
    }
  }
}

extension on String {
  ResourceStatus toResourceStatus() {
    switch (this) {
      case 'AVAILABLE':
        return ResourceStatus.available;
      case 'ZONAL_RESOURCE_INACCESSIBLE':
        return ResourceStatus.zonalResourceInaccessible;
      case 'LIMIT_EXCEEDED':
        return ResourceStatus.limitExceeded;
      case 'UNAVAILABLE':
        return ResourceStatus.unavailable;
      case 'PENDING':
        return ResourceStatus.pending;
    }
    throw Exception('$this is not known in enum ResourceStatus');
  }
}

/// Information about a shareable resource type and the Amazon Web Services
/// service to which resources of that type belong.
class ServiceNameAndResourceType {
  /// Specifies the scope of visibility of resources of this type:
  ///
  /// <ul>
  /// <li>
  /// <b>REGIONAL</b> – The resource can be accessed only by using requests that
  /// target the Amazon Web Services Region in which the resource exists.
  /// </li>
  /// <li>
  /// <b>GLOBAL</b> – The resource can be accessed from any Amazon Web Services
  /// Region.
  /// </li>
  /// </ul>
  final ResourceRegionScope? resourceRegionScope;

  /// The type of the resource.
  final String? resourceType;

  /// The name of the Amazon Web Services service to which resources of this type
  /// belong.
  final String? serviceName;

  ServiceNameAndResourceType({
    this.resourceRegionScope,
    this.resourceType,
    this.serviceName,
  });
  factory ServiceNameAndResourceType.fromJson(Map<String, dynamic> json) {
    return ServiceNameAndResourceType(
      resourceRegionScope:
          (json['resourceRegionScope'] as String?)?.toResourceRegionScope(),
      resourceType: json['resourceType'] as String?,
      serviceName: json['serviceName'] as String?,
    );
  }
}

/// A structure containing a tag. A tag is metadata that you can attach to your
/// resources to help organize and categorize them. You can also use them to
/// help you secure your resources. For more information, see <a
/// href="https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html">Controlling
/// access to Amazon Web Services resources using tags</a>.
///
/// For more information about tags, see <a
/// href="https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html">Tagging
/// Amazon Web Services resources</a> in the <i>Amazon Web Services General
/// Reference Guide</i>.
class Tag {
  /// The key, or name, attached to the tag. Every tag must have a key. Key names
  /// are case sensitive.
  final String? key;

  /// The string value attached to the tag. The value can be an empty string. Key
  /// values are case sensitive.
  final String? value;

  Tag({
    this.key,
    this.value,
  });
  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      key: json['key'] as String?,
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final key = this.key;
    final value = this.value;
    return {
      if (key != null) 'key': key,
      if (value != null) 'value': value,
    };
  }
}

/// A tag key and optional list of possible values that you can use to filter
/// results for tagged resources.
class TagFilter {
  /// The tag key. This must have a valid string value and can't be empty.
  final String? tagKey;

  /// A list of zero or more tag values. If no values are provided, then the
  /// filter matches any tag with the specified key, regardless of its value.
  final List<String>? tagValues;

  TagFilter({
    this.tagKey,
    this.tagValues,
  });
  Map<String, dynamic> toJson() {
    final tagKey = this.tagKey;
    final tagValues = this.tagValues;
    return {
      if (tagKey != null) 'tagKey': tagKey,
      if (tagValues != null) 'tagValues': tagValues,
    };
  }
}

class TagResourceResponse {
  TagResourceResponse();
  factory TagResourceResponse.fromJson(Map<String, dynamic> _) {
    return TagResourceResponse();
  }
}

class UntagResourceResponse {
  UntagResourceResponse();
  factory UntagResourceResponse.fromJson(Map<String, dynamic> _) {
    return UntagResourceResponse();
  }
}

class UpdateResourceShareResponse {
  /// The idempotency identifier associated with this request. If you want to
  /// repeat the same operation in an idempotent manner then you must include this
  /// value in the <code>clientToken</code> request parameter of that later call.
  /// All other parameters must also have the same values that you used in the
  /// first call.
  final String? clientToken;

  /// Information about the resource share.
  final ResourceShare? resourceShare;

  UpdateResourceShareResponse({
    this.clientToken,
    this.resourceShare,
  });
  factory UpdateResourceShareResponse.fromJson(Map<String, dynamic> json) {
    return UpdateResourceShareResponse(
      clientToken: json['clientToken'] as String?,
      resourceShare: json['resourceShare'] != null
          ? ResourceShare.fromJson(
              json['resourceShare'] as Map<String, dynamic>)
          : null,
    );
  }
}

class IdempotentParameterMismatchException extends _s.GenericAwsException {
  IdempotentParameterMismatchException({String? type, String? message})
      : super(
            type: type,
            code: 'IdempotentParameterMismatchException',
            message: message);
}

class InvalidClientTokenException extends _s.GenericAwsException {
  InvalidClientTokenException({String? type, String? message})
      : super(
            type: type, code: 'InvalidClientTokenException', message: message);
}

class InvalidMaxResultsException extends _s.GenericAwsException {
  InvalidMaxResultsException({String? type, String? message})
      : super(type: type, code: 'InvalidMaxResultsException', message: message);
}

class InvalidNextTokenException extends _s.GenericAwsException {
  InvalidNextTokenException({String? type, String? message})
      : super(type: type, code: 'InvalidNextTokenException', message: message);
}

class InvalidParameterException extends _s.GenericAwsException {
  InvalidParameterException({String? type, String? message})
      : super(type: type, code: 'InvalidParameterException', message: message);
}

class InvalidResourceTypeException extends _s.GenericAwsException {
  InvalidResourceTypeException({String? type, String? message})
      : super(
            type: type, code: 'InvalidResourceTypeException', message: message);
}

class InvalidStateTransitionException extends _s.GenericAwsException {
  InvalidStateTransitionException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidStateTransitionException',
            message: message);
}

class MalformedArnException extends _s.GenericAwsException {
  MalformedArnException({String? type, String? message})
      : super(type: type, code: 'MalformedArnException', message: message);
}

class MissingRequiredParameterException extends _s.GenericAwsException {
  MissingRequiredParameterException({String? type, String? message})
      : super(
            type: type,
            code: 'MissingRequiredParameterException',
            message: message);
}

class OperationNotPermittedException extends _s.GenericAwsException {
  OperationNotPermittedException({String? type, String? message})
      : super(
            type: type,
            code: 'OperationNotPermittedException',
            message: message);
}

class ResourceArnNotFoundException extends _s.GenericAwsException {
  ResourceArnNotFoundException({String? type, String? message})
      : super(
            type: type, code: 'ResourceArnNotFoundException', message: message);
}

class ResourceShareInvitationAlreadyAcceptedException
    extends _s.GenericAwsException {
  ResourceShareInvitationAlreadyAcceptedException(
      {String? type, String? message})
      : super(
            type: type,
            code: 'ResourceShareInvitationAlreadyAcceptedException',
            message: message);
}

class ResourceShareInvitationAlreadyRejectedException
    extends _s.GenericAwsException {
  ResourceShareInvitationAlreadyRejectedException(
      {String? type, String? message})
      : super(
            type: type,
            code: 'ResourceShareInvitationAlreadyRejectedException',
            message: message);
}

class ResourceShareInvitationArnNotFoundException
    extends _s.GenericAwsException {
  ResourceShareInvitationArnNotFoundException({String? type, String? message})
      : super(
            type: type,
            code: 'ResourceShareInvitationArnNotFoundException',
            message: message);
}

class ResourceShareInvitationExpiredException extends _s.GenericAwsException {
  ResourceShareInvitationExpiredException({String? type, String? message})
      : super(
            type: type,
            code: 'ResourceShareInvitationExpiredException',
            message: message);
}

class ResourceShareLimitExceededException extends _s.GenericAwsException {
  ResourceShareLimitExceededException({String? type, String? message})
      : super(
            type: type,
            code: 'ResourceShareLimitExceededException',
            message: message);
}

class ServerInternalException extends _s.GenericAwsException {
  ServerInternalException({String? type, String? message})
      : super(type: type, code: 'ServerInternalException', message: message);
}

class ServiceUnavailableException extends _s.GenericAwsException {
  ServiceUnavailableException({String? type, String? message})
      : super(
            type: type, code: 'ServiceUnavailableException', message: message);
}

class TagLimitExceededException extends _s.GenericAwsException {
  TagLimitExceededException({String? type, String? message})
      : super(type: type, code: 'TagLimitExceededException', message: message);
}

class TagPolicyViolationException extends _s.GenericAwsException {
  TagPolicyViolationException({String? type, String? message})
      : super(
            type: type, code: 'TagPolicyViolationException', message: message);
}

class ThrottlingException extends _s.GenericAwsException {
  ThrottlingException({String? type, String? message})
      : super(type: type, code: 'ThrottlingException', message: message);
}

class UnknownResourceException extends _s.GenericAwsException {
  UnknownResourceException({String? type, String? message})
      : super(type: type, code: 'UnknownResourceException', message: message);
}

final _exceptionFns = <String, _s.AwsExceptionFn>{
  'IdempotentParameterMismatchException': (type, message) =>
      IdempotentParameterMismatchException(type: type, message: message),
  'InvalidClientTokenException': (type, message) =>
      InvalidClientTokenException(type: type, message: message),
  'InvalidMaxResultsException': (type, message) =>
      InvalidMaxResultsException(type: type, message: message),
  'InvalidNextTokenException': (type, message) =>
      InvalidNextTokenException(type: type, message: message),
  'InvalidParameterException': (type, message) =>
      InvalidParameterException(type: type, message: message),
  'InvalidResourceTypeException': (type, message) =>
      InvalidResourceTypeException(type: type, message: message),
  'InvalidStateTransitionException': (type, message) =>
      InvalidStateTransitionException(type: type, message: message),
  'MalformedArnException': (type, message) =>
      MalformedArnException(type: type, message: message),
  'MissingRequiredParameterException': (type, message) =>
      MissingRequiredParameterException(type: type, message: message),
  'OperationNotPermittedException': (type, message) =>
      OperationNotPermittedException(type: type, message: message),
  'ResourceArnNotFoundException': (type, message) =>
      ResourceArnNotFoundException(type: type, message: message),
  'ResourceShareInvitationAlreadyAcceptedException': (type, message) =>
      ResourceShareInvitationAlreadyAcceptedException(
          type: type, message: message),
  'ResourceShareInvitationAlreadyRejectedException': (type, message) =>
      ResourceShareInvitationAlreadyRejectedException(
          type: type, message: message),
  'ResourceShareInvitationArnNotFoundException': (type, message) =>
      ResourceShareInvitationArnNotFoundException(type: type, message: message),
  'ResourceShareInvitationExpiredException': (type, message) =>
      ResourceShareInvitationExpiredException(type: type, message: message),
  'ResourceShareLimitExceededException': (type, message) =>
      ResourceShareLimitExceededException(type: type, message: message),
  'ServerInternalException': (type, message) =>
      ServerInternalException(type: type, message: message),
  'ServiceUnavailableException': (type, message) =>
      ServiceUnavailableException(type: type, message: message),
  'TagLimitExceededException': (type, message) =>
      TagLimitExceededException(type: type, message: message),
  'TagPolicyViolationException': (type, message) =>
      TagPolicyViolationException(type: type, message: message),
  'ThrottlingException': (type, message) =>
      ThrottlingException(type: type, message: message),
  'UnknownResourceException': (type, message) =>
      UnknownResourceException(type: type, message: message),
};
