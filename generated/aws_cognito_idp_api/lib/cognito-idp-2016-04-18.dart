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

/// Using the Amazon Cognito user pools API, you can create a user pool to
/// manage directories and users. You can authenticate a user to obtain tokens
/// related to user identity and access policies.
///
/// This API reference provides information about user pools in Amazon Cognito
/// user pools.
///
/// For more information, see the <a
/// href="https://docs.aws.amazon.com/cognito/latest/developerguide/what-is-amazon-cognito.html">Amazon
/// Cognito Documentation</a>.
class CognitoIdentityProvider {
  final _s.JsonProtocol _protocol;
  CognitoIdentityProvider({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.AwsClientCredentialsProvider? credentialsProvider,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.JsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'cognito-idp',
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

  /// Adds additional user attributes to the user pool schema.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserImportInProgressException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [customAttributes] :
  /// An array of custom attributes, such as Mutable and Name.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool where you want to add custom
  /// attributes.
  Future<void> addCustomAttributes({
    required List<SchemaAttributeType> customAttributes,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(customAttributes, 'customAttributes');
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AddCustomAttributes'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'CustomAttributes': customAttributes,
        'UserPoolId': userPoolId,
      },
    );
  }

  /// Adds the specified user to the specified group.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [groupName] :
  /// The group name.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool.
  ///
  /// Parameter [username] :
  /// The username for the user.
  Future<void> adminAddUserToGroup({
    required String groupName,
    required String userPoolId,
    required String username,
  }) async {
    ArgumentError.checkNotNull(groupName, 'groupName');
    _s.validateStringLength(
      'groupName',
      groupName,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AdminAddUserToGroup'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'GroupName': groupName,
        'UserPoolId': userPoolId,
        'Username': username,
      },
    );
  }

  /// Confirms user registration as an admin without using a confirmation code.
  /// Works on any user.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [UnexpectedLambdaException].
  /// May throw [UserLambdaValidationException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyFailedAttemptsException].
  /// May throw [InvalidLambdaResponseException].
  /// May throw [TooManyRequestsException].
  /// May throw [LimitExceededException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for which you want to confirm user registration.
  ///
  /// Parameter [username] :
  /// The user name for which you want to confirm user registration.
  ///
  /// Parameter [clientMetadata] :
  /// A map of custom key-value pairs that you can provide as input for any
  /// custom workflows that this action triggers.
  ///
  /// If your user pool configuration includes triggers, the AdminConfirmSignUp
  /// API action invokes the Lambda function that is specified for the <i>post
  /// confirmation</i> trigger. When Amazon Cognito invokes this function, it
  /// passes a JSON payload, which the function receives as input. In this
  /// payload, the <code>clientMetadata</code> attribute provides the data that
  /// you assigned to the ClientMetadata parameter in your AdminConfirmSignUp
  /// request. In your function code in Lambda, you can process the
  /// ClientMetadata value to enhance your workflow for your specific needs.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html">
  /// Customizing user pool Workflows with Lambda Triggers</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// <note>
  /// When you use the ClientMetadata parameter, remember that Amazon Cognito
  /// won't do the following:
  ///
  /// <ul>
  /// <li>
  /// Store the ClientMetadata value. This data is available only to Lambda
  /// triggers that are assigned to a user pool to support custom workflows. If
  /// your user pool configuration doesn't include triggers, the ClientMetadata
  /// parameter serves no purpose.
  /// </li>
  /// <li>
  /// Validate the ClientMetadata value.
  /// </li>
  /// <li>
  /// Encrypt the ClientMetadata value. Don't use Amazon Cognito to provide
  /// sensitive information.
  /// </li>
  /// </ul> </note>
  Future<void> adminConfirmSignUp({
    required String userPoolId,
    required String username,
    Map<String, String>? clientMetadata,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AdminConfirmSignUp'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        'Username': username,
        if (clientMetadata != null) 'ClientMetadata': clientMetadata,
      },
    );
  }

  /// Creates a new user in the specified user pool.
  ///
  /// If <code>MessageAction</code> isn't set, the default is to send a welcome
  /// message via email or phone (SMS).
  /// <note>
  /// This action might generate an SMS text message. Starting June 1, 2021, US
  /// telecom carriers require you to register an origination phone number
  /// before you can send SMS messages to US phone numbers. If you use SMS text
  /// messages in Amazon Cognito, you must register a phone number with <a
  /// href="https://console.aws.amazon.com/pinpoint/home/">Amazon Pinpoint</a>.
  /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
  /// Cognito users who must receive SMS messages might not be able to sign up,
  /// activate their accounts, or sign in.
  ///
  /// If you have never used SMS text messages with Amazon Cognito or any other
  /// Amazon Web Service, Amazon Simple Notification Service might place your
  /// account in the SMS sandbox. In <i> <a
  /// href="https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html">sandbox
  /// mode</a> </i>, you can send messages only to verified phone numbers. After
  /// you test your app while in the sandbox environment, you can move out of
  /// the sandbox and into production. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-sms-userpool-settings.html">
  /// SMS message settings for Amazon Cognito user pools</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// </note>
  /// This message is based on a template that you configured in your call to
  /// create or update a user pool. This template includes your custom sign-up
  /// instructions and placeholders for user name and temporary password.
  ///
  /// Alternatively, you can call <code>AdminCreateUser</code> with
  /// <code>SUPPRESS</code> for the <code>MessageAction</code> parameter, and
  /// Amazon Cognito won't send any email.
  ///
  /// In either case, the user will be in the <code>FORCE_CHANGE_PASSWORD</code>
  /// state until they sign in and change their password.
  ///
  /// <code>AdminCreateUser</code> requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [UserNotFoundException].
  /// May throw [UsernameExistsException].
  /// May throw [InvalidPasswordException].
  /// May throw [CodeDeliveryFailureException].
  /// May throw [UnexpectedLambdaException].
  /// May throw [UserLambdaValidationException].
  /// May throw [InvalidLambdaResponseException].
  /// May throw [PreconditionNotMetException].
  /// May throw [InvalidSmsRoleAccessPolicyException].
  /// May throw [InvalidSmsRoleTrustRelationshipException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UnsupportedUserStateException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool where the user will be created.
  ///
  /// Parameter [username] :
  /// The username for the user. Must be unique within the user pool. Must be a
  /// UTF-8 string between 1 and 128 characters. After the user is created, the
  /// username can't be changed.
  ///
  /// Parameter [clientMetadata] :
  /// A map of custom key-value pairs that you can provide as input for any
  /// custom workflows that this action triggers.
  ///
  /// You create custom workflows by assigning Lambda functions to user pool
  /// triggers. When you use the AdminCreateUser API action, Amazon Cognito
  /// invokes the function that is assigned to the <i>pre sign-up</i> trigger.
  /// When Amazon Cognito invokes this function, it passes a JSON payload, which
  /// the function receives as input. This payload contains a
  /// <code>clientMetadata</code> attribute, which provides the data that you
  /// assigned to the ClientMetadata parameter in your AdminCreateUser request.
  /// In your function code in Lambda, you can process the
  /// <code>clientMetadata</code> value to enhance your workflow for your
  /// specific needs.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html">
  /// Customizing user pool Workflows with Lambda Triggers</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// <note>
  /// When you use the ClientMetadata parameter, remember that Amazon Cognito
  /// won't do the following:
  ///
  /// <ul>
  /// <li>
  /// Store the ClientMetadata value. This data is available only to Lambda
  /// triggers that are assigned to a user pool to support custom workflows. If
  /// your user pool configuration doesn't include triggers, the ClientMetadata
  /// parameter serves no purpose.
  /// </li>
  /// <li>
  /// Validate the ClientMetadata value.
  /// </li>
  /// <li>
  /// Encrypt the ClientMetadata value. Don't use Amazon Cognito to provide
  /// sensitive information.
  /// </li>
  /// </ul> </note>
  ///
  /// Parameter [desiredDeliveryMediums] :
  /// Specify <code>"EMAIL"</code> if email will be used to send the welcome
  /// message. Specify <code>"SMS"</code> if the phone number will be used. The
  /// default value is <code>"SMS"</code>. You can specify more than one value.
  ///
  /// Parameter [forceAliasCreation] :
  /// This parameter is used only if the <code>phone_number_verified</code> or
  /// <code>email_verified</code> attribute is set to <code>True</code>.
  /// Otherwise, it is ignored.
  ///
  /// If this parameter is set to <code>True</code> and the phone number or
  /// email address specified in the UserAttributes parameter already exists as
  /// an alias with a different user, the API call will migrate the alias from
  /// the previous user to the newly created user. The previous user will no
  /// longer be able to log in using that alias.
  ///
  /// If this parameter is set to <code>False</code>, the API throws an
  /// <code>AliasExistsException</code> error if the alias already exists. The
  /// default value is <code>False</code>.
  ///
  /// Parameter [messageAction] :
  /// Set to <code>RESEND</code> to resend the invitation message to a user that
  /// already exists and reset the expiration limit on the user's account. Set
  /// to <code>SUPPRESS</code> to suppress sending the message. You can specify
  /// only one value.
  ///
  /// Parameter [temporaryPassword] :
  /// The user's temporary password. This password must conform to the password
  /// policy that you specified when you created the user pool.
  ///
  /// The temporary password is valid only once. To complete the Admin Create
  /// User flow, the user must enter the temporary password in the sign-in page,
  /// along with a new password to be used in all future sign-ins.
  ///
  /// This parameter isn't required. If you don't specify a value, Amazon
  /// Cognito generates one for you.
  ///
  /// The temporary password can only be used until the user account expiration
  /// limit that you specified when you created the user pool. To reset the
  /// account after that time limit, you must call <code>AdminCreateUser</code>
  /// again, specifying <code>"RESEND"</code> for the <code>MessageAction</code>
  /// parameter.
  ///
  /// Parameter [userAttributes] :
  /// An array of name-value pairs that contain user attributes and attribute
  /// values to be set for the user to be created. You can create a user without
  /// specifying any attributes other than <code>Username</code>. However, any
  /// attributes that you specify as required (when creating a user pool or in
  /// the <b>Attributes</b> tab of the console) either you should supply (in
  /// your call to <code>AdminCreateUser</code>) or the user should supply (when
  /// they sign up in response to your welcome message).
  ///
  /// For custom attributes, you must prepend the <code>custom:</code> prefix to
  /// the attribute name.
  ///
  /// To send a message inviting the user to sign up, you must specify the
  /// user's email address or phone number. You can do this in your call to
  /// AdminCreateUser or in the <b>Users</b> tab of the Amazon Cognito console
  /// for managing your user pools.
  ///
  /// In your call to <code>AdminCreateUser</code>, you can set the
  /// <code>email_verified</code> attribute to <code>True</code>, and you can
  /// set the <code>phone_number_verified</code> attribute to <code>True</code>.
  /// You can also do this by calling <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AdminUpdateUserAttributes.html">AdminUpdateUserAttributes</a>.
  ///
  /// <ul>
  /// <li>
  /// <b>email</b>: The email address of the user to whom the message that
  /// contains the code and username will be sent. Required if the
  /// <code>email_verified</code> attribute is set to <code>True</code>, or if
  /// <code>"EMAIL"</code> is specified in the
  /// <code>DesiredDeliveryMediums</code> parameter.
  /// </li>
  /// <li>
  /// <b>phone_number</b>: The phone number of the user to whom the message that
  /// contains the code and username will be sent. Required if the
  /// <code>phone_number_verified</code> attribute is set to <code>True</code>,
  /// or if <code>"SMS"</code> is specified in the
  /// <code>DesiredDeliveryMediums</code> parameter.
  /// </li>
  /// </ul>
  ///
  /// Parameter [validationData] :
  /// The user's validation data. This is an array of name-value pairs that
  /// contain user attributes and attribute values that you can use for custom
  /// validation, such as restricting the types of user accounts that can be
  /// registered. For example, you might choose to allow or disallow user
  /// sign-up based on the user's domain.
  ///
  /// To configure custom validation, you must create a Pre Sign-up Lambda
  /// trigger for the user pool as described in the Amazon Cognito Developer
  /// Guide. The Lambda trigger receives the validation data and uses it in the
  /// validation process.
  ///
  /// The user's validation data isn't persisted.
  Future<AdminCreateUserResponse> adminCreateUser({
    required String userPoolId,
    required String username,
    Map<String, String>? clientMetadata,
    List<DeliveryMediumType>? desiredDeliveryMediums,
    bool? forceAliasCreation,
    MessageActionType? messageAction,
    String? temporaryPassword,
    List<AttributeType>? userAttributes,
    List<AttributeType>? validationData,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringLength(
      'temporaryPassword',
      temporaryPassword,
      0,
      256,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AdminCreateUser'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        'Username': username,
        if (clientMetadata != null) 'ClientMetadata': clientMetadata,
        if (desiredDeliveryMediums != null)
          'DesiredDeliveryMediums':
              desiredDeliveryMediums.map((e) => e.toValue()).toList(),
        if (forceAliasCreation != null)
          'ForceAliasCreation': forceAliasCreation,
        if (messageAction != null) 'MessageAction': messageAction.toValue(),
        if (temporaryPassword != null) 'TemporaryPassword': temporaryPassword,
        if (userAttributes != null) 'UserAttributes': userAttributes,
        if (validationData != null) 'ValidationData': validationData,
      },
    );

    return AdminCreateUserResponse.fromJson(jsonResponse.body);
  }

  /// Deletes a user as an administrator. Works on any user.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool where you want to delete the user.
  ///
  /// Parameter [username] :
  /// The user name of the user you want to delete.
  Future<void> adminDeleteUser({
    required String userPoolId,
    required String username,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AdminDeleteUser'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        'Username': username,
      },
    );
  }

  /// Deletes the user attributes in a user pool as an administrator. Works on
  /// any user.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userAttributeNames] :
  /// An array of strings representing the user attribute names you want to
  /// delete.
  ///
  /// For custom attributes, you must prepend the <code>custom:</code> prefix to
  /// the attribute name.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool where you want to delete user
  /// attributes.
  ///
  /// Parameter [username] :
  /// The user name of the user from which you would like to delete attributes.
  Future<void> adminDeleteUserAttributes({
    required List<String> userAttributeNames,
    required String userPoolId,
    required String username,
  }) async {
    ArgumentError.checkNotNull(userAttributeNames, 'userAttributeNames');
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSCognitoIdentityProviderService.AdminDeleteUserAttributes'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserAttributeNames': userAttributeNames,
        'UserPoolId': userPoolId,
        'Username': username,
      },
    );
  }

  /// Prevents the user from signing in with the specified external (SAML or
  /// social) identity provider (IdP). If the user that you want to deactivate
  /// is a Amazon Cognito user pools native username + password user, they can't
  /// use their password to sign in. If the user to deactivate is a linked
  /// external IdP user, any link between that user and an existing user is
  /// removed. When the external user signs in again, and the user is no longer
  /// attached to the previously linked <code>DestinationUser</code>, the user
  /// must create a new user account. See <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AdminLinkProviderForUser.html">AdminLinkProviderForUser</a>.
  ///
  /// This action is enabled only for admin access and requires developer
  /// credentials.
  ///
  /// The <code>ProviderName</code> must match the value specified when creating
  /// an IdP for the pool.
  ///
  /// To deactivate a native username + password user, the
  /// <code>ProviderName</code> value must be <code>Cognito</code> and the
  /// <code>ProviderAttributeName</code> must be <code>Cognito_Subject</code>.
  /// The <code>ProviderAttributeValue</code> must be the name that is used in
  /// the user pool for the user.
  ///
  /// The <code>ProviderAttributeName</code> must always be
  /// <code>Cognito_Subject</code> for social IdPs. The
  /// <code>ProviderAttributeValue</code> must always be the exact subject that
  /// was used when the user was originally linked as a source user.
  ///
  /// For de-linking a SAML identity, there are two scenarios. If the linked
  /// identity has not yet been used to sign in, the
  /// <code>ProviderAttributeName</code> and <code>ProviderAttributeValue</code>
  /// must be the same values that were used for the <code>SourceUser</code>
  /// when the identities were originally linked using <code>
  /// AdminLinkProviderForUser</code> call. (If the linking was done with
  /// <code>ProviderAttributeName</code> set to <code>Cognito_Subject</code>,
  /// the same applies here). However, if the user has already signed in, the
  /// <code>ProviderAttributeName</code> must be <code>Cognito_Subject</code>
  /// and <code>ProviderAttributeValue</code> must be the subject of the SAML
  /// assertion.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [AliasExistsException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [user] :
  /// The user to be disabled.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool.
  Future<void> adminDisableProviderForUser({
    required ProviderUserIdentifierType user,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(user, 'user');
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSCognitoIdentityProviderService.AdminDisableProviderForUser'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'User': user,
        'UserPoolId': userPoolId,
      },
    );
  }

  /// Disables the specified user.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool where you want to disable the user.
  ///
  /// Parameter [username] :
  /// The user name of the user you want to disable.
  Future<void> adminDisableUser({
    required String userPoolId,
    required String username,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AdminDisableUser'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        'Username': username,
      },
    );
  }

  /// Enables the specified user as an administrator. Works on any user.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool where you want to enable the user.
  ///
  /// Parameter [username] :
  /// The user name of the user you want to enable.
  Future<void> adminEnableUser({
    required String userPoolId,
    required String username,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AdminEnableUser'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        'Username': username,
      },
    );
  }

  /// Forgets the device, as an administrator.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [InvalidUserPoolConfigurationException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [deviceKey] :
  /// The device key.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  ///
  /// Parameter [username] :
  /// The user name.
  Future<void> adminForgetDevice({
    required String deviceKey,
    required String userPoolId,
    required String username,
  }) async {
    ArgumentError.checkNotNull(deviceKey, 'deviceKey');
    _s.validateStringLength(
      'deviceKey',
      deviceKey,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AdminForgetDevice'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'DeviceKey': deviceKey,
        'UserPoolId': userPoolId,
        'Username': username,
      },
    );
  }

  /// Gets the device, as an administrator.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [InvalidUserPoolConfigurationException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  /// May throw [NotAuthorizedException].
  ///
  /// Parameter [deviceKey] :
  /// The device key.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  ///
  /// Parameter [username] :
  /// The user name.
  Future<AdminGetDeviceResponse> adminGetDevice({
    required String deviceKey,
    required String userPoolId,
    required String username,
  }) async {
    ArgumentError.checkNotNull(deviceKey, 'deviceKey');
    _s.validateStringLength(
      'deviceKey',
      deviceKey,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AdminGetDevice'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'DeviceKey': deviceKey,
        'UserPoolId': userPoolId,
        'Username': username,
      },
    );

    return AdminGetDeviceResponse.fromJson(jsonResponse.body);
  }

  /// Gets the specified user by user name in a user pool as an administrator.
  /// Works on any user.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool where you want to get information about
  /// the user.
  ///
  /// Parameter [username] :
  /// The user name of the user you want to retrieve.
  Future<AdminGetUserResponse> adminGetUser({
    required String userPoolId,
    required String username,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AdminGetUser'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        'Username': username,
      },
    );

    return AdminGetUserResponse.fromJson(jsonResponse.body);
  }

  /// Initiates the authentication flow, as an administrator.
  /// <note>
  /// This action might generate an SMS text message. Starting June 1, 2021, US
  /// telecom carriers require you to register an origination phone number
  /// before you can send SMS messages to US phone numbers. If you use SMS text
  /// messages in Amazon Cognito, you must register a phone number with <a
  /// href="https://console.aws.amazon.com/pinpoint/home/">Amazon Pinpoint</a>.
  /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
  /// Cognito users who must receive SMS messages might not be able to sign up,
  /// activate their accounts, or sign in.
  ///
  /// If you have never used SMS text messages with Amazon Cognito or any other
  /// Amazon Web Service, Amazon Simple Notification Service might place your
  /// account in the SMS sandbox. In <i> <a
  /// href="https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html">sandbox
  /// mode</a> </i>, you can send messages only to verified phone numbers. After
  /// you test your app while in the sandbox environment, you can move out of
  /// the sandbox and into production. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-sms-userpool-settings.html">
  /// SMS message settings for Amazon Cognito user pools</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// </note>
  /// Calling this action requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  /// May throw [UnexpectedLambdaException].
  /// May throw [InvalidUserPoolConfigurationException].
  /// May throw [UserLambdaValidationException].
  /// May throw [InvalidLambdaResponseException].
  /// May throw [MFAMethodNotFoundException].
  /// May throw [InvalidSmsRoleAccessPolicyException].
  /// May throw [InvalidSmsRoleTrustRelationshipException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  ///
  /// Parameter [authFlow] :
  /// The authentication flow for this call to run. The API action will depend
  /// on this value. For example:
  ///
  /// <ul>
  /// <li>
  /// <code>REFRESH_TOKEN_AUTH</code> will take in a valid refresh token and
  /// return new tokens.
  /// </li>
  /// <li>
  /// <code>USER_SRP_AUTH</code> will take in <code>USERNAME</code> and
  /// <code>SRP_A</code> and return the Secure Remote Password (SRP) protocol
  /// variables to be used for next challenge execution.
  /// </li>
  /// <li>
  /// <code>ADMIN_USER_PASSWORD_AUTH</code> will take in <code>USERNAME</code>
  /// and <code>PASSWORD</code> and return the next challenge or tokens.
  /// </li>
  /// </ul>
  /// Valid values include:
  ///
  /// <ul>
  /// <li>
  /// <code>USER_SRP_AUTH</code>: Authentication flow for the Secure Remote
  /// Password (SRP) protocol.
  /// </li>
  /// <li>
  /// <code>REFRESH_TOKEN_AUTH</code>/<code>REFRESH_TOKEN</code>: Authentication
  /// flow for refreshing the access token and ID token by supplying a valid
  /// refresh token.
  /// </li>
  /// <li>
  /// <code>CUSTOM_AUTH</code>: Custom authentication flow.
  /// </li>
  /// <li>
  /// <code>ADMIN_NO_SRP_AUTH</code>: Non-SRP authentication flow; you can pass
  /// in the USERNAME and PASSWORD directly if the flow is enabled for calling
  /// the app client.
  /// </li>
  /// <li>
  /// <code>ADMIN_USER_PASSWORD_AUTH</code>: Admin-based user password
  /// authentication. This replaces the <code>ADMIN_NO_SRP_AUTH</code>
  /// authentication flow. In this flow, Amazon Cognito receives the password in
  /// the request instead of using the SRP process to verify passwords.
  /// </li>
  /// </ul>
  ///
  /// Parameter [clientId] :
  /// The app client ID.
  ///
  /// Parameter [userPoolId] :
  /// The ID of the Amazon Cognito user pool.
  ///
  /// Parameter [analyticsMetadata] :
  /// The analytics metadata for collecting Amazon Pinpoint metrics for
  /// <code>AdminInitiateAuth</code> calls.
  ///
  /// Parameter [authParameters] :
  /// The authentication parameters. These are inputs corresponding to the
  /// <code>AuthFlow</code> that you're invoking. The required values depend on
  /// the value of <code>AuthFlow</code>:
  ///
  /// <ul>
  /// <li>
  /// For <code>USER_SRP_AUTH</code>: <code>USERNAME</code> (required),
  /// <code>SRP_A</code> (required), <code>SECRET_HASH</code> (required if the
  /// app client is configured with a client secret), <code>DEVICE_KEY</code>.
  /// </li>
  /// <li>
  /// For <code>REFRESH_TOKEN_AUTH/REFRESH_TOKEN</code>:
  /// <code>REFRESH_TOKEN</code> (required), <code>SECRET_HASH</code> (required
  /// if the app client is configured with a client secret),
  /// <code>DEVICE_KEY</code>.
  /// </li>
  /// <li>
  /// For <code>ADMIN_NO_SRP_AUTH</code>: <code>USERNAME</code> (required),
  /// <code>SECRET_HASH</code> (if app client is configured with client secret),
  /// <code>PASSWORD</code> (required), <code>DEVICE_KEY</code>.
  /// </li>
  /// <li>
  /// For <code>CUSTOM_AUTH</code>: <code>USERNAME</code> (required),
  /// <code>SECRET_HASH</code> (if app client is configured with client secret),
  /// <code>DEVICE_KEY</code>. To start the authentication flow with password
  /// verification, include <code>ChallengeName: SRP_A</code> and <code>SRP_A:
  /// (The SRP_A Value)</code>.
  /// </li>
  /// </ul>
  ///
  /// Parameter [clientMetadata] :
  /// A map of custom key-value pairs that you can provide as input for certain
  /// custom workflows that this action triggers.
  ///
  /// You create custom workflows by assigning Lambda functions to user pool
  /// triggers. When you use the AdminInitiateAuth API action, Amazon Cognito
  /// invokes the Lambda functions that are specified for various triggers. The
  /// ClientMetadata value is passed as input to the functions for only the
  /// following triggers:
  ///
  /// <ul>
  /// <li>
  /// Pre signup
  /// </li>
  /// <li>
  /// Pre authentication
  /// </li>
  /// <li>
  /// User migration
  /// </li>
  /// </ul>
  /// When Amazon Cognito invokes the functions for these triggers, it passes a
  /// JSON payload, which the function receives as input. This payload contains
  /// a <code>validationData</code> attribute, which provides the data that you
  /// assigned to the ClientMetadata parameter in your AdminInitiateAuth
  /// request. In your function code in Lambda, you can process the
  /// <code>validationData</code> value to enhance your workflow for your
  /// specific needs.
  ///
  /// When you use the AdminInitiateAuth API action, Amazon Cognito also invokes
  /// the functions for the following triggers, but it doesn't provide the
  /// ClientMetadata value as input:
  ///
  /// <ul>
  /// <li>
  /// Post authentication
  /// </li>
  /// <li>
  /// Custom message
  /// </li>
  /// <li>
  /// Pre token generation
  /// </li>
  /// <li>
  /// Create auth challenge
  /// </li>
  /// <li>
  /// Define auth challenge
  /// </li>
  /// <li>
  /// Verify auth challenge
  /// </li>
  /// </ul>
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html">
  /// Customizing user pool Workflows with Lambda Triggers</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// <note>
  /// When you use the ClientMetadata parameter, remember that Amazon Cognito
  /// won't do the following:
  ///
  /// <ul>
  /// <li>
  /// Store the ClientMetadata value. This data is available only to Lambda
  /// triggers that are assigned to a user pool to support custom workflows. If
  /// your user pool configuration doesn't include triggers, the ClientMetadata
  /// parameter serves no purpose.
  /// </li>
  /// <li>
  /// Validate the ClientMetadata value.
  /// </li>
  /// <li>
  /// Encrypt the ClientMetadata value. Don't use Amazon Cognito to provide
  /// sensitive information.
  /// </li>
  /// </ul> </note>
  ///
  /// Parameter [contextData] :
  /// Contextual data about your user session, such as the device fingerprint,
  /// IP address, or location. Amazon Cognito advanced security evaluates the
  /// risk of an authentication event based on the context that your app
  /// generates and passes to Amazon Cognito when it makes API requests.
  Future<AdminInitiateAuthResponse> adminInitiateAuth({
    required AuthFlowType authFlow,
    required String clientId,
    required String userPoolId,
    AnalyticsMetadataType? analyticsMetadata,
    Map<String, String>? authParameters,
    Map<String, String>? clientMetadata,
    ContextDataType? contextData,
  }) async {
    ArgumentError.checkNotNull(authFlow, 'authFlow');
    ArgumentError.checkNotNull(clientId, 'clientId');
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AdminInitiateAuth'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AuthFlow': authFlow.toValue(),
        'ClientId': clientId,
        'UserPoolId': userPoolId,
        if (analyticsMetadata != null) 'AnalyticsMetadata': analyticsMetadata,
        if (authParameters != null) 'AuthParameters': authParameters,
        if (clientMetadata != null) 'ClientMetadata': clientMetadata,
        if (contextData != null) 'ContextData': contextData,
      },
    );

    return AdminInitiateAuthResponse.fromJson(jsonResponse.body);
  }

  /// Links an existing user account in a user pool
  /// (<code>DestinationUser</code>) to an identity from an external IdP
  /// (<code>SourceUser</code>) based on a specified attribute name and value
  /// from the external IdP. This allows you to create a link from the existing
  /// user account to an external federated user identity that has not yet been
  /// used to sign in. You can then use the federated user identity to sign in
  /// as the existing user account.
  ///
  /// For example, if there is an existing user with a username and password,
  /// this API links that user to a federated user identity. When the user signs
  /// in with a federated user identity, they sign in as the existing user
  /// account.
  /// <note>
  /// The maximum number of federated identities linked to a user is five.
  /// </note> <important>
  /// Because this API allows a user with an external federated identity to sign
  /// in as an existing user in the user pool, it is critical that it only be
  /// used with external IdPs and provider attributes that have been trusted by
  /// the application owner.
  /// </important>
  /// This action is administrative and requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [AliasExistsException].
  /// May throw [LimitExceededException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [destinationUser] :
  /// The existing user in the user pool that you want to assign to the external
  /// IdP user account. This user can be a native (Username + Password) Amazon
  /// Cognito user pools user or a federated user (for example, a SAML or
  /// Facebook user). If the user doesn't exist, Amazon Cognito generates an
  /// exception. Amazon Cognito returns this user when the new user (with the
  /// linked IdP attribute) signs in.
  ///
  /// For a native username + password user, the
  /// <code>ProviderAttributeValue</code> for the <code>DestinationUser</code>
  /// should be the username in the user pool. For a federated user, it should
  /// be the provider-specific <code>user_id</code>.
  ///
  /// The <code>ProviderAttributeName</code> of the <code>DestinationUser</code>
  /// is ignored.
  ///
  /// The <code>ProviderName</code> should be set to <code>Cognito</code> for
  /// users in Cognito user pools.
  /// <important>
  /// All attributes in the DestinationUser profile must be mutable. If you have
  /// assigned the user any immutable custom attributes, the operation won't
  /// succeed.
  /// </important>
  ///
  /// Parameter [sourceUser] :
  /// An external IdP account for a user who doesn't exist yet in the user pool.
  /// This user must be a federated user (for example, a SAML or Facebook user),
  /// not another native user.
  ///
  /// If the <code>SourceUser</code> is using a federated social IdP, such as
  /// Facebook, Google, or Login with Amazon, you must set the
  /// <code>ProviderAttributeName</code> to <code>Cognito_Subject</code>. For
  /// social IdPs, the <code>ProviderName</code> will be <code>Facebook</code>,
  /// <code>Google</code>, or <code>LoginWithAmazon</code>, and Amazon Cognito
  /// will automatically parse the Facebook, Google, and Login with Amazon
  /// tokens for <code>id</code>, <code>sub</code>, and <code>user_id</code>,
  /// respectively. The <code>ProviderAttributeValue</code> for the user must be
  /// the same value as the <code>id</code>, <code>sub</code>, or
  /// <code>user_id</code> value found in the social IdP token.
  /// <p/>
  /// For SAML, the <code>ProviderAttributeName</code> can be any value that
  /// matches a claim in the SAML assertion. If you want to link SAML users
  /// based on the subject of the SAML assertion, you should map the subject to
  /// a claim through the SAML IdP and submit that claim name as the
  /// <code>ProviderAttributeName</code>. If you set
  /// <code>ProviderAttributeName</code> to <code>Cognito_Subject</code>, Amazon
  /// Cognito will automatically parse the default unique identifier found in
  /// the subject from the SAML token.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool.
  Future<void> adminLinkProviderForUser({
    required ProviderUserIdentifierType destinationUser,
    required ProviderUserIdentifierType sourceUser,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(destinationUser, 'destinationUser');
    ArgumentError.checkNotNull(sourceUser, 'sourceUser');
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSCognitoIdentityProviderService.AdminLinkProviderForUser'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'DestinationUser': destinationUser,
        'SourceUser': sourceUser,
        'UserPoolId': userPoolId,
      },
    );
  }

  /// Lists devices, as an administrator.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidUserPoolConfigurationException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  /// May throw [NotAuthorizedException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  ///
  /// Parameter [username] :
  /// The user name.
  ///
  /// Parameter [limit] :
  /// The limit of the devices request.
  ///
  /// Parameter [paginationToken] :
  /// The pagination token.
  Future<AdminListDevicesResponse> adminListDevices({
    required String userPoolId,
    required String username,
    int? limit,
    String? paginationToken,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    _s.validateNumRange(
      'limit',
      limit,
      0,
      60,
    );
    _s.validateStringLength(
      'paginationToken',
      paginationToken,
      1,
      1152921504606846976,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AdminListDevices'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        'Username': username,
        if (limit != null) 'Limit': limit,
        if (paginationToken != null) 'PaginationToken': paginationToken,
      },
    );

    return AdminListDevicesResponse.fromJson(jsonResponse.body);
  }

  /// Lists the groups that the user belongs to.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool.
  ///
  /// Parameter [username] :
  /// The username for the user.
  ///
  /// Parameter [limit] :
  /// The limit of the request to list groups.
  ///
  /// Parameter [nextToken] :
  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  Future<AdminListGroupsForUserResponse> adminListGroupsForUser({
    required String userPoolId,
    required String username,
    int? limit,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    _s.validateNumRange(
      'limit',
      limit,
      0,
      60,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      1152921504606846976,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AdminListGroupsForUser'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        'Username': username,
        if (limit != null) 'Limit': limit,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return AdminListGroupsForUserResponse.fromJson(jsonResponse.body);
  }

  /// A history of user activity and any risks detected as part of Amazon
  /// Cognito advanced security.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [UserPoolAddOnNotEnabledException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  ///
  /// Parameter [username] :
  /// The user pool username or an alias.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of authentication events to return.
  ///
  /// Parameter [nextToken] :
  /// A pagination token.
  Future<AdminListUserAuthEventsResponse> adminListUserAuthEvents({
    required String userPoolId,
    required String username,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      0,
      60,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      1152921504606846976,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSCognitoIdentityProviderService.AdminListUserAuthEvents'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        'Username': username,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return AdminListUserAuthEventsResponse.fromJson(jsonResponse.body);
  }

  /// Removes the specified user from the specified group.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [groupName] :
  /// The group name.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool.
  ///
  /// Parameter [username] :
  /// The username for the user.
  Future<void> adminRemoveUserFromGroup({
    required String groupName,
    required String userPoolId,
    required String username,
  }) async {
    ArgumentError.checkNotNull(groupName, 'groupName');
    _s.validateStringLength(
      'groupName',
      groupName,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSCognitoIdentityProviderService.AdminRemoveUserFromGroup'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'GroupName': groupName,
        'UserPoolId': userPoolId,
        'Username': username,
      },
    );
  }

  /// Resets the specified user's password in a user pool as an administrator.
  /// Works on any user.
  ///
  /// When a developer calls this API, the current password is invalidated, so
  /// it must be changed. If a user tries to sign in after the API is called,
  /// the app will get a PasswordResetRequiredException exception back and
  /// should direct the user down the flow to reset the password, which is the
  /// same as the forgot password flow. In addition, if the user pool has phone
  /// verification selected and a verified phone number exists for the user, or
  /// if email verification is selected and a verified email exists for the
  /// user, calling this API will also result in sending a message to the end
  /// user with the code to change their password.
  /// <note>
  /// This action might generate an SMS text message. Starting June 1, 2021, US
  /// telecom carriers require you to register an origination phone number
  /// before you can send SMS messages to US phone numbers. If you use SMS text
  /// messages in Amazon Cognito, you must register a phone number with <a
  /// href="https://console.aws.amazon.com/pinpoint/home/">Amazon Pinpoint</a>.
  /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
  /// Cognito users who must receive SMS messages might not be able to sign up,
  /// activate their accounts, or sign in.
  ///
  /// If you have never used SMS text messages with Amazon Cognito or any other
  /// Amazon Web Service, Amazon Simple Notification Service might place your
  /// account in the SMS sandbox. In <i> <a
  /// href="https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html">sandbox
  /// mode</a> </i>, you can send messages only to verified phone numbers. After
  /// you test your app while in the sandbox environment, you can move out of
  /// the sandbox and into production. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-sms-userpool-settings.html">
  /// SMS message settings for Amazon Cognito user pools</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// </note>
  /// Calling this action requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [UnexpectedLambdaException].
  /// May throw [UserLambdaValidationException].
  /// May throw [NotAuthorizedException].
  /// May throw [InvalidLambdaResponseException].
  /// May throw [TooManyRequestsException].
  /// May throw [LimitExceededException].
  /// May throw [UserNotFoundException].
  /// May throw [InvalidSmsRoleAccessPolicyException].
  /// May throw [InvalidEmailRoleAccessPolicyException].
  /// May throw [InvalidSmsRoleTrustRelationshipException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool where you want to reset the user's
  /// password.
  ///
  /// Parameter [username] :
  /// The user name of the user whose password you want to reset.
  ///
  /// Parameter [clientMetadata] :
  /// A map of custom key-value pairs that you can provide as input for any
  /// custom workflows that this action triggers.
  ///
  /// You create custom workflows by assigning Lambda functions to user pool
  /// triggers. When you use the AdminResetUserPassword API action, Amazon
  /// Cognito invokes the function that is assigned to the <i>custom message</i>
  /// trigger. When Amazon Cognito invokes this function, it passes a JSON
  /// payload, which the function receives as input. This payload contains a
  /// <code>clientMetadata</code> attribute, which provides the data that you
  /// assigned to the ClientMetadata parameter in your AdminResetUserPassword
  /// request. In your function code in Lambda, you can process the
  /// <code>clientMetadata</code> value to enhance your workflow for your
  /// specific needs.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html">
  /// Customizing user pool Workflows with Lambda Triggers</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// <note>
  /// When you use the ClientMetadata parameter, remember that Amazon Cognito
  /// won't do the following:
  ///
  /// <ul>
  /// <li>
  /// Store the ClientMetadata value. This data is available only to Lambda
  /// triggers that are assigned to a user pool to support custom workflows. If
  /// your user pool configuration doesn't include triggers, the ClientMetadata
  /// parameter serves no purpose.
  /// </li>
  /// <li>
  /// Validate the ClientMetadata value.
  /// </li>
  /// <li>
  /// Encrypt the ClientMetadata value. Don't use Amazon Cognito to provide
  /// sensitive information.
  /// </li>
  /// </ul> </note>
  Future<void> adminResetUserPassword({
    required String userPoolId,
    required String username,
    Map<String, String>? clientMetadata,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AdminResetUserPassword'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        'Username': username,
        if (clientMetadata != null) 'ClientMetadata': clientMetadata,
      },
    );
  }

  /// Responds to an authentication challenge, as an administrator.
  /// <note>
  /// This action might generate an SMS text message. Starting June 1, 2021, US
  /// telecom carriers require you to register an origination phone number
  /// before you can send SMS messages to US phone numbers. If you use SMS text
  /// messages in Amazon Cognito, you must register a phone number with <a
  /// href="https://console.aws.amazon.com/pinpoint/home/">Amazon Pinpoint</a>.
  /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
  /// Cognito users who must receive SMS messages might not be able to sign up,
  /// activate their accounts, or sign in.
  ///
  /// If you have never used SMS text messages with Amazon Cognito or any other
  /// Amazon Web Service, Amazon Simple Notification Service might place your
  /// account in the SMS sandbox. In <i> <a
  /// href="https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html">sandbox
  /// mode</a> </i>, you can send messages only to verified phone numbers. After
  /// you test your app while in the sandbox environment, you can move out of
  /// the sandbox and into production. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-sms-userpool-settings.html">
  /// SMS message settings for Amazon Cognito user pools</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// </note>
  /// Calling this action requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [CodeMismatchException].
  /// May throw [ExpiredCodeException].
  /// May throw [UnexpectedLambdaException].
  /// May throw [InvalidPasswordException].
  /// May throw [UserLambdaValidationException].
  /// May throw [InvalidLambdaResponseException].
  /// May throw [TooManyRequestsException].
  /// May throw [InvalidUserPoolConfigurationException].
  /// May throw [InternalErrorException].
  /// May throw [MFAMethodNotFoundException].
  /// May throw [InvalidSmsRoleAccessPolicyException].
  /// May throw [InvalidSmsRoleTrustRelationshipException].
  /// May throw [AliasExistsException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [SoftwareTokenMFANotFoundException].
  ///
  /// Parameter [challengeName] :
  /// The challenge name. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AdminInitiateAuth.html">AdminInitiateAuth</a>.
  ///
  /// Parameter [clientId] :
  /// The app client ID.
  ///
  /// Parameter [userPoolId] :
  /// The ID of the Amazon Cognito user pool.
  ///
  /// Parameter [analyticsMetadata] :
  /// The analytics metadata for collecting Amazon Pinpoint metrics for
  /// <code>AdminRespondToAuthChallenge</code> calls.
  ///
  /// Parameter [challengeResponses] :
  /// The challenge responses. These are inputs corresponding to the value of
  /// <code>ChallengeName</code>, for example:
  ///
  /// <ul>
  /// <li>
  /// <code>SMS_MFA</code>: <code>SMS_MFA_CODE</code>, <code>USERNAME</code>,
  /// <code>SECRET_HASH</code> (if app client is configured with client secret).
  /// </li>
  /// <li>
  /// <code>PASSWORD_VERIFIER</code>: <code>PASSWORD_CLAIM_SIGNATURE</code>,
  /// <code>PASSWORD_CLAIM_SECRET_BLOCK</code>, <code>TIMESTAMP</code>,
  /// <code>USERNAME</code>, <code>SECRET_HASH</code> (if app client is
  /// configured with client secret).
  /// <note>
  /// <code>PASSWORD_VERIFIER</code> requires <code>DEVICE_KEY</code> when
  /// signing in with a remembered device.
  /// </note> </li>
  /// <li>
  /// <code>ADMIN_NO_SRP_AUTH</code>: <code>PASSWORD</code>,
  /// <code>USERNAME</code>, <code>SECRET_HASH</code> (if app client is
  /// configured with client secret).
  /// </li>
  /// <li>
  /// <code>NEW_PASSWORD_REQUIRED</code>: <code>NEW_PASSWORD</code>,
  /// <code>USERNAME</code>, <code>SECRET_HASH</code> (if app client is
  /// configured with client secret). To set any required attributes that Amazon
  /// Cognito returned as <code>requiredAttributes</code> in the
  /// <code>AdminInitiateAuth</code> response, add a
  /// <code>userAttributes.<i>attributename</i> </code> parameter. This
  /// parameter can also set values for writable attributes that aren't required
  /// by your user pool.
  /// <note>
  /// In a <code>NEW_PASSWORD_REQUIRED</code> challenge response, you can't
  /// modify a required attribute that already has a value. In
  /// <code>AdminRespondToAuthChallenge</code>, set a value for any keys that
  /// Amazon Cognito returned in the <code>requiredAttributes</code> parameter,
  /// then use the <code>AdminUpdateUserAttributes</code> API operation to
  /// modify the value of any additional attributes.
  /// </note> </li>
  /// <li>
  /// <code>MFA_SETUP</code> requires <code>USERNAME</code>, plus you must use
  /// the session value returned by <code>VerifySoftwareToken</code> in the
  /// <code>Session</code> parameter.
  /// </li>
  /// </ul>
  /// The value of the <code>USERNAME</code> attribute must be the user's actual
  /// username, not an alias (such as an email address or phone number). To make
  /// this simpler, the <code>AdminInitiateAuth</code> response includes the
  /// actual username value in the <code>USERNAMEUSER_ID_FOR_SRP</code>
  /// attribute. This happens even if you specified an alias in your call to
  /// <code>AdminInitiateAuth</code>.
  ///
  /// Parameter [clientMetadata] :
  /// A map of custom key-value pairs that you can provide as input for any
  /// custom workflows that this action triggers.
  ///
  /// You create custom workflows by assigning Lambda functions to user pool
  /// triggers. When you use the AdminRespondToAuthChallenge API action, Amazon
  /// Cognito invokes any functions that you have assigned to the following
  /// triggers:
  ///
  /// <ul>
  /// <li>
  /// pre sign-up
  /// </li>
  /// <li>
  /// custom message
  /// </li>
  /// <li>
  /// post authentication
  /// </li>
  /// <li>
  /// user migration
  /// </li>
  /// <li>
  /// pre token generation
  /// </li>
  /// <li>
  /// define auth challenge
  /// </li>
  /// <li>
  /// create auth challenge
  /// </li>
  /// <li>
  /// verify auth challenge response
  /// </li>
  /// </ul>
  /// When Amazon Cognito invokes any of these functions, it passes a JSON
  /// payload, which the function receives as input. This payload contains a
  /// <code>clientMetadata</code> attribute that provides the data that you
  /// assigned to the ClientMetadata parameter in your
  /// AdminRespondToAuthChallenge request. In your function code in Lambda, you
  /// can process the <code>clientMetadata</code> value to enhance your workflow
  /// for your specific needs.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html">
  /// Customizing user pool Workflows with Lambda Triggers</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// <note>
  /// When you use the ClientMetadata parameter, remember that Amazon Cognito
  /// won't do the following:
  ///
  /// <ul>
  /// <li>
  /// Store the ClientMetadata value. This data is available only to Lambda
  /// triggers that are assigned to a user pool to support custom workflows. If
  /// your user pool configuration doesn't include triggers, the ClientMetadata
  /// parameter serves no purpose.
  /// </li>
  /// <li>
  /// Validate the ClientMetadata value.
  /// </li>
  /// <li>
  /// Encrypt the ClientMetadata value. Don't use Amazon Cognito to provide
  /// sensitive information.
  /// </li>
  /// </ul> </note>
  ///
  /// Parameter [contextData] :
  /// Contextual data about your user session, such as the device fingerprint,
  /// IP address, or location. Amazon Cognito advanced security evaluates the
  /// risk of an authentication event based on the context that your app
  /// generates and passes to Amazon Cognito when it makes API requests.
  ///
  /// Parameter [session] :
  /// The session that should be passed both ways in challenge-response calls to
  /// the service. If an <code>InitiateAuth</code> or
  /// <code>RespondToAuthChallenge</code> API call determines that the caller
  /// must pass another challenge, it returns a session with other challenge
  /// parameters. This session should be passed as it is to the next
  /// <code>RespondToAuthChallenge</code> API call.
  Future<AdminRespondToAuthChallengeResponse> adminRespondToAuthChallenge({
    required ChallengeNameType challengeName,
    required String clientId,
    required String userPoolId,
    AnalyticsMetadataType? analyticsMetadata,
    Map<String, String>? challengeResponses,
    Map<String, String>? clientMetadata,
    ContextDataType? contextData,
    String? session,
  }) async {
    ArgumentError.checkNotNull(challengeName, 'challengeName');
    ArgumentError.checkNotNull(clientId, 'clientId');
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateStringLength(
      'session',
      session,
      20,
      2048,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSCognitoIdentityProviderService.AdminRespondToAuthChallenge'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ChallengeName': challengeName.toValue(),
        'ClientId': clientId,
        'UserPoolId': userPoolId,
        if (analyticsMetadata != null) 'AnalyticsMetadata': analyticsMetadata,
        if (challengeResponses != null)
          'ChallengeResponses': challengeResponses,
        if (clientMetadata != null) 'ClientMetadata': clientMetadata,
        if (contextData != null) 'ContextData': contextData,
        if (session != null) 'Session': session,
      },
    );

    return AdminRespondToAuthChallengeResponse.fromJson(jsonResponse.body);
  }

  /// The user's multi-factor authentication (MFA) preference, including which
  /// MFA options are activated, and if any are preferred. Only one factor can
  /// be set as preferred. The preferred MFA factor will be used to authenticate
  /// a user if multiple factors are activated. If multiple options are
  /// activated and no preference is set, a challenge to choose an MFA option
  /// will be returned during sign-in.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  ///
  /// Parameter [username] :
  /// The user pool username or alias.
  ///
  /// Parameter [sMSMfaSettings] :
  /// The SMS text message MFA settings.
  ///
  /// Parameter [softwareTokenMfaSettings] :
  /// The time-based one-time password software token MFA settings.
  Future<void> adminSetUserMFAPreference({
    required String userPoolId,
    required String username,
    SMSMfaSettingsType? sMSMfaSettings,
    SoftwareTokenMfaSettingsType? softwareTokenMfaSettings,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSCognitoIdentityProviderService.AdminSetUserMFAPreference'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        'Username': username,
        if (sMSMfaSettings != null) 'SMSMfaSettings': sMSMfaSettings,
        if (softwareTokenMfaSettings != null)
          'SoftwareTokenMfaSettings': softwareTokenMfaSettings,
      },
    );
  }

  /// Sets the specified user's password in a user pool as an administrator.
  /// Works on any user.
  ///
  /// The password can be temporary or permanent. If it is temporary, the user
  /// status enters the <code>FORCE_CHANGE_PASSWORD</code> state. When the user
  /// next tries to sign in, the InitiateAuth/AdminInitiateAuth response will
  /// contain the <code>NEW_PASSWORD_REQUIRED</code> challenge. If the user
  /// doesn't sign in before it expires, the user won't be able to sign in, and
  /// an administrator must reset their password.
  ///
  /// Once the user has set a new password, or the password is permanent, the
  /// user status is set to <code>Confirmed</code>.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  /// May throw [TooManyRequestsException].
  /// May throw [InvalidParameterException].
  /// May throw [InvalidPasswordException].
  ///
  /// Parameter [password] :
  /// The password for the user.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool where you want to set the user's
  /// password.
  ///
  /// Parameter [username] :
  /// The user name of the user whose password you want to set.
  ///
  /// Parameter [permanent] :
  /// <code>True</code> if the password is permanent, <code>False</code> if it
  /// is temporary.
  Future<void> adminSetUserPassword({
    required String password,
    required String userPoolId,
    required String username,
    bool? permanent,
  }) async {
    ArgumentError.checkNotNull(password, 'password');
    _s.validateStringLength(
      'password',
      password,
      0,
      256,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AdminSetUserPassword'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Password': password,
        'UserPoolId': userPoolId,
        'Username': username,
        if (permanent != null) 'Permanent': permanent,
      },
    );
  }

  /// <i>This action is no longer supported.</i> You can use it to configure
  /// only SMS MFA. You can't use it to configure time-based one-time password
  /// (TOTP) software token MFA. To configure either type of MFA, use <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AdminSetUserMFAPreference.html">AdminSetUserMFAPreference</a>
  /// instead.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [mFAOptions] :
  /// You can use this parameter only to set an SMS configuration that uses SMS
  /// for delivery.
  ///
  /// Parameter [userPoolId] :
  /// The ID of the user pool that contains the user whose options you're
  /// setting.
  ///
  /// Parameter [username] :
  /// The user name of the user whose options you're setting.
  Future<void> adminSetUserSettings({
    required List<MFAOptionType> mFAOptions,
    required String userPoolId,
    required String username,
  }) async {
    ArgumentError.checkNotNull(mFAOptions, 'mFAOptions');
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AdminSetUserSettings'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'MFAOptions': mFAOptions,
        'UserPoolId': userPoolId,
        'Username': username,
      },
    );
  }

  /// Provides feedback for an authentication event indicating if it was from a
  /// valid user. This feedback is used for improving the risk evaluation
  /// decision for the user pool as part of Amazon Cognito advanced security.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [UserPoolAddOnNotEnabledException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [eventId] :
  /// The authentication event ID.
  ///
  /// Parameter [feedbackValue] :
  /// The authentication event feedback value.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  ///
  /// Parameter [username] :
  /// The user pool username.
  Future<void> adminUpdateAuthEventFeedback({
    required String eventId,
    required FeedbackValueType feedbackValue,
    required String userPoolId,
    required String username,
  }) async {
    ArgumentError.checkNotNull(eventId, 'eventId');
    _s.validateStringLength(
      'eventId',
      eventId,
      1,
      50,
      isRequired: true,
    );
    ArgumentError.checkNotNull(feedbackValue, 'feedbackValue');
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSCognitoIdentityProviderService.AdminUpdateAuthEventFeedback'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'EventId': eventId,
        'FeedbackValue': feedbackValue.toValue(),
        'UserPoolId': userPoolId,
        'Username': username,
      },
    );
  }

  /// Updates the device status as an administrator.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidUserPoolConfigurationException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [deviceKey] :
  /// The device key.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  ///
  /// Parameter [username] :
  /// The user name.
  ///
  /// Parameter [deviceRememberedStatus] :
  /// The status indicating whether a device has been remembered or not.
  Future<void> adminUpdateDeviceStatus({
    required String deviceKey,
    required String userPoolId,
    required String username,
    DeviceRememberedStatusType? deviceRememberedStatus,
  }) async {
    ArgumentError.checkNotNull(deviceKey, 'deviceKey');
    _s.validateStringLength(
      'deviceKey',
      deviceKey,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSCognitoIdentityProviderService.AdminUpdateDeviceStatus'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'DeviceKey': deviceKey,
        'UserPoolId': userPoolId,
        'Username': username,
        if (deviceRememberedStatus != null)
          'DeviceRememberedStatus': deviceRememberedStatus.toValue(),
      },
    );
  }

  /// Updates the specified user's attributes, including developer attributes,
  /// as an administrator. Works on any user.
  ///
  /// For custom attributes, you must prepend the <code>custom:</code> prefix to
  /// the attribute name.
  ///
  /// In addition to updating user attributes, this API can also be used to mark
  /// phone and email as verified.
  /// <note>
  /// This action might generate an SMS text message. Starting June 1, 2021, US
  /// telecom carriers require you to register an origination phone number
  /// before you can send SMS messages to US phone numbers. If you use SMS text
  /// messages in Amazon Cognito, you must register a phone number with <a
  /// href="https://console.aws.amazon.com/pinpoint/home/">Amazon Pinpoint</a>.
  /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
  /// Cognito users who must receive SMS messages might not be able to sign up,
  /// activate their accounts, or sign in.
  ///
  /// If you have never used SMS text messages with Amazon Cognito or any other
  /// Amazon Web Service, Amazon Simple Notification Service might place your
  /// account in the SMS sandbox. In <i> <a
  /// href="https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html">sandbox
  /// mode</a> </i>, you can send messages only to verified phone numbers. After
  /// you test your app while in the sandbox environment, you can move out of
  /// the sandbox and into production. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-sms-userpool-settings.html">
  /// SMS message settings for Amazon Cognito user pools</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// </note>
  /// Calling this action requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [UnexpectedLambdaException].
  /// May throw [UserLambdaValidationException].
  /// May throw [InvalidLambdaResponseException].
  /// May throw [AliasExistsException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  /// May throw [InvalidSmsRoleAccessPolicyException].
  /// May throw [InvalidEmailRoleAccessPolicyException].
  /// May throw [InvalidSmsRoleTrustRelationshipException].
  ///
  /// Parameter [userAttributes] :
  /// An array of name-value pairs representing user attributes.
  ///
  /// For custom attributes, you must prepend the <code>custom:</code> prefix to
  /// the attribute name.
  ///
  /// If your user pool requires verification before Amazon Cognito updates an
  /// attribute value that you specify in this request, Amazon Cognito doesn’t
  /// immediately update the value of that attribute. After your user receives
  /// and responds to a verification message to verify the new value, Amazon
  /// Cognito updates the attribute value. Your user can sign in and receive
  /// messages with the original attribute value until they verify the new
  /// value.
  ///
  /// To update the value of an attribute that requires verification in the same
  /// API request, include the <code>email_verified</code> or
  /// <code>phone_number_verified</code> attribute, with a value of
  /// <code>true</code>. If you set the <code>email_verified</code> or
  /// <code>phone_number_verified</code> value for an <code>email</code> or
  /// <code>phone_number</code> attribute that requires verification to
  /// <code>true</code>, Amazon Cognito doesn’t send a verification message to
  /// your user.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool where you want to update user
  /// attributes.
  ///
  /// Parameter [username] :
  /// The user name of the user for whom you want to update user attributes.
  ///
  /// Parameter [clientMetadata] :
  /// A map of custom key-value pairs that you can provide as input for any
  /// custom workflows that this action triggers.
  ///
  /// You create custom workflows by assigning Lambda functions to user pool
  /// triggers. When you use the AdminUpdateUserAttributes API action, Amazon
  /// Cognito invokes the function that is assigned to the <i>custom message</i>
  /// trigger. When Amazon Cognito invokes this function, it passes a JSON
  /// payload, which the function receives as input. This payload contains a
  /// <code>clientMetadata</code> attribute, which provides the data that you
  /// assigned to the ClientMetadata parameter in your AdminUpdateUserAttributes
  /// request. In your function code in Lambda, you can process the
  /// <code>clientMetadata</code> value to enhance your workflow for your
  /// specific needs.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html">
  /// Customizing user pool Workflows with Lambda Triggers</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// <note>
  /// When you use the ClientMetadata parameter, remember that Amazon Cognito
  /// won't do the following:
  ///
  /// <ul>
  /// <li>
  /// Store the ClientMetadata value. This data is available only to Lambda
  /// triggers that are assigned to a user pool to support custom workflows. If
  /// your user pool configuration doesn't include triggers, the ClientMetadata
  /// parameter serves no purpose.
  /// </li>
  /// <li>
  /// Validate the ClientMetadata value.
  /// </li>
  /// <li>
  /// Encrypt the ClientMetadata value. Don't use Amazon Cognito to provide
  /// sensitive information.
  /// </li>
  /// </ul> </note>
  Future<void> adminUpdateUserAttributes({
    required List<AttributeType> userAttributes,
    required String userPoolId,
    required String username,
    Map<String, String>? clientMetadata,
  }) async {
    ArgumentError.checkNotNull(userAttributes, 'userAttributes');
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSCognitoIdentityProviderService.AdminUpdateUserAttributes'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserAttributes': userAttributes,
        'UserPoolId': userPoolId,
        'Username': username,
        if (clientMetadata != null) 'ClientMetadata': clientMetadata,
      },
    );
  }

  /// Signs out a user from all devices. You must sign
  /// <code>AdminUserGlobalSignOut</code> requests with Amazon Web Services
  /// credentials. It also invalidates all refresh tokens that Amazon Cognito
  /// has issued to a user. The user's current access and ID tokens remain valid
  /// until they expire. By default, access and ID tokens expire one hour after
  /// they're issued. A user can still use a hosted UI cookie to retrieve new
  /// tokens for the duration of the cookie validity period of 1 hour.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  ///
  /// Parameter [username] :
  /// The user name.
  Future<void> adminUserGlobalSignOut({
    required String userPoolId,
    required String username,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AdminUserGlobalSignOut'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        'Username': username,
      },
    );
  }

  /// Begins setup of time-based one-time password (TOTP) multi-factor
  /// authentication (MFA) for a user, with a unique private key that Amazon
  /// Cognito generates and returns in the API response. You can authorize an
  /// <code>AssociateSoftwareToken</code> request with either the user's access
  /// token, or a session string from a challenge response that you received
  /// from Amazon Cognito.
  /// <note>
  /// Amazon Cognito disassociates an existing software token when you verify
  /// the new token in a <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_VerifySoftwareToken.html">
  /// VerifySoftwareToken</a> API request. If you don't verify the software
  /// token and your user pool doesn't require MFA, the user can then
  /// authenticate with user name and password credentials alone. If your user
  /// pool requires TOTP MFA, Amazon Cognito generates an <code>MFA_SETUP</code>
  /// or <code>SOFTWARE_TOKEN_SETUP</code> challenge each time your user signs.
  /// Complete setup with <code>AssociateSoftwareToken</code> and
  /// <code>VerifySoftwareToken</code>.
  ///
  /// After you set up software token MFA for your user, Amazon Cognito
  /// generates a <code>SOFTWARE_TOKEN_MFA</code> challenge when they
  /// authenticate. Respond to this challenge with your user's TOTP.
  /// </note>
  ///
  /// May throw [ConcurrentModificationException].
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [ResourceNotFoundException].
  /// May throw [InternalErrorException].
  /// May throw [SoftwareTokenMFANotFoundException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [accessToken] :
  /// A valid access token that Amazon Cognito issued to the user whose software
  /// token you want to generate.
  ///
  /// Parameter [session] :
  /// The session that should be passed both ways in challenge-response calls to
  /// the service. This allows authentication of the user as part of the MFA
  /// setup process.
  Future<AssociateSoftwareTokenResponse> associateSoftwareToken({
    String? accessToken,
    String? session,
  }) async {
    _s.validateStringLength(
      'session',
      session,
      20,
      2048,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.AssociateSoftwareToken'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (accessToken != null) 'AccessToken': accessToken,
        if (session != null) 'Session': session,
      },
    );

    return AssociateSoftwareTokenResponse.fromJson(jsonResponse.body);
  }

  /// Changes the password for a specified user in a user pool.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [InvalidPasswordException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [LimitExceededException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [accessToken] :
  /// A valid access token that Amazon Cognito issued to the user whose password
  /// you want to change.
  ///
  /// Parameter [previousPassword] :
  /// The old password.
  ///
  /// Parameter [proposedPassword] :
  /// The new password.
  Future<void> changePassword({
    required String accessToken,
    required String previousPassword,
    required String proposedPassword,
  }) async {
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    ArgumentError.checkNotNull(previousPassword, 'previousPassword');
    _s.validateStringLength(
      'previousPassword',
      previousPassword,
      0,
      256,
      isRequired: true,
    );
    ArgumentError.checkNotNull(proposedPassword, 'proposedPassword');
    _s.validateStringLength(
      'proposedPassword',
      proposedPassword,
      0,
      256,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ChangePassword'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      signed: false,
      // TODO queryParams
      headers: headers,
      payload: {
        'AccessToken': accessToken,
        'PreviousPassword': previousPassword,
        'ProposedPassword': proposedPassword,
      },
    );
  }

  /// Confirms tracking of the device. This API call is the call that begins
  /// device tracking.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [InvalidPasswordException].
  /// May throw [InvalidLambdaResponseException].
  /// May throw [UsernameExistsException].
  /// May throw [InvalidUserPoolConfigurationException].
  /// May throw [TooManyRequestsException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [accessToken] :
  /// A valid access token that Amazon Cognito issued to the user whose device
  /// you want to confirm.
  ///
  /// Parameter [deviceKey] :
  /// The device key.
  ///
  /// Parameter [deviceName] :
  /// The device name.
  ///
  /// Parameter [deviceSecretVerifierConfig] :
  /// The configuration of the device secret verifier.
  Future<ConfirmDeviceResponse> confirmDevice({
    required String accessToken,
    required String deviceKey,
    String? deviceName,
    DeviceSecretVerifierConfigType? deviceSecretVerifierConfig,
  }) async {
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    ArgumentError.checkNotNull(deviceKey, 'deviceKey');
    _s.validateStringLength(
      'deviceKey',
      deviceKey,
      1,
      55,
      isRequired: true,
    );
    _s.validateStringLength(
      'deviceName',
      deviceName,
      1,
      1024,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ConfirmDevice'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AccessToken': accessToken,
        'DeviceKey': deviceKey,
        if (deviceName != null) 'DeviceName': deviceName,
        if (deviceSecretVerifierConfig != null)
          'DeviceSecretVerifierConfig': deviceSecretVerifierConfig,
      },
    );

    return ConfirmDeviceResponse.fromJson(jsonResponse.body);
  }

  /// Allows a user to enter a confirmation code to reset a forgotten password.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [UnexpectedLambdaException].
  /// May throw [UserLambdaValidationException].
  /// May throw [InvalidParameterException].
  /// May throw [InvalidPasswordException].
  /// May throw [NotAuthorizedException].
  /// May throw [CodeMismatchException].
  /// May throw [ExpiredCodeException].
  /// May throw [TooManyFailedAttemptsException].
  /// May throw [InvalidLambdaResponseException].
  /// May throw [TooManyRequestsException].
  /// May throw [LimitExceededException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [clientId] :
  /// The app client ID of the app associated with the user pool.
  ///
  /// Parameter [confirmationCode] :
  /// The confirmation code from your user's request to reset their password.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_ForgotPassword.html">ForgotPassword</a>.
  ///
  /// Parameter [password] :
  /// The new password that your user wants to set.
  ///
  /// Parameter [username] :
  /// The user name of the user for whom you want to enter a code to retrieve a
  /// forgotten password.
  ///
  /// Parameter [analyticsMetadata] :
  /// The Amazon Pinpoint analytics metadata for collecting metrics for
  /// <code>ConfirmForgotPassword</code> calls.
  ///
  /// Parameter [clientMetadata] :
  /// A map of custom key-value pairs that you can provide as input for any
  /// custom workflows that this action triggers.
  ///
  /// You create custom workflows by assigning Lambda functions to user pool
  /// triggers. When you use the ConfirmForgotPassword API action, Amazon
  /// Cognito invokes the function that is assigned to the <i>post
  /// confirmation</i> trigger. When Amazon Cognito invokes this function, it
  /// passes a JSON payload, which the function receives as input. This payload
  /// contains a <code>clientMetadata</code> attribute, which provides the data
  /// that you assigned to the ClientMetadata parameter in your
  /// ConfirmForgotPassword request. In your function code in Lambda, you can
  /// process the <code>clientMetadata</code> value to enhance your workflow for
  /// your specific needs.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html">
  /// Customizing user pool Workflows with Lambda Triggers</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// <note>
  /// When you use the ClientMetadata parameter, remember that Amazon Cognito
  /// won't do the following:
  ///
  /// <ul>
  /// <li>
  /// Store the ClientMetadata value. This data is available only to Lambda
  /// triggers that are assigned to a user pool to support custom workflows. If
  /// your user pool configuration doesn't include triggers, the ClientMetadata
  /// parameter serves no purpose.
  /// </li>
  /// <li>
  /// Validate the ClientMetadata value.
  /// </li>
  /// <li>
  /// Encrypt the ClientMetadata value. Don't use Amazon Cognito to provide
  /// sensitive information.
  /// </li>
  /// </ul> </note>
  ///
  /// Parameter [secretHash] :
  /// A keyed-hash message authentication code (HMAC) calculated using the
  /// secret key of a user pool client and username plus the client ID in the
  /// message.
  ///
  /// Parameter [userContextData] :
  /// Contextual data about your user session, such as the device fingerprint,
  /// IP address, or location. Amazon Cognito advanced security evaluates the
  /// risk of an authentication event based on the context that your app
  /// generates and passes to Amazon Cognito when it makes API requests.
  Future<void> confirmForgotPassword({
    required String clientId,
    required String confirmationCode,
    required String password,
    required String username,
    AnalyticsMetadataType? analyticsMetadata,
    Map<String, String>? clientMetadata,
    String? secretHash,
    UserContextDataType? userContextData,
  }) async {
    ArgumentError.checkNotNull(clientId, 'clientId');
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(confirmationCode, 'confirmationCode');
    _s.validateStringLength(
      'confirmationCode',
      confirmationCode,
      1,
      2048,
      isRequired: true,
    );
    ArgumentError.checkNotNull(password, 'password');
    _s.validateStringLength(
      'password',
      password,
      0,
      256,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringLength(
      'secretHash',
      secretHash,
      1,
      128,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ConfirmForgotPassword'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      signed: false,
      // TODO queryParams
      headers: headers,
      payload: {
        'ClientId': clientId,
        'ConfirmationCode': confirmationCode,
        'Password': password,
        'Username': username,
        if (analyticsMetadata != null) 'AnalyticsMetadata': analyticsMetadata,
        if (clientMetadata != null) 'ClientMetadata': clientMetadata,
        if (secretHash != null) 'SecretHash': secretHash,
        if (userContextData != null) 'UserContextData': userContextData,
      },
    );
  }

  /// Confirms registration of a new user.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [UnexpectedLambdaException].
  /// May throw [UserLambdaValidationException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyFailedAttemptsException].
  /// May throw [CodeMismatchException].
  /// May throw [ExpiredCodeException].
  /// May throw [InvalidLambdaResponseException].
  /// May throw [AliasExistsException].
  /// May throw [TooManyRequestsException].
  /// May throw [LimitExceededException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [clientId] :
  /// The ID of the app client associated with the user pool.
  ///
  /// Parameter [confirmationCode] :
  /// The confirmation code sent by a user's request to confirm registration.
  ///
  /// Parameter [username] :
  /// The user name of the user whose registration you want to confirm.
  ///
  /// Parameter [analyticsMetadata] :
  /// The Amazon Pinpoint analytics metadata for collecting metrics for
  /// <code>ConfirmSignUp</code> calls.
  ///
  /// Parameter [clientMetadata] :
  /// A map of custom key-value pairs that you can provide as input for any
  /// custom workflows that this action triggers.
  ///
  /// You create custom workflows by assigning Lambda functions to user pool
  /// triggers. When you use the ConfirmSignUp API action, Amazon Cognito
  /// invokes the function that is assigned to the <i>post confirmation</i>
  /// trigger. When Amazon Cognito invokes this function, it passes a JSON
  /// payload, which the function receives as input. This payload contains a
  /// <code>clientMetadata</code> attribute, which provides the data that you
  /// assigned to the ClientMetadata parameter in your ConfirmSignUp request. In
  /// your function code in Lambda, you can process the
  /// <code>clientMetadata</code> value to enhance your workflow for your
  /// specific needs.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html">
  /// Customizing user pool Workflows with Lambda Triggers</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// <note>
  /// When you use the ClientMetadata parameter, remember that Amazon Cognito
  /// won't do the following:
  ///
  /// <ul>
  /// <li>
  /// Store the ClientMetadata value. This data is available only to Lambda
  /// triggers that are assigned to a user pool to support custom workflows. If
  /// your user pool configuration doesn't include triggers, the ClientMetadata
  /// parameter serves no purpose.
  /// </li>
  /// <li>
  /// Validate the ClientMetadata value.
  /// </li>
  /// <li>
  /// Encrypt the ClientMetadata value. Don't use Amazon Cognito to provide
  /// sensitive information.
  /// </li>
  /// </ul> </note>
  ///
  /// Parameter [forceAliasCreation] :
  /// Boolean to be specified to force user confirmation irrespective of
  /// existing alias. By default set to <code>False</code>. If this parameter is
  /// set to <code>True</code> and the phone number/email used for sign up
  /// confirmation already exists as an alias with a different user, the API
  /// call will migrate the alias from the previous user to the newly created
  /// user being confirmed. If set to <code>False</code>, the API will throw an
  /// <b>AliasExistsException</b> error.
  ///
  /// Parameter [secretHash] :
  /// A keyed-hash message authentication code (HMAC) calculated using the
  /// secret key of a user pool client and username plus the client ID in the
  /// message.
  ///
  /// Parameter [userContextData] :
  /// Contextual data about your user session, such as the device fingerprint,
  /// IP address, or location. Amazon Cognito advanced security evaluates the
  /// risk of an authentication event based on the context that your app
  /// generates and passes to Amazon Cognito when it makes API requests.
  Future<void> confirmSignUp({
    required String clientId,
    required String confirmationCode,
    required String username,
    AnalyticsMetadataType? analyticsMetadata,
    Map<String, String>? clientMetadata,
    bool? forceAliasCreation,
    String? secretHash,
    UserContextDataType? userContextData,
  }) async {
    ArgumentError.checkNotNull(clientId, 'clientId');
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(confirmationCode, 'confirmationCode');
    _s.validateStringLength(
      'confirmationCode',
      confirmationCode,
      1,
      2048,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringLength(
      'secretHash',
      secretHash,
      1,
      128,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ConfirmSignUp'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      signed: false,
      // TODO queryParams
      headers: headers,
      payload: {
        'ClientId': clientId,
        'ConfirmationCode': confirmationCode,
        'Username': username,
        if (analyticsMetadata != null) 'AnalyticsMetadata': analyticsMetadata,
        if (clientMetadata != null) 'ClientMetadata': clientMetadata,
        if (forceAliasCreation != null)
          'ForceAliasCreation': forceAliasCreation,
        if (secretHash != null) 'SecretHash': secretHash,
        if (userContextData != null) 'UserContextData': userContextData,
      },
    );
  }

  /// Creates a new group in the specified user pool.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [GroupExistsException].
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [LimitExceededException].
  /// May throw [NotAuthorizedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [groupName] :
  /// The name of the group. Must be unique.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool.
  ///
  /// Parameter [description] :
  /// A string containing the description of the group.
  ///
  /// Parameter [precedence] :
  /// A non-negative integer value that specifies the precedence of this group
  /// relative to the other groups that a user can belong to in the user pool.
  /// Zero is the highest precedence value. Groups with lower
  /// <code>Precedence</code> values take precedence over groups with higher or
  /// null <code>Precedence</code> values. If a user belongs to two or more
  /// groups, it is the group with the lowest precedence value whose role ARN is
  /// given in the user's tokens for the <code>cognito:roles</code> and
  /// <code>cognito:preferred_role</code> claims.
  ///
  /// Two groups can have the same <code>Precedence</code> value. If this
  /// happens, neither group takes precedence over the other. If two groups with
  /// the same <code>Precedence</code> have the same role ARN, that role is used
  /// in the <code>cognito:preferred_role</code> claim in tokens for users in
  /// each group. If the two groups have different role ARNs, the
  /// <code>cognito:preferred_role</code> claim isn't set in users' tokens.
  ///
  /// The default <code>Precedence</code> value is null. The maximum
  /// <code>Precedence</code> value is <code>2^31-1</code>.
  ///
  /// Parameter [roleArn] :
  /// The role Amazon Resource Name (ARN) for the group.
  Future<CreateGroupResponse> createGroup({
    required String groupName,
    required String userPoolId,
    String? description,
    int? precedence,
    String? roleArn,
  }) async {
    ArgumentError.checkNotNull(groupName, 'groupName');
    _s.validateStringLength(
      'groupName',
      groupName,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateStringLength(
      'description',
      description,
      0,
      2048,
    );
    _s.validateNumRange(
      'precedence',
      precedence,
      0,
      1152921504606846976,
    );
    _s.validateStringLength(
      'roleArn',
      roleArn,
      20,
      2048,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.CreateGroup'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'GroupName': groupName,
        'UserPoolId': userPoolId,
        if (description != null) 'Description': description,
        if (precedence != null) 'Precedence': precedence,
        if (roleArn != null) 'RoleArn': roleArn,
      },
    );

    return CreateGroupResponse.fromJson(jsonResponse.body);
  }

  /// Creates an IdP for a user pool.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [DuplicateProviderException].
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [LimitExceededException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [providerDetails] :
  /// The IdP details. The following list describes the provider detail keys for
  /// each IdP type.
  ///
  /// <ul>
  /// <li>
  /// For Google and Login with Amazon:
  ///
  /// <ul>
  /// <li>
  /// client_id
  /// </li>
  /// <li>
  /// client_secret
  /// </li>
  /// <li>
  /// authorize_scopes
  /// </li>
  /// </ul> </li>
  /// <li>
  /// For Facebook:
  ///
  /// <ul>
  /// <li>
  /// client_id
  /// </li>
  /// <li>
  /// client_secret
  /// </li>
  /// <li>
  /// authorize_scopes
  /// </li>
  /// <li>
  /// api_version
  /// </li>
  /// </ul> </li>
  /// <li>
  /// For Sign in with Apple:
  ///
  /// <ul>
  /// <li>
  /// client_id
  /// </li>
  /// <li>
  /// team_id
  /// </li>
  /// <li>
  /// key_id
  /// </li>
  /// <li>
  /// private_key
  /// </li>
  /// <li>
  /// authorize_scopes
  /// </li>
  /// </ul> </li>
  /// <li>
  /// For OpenID Connect (OIDC) providers:
  ///
  /// <ul>
  /// <li>
  /// client_id
  /// </li>
  /// <li>
  /// client_secret
  /// </li>
  /// <li>
  /// attributes_request_method
  /// </li>
  /// <li>
  /// oidc_issuer
  /// </li>
  /// <li>
  /// authorize_scopes
  /// </li>
  /// <li>
  /// The following keys are only present if Amazon Cognito didn't discover them
  /// at the <code>oidc_issuer</code> URL.
  ///
  /// <ul>
  /// <li>
  /// authorize_url
  /// </li>
  /// <li>
  /// token_url
  /// </li>
  /// <li>
  /// attributes_url
  /// </li>
  /// <li>
  /// jwks_uri
  /// </li>
  /// </ul> </li>
  /// <li>
  /// Amazon Cognito sets the value of the following keys automatically. They
  /// are read-only.
  ///
  /// <ul>
  /// <li>
  /// attributes_url_add_attributes
  /// </li>
  /// </ul> </li>
  /// </ul> </li>
  /// <li>
  /// For SAML providers:
  ///
  /// <ul>
  /// <li>
  /// MetadataFile or MetadataURL
  /// </li>
  /// <li>
  /// IDPSignout <i>optional</i>
  /// </li>
  /// </ul> </li>
  /// </ul>
  ///
  /// Parameter [providerName] :
  /// The IdP name.
  ///
  /// Parameter [providerType] :
  /// The IdP type.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  ///
  /// Parameter [attributeMapping] :
  /// A mapping of IdP attributes to standard and custom user pool attributes.
  ///
  /// Parameter [idpIdentifiers] :
  /// A list of IdP identifiers.
  Future<CreateIdentityProviderResponse> createIdentityProvider({
    required Map<String, String> providerDetails,
    required String providerName,
    required IdentityProviderTypeType providerType,
    required String userPoolId,
    Map<String, String>? attributeMapping,
    List<String>? idpIdentifiers,
  }) async {
    ArgumentError.checkNotNull(providerDetails, 'providerDetails');
    ArgumentError.checkNotNull(providerName, 'providerName');
    _s.validateStringLength(
      'providerName',
      providerName,
      3,
      32,
      isRequired: true,
    );
    ArgumentError.checkNotNull(providerType, 'providerType');
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.CreateIdentityProvider'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ProviderDetails': providerDetails,
        'ProviderName': providerName,
        'ProviderType': providerType.toValue(),
        'UserPoolId': userPoolId,
        if (attributeMapping != null) 'AttributeMapping': attributeMapping,
        if (idpIdentifiers != null) 'IdpIdentifiers': idpIdentifiers,
      },
    );

    return CreateIdentityProviderResponse.fromJson(jsonResponse.body);
  }

  /// Creates a new OAuth2.0 resource server and defines custom scopes within
  /// it.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [LimitExceededException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [identifier] :
  /// A unique resource server identifier for the resource server. This could be
  /// an HTTPS endpoint where the resource server is located, such as
  /// <code>https://my-weather-api.example.com</code>.
  ///
  /// Parameter [name] :
  /// A friendly name for the resource server.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool.
  ///
  /// Parameter [scopes] :
  /// A list of scopes. Each scope is a key-value map with the keys
  /// <code>name</code> and <code>description</code>.
  Future<CreateResourceServerResponse> createResourceServer({
    required String identifier,
    required String name,
    required String userPoolId,
    List<ResourceServerScopeType>? scopes,
  }) async {
    ArgumentError.checkNotNull(identifier, 'identifier');
    _s.validateStringLength(
      'identifier',
      identifier,
      1,
      256,
      isRequired: true,
    );
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      256,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.CreateResourceServer'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Identifier': identifier,
        'Name': name,
        'UserPoolId': userPoolId,
        if (scopes != null) 'Scopes': scopes,
      },
    );

    return CreateResourceServerResponse.fromJson(jsonResponse.body);
  }

  /// Creates the user import job.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [PreconditionNotMetException].
  /// May throw [NotAuthorizedException].
  /// May throw [LimitExceededException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [cloudWatchLogsRoleArn] :
  /// The role ARN for the Amazon CloudWatch Logs Logging role for the user
  /// import job.
  ///
  /// Parameter [jobName] :
  /// The job name for the user import job.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool that the users are being imported into.
  Future<CreateUserImportJobResponse> createUserImportJob({
    required String cloudWatchLogsRoleArn,
    required String jobName,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(cloudWatchLogsRoleArn, 'cloudWatchLogsRoleArn');
    _s.validateStringLength(
      'cloudWatchLogsRoleArn',
      cloudWatchLogsRoleArn,
      20,
      2048,
      isRequired: true,
    );
    ArgumentError.checkNotNull(jobName, 'jobName');
    _s.validateStringLength(
      'jobName',
      jobName,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.CreateUserImportJob'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'CloudWatchLogsRoleArn': cloudWatchLogsRoleArn,
        'JobName': jobName,
        'UserPoolId': userPoolId,
      },
    );

    return CreateUserImportJobResponse.fromJson(jsonResponse.body);
  }

  /// Creates a new Amazon Cognito user pool and sets the password policy for
  /// the pool.
  /// <note>
  /// This action might generate an SMS text message. Starting June 1, 2021, US
  /// telecom carriers require you to register an origination phone number
  /// before you can send SMS messages to US phone numbers. If you use SMS text
  /// messages in Amazon Cognito, you must register a phone number with <a
  /// href="https://console.aws.amazon.com/pinpoint/home/">Amazon Pinpoint</a>.
  /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
  /// Cognito users who must receive SMS messages might not be able to sign up,
  /// activate their accounts, or sign in.
  ///
  /// If you have never used SMS text messages with Amazon Cognito or any other
  /// Amazon Web Service, Amazon Simple Notification Service might place your
  /// account in the SMS sandbox. In <i> <a
  /// href="https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html">sandbox
  /// mode</a> </i>, you can send messages only to verified phone numbers. After
  /// you test your app while in the sandbox environment, you can move out of
  /// the sandbox and into production. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-sms-userpool-settings.html">
  /// SMS message settings for Amazon Cognito user pools</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// </note>
  ///
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [LimitExceededException].
  /// May throw [InvalidSmsRoleAccessPolicyException].
  /// May throw [InvalidSmsRoleTrustRelationshipException].
  /// May throw [InvalidEmailRoleAccessPolicyException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserPoolTaggingException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [poolName] :
  /// A string used to name the user pool.
  ///
  /// Parameter [accountRecoverySetting] :
  /// The available verified method a user can use to recover their password
  /// when they call <code>ForgotPassword</code>. You can use this setting to
  /// define a preferred method when a user has more than one method available.
  /// With this setting, SMS doesn't qualify for a valid password recovery
  /// mechanism if the user also has SMS multi-factor authentication (MFA)
  /// activated. In the absence of this setting, Amazon Cognito uses the legacy
  /// behavior to determine the recovery method where SMS is preferred through
  /// email.
  ///
  /// Parameter [adminCreateUserConfig] :
  /// The configuration for <code>AdminCreateUser</code> requests.
  ///
  /// Parameter [aliasAttributes] :
  /// Attributes supported as an alias for this user pool. Possible values:
  /// <b>phone_number</b>, <b>email</b>, or <b>preferred_username</b>.
  ///
  /// Parameter [autoVerifiedAttributes] :
  /// The attributes to be auto-verified. Possible values: <b>email</b>,
  /// <b>phone_number</b>.
  ///
  /// Parameter [deviceConfiguration] :
  /// The device-remembering configuration for a user pool. A null value
  /// indicates that you have deactivated device remembering in your user pool.
  /// <note>
  /// When you provide a value for any <code>DeviceConfiguration</code> field,
  /// you activate the Amazon Cognito device-remembering feature.
  /// </note>
  ///
  /// Parameter [emailConfiguration] :
  /// The email configuration of your user pool. The email configuration type
  /// sets your preferred sending method, Amazon Web Services Region, and sender
  /// for messages from your user pool.
  ///
  /// Parameter [emailVerificationMessage] :
  /// A string representing the email verification message.
  /// <code>EmailVerificationMessage</code> is allowed only if <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount">EmailSendingAccount</a>
  /// is DEVELOPER.
  ///
  /// Parameter [emailVerificationSubject] :
  /// A string representing the email verification subject.
  /// <code>EmailVerificationSubject</code> is allowed only if <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount">EmailSendingAccount</a>
  /// is DEVELOPER.
  ///
  /// Parameter [lambdaConfig] :
  /// The Lambda trigger configuration information for the new user pool.
  /// <note>
  /// In a push model, event sources (such as Amazon S3 and custom applications)
  /// need permission to invoke a function. So you must make an extra call to
  /// add permission for these event sources to invoke your Lambda function.
  /// <p/>
  /// For more information on using the Lambda API to add permission, see<a
  /// href="https://docs.aws.amazon.com/lambda/latest/dg/API_AddPermission.html">
  /// AddPermission </a>.
  ///
  /// For adding permission using the CLI, see<a
  /// href="https://docs.aws.amazon.com/cli/latest/reference/lambda/add-permission.html">
  /// add-permission </a>.
  /// </note>
  ///
  /// Parameter [mfaConfiguration] :
  /// Specifies MFA configuration details.
  ///
  /// Parameter [policies] :
  /// The policies associated with the new user pool.
  ///
  /// Parameter [schema] :
  /// An array of schema attributes for the new user pool. These attributes can
  /// be standard or custom attributes.
  ///
  /// Parameter [smsAuthenticationMessage] :
  /// A string representing the SMS authentication message.
  ///
  /// Parameter [smsConfiguration] :
  /// The SMS configuration with the settings that your Amazon Cognito user pool
  /// must use to send an SMS message from your Amazon Web Services account
  /// through Amazon Simple Notification Service. To send SMS messages with
  /// Amazon SNS in the Amazon Web Services Region that you want, the Amazon
  /// Cognito user pool uses an Identity and Access Management (IAM) role in
  /// your Amazon Web Services account.
  ///
  /// Parameter [smsVerificationMessage] :
  /// A string representing the SMS verification message.
  ///
  /// Parameter [userAttributeUpdateSettings] :
  /// The settings for updates to user attributes. These settings include the
  /// property <code>AttributesRequireVerificationBeforeUpdate</code>, a
  /// user-pool setting that tells Amazon Cognito how to handle changes to the
  /// value of your users' email address and phone number attributes. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-email-phone-verification.html#user-pool-settings-verifications-verify-attribute-updates">
  /// Verifying updates to email addresses and phone numbers</a>.
  ///
  /// Parameter [userPoolAddOns] :
  /// Enables advanced security risk detection. Set the key
  /// <code>AdvancedSecurityMode</code> to the value "AUDIT".
  ///
  /// Parameter [userPoolTags] :
  /// The tag keys and values to assign to the user pool. A tag is a label that
  /// you can use to categorize and manage user pools in different ways, such as
  /// by purpose, owner, environment, or other criteria.
  ///
  /// Parameter [usernameAttributes] :
  /// Specifies whether a user can use an email address or phone number as a
  /// username when they sign up.
  ///
  /// Parameter [usernameConfiguration] :
  /// Case sensitivity on the username input for the selected sign-in option.
  /// For example, when case sensitivity is set to <code>False</code>, users can
  /// sign in using either "username" or "Username". This configuration is
  /// immutable once it has been set. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_UsernameConfigurationType.html">UsernameConfigurationType</a>.
  ///
  /// Parameter [verificationMessageTemplate] :
  /// The template for the verification message that the user sees when the app
  /// requests permission to access the user's information.
  Future<CreateUserPoolResponse> createUserPool({
    required String poolName,
    AccountRecoverySettingType? accountRecoverySetting,
    AdminCreateUserConfigType? adminCreateUserConfig,
    List<AliasAttributeType>? aliasAttributes,
    List<VerifiedAttributeType>? autoVerifiedAttributes,
    DeviceConfigurationType? deviceConfiguration,
    EmailConfigurationType? emailConfiguration,
    String? emailVerificationMessage,
    String? emailVerificationSubject,
    LambdaConfigType? lambdaConfig,
    UserPoolMfaType? mfaConfiguration,
    UserPoolPolicyType? policies,
    List<SchemaAttributeType>? schema,
    String? smsAuthenticationMessage,
    SmsConfigurationType? smsConfiguration,
    String? smsVerificationMessage,
    UserAttributeUpdateSettingsType? userAttributeUpdateSettings,
    UserPoolAddOnsType? userPoolAddOns,
    Map<String, String>? userPoolTags,
    List<UsernameAttributeType>? usernameAttributes,
    UsernameConfigurationType? usernameConfiguration,
    VerificationMessageTemplateType? verificationMessageTemplate,
  }) async {
    ArgumentError.checkNotNull(poolName, 'poolName');
    _s.validateStringLength(
      'poolName',
      poolName,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringLength(
      'emailVerificationMessage',
      emailVerificationMessage,
      6,
      20000,
    );
    _s.validateStringLength(
      'emailVerificationSubject',
      emailVerificationSubject,
      1,
      140,
    );
    _s.validateStringLength(
      'smsAuthenticationMessage',
      smsAuthenticationMessage,
      6,
      140,
    );
    _s.validateStringLength(
      'smsVerificationMessage',
      smsVerificationMessage,
      6,
      140,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.CreateUserPool'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'PoolName': poolName,
        if (accountRecoverySetting != null)
          'AccountRecoverySetting': accountRecoverySetting,
        if (adminCreateUserConfig != null)
          'AdminCreateUserConfig': adminCreateUserConfig,
        if (aliasAttributes != null)
          'AliasAttributes': aliasAttributes.map((e) => e.toValue()).toList(),
        if (autoVerifiedAttributes != null)
          'AutoVerifiedAttributes':
              autoVerifiedAttributes.map((e) => e.toValue()).toList(),
        if (deviceConfiguration != null)
          'DeviceConfiguration': deviceConfiguration,
        if (emailConfiguration != null)
          'EmailConfiguration': emailConfiguration,
        if (emailVerificationMessage != null)
          'EmailVerificationMessage': emailVerificationMessage,
        if (emailVerificationSubject != null)
          'EmailVerificationSubject': emailVerificationSubject,
        if (lambdaConfig != null) 'LambdaConfig': lambdaConfig,
        if (mfaConfiguration != null)
          'MfaConfiguration': mfaConfiguration.toValue(),
        if (policies != null) 'Policies': policies,
        if (schema != null) 'Schema': schema,
        if (smsAuthenticationMessage != null)
          'SmsAuthenticationMessage': smsAuthenticationMessage,
        if (smsConfiguration != null) 'SmsConfiguration': smsConfiguration,
        if (smsVerificationMessage != null)
          'SmsVerificationMessage': smsVerificationMessage,
        if (userAttributeUpdateSettings != null)
          'UserAttributeUpdateSettings': userAttributeUpdateSettings,
        if (userPoolAddOns != null) 'UserPoolAddOns': userPoolAddOns,
        if (userPoolTags != null) 'UserPoolTags': userPoolTags,
        if (usernameAttributes != null)
          'UsernameAttributes':
              usernameAttributes.map((e) => e.toValue()).toList(),
        if (usernameConfiguration != null)
          'UsernameConfiguration': usernameConfiguration,
        if (verificationMessageTemplate != null)
          'VerificationMessageTemplate': verificationMessageTemplate,
      },
    );

    return CreateUserPoolResponse.fromJson(jsonResponse.body);
  }

  /// Creates the user pool client.
  ///
  /// When you create a new user pool client, token revocation is automatically
  /// activated. For more information about revoking tokens, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_RevokeToken.html">RevokeToken</a>.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [LimitExceededException].
  /// May throw [NotAuthorizedException].
  /// May throw [ScopeDoesNotExistException].
  /// May throw [InvalidOAuthFlowException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [clientName] :
  /// The client name for the user pool client you would like to create.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool where you want to create a user pool
  /// client.
  ///
  /// Parameter [accessTokenValidity] :
  /// The access token time limit. After this limit expires, your user can't use
  /// their access token. To specify the time unit for
  /// <code>AccessTokenValidity</code> as <code>seconds</code>,
  /// <code>minutes</code>, <code>hours</code>, or <code>days</code>, set a
  /// <code>TokenValidityUnits</code> value in your API request.
  ///
  /// For example, when you set <code>AccessTokenValidity</code> to
  /// <code>10</code> and <code>TokenValidityUnits</code> to <code>hours</code>,
  /// your user can authorize access with their access token for 10 hours.
  ///
  /// The default time unit for <code>AccessTokenValidity</code> in an API
  /// request is hours. <i>Valid range</i> is displayed below in seconds.
  ///
  /// Parameter [allowedOAuthFlows] :
  /// The allowed OAuth flows.
  /// <dl> <dt>code</dt> <dd>
  /// Use a code grant flow, which provides an authorization code as the
  /// response. This code can be exchanged for access tokens with the
  /// <code>/oauth2/token</code> endpoint.
  /// </dd> <dt>implicit</dt> <dd>
  /// Issue the access token (and, optionally, ID token, based on scopes)
  /// directly to your user.
  /// </dd> <dt>client_credentials</dt> <dd>
  /// Issue the access token from the <code>/oauth2/token</code> endpoint
  /// directly to a non-person user using a combination of the client ID and
  /// client secret.
  /// </dd> </dl>
  ///
  /// Parameter [allowedOAuthFlowsUserPoolClient] :
  /// Set to true if the client is allowed to follow the OAuth protocol when
  /// interacting with Amazon Cognito user pools.
  ///
  /// Parameter [allowedOAuthScopes] :
  /// The allowed OAuth scopes. Possible values provided by OAuth are
  /// <code>phone</code>, <code>email</code>, <code>openid</code>, and
  /// <code>profile</code>. Possible values provided by Amazon Web Services are
  /// <code>aws.cognito.signin.user.admin</code>. Custom scopes created in
  /// Resource Servers are also supported.
  ///
  /// Parameter [analyticsConfiguration] :
  /// The user pool analytics configuration for collecting metrics and sending
  /// them to your Amazon Pinpoint campaign.
  /// <note>
  /// In Amazon Web Services Regions where Amazon Pinpoint isn't available, user
  /// pools only support sending events to Amazon Pinpoint projects in Amazon
  /// Web Services Region us-east-1. In Regions where Amazon Pinpoint is
  /// available, user pools support sending events to Amazon Pinpoint projects
  /// within that same Region.
  /// </note>
  ///
  /// Parameter [callbackURLs] :
  /// A list of allowed redirect (callback) URLs for the IdPs.
  ///
  /// A redirect URI must:
  ///
  /// <ul>
  /// <li>
  /// Be an absolute URI.
  /// </li>
  /// <li>
  /// Be registered with the authorization server.
  /// </li>
  /// <li>
  /// Not include a fragment component.
  /// </li>
  /// </ul>
  /// See <a href="https://tools.ietf.org/html/rfc6749#section-3.1.2">OAuth 2.0
  /// - Redirection Endpoint</a>.
  ///
  /// Amazon Cognito requires HTTPS over HTTP except for http://localhost for
  /// testing purposes only.
  ///
  /// App callback URLs such as myapp://example are also supported.
  ///
  /// Parameter [defaultRedirectURI] :
  /// The default redirect URI. Must be in the <code>CallbackURLs</code> list.
  ///
  /// A redirect URI must:
  ///
  /// <ul>
  /// <li>
  /// Be an absolute URI.
  /// </li>
  /// <li>
  /// Be registered with the authorization server.
  /// </li>
  /// <li>
  /// Not include a fragment component.
  /// </li>
  /// </ul>
  /// See <a href="https://tools.ietf.org/html/rfc6749#section-3.1.2">OAuth 2.0
  /// - Redirection Endpoint</a>.
  ///
  /// Amazon Cognito requires HTTPS over HTTP except for http://localhost for
  /// testing purposes only.
  ///
  /// App callback URLs such as myapp://example are also supported.
  ///
  /// Parameter [enablePropagateAdditionalUserContextData] :
  /// Activates the propagation of additional user context data. For more
  /// information about propagation of user context data, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-advanced-security.html">
  /// Adding advanced security to a user pool</a>. If you don’t include this
  /// parameter, you can't send device fingerprint information, including source
  /// IP address, to Amazon Cognito advanced security. You can only activate
  /// <code>EnablePropagateAdditionalUserContextData</code> in an app client
  /// that has a client secret.
  ///
  /// Parameter [enableTokenRevocation] :
  /// Activates or deactivates token revocation. For more information about
  /// revoking tokens, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_RevokeToken.html">RevokeToken</a>.
  ///
  /// If you don't include this parameter, token revocation is automatically
  /// activated for the new user pool client.
  ///
  /// Parameter [explicitAuthFlows] :
  /// The authentication flows that are supported by the user pool clients. Flow
  /// names without the <code>ALLOW_</code> prefix are no longer supported, in
  /// favor of new names with the <code>ALLOW_</code> prefix.
  /// <note>
  /// Values with <code>ALLOW_</code> prefix must be used only along with the
  /// <code>ALLOW_</code> prefix.
  /// </note>
  /// Valid values include:
  /// <dl> <dt>ALLOW_ADMIN_USER_PASSWORD_AUTH</dt> <dd>
  /// Enable admin based user password authentication flow
  /// <code>ADMIN_USER_PASSWORD_AUTH</code>. This setting replaces the
  /// <code>ADMIN_NO_SRP_AUTH</code> setting. With this authentication flow,
  /// Amazon Cognito receives the password in the request instead of using the
  /// Secure Remote Password (SRP) protocol to verify passwords.
  /// </dd> <dt>ALLOW_CUSTOM_AUTH</dt> <dd>
  /// Enable Lambda trigger based authentication.
  /// </dd> <dt>ALLOW_USER_PASSWORD_AUTH</dt> <dd>
  /// Enable user password-based authentication. In this flow, Amazon Cognito
  /// receives the password in the request instead of using the SRP protocol to
  /// verify passwords.
  /// </dd> <dt>ALLOW_USER_SRP_AUTH</dt> <dd>
  /// Enable SRP-based authentication.
  /// </dd> <dt>ALLOW_REFRESH_TOKEN_AUTH</dt> <dd>
  /// Enable the authflow that refreshes tokens.
  /// </dd> </dl>
  /// If you don't specify a value for <code>ExplicitAuthFlows</code>, your user
  /// client supports <code>ALLOW_USER_SRP_AUTH</code> and
  /// <code>ALLOW_CUSTOM_AUTH</code>.
  ///
  /// Parameter [generateSecret] :
  /// Boolean to specify whether you want to generate a secret for the user pool
  /// client being created.
  ///
  /// Parameter [idTokenValidity] :
  /// The ID token time limit. After this limit expires, your user can't use
  /// their ID token. To specify the time unit for <code>IdTokenValidity</code>
  /// as <code>seconds</code>, <code>minutes</code>, <code>hours</code>, or
  /// <code>days</code>, set a <code>TokenValidityUnits</code> value in your API
  /// request.
  ///
  /// For example, when you set <code>IdTokenValidity</code> as <code>10</code>
  /// and <code>TokenValidityUnits</code> as <code>hours</code>, your user can
  /// authenticate their session with their ID token for 10 hours.
  ///
  /// The default time unit for <code>AccessTokenValidity</code> in an API
  /// request is hours. <i>Valid range</i> is displayed below in seconds.
  ///
  /// Parameter [logoutURLs] :
  /// A list of allowed logout URLs for the IdPs.
  ///
  /// Parameter [preventUserExistenceErrors] :
  /// Errors and responses that you want Amazon Cognito APIs to return during
  /// authentication, account confirmation, and password recovery when the user
  /// doesn't exist in the user pool. When set to <code>ENABLED</code> and the
  /// user doesn't exist, authentication returns an error indicating either the
  /// username or password was incorrect. Account confirmation and password
  /// recovery return a response indicating a code was sent to a simulated
  /// destination. When set to <code>LEGACY</code>, those APIs return a
  /// <code>UserNotFoundException</code> exception if the user doesn't exist in
  /// the user pool.
  ///
  /// Valid values include:
  ///
  /// <ul>
  /// <li>
  /// <code>ENABLED</code> - This prevents user existence-related errors.
  /// </li>
  /// <li>
  /// <code>LEGACY</code> - This represents the early behavior of Amazon Cognito
  /// where user existence related errors aren't prevented.
  /// </li>
  /// </ul>
  ///
  /// Parameter [readAttributes] :
  /// The read attributes.
  ///
  /// Parameter [refreshTokenValidity] :
  /// The refresh token time limit. After this limit expires, your user can't
  /// use their refresh token. To specify the time unit for
  /// <code>RefreshTokenValidity</code> as <code>seconds</code>,
  /// <code>minutes</code>, <code>hours</code>, or <code>days</code>, set a
  /// <code>TokenValidityUnits</code> value in your API request.
  ///
  /// For example, when you set <code>RefreshTokenValidity</code> as
  /// <code>10</code> and <code>TokenValidityUnits</code> as <code>days</code>,
  /// your user can refresh their session and retrieve new access and ID tokens
  /// for 10 days.
  ///
  /// The default time unit for <code>RefreshTokenValidity</code> in an API
  /// request is days. You can't set <code>RefreshTokenValidity</code> to 0. If
  /// you do, Amazon Cognito overrides the value with the default value of 30
  /// days. <i>Valid range</i> is displayed below in seconds.
  ///
  /// Parameter [supportedIdentityProviders] :
  /// A list of provider names for the identity providers (IdPs) that are
  /// supported on this client. The following are supported:
  /// <code>COGNITO</code>, <code>Facebook</code>, <code>Google</code>,
  /// <code>SignInWithApple</code>, and <code>LoginWithAmazon</code>. You can
  /// also specify the names that you configured for the SAML and OIDC IdPs in
  /// your user pool, for example <code>MySAMLIdP</code> or
  /// <code>MyOIDCIdP</code>.
  ///
  /// Parameter [tokenValidityUnits] :
  /// The units in which the validity times are represented. The default unit
  /// for RefreshToken is days, and default for ID and access tokens are hours.
  ///
  /// Parameter [writeAttributes] :
  /// The user pool attributes that the app client can write to.
  ///
  /// If your app client allows users to sign in through an IdP, this array must
  /// include all attributes that you have mapped to IdP attributes. Amazon
  /// Cognito updates mapped attributes when users sign in to your application
  /// through an IdP. If your app client does not have write access to a mapped
  /// attribute, Amazon Cognito throws an error when it tries to update the
  /// attribute. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-specifying-attribute-mapping.html">Specifying
  /// IdP Attribute Mappings for Your user pool</a>.
  Future<CreateUserPoolClientResponse> createUserPoolClient({
    required String clientName,
    required String userPoolId,
    int? accessTokenValidity,
    List<OAuthFlowType>? allowedOAuthFlows,
    bool? allowedOAuthFlowsUserPoolClient,
    List<String>? allowedOAuthScopes,
    AnalyticsConfigurationType? analyticsConfiguration,
    List<String>? callbackURLs,
    String? defaultRedirectURI,
    bool? enablePropagateAdditionalUserContextData,
    bool? enableTokenRevocation,
    List<ExplicitAuthFlowsType>? explicitAuthFlows,
    bool? generateSecret,
    int? idTokenValidity,
    List<String>? logoutURLs,
    PreventUserExistenceErrorTypes? preventUserExistenceErrors,
    List<String>? readAttributes,
    int? refreshTokenValidity,
    List<String>? supportedIdentityProviders,
    TokenValidityUnitsType? tokenValidityUnits,
    List<String>? writeAttributes,
  }) async {
    ArgumentError.checkNotNull(clientName, 'clientName');
    _s.validateStringLength(
      'clientName',
      clientName,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateNumRange(
      'accessTokenValidity',
      accessTokenValidity,
      1,
      86400,
    );
    _s.validateStringLength(
      'defaultRedirectURI',
      defaultRedirectURI,
      1,
      1024,
    );
    _s.validateNumRange(
      'idTokenValidity',
      idTokenValidity,
      1,
      86400,
    );
    _s.validateNumRange(
      'refreshTokenValidity',
      refreshTokenValidity,
      0,
      315360000,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.CreateUserPoolClient'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ClientName': clientName,
        'UserPoolId': userPoolId,
        if (accessTokenValidity != null)
          'AccessTokenValidity': accessTokenValidity,
        if (allowedOAuthFlows != null)
          'AllowedOAuthFlows':
              allowedOAuthFlows.map((e) => e.toValue()).toList(),
        if (allowedOAuthFlowsUserPoolClient != null)
          'AllowedOAuthFlowsUserPoolClient': allowedOAuthFlowsUserPoolClient,
        if (allowedOAuthScopes != null)
          'AllowedOAuthScopes': allowedOAuthScopes,
        if (analyticsConfiguration != null)
          'AnalyticsConfiguration': analyticsConfiguration,
        if (callbackURLs != null) 'CallbackURLs': callbackURLs,
        if (defaultRedirectURI != null)
          'DefaultRedirectURI': defaultRedirectURI,
        if (enablePropagateAdditionalUserContextData != null)
          'EnablePropagateAdditionalUserContextData':
              enablePropagateAdditionalUserContextData,
        if (enableTokenRevocation != null)
          'EnableTokenRevocation': enableTokenRevocation,
        if (explicitAuthFlows != null)
          'ExplicitAuthFlows':
              explicitAuthFlows.map((e) => e.toValue()).toList(),
        if (generateSecret != null) 'GenerateSecret': generateSecret,
        if (idTokenValidity != null) 'IdTokenValidity': idTokenValidity,
        if (logoutURLs != null) 'LogoutURLs': logoutURLs,
        if (preventUserExistenceErrors != null)
          'PreventUserExistenceErrors': preventUserExistenceErrors.toValue(),
        if (readAttributes != null) 'ReadAttributes': readAttributes,
        if (refreshTokenValidity != null)
          'RefreshTokenValidity': refreshTokenValidity,
        if (supportedIdentityProviders != null)
          'SupportedIdentityProviders': supportedIdentityProviders,
        if (tokenValidityUnits != null)
          'TokenValidityUnits': tokenValidityUnits,
        if (writeAttributes != null) 'WriteAttributes': writeAttributes,
      },
    );

    return CreateUserPoolClientResponse.fromJson(jsonResponse.body);
  }

  /// Creates a new domain for a user pool.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [ResourceNotFoundException].
  /// May throw [LimitExceededException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [domain] :
  /// The domain string. For custom domains, this is the fully-qualified domain
  /// name, such as <code>auth.example.com</code>. For Amazon Cognito prefix
  /// domains, this is the prefix alone, such as <code>auth</code>.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  ///
  /// Parameter [customDomainConfig] :
  /// The configuration for a custom domain that hosts the sign-up and sign-in
  /// webpages for your application.
  ///
  /// Provide this parameter only if you want to use a custom domain for your
  /// user pool. Otherwise, you can exclude this parameter and use the Amazon
  /// Cognito hosted domain instead.
  ///
  /// For more information about the hosted domain and custom domains, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-assign-domain.html">Configuring
  /// a User Pool Domain</a>.
  Future<CreateUserPoolDomainResponse> createUserPoolDomain({
    required String domain,
    required String userPoolId,
    CustomDomainConfigType? customDomainConfig,
  }) async {
    ArgumentError.checkNotNull(domain, 'domain');
    _s.validateStringLength(
      'domain',
      domain,
      1,
      63,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.CreateUserPoolDomain'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Domain': domain,
        'UserPoolId': userPoolId,
        if (customDomainConfig != null)
          'CustomDomainConfig': customDomainConfig,
      },
    );

    return CreateUserPoolDomainResponse.fromJson(jsonResponse.body);
  }

  /// Deletes a group.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [groupName] :
  /// The name of the group.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool.
  Future<void> deleteGroup({
    required String groupName,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(groupName, 'groupName');
    _s.validateStringLength(
      'groupName',
      groupName,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.DeleteGroup'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'GroupName': groupName,
        'UserPoolId': userPoolId,
      },
    );
  }

  /// Deletes an IdP for a user pool.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [UnsupportedIdentityProviderException].
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [providerName] :
  /// The IdP name.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  Future<void> deleteIdentityProvider({
    required String providerName,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(providerName, 'providerName');
    _s.validateStringLength(
      'providerName',
      providerName,
      1,
      32,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.DeleteIdentityProvider'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ProviderName': providerName,
        'UserPoolId': userPoolId,
      },
    );
  }

  /// Deletes a resource server.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [identifier] :
  /// The identifier for the resource server.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool that hosts the resource server.
  Future<void> deleteResourceServer({
    required String identifier,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(identifier, 'identifier');
    _s.validateStringLength(
      'identifier',
      identifier,
      1,
      256,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.DeleteResourceServer'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Identifier': identifier,
        'UserPoolId': userPoolId,
      },
    );
  }

  /// Allows a user to delete himself or herself.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [accessToken] :
  /// A valid access token that Amazon Cognito issued to the user whose user
  /// profile you want to delete.
  Future<void> deleteUser({
    required String accessToken,
  }) async {
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.DeleteUser'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      signed: false,
      // TODO queryParams
      headers: headers,
      payload: {
        'AccessToken': accessToken,
      },
    );
  }

  /// Deletes the attributes for a user.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [accessToken] :
  /// A valid access token that Amazon Cognito issued to the user whose
  /// attributes you want to delete.
  ///
  /// Parameter [userAttributeNames] :
  /// An array of strings representing the user attribute names you want to
  /// delete.
  ///
  /// For custom attributes, you must prependattach the <code>custom:</code>
  /// prefix to the front of the attribute name.
  Future<void> deleteUserAttributes({
    required String accessToken,
    required List<String> userAttributeNames,
  }) async {
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    ArgumentError.checkNotNull(userAttributeNames, 'userAttributeNames');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.DeleteUserAttributes'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      signed: false,
      // TODO queryParams
      headers: headers,
      payload: {
        'AccessToken': accessToken,
        'UserAttributeNames': userAttributeNames,
      },
    );
  }

  /// Deletes the specified Amazon Cognito user pool.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserImportInProgressException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool you want to delete.
  Future<void> deleteUserPool({
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.DeleteUserPool'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
      },
    );
  }

  /// Allows the developer to delete the user pool client.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [clientId] :
  /// The app client ID of the app associated with the user pool.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool where you want to delete the client.
  Future<void> deleteUserPoolClient({
    required String clientId,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(clientId, 'clientId');
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.DeleteUserPoolClient'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ClientId': clientId,
        'UserPoolId': userPoolId,
      },
    );
  }

  /// Deletes a domain for a user pool.
  ///
  /// May throw [NotAuthorizedException].
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [domain] :
  /// The domain string. For custom domains, this is the fully-qualified domain
  /// name, such as <code>auth.example.com</code>. For Amazon Cognito prefix
  /// domains, this is the prefix alone, such as <code>auth</code>.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  Future<void> deleteUserPoolDomain({
    required String domain,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(domain, 'domain');
    _s.validateStringLength(
      'domain',
      domain,
      1,
      63,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.DeleteUserPoolDomain'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Domain': domain,
        'UserPoolId': userPoolId,
      },
    );
  }

  /// Gets information about a specific IdP.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [providerName] :
  /// The IdP name.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  Future<DescribeIdentityProviderResponse> describeIdentityProvider({
    required String providerName,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(providerName, 'providerName');
    _s.validateStringLength(
      'providerName',
      providerName,
      1,
      32,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSCognitoIdentityProviderService.DescribeIdentityProvider'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ProviderName': providerName,
        'UserPoolId': userPoolId,
      },
    );

    return DescribeIdentityProviderResponse.fromJson(jsonResponse.body);
  }

  /// Describes a resource server.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [identifier] :
  /// The identifier for the resource server
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool that hosts the resource server.
  Future<DescribeResourceServerResponse> describeResourceServer({
    required String identifier,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(identifier, 'identifier');
    _s.validateStringLength(
      'identifier',
      identifier,
      1,
      256,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.DescribeResourceServer'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Identifier': identifier,
        'UserPoolId': userPoolId,
      },
    );

    return DescribeResourceServerResponse.fromJson(jsonResponse.body);
  }

  /// Describes the risk configuration.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserPoolAddOnNotEnabledException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  ///
  /// Parameter [clientId] :
  /// The app client ID.
  Future<DescribeRiskConfigurationResponse> describeRiskConfiguration({
    required String userPoolId,
    String? clientId,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSCognitoIdentityProviderService.DescribeRiskConfiguration'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        if (clientId != null) 'ClientId': clientId,
      },
    );

    return DescribeRiskConfigurationResponse.fromJson(jsonResponse.body);
  }

  /// Describes the user import job.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [jobId] :
  /// The job ID for the user import job.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool that the users are being imported into.
  Future<DescribeUserImportJobResponse> describeUserImportJob({
    required String jobId,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(jobId, 'jobId');
    _s.validateStringLength(
      'jobId',
      jobId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.DescribeUserImportJob'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'JobId': jobId,
        'UserPoolId': userPoolId,
      },
    );

    return DescribeUserImportJobResponse.fromJson(jsonResponse.body);
  }

  /// Returns the configuration information and metadata of the specified user
  /// pool.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserPoolTaggingException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool you want to describe.
  Future<DescribeUserPoolResponse> describeUserPool({
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.DescribeUserPool'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
      },
    );

    return DescribeUserPoolResponse.fromJson(jsonResponse.body);
  }

  /// Client method for returning the configuration information and metadata of
  /// the specified user pool app client.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [clientId] :
  /// The app client ID of the app associated with the user pool.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool you want to describe.
  Future<DescribeUserPoolClientResponse> describeUserPoolClient({
    required String clientId,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(clientId, 'clientId');
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.DescribeUserPoolClient'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ClientId': clientId,
        'UserPoolId': userPoolId,
      },
    );

    return DescribeUserPoolClientResponse.fromJson(jsonResponse.body);
  }

  /// Gets information about a domain.
  ///
  /// May throw [NotAuthorizedException].
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [domain] :
  /// The domain string. For custom domains, this is the fully-qualified domain
  /// name, such as <code>auth.example.com</code>. For Amazon Cognito prefix
  /// domains, this is the prefix alone, such as <code>auth</code>.
  Future<DescribeUserPoolDomainResponse> describeUserPoolDomain({
    required String domain,
  }) async {
    ArgumentError.checkNotNull(domain, 'domain');
    _s.validateStringLength(
      'domain',
      domain,
      1,
      63,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.DescribeUserPoolDomain'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Domain': domain,
      },
    );

    return DescribeUserPoolDomainResponse.fromJson(jsonResponse.body);
  }

  /// Forgets the specified device.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [InvalidUserPoolConfigurationException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [deviceKey] :
  /// The device key.
  ///
  /// Parameter [accessToken] :
  /// A valid access token that Amazon Cognito issued to the user whose
  /// registered device you want to forget.
  Future<void> forgetDevice({
    required String deviceKey,
    String? accessToken,
  }) async {
    ArgumentError.checkNotNull(deviceKey, 'deviceKey');
    _s.validateStringLength(
      'deviceKey',
      deviceKey,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ForgetDevice'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'DeviceKey': deviceKey,
        if (accessToken != null) 'AccessToken': accessToken,
      },
    );
  }

  /// Calling this API causes a message to be sent to the end user with a
  /// confirmation code that is required to change the user's password. For the
  /// <code>Username</code> parameter, you can use the username or user alias.
  /// The method used to send the confirmation code is sent according to the
  /// specified AccountRecoverySetting. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/how-to-recover-a-user-account.html">Recovering
  /// User Accounts</a> in the <i>Amazon Cognito Developer Guide</i>. If neither
  /// a verified phone number nor a verified email exists, an
  /// <code>InvalidParameterException</code> is thrown. To use the confirmation
  /// code for resetting the password, call <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_ConfirmForgotPassword.html">ConfirmForgotPassword</a>.
  /// <note>
  /// This action might generate an SMS text message. Starting June 1, 2021, US
  /// telecom carriers require you to register an origination phone number
  /// before you can send SMS messages to US phone numbers. If you use SMS text
  /// messages in Amazon Cognito, you must register a phone number with <a
  /// href="https://console.aws.amazon.com/pinpoint/home/">Amazon Pinpoint</a>.
  /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
  /// Cognito users who must receive SMS messages might not be able to sign up,
  /// activate their accounts, or sign in.
  ///
  /// If you have never used SMS text messages with Amazon Cognito or any other
  /// Amazon Web Service, Amazon Simple Notification Service might place your
  /// account in the SMS sandbox. In <i> <a
  /// href="https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html">sandbox
  /// mode</a> </i>, you can send messages only to verified phone numbers. After
  /// you test your app while in the sandbox environment, you can move out of
  /// the sandbox and into production. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-sms-userpool-settings.html">
  /// SMS message settings for Amazon Cognito user pools</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// </note>
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [UnexpectedLambdaException].
  /// May throw [UserLambdaValidationException].
  /// May throw [NotAuthorizedException].
  /// May throw [InvalidLambdaResponseException].
  /// May throw [TooManyRequestsException].
  /// May throw [LimitExceededException].
  /// May throw [InvalidSmsRoleAccessPolicyException].
  /// May throw [InvalidSmsRoleTrustRelationshipException].
  /// May throw [InvalidEmailRoleAccessPolicyException].
  /// May throw [CodeDeliveryFailureException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [clientId] :
  /// The ID of the client associated with the user pool.
  ///
  /// Parameter [username] :
  /// The user name of the user for whom you want to enter a code to reset a
  /// forgotten password.
  ///
  /// Parameter [analyticsMetadata] :
  /// The Amazon Pinpoint analytics metadata that contributes to your metrics
  /// for <code>ForgotPassword</code> calls.
  ///
  /// Parameter [clientMetadata] :
  /// A map of custom key-value pairs that you can provide as input for any
  /// custom workflows that this action triggers.
  ///
  /// You create custom workflows by assigning Lambda functions to user pool
  /// triggers. When you use the ForgotPassword API action, Amazon Cognito
  /// invokes any functions that are assigned to the following triggers: <i>pre
  /// sign-up</i>, <i>custom message</i>, and <i>user migration</i>. When Amazon
  /// Cognito invokes any of these functions, it passes a JSON payload, which
  /// the function receives as input. This payload contains a
  /// <code>clientMetadata</code> attribute, which provides the data that you
  /// assigned to the ClientMetadata parameter in your ForgotPassword request.
  /// In your function code in Lambda, you can process the
  /// <code>clientMetadata</code> value to enhance your workflow for your
  /// specific needs.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html">
  /// Customizing user pool Workflows with Lambda Triggers</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// <note>
  /// When you use the ClientMetadata parameter, remember that Amazon Cognito
  /// won't do the following:
  ///
  /// <ul>
  /// <li>
  /// Store the ClientMetadata value. This data is available only to Lambda
  /// triggers that are assigned to a user pool to support custom workflows. If
  /// your user pool configuration doesn't include triggers, the ClientMetadata
  /// parameter serves no purpose.
  /// </li>
  /// <li>
  /// Validate the ClientMetadata value.
  /// </li>
  /// <li>
  /// Encrypt the ClientMetadata value. Don't use Amazon Cognito to provide
  /// sensitive information.
  /// </li>
  /// </ul> </note>
  ///
  /// Parameter [secretHash] :
  /// A keyed-hash message authentication code (HMAC) calculated using the
  /// secret key of a user pool client and username plus the client ID in the
  /// message.
  ///
  /// Parameter [userContextData] :
  /// Contextual data about your user session, such as the device fingerprint,
  /// IP address, or location. Amazon Cognito advanced security evaluates the
  /// risk of an authentication event based on the context that your app
  /// generates and passes to Amazon Cognito when it makes API requests.
  Future<ForgotPasswordResponse> forgotPassword({
    required String clientId,
    required String username,
    AnalyticsMetadataType? analyticsMetadata,
    Map<String, String>? clientMetadata,
    String? secretHash,
    UserContextDataType? userContextData,
  }) async {
    ArgumentError.checkNotNull(clientId, 'clientId');
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringLength(
      'secretHash',
      secretHash,
      1,
      128,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ForgotPassword'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      signed: false,
      // TODO queryParams
      headers: headers,
      payload: {
        'ClientId': clientId,
        'Username': username,
        if (analyticsMetadata != null) 'AnalyticsMetadata': analyticsMetadata,
        if (clientMetadata != null) 'ClientMetadata': clientMetadata,
        if (secretHash != null) 'SecretHash': secretHash,
        if (userContextData != null) 'UserContextData': userContextData,
      },
    );

    return ForgotPasswordResponse.fromJson(jsonResponse.body);
  }

  /// Gets the header information for the comma-separated value (CSV) file to be
  /// used as input for the user import job.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool that the users are to be imported into.
  Future<GetCSVHeaderResponse> getCSVHeader({
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.GetCSVHeader'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
      },
    );

    return GetCSVHeaderResponse.fromJson(jsonResponse.body);
  }

  /// Gets the device.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [InvalidUserPoolConfigurationException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [deviceKey] :
  /// The device key.
  ///
  /// Parameter [accessToken] :
  /// A valid access token that Amazon Cognito issued to the user whose device
  /// information you want to request.
  Future<GetDeviceResponse> getDevice({
    required String deviceKey,
    String? accessToken,
  }) async {
    ArgumentError.checkNotNull(deviceKey, 'deviceKey');
    _s.validateStringLength(
      'deviceKey',
      deviceKey,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.GetDevice'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'DeviceKey': deviceKey,
        if (accessToken != null) 'AccessToken': accessToken,
      },
    );

    return GetDeviceResponse.fromJson(jsonResponse.body);
  }

  /// Gets a group.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [groupName] :
  /// The name of the group.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool.
  Future<GetGroupResponse> getGroup({
    required String groupName,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(groupName, 'groupName');
    _s.validateStringLength(
      'groupName',
      groupName,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.GetGroup'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'GroupName': groupName,
        'UserPoolId': userPoolId,
      },
    );

    return GetGroupResponse.fromJson(jsonResponse.body);
  }

  /// Gets the specified IdP.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [idpIdentifier] :
  /// The IdP identifier.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  Future<GetIdentityProviderByIdentifierResponse>
      getIdentityProviderByIdentifier({
    required String idpIdentifier,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(idpIdentifier, 'idpIdentifier');
    _s.validateStringLength(
      'idpIdentifier',
      idpIdentifier,
      1,
      40,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSCognitoIdentityProviderService.GetIdentityProviderByIdentifier'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'IdpIdentifier': idpIdentifier,
        'UserPoolId': userPoolId,
      },
    );

    return GetIdentityProviderByIdentifierResponse.fromJson(jsonResponse.body);
  }

  /// This method takes a user pool ID, and returns the signing certificate.
  ///
  /// May throw [InternalErrorException].
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  Future<GetSigningCertificateResponse> getSigningCertificate({
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.GetSigningCertificate'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
      },
    );

    return GetSigningCertificateResponse.fromJson(jsonResponse.body);
  }

  /// Gets the user interface (UI) Customization information for a particular
  /// app client's app UI, if any such information exists for the client. If
  /// nothing is set for the particular client, but there is an existing pool
  /// level customization (the app <code>clientId</code> is <code>ALL</code>),
  /// then that information is returned. If nothing is present, then an empty
  /// shape is returned.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool.
  ///
  /// Parameter [clientId] :
  /// The client ID for the client app.
  Future<GetUICustomizationResponse> getUICustomization({
    required String userPoolId,
    String? clientId,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.GetUICustomization'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        if (clientId != null) 'ClientId': clientId,
      },
    );

    return GetUICustomizationResponse.fromJson(jsonResponse.body);
  }

  /// Gets the user attributes and metadata for a user.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [accessToken] :
  /// A non-expired access token for the user whose information you want to
  /// query.
  Future<GetUserResponse> getUser({
    required String accessToken,
  }) async {
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.GetUser'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      signed: false,
      // TODO queryParams
      headers: headers,
      payload: {
        'AccessToken': accessToken,
      },
    );

    return GetUserResponse.fromJson(jsonResponse.body);
  }

  /// Generates a user attribute verification code for the specified attribute
  /// name. Sends a message to a user with a code that they must return in a
  /// VerifyUserAttribute request.
  /// <note>
  /// This action might generate an SMS text message. Starting June 1, 2021, US
  /// telecom carriers require you to register an origination phone number
  /// before you can send SMS messages to US phone numbers. If you use SMS text
  /// messages in Amazon Cognito, you must register a phone number with <a
  /// href="https://console.aws.amazon.com/pinpoint/home/">Amazon Pinpoint</a>.
  /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
  /// Cognito users who must receive SMS messages might not be able to sign up,
  /// activate their accounts, or sign in.
  ///
  /// If you have never used SMS text messages with Amazon Cognito or any other
  /// Amazon Web Service, Amazon Simple Notification Service might place your
  /// account in the SMS sandbox. In <i> <a
  /// href="https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html">sandbox
  /// mode</a> </i>, you can send messages only to verified phone numbers. After
  /// you test your app while in the sandbox environment, you can move out of
  /// the sandbox and into production. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-sms-userpool-settings.html">
  /// SMS message settings for Amazon Cognito user pools</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// </note>
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UnexpectedLambdaException].
  /// May throw [UserLambdaValidationException].
  /// May throw [InvalidLambdaResponseException].
  /// May throw [InvalidSmsRoleAccessPolicyException].
  /// May throw [InvalidSmsRoleTrustRelationshipException].
  /// May throw [InvalidEmailRoleAccessPolicyException].
  /// May throw [CodeDeliveryFailureException].
  /// May throw [LimitExceededException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [accessToken] :
  /// A non-expired access token for the user whose attribute verification code
  /// you want to generate.
  ///
  /// Parameter [attributeName] :
  /// The attribute name returned by the server response to get the user
  /// attribute verification code.
  ///
  /// Parameter [clientMetadata] :
  /// A map of custom key-value pairs that you can provide as input for any
  /// custom workflows that this action triggers.
  ///
  /// You create custom workflows by assigning Lambda functions to user pool
  /// triggers. When you use the GetUserAttributeVerificationCode API action,
  /// Amazon Cognito invokes the function that is assigned to the <i>custom
  /// message</i> trigger. When Amazon Cognito invokes this function, it passes
  /// a JSON payload, which the function receives as input. This payload
  /// contains a <code>clientMetadata</code> attribute, which provides the data
  /// that you assigned to the ClientMetadata parameter in your
  /// GetUserAttributeVerificationCode request. In your function code in Lambda,
  /// you can process the <code>clientMetadata</code> value to enhance your
  /// workflow for your specific needs.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html">
  /// Customizing user pool Workflows with Lambda Triggers</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// <note>
  /// When you use the ClientMetadata parameter, remember that Amazon Cognito
  /// won't do the following:
  ///
  /// <ul>
  /// <li>
  /// Store the ClientMetadata value. This data is available only to Lambda
  /// triggers that are assigned to a user pool to support custom workflows. If
  /// your user pool configuration doesn't include triggers, the ClientMetadata
  /// parameter serves no purpose.
  /// </li>
  /// <li>
  /// Validate the ClientMetadata value.
  /// </li>
  /// <li>
  /// Encrypt the ClientMetadata value. Don't use Amazon Cognito to provide
  /// sensitive information.
  /// </li>
  /// </ul> </note>
  Future<GetUserAttributeVerificationCodeResponse>
      getUserAttributeVerificationCode({
    required String accessToken,
    required String attributeName,
    Map<String, String>? clientMetadata,
  }) async {
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    ArgumentError.checkNotNull(attributeName, 'attributeName');
    _s.validateStringLength(
      'attributeName',
      attributeName,
      1,
      32,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSCognitoIdentityProviderService.GetUserAttributeVerificationCode'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      signed: false,
      // TODO queryParams
      headers: headers,
      payload: {
        'AccessToken': accessToken,
        'AttributeName': attributeName,
        if (clientMetadata != null) 'ClientMetadata': clientMetadata,
      },
    );

    return GetUserAttributeVerificationCodeResponse.fromJson(jsonResponse.body);
  }

  /// Gets the user pool multi-factor authentication (MFA) configuration.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  Future<GetUserPoolMfaConfigResponse> getUserPoolMfaConfig({
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.GetUserPoolMfaConfig'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
      },
    );

    return GetUserPoolMfaConfigResponse.fromJson(jsonResponse.body);
  }

  /// Signs out users from all devices. It also invalidates all refresh tokens
  /// that Amazon Cognito has issued to a user. The user's current access and ID
  /// tokens remain valid until their expiry. By default, access and ID tokens
  /// expire one hour after Amazon Cognito issues them. A user can still use a
  /// hosted UI cookie to retrieve new tokens for the duration of the cookie
  /// validity period of 1 hour.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [accessToken] :
  /// A valid access token that Amazon Cognito issued to the user who you want
  /// to sign out.
  Future<void> globalSignOut({
    required String accessToken,
  }) async {
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.GlobalSignOut'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AccessToken': accessToken,
      },
    );
  }

  /// Initiates sign-in for a user in the Amazon Cognito user directory. You
  /// can't sign in a user with a federated IdP with <code>InitiateAuth</code>.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-identity-federation.html">
  /// Adding user pool sign-in through a third party</a>.
  /// <note>
  /// This action might generate an SMS text message. Starting June 1, 2021, US
  /// telecom carriers require you to register an origination phone number
  /// before you can send SMS messages to US phone numbers. If you use SMS text
  /// messages in Amazon Cognito, you must register a phone number with <a
  /// href="https://console.aws.amazon.com/pinpoint/home/">Amazon Pinpoint</a>.
  /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
  /// Cognito users who must receive SMS messages might not be able to sign up,
  /// activate their accounts, or sign in.
  ///
  /// If you have never used SMS text messages with Amazon Cognito or any other
  /// Amazon Web Service, Amazon Simple Notification Service might place your
  /// account in the SMS sandbox. In <i> <a
  /// href="https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html">sandbox
  /// mode</a> </i>, you can send messages only to verified phone numbers. After
  /// you test your app while in the sandbox environment, you can move out of
  /// the sandbox and into production. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-sms-userpool-settings.html">
  /// SMS message settings for Amazon Cognito user pools</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// </note>
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [UnexpectedLambdaException].
  /// May throw [InvalidUserPoolConfigurationException].
  /// May throw [UserLambdaValidationException].
  /// May throw [InvalidLambdaResponseException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [InvalidSmsRoleAccessPolicyException].
  /// May throw [InvalidSmsRoleTrustRelationshipException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [authFlow] :
  /// The authentication flow for this call to run. The API action will depend
  /// on this value. For example:
  ///
  /// <ul>
  /// <li>
  /// <code>REFRESH_TOKEN_AUTH</code> takes in a valid refresh token and returns
  /// new tokens.
  /// </li>
  /// <li>
  /// <code>USER_SRP_AUTH</code> takes in <code>USERNAME</code> and
  /// <code>SRP_A</code> and returns the SRP variables to be used for next
  /// challenge execution.
  /// </li>
  /// <li>
  /// <code>USER_PASSWORD_AUTH</code> takes in <code>USERNAME</code> and
  /// <code>PASSWORD</code> and returns the next challenge or tokens.
  /// </li>
  /// </ul>
  /// Valid values include:
  ///
  /// <ul>
  /// <li>
  /// <code>USER_SRP_AUTH</code>: Authentication flow for the Secure Remote
  /// Password (SRP) protocol.
  /// </li>
  /// <li>
  /// <code>REFRESH_TOKEN_AUTH</code>/<code>REFRESH_TOKEN</code>: Authentication
  /// flow for refreshing the access token and ID token by supplying a valid
  /// refresh token.
  /// </li>
  /// <li>
  /// <code>CUSTOM_AUTH</code>: Custom authentication flow.
  /// </li>
  /// <li>
  /// <code>USER_PASSWORD_AUTH</code>: Non-SRP authentication flow; user name
  /// and password are passed directly. If a user migration Lambda trigger is
  /// set, this flow will invoke the user migration Lambda if it doesn't find
  /// the user name in the user pool.
  /// </li>
  /// </ul>
  /// <code>ADMIN_NO_SRP_AUTH</code> isn't a valid value.
  ///
  /// Parameter [clientId] :
  /// The app client ID.
  ///
  /// Parameter [analyticsMetadata] :
  /// The Amazon Pinpoint analytics metadata that contributes to your metrics
  /// for <code>InitiateAuth</code> calls.
  ///
  /// Parameter [authParameters] :
  /// The authentication parameters. These are inputs corresponding to the
  /// <code>AuthFlow</code> that you're invoking. The required values depend on
  /// the value of <code>AuthFlow</code>:
  ///
  /// <ul>
  /// <li>
  /// For <code>USER_SRP_AUTH</code>: <code>USERNAME</code> (required),
  /// <code>SRP_A</code> (required), <code>SECRET_HASH</code> (required if the
  /// app client is configured with a client secret), <code>DEVICE_KEY</code>.
  /// </li>
  /// <li>
  /// For <code>REFRESH_TOKEN_AUTH/REFRESH_TOKEN</code>:
  /// <code>REFRESH_TOKEN</code> (required), <code>SECRET_HASH</code> (required
  /// if the app client is configured with a client secret),
  /// <code>DEVICE_KEY</code>.
  /// </li>
  /// <li>
  /// For <code>CUSTOM_AUTH</code>: <code>USERNAME</code> (required),
  /// <code>SECRET_HASH</code> (if app client is configured with client secret),
  /// <code>DEVICE_KEY</code>. To start the authentication flow with password
  /// verification, include <code>ChallengeName: SRP_A</code> and <code>SRP_A:
  /// (The SRP_A Value)</code>.
  /// </li>
  /// </ul>
  ///
  /// Parameter [clientMetadata] :
  /// A map of custom key-value pairs that you can provide as input for certain
  /// custom workflows that this action triggers.
  ///
  /// You create custom workflows by assigning Lambda functions to user pool
  /// triggers. When you use the InitiateAuth API action, Amazon Cognito invokes
  /// the Lambda functions that are specified for various triggers. The
  /// ClientMetadata value is passed as input to the functions for only the
  /// following triggers:
  ///
  /// <ul>
  /// <li>
  /// Pre signup
  /// </li>
  /// <li>
  /// Pre authentication
  /// </li>
  /// <li>
  /// User migration
  /// </li>
  /// </ul>
  /// When Amazon Cognito invokes the functions for these triggers, it passes a
  /// JSON payload, which the function receives as input. This payload contains
  /// a <code>validationData</code> attribute, which provides the data that you
  /// assigned to the ClientMetadata parameter in your InitiateAuth request. In
  /// your function code in Lambda, you can process the
  /// <code>validationData</code> value to enhance your workflow for your
  /// specific needs.
  ///
  /// When you use the InitiateAuth API action, Amazon Cognito also invokes the
  /// functions for the following triggers, but it doesn't provide the
  /// ClientMetadata value as input:
  ///
  /// <ul>
  /// <li>
  /// Post authentication
  /// </li>
  /// <li>
  /// Custom message
  /// </li>
  /// <li>
  /// Pre token generation
  /// </li>
  /// <li>
  /// Create auth challenge
  /// </li>
  /// <li>
  /// Define auth challenge
  /// </li>
  /// <li>
  /// Verify auth challenge
  /// </li>
  /// </ul>
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html">
  /// Customizing user pool Workflows with Lambda Triggers</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// <note>
  /// When you use the ClientMetadata parameter, remember that Amazon Cognito
  /// won't do the following:
  ///
  /// <ul>
  /// <li>
  /// Store the ClientMetadata value. This data is available only to Lambda
  /// triggers that are assigned to a user pool to support custom workflows. If
  /// your user pool configuration doesn't include triggers, the ClientMetadata
  /// parameter serves no purpose.
  /// </li>
  /// <li>
  /// Validate the ClientMetadata value.
  /// </li>
  /// <li>
  /// Encrypt the ClientMetadata value. Don't use Amazon Cognito to provide
  /// sensitive information.
  /// </li>
  /// </ul> </note>
  ///
  /// Parameter [userContextData] :
  /// Contextual data about your user session, such as the device fingerprint,
  /// IP address, or location. Amazon Cognito advanced security evaluates the
  /// risk of an authentication event based on the context that your app
  /// generates and passes to Amazon Cognito when it makes API requests.
  Future<InitiateAuthResponse> initiateAuth({
    required AuthFlowType authFlow,
    required String clientId,
    AnalyticsMetadataType? analyticsMetadata,
    Map<String, String>? authParameters,
    Map<String, String>? clientMetadata,
    UserContextDataType? userContextData,
  }) async {
    ArgumentError.checkNotNull(authFlow, 'authFlow');
    ArgumentError.checkNotNull(clientId, 'clientId');
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.InitiateAuth'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      signed: false,
      // TODO queryParams
      headers: headers,
      payload: {
        'AuthFlow': authFlow.toValue(),
        'ClientId': clientId,
        if (analyticsMetadata != null) 'AnalyticsMetadata': analyticsMetadata,
        if (authParameters != null) 'AuthParameters': authParameters,
        if (clientMetadata != null) 'ClientMetadata': clientMetadata,
        if (userContextData != null) 'UserContextData': userContextData,
      },
    );

    return InitiateAuthResponse.fromJson(jsonResponse.body);
  }

  /// Lists the sign-in devices that Amazon Cognito has registered to the
  /// current user.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [InvalidUserPoolConfigurationException].
  /// May throw [TooManyRequestsException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [accessToken] :
  /// A valid access token that Amazon Cognito issued to the user whose list of
  /// devices you want to view.
  ///
  /// Parameter [limit] :
  /// The limit of the device request.
  ///
  /// Parameter [paginationToken] :
  /// The pagination token for the list request.
  Future<ListDevicesResponse> listDevices({
    required String accessToken,
    int? limit,
    String? paginationToken,
  }) async {
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    _s.validateNumRange(
      'limit',
      limit,
      0,
      60,
    );
    _s.validateStringLength(
      'paginationToken',
      paginationToken,
      1,
      1152921504606846976,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ListDevices'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AccessToken': accessToken,
        if (limit != null) 'Limit': limit,
        if (paginationToken != null) 'PaginationToken': paginationToken,
      },
    );

    return ListDevicesResponse.fromJson(jsonResponse.body);
  }

  /// Lists the groups associated with a user pool.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool.
  ///
  /// Parameter [limit] :
  /// The limit of the request to list groups.
  ///
  /// Parameter [nextToken] :
  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  Future<ListGroupsResponse> listGroups({
    required String userPoolId,
    int? limit,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateNumRange(
      'limit',
      limit,
      0,
      60,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      1152921504606846976,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ListGroups'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        if (limit != null) 'Limit': limit,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListGroupsResponse.fromJson(jsonResponse.body);
  }

  /// Lists information about all IdPs for a user pool.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of IdPs to return.
  ///
  /// Parameter [nextToken] :
  /// A pagination token.
  Future<ListIdentityProvidersResponse> listIdentityProviders({
    required String userPoolId,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      0,
      60,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      1152921504606846976,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ListIdentityProviders'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListIdentityProvidersResponse.fromJson(jsonResponse.body);
  }

  /// Lists the resource servers for a user pool.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of resource servers to return.
  ///
  /// Parameter [nextToken] :
  /// A pagination token.
  Future<ListResourceServersResponse> listResourceServers({
    required String userPoolId,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      50,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      1152921504606846976,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ListResourceServers'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListResourceServersResponse.fromJson(jsonResponse.body);
  }

  /// Lists the tags that are assigned to an Amazon Cognito user pool.
  ///
  /// A tag is a label that you can apply to user pools to categorize and manage
  /// them in different ways, such as by purpose, owner, environment, or other
  /// criteria.
  ///
  /// You can use this action up to 10 times per second, per account.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [InvalidParameterException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [resourceArn] :
  /// The Amazon Resource Name (ARN) of the user pool that the tags are assigned
  /// to.
  Future<ListTagsForResourceResponse> listTagsForResource({
    required String resourceArn,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateStringLength(
      'resourceArn',
      resourceArn,
      20,
      2048,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ListTagsForResource'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ResourceArn': resourceArn,
      },
    );

    return ListTagsForResourceResponse.fromJson(jsonResponse.body);
  }

  /// Lists the user import jobs.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [maxResults] :
  /// The maximum number of import jobs you want the request to return.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool that the users are being imported into.
  ///
  /// Parameter [paginationToken] :
  /// An identifier that was returned from the previous call to
  /// <code>ListUserImportJobs</code>, which can be used to return the next set
  /// of import jobs in the list.
  Future<ListUserImportJobsResponse> listUserImportJobs({
    required int maxResults,
    required String userPoolId,
    String? paginationToken,
  }) async {
    ArgumentError.checkNotNull(maxResults, 'maxResults');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      60,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateStringLength(
      'paginationToken',
      paginationToken,
      1,
      1152921504606846976,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ListUserImportJobs'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'MaxResults': maxResults,
        'UserPoolId': userPoolId,
        if (paginationToken != null) 'PaginationToken': paginationToken,
      },
    );

    return ListUserImportJobsResponse.fromJson(jsonResponse.body);
  }

  /// Lists the clients that have been created for the specified user pool.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool where you want to list user pool
  /// clients.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of results you want the request to return when listing
  /// the user pool clients.
  ///
  /// Parameter [nextToken] :
  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  Future<ListUserPoolClientsResponse> listUserPoolClients({
    required String userPoolId,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      60,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      1152921504606846976,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ListUserPoolClients'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListUserPoolClientsResponse.fromJson(jsonResponse.body);
  }

  /// Lists the user pools associated with an Amazon Web Services account.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [maxResults] :
  /// The maximum number of results you want the request to return when listing
  /// the user pools.
  ///
  /// Parameter [nextToken] :
  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  Future<ListUserPoolsResponse> listUserPools({
    required int maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(maxResults, 'maxResults');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      60,
      isRequired: true,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      1152921504606846976,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ListUserPools'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListUserPoolsResponse.fromJson(jsonResponse.body);
  }

  /// Lists the users in the Amazon Cognito user pool.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool on which the search should be
  /// performed.
  ///
  /// Parameter [attributesToGet] :
  /// An array of strings, where each string is the name of a user attribute to
  /// be returned for each user in the search results. If the array is null, all
  /// attributes are returned.
  ///
  /// Parameter [filter] :
  /// A filter string of the form "<i>AttributeName</i> <i>Filter-Type</i>
  /// "<i>AttributeValue</i>"". Quotation marks within the filter string must be
  /// escaped using the backslash (\) character. For example,
  /// "<code>family_name</code> = \"Reddy\"".
  ///
  /// <ul>
  /// <li>
  /// <i>AttributeName</i>: The name of the attribute to search for. You can
  /// only search for one attribute at a time.
  /// </li>
  /// <li>
  /// <i>Filter-Type</i>: For an exact match, use =, for example,
  /// "<code>given_name</code> = \"Jon\"". For a prefix ("starts with") match,
  /// use ^=, for example, "<code>given_name</code> ^= \"Jon\"".
  /// </li>
  /// <li>
  /// <i>AttributeValue</i>: The attribute value that must be matched for each
  /// user.
  /// </li>
  /// </ul>
  /// If the filter string is empty, <code>ListUsers</code> returns all users in
  /// the user pool.
  ///
  /// You can only search for the following standard attributes:
  ///
  /// <ul>
  /// <li>
  /// <code>username</code> (case-sensitive)
  /// </li>
  /// <li>
  /// <code>email</code>
  /// </li>
  /// <li>
  /// <code>phone_number</code>
  /// </li>
  /// <li>
  /// <code>name</code>
  /// </li>
  /// <li>
  /// <code>given_name</code>
  /// </li>
  /// <li>
  /// <code>family_name</code>
  /// </li>
  /// <li>
  /// <code>preferred_username</code>
  /// </li>
  /// <li>
  /// <code>cognito:user_status</code> (called <b>Status</b> in the Console)
  /// (case-insensitive)
  /// </li>
  /// <li>
  /// <code>status (called <b>Enabled</b> in the Console)
  /// (case-sensitive)</code>
  /// </li>
  /// <li>
  /// <code>sub</code>
  /// </li>
  /// </ul>
  /// Custom attributes aren't searchable.
  /// <note>
  /// You can also list users with a client-side filter. The server-side filter
  /// matches no more than one attribute. For an advanced search, use a
  /// client-side filter with the <code>--query</code> parameter of the
  /// <code>list-users</code> action in the CLI. When you use a client-side
  /// filter, ListUsers returns a paginated list of zero or more users. You can
  /// receive multiple pages in a row with zero results. Repeat the query with
  /// each pagination token that is returned until you receive a null pagination
  /// token value, and then review the combined result.
  ///
  /// For more information about server-side and client-side filtering, see <a
  /// href="https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-filter.html">FilteringCLI
  /// output</a> in the <a
  /// href="https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-filter.html">Command
  /// Line Interface User Guide</a>.
  /// </note>
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/how-to-manage-user-accounts.html#cognito-user-pools-searching-for-users-using-listusers-api">Searching
  /// for Users Using the ListUsers API</a> and <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/how-to-manage-user-accounts.html#cognito-user-pools-searching-for-users-listusers-api-examples">Examples
  /// of Using the ListUsers API</a> in the <i>Amazon Cognito Developer
  /// Guide</i>.
  ///
  /// Parameter [limit] :
  /// Maximum number of users to be returned.
  ///
  /// Parameter [paginationToken] :
  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  Future<ListUsersResponse> listUsers({
    required String userPoolId,
    List<String>? attributesToGet,
    String? filter,
    int? limit,
    String? paginationToken,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateStringLength(
      'filter',
      filter,
      0,
      256,
    );
    _s.validateNumRange(
      'limit',
      limit,
      0,
      60,
    );
    _s.validateStringLength(
      'paginationToken',
      paginationToken,
      1,
      1152921504606846976,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ListUsers'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        if (attributesToGet != null) 'AttributesToGet': attributesToGet,
        if (filter != null) 'Filter': filter,
        if (limit != null) 'Limit': limit,
        if (paginationToken != null) 'PaginationToken': paginationToken,
      },
    );

    return ListUsersResponse.fromJson(jsonResponse.body);
  }

  /// Lists the users in the specified group.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [groupName] :
  /// The name of the group.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool.
  ///
  /// Parameter [limit] :
  /// The limit of the request to list users.
  ///
  /// Parameter [nextToken] :
  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  Future<ListUsersInGroupResponse> listUsersInGroup({
    required String groupName,
    required String userPoolId,
    int? limit,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(groupName, 'groupName');
    _s.validateStringLength(
      'groupName',
      groupName,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateNumRange(
      'limit',
      limit,
      0,
      60,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      1152921504606846976,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ListUsersInGroup'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'GroupName': groupName,
        'UserPoolId': userPoolId,
        if (limit != null) 'Limit': limit,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListUsersInGroupResponse.fromJson(jsonResponse.body);
  }

  /// Resends the confirmation (for confirmation of registration) to a specific
  /// user in the user pool.
  /// <note>
  /// This action might generate an SMS text message. Starting June 1, 2021, US
  /// telecom carriers require you to register an origination phone number
  /// before you can send SMS messages to US phone numbers. If you use SMS text
  /// messages in Amazon Cognito, you must register a phone number with <a
  /// href="https://console.aws.amazon.com/pinpoint/home/">Amazon Pinpoint</a>.
  /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
  /// Cognito users who must receive SMS messages might not be able to sign up,
  /// activate their accounts, or sign in.
  ///
  /// If you have never used SMS text messages with Amazon Cognito or any other
  /// Amazon Web Service, Amazon Simple Notification Service might place your
  /// account in the SMS sandbox. In <i> <a
  /// href="https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html">sandbox
  /// mode</a> </i>, you can send messages only to verified phone numbers. After
  /// you test your app while in the sandbox environment, you can move out of
  /// the sandbox and into production. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-sms-userpool-settings.html">
  /// SMS message settings for Amazon Cognito user pools</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// </note>
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [UnexpectedLambdaException].
  /// May throw [UserLambdaValidationException].
  /// May throw [NotAuthorizedException].
  /// May throw [InvalidLambdaResponseException].
  /// May throw [TooManyRequestsException].
  /// May throw [LimitExceededException].
  /// May throw [InvalidSmsRoleAccessPolicyException].
  /// May throw [InvalidSmsRoleTrustRelationshipException].
  /// May throw [InvalidEmailRoleAccessPolicyException].
  /// May throw [CodeDeliveryFailureException].
  /// May throw [UserNotFoundException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [clientId] :
  /// The ID of the client associated with the user pool.
  ///
  /// Parameter [username] :
  /// The <code>username</code> attribute of the user to whom you want to resend
  /// a confirmation code.
  ///
  /// Parameter [analyticsMetadata] :
  /// The Amazon Pinpoint analytics metadata that contributes to your metrics
  /// for <code>ResendConfirmationCode</code> calls.
  ///
  /// Parameter [clientMetadata] :
  /// A map of custom key-value pairs that you can provide as input for any
  /// custom workflows that this action triggers.
  ///
  /// You create custom workflows by assigning Lambda functions to user pool
  /// triggers. When you use the ResendConfirmationCode API action, Amazon
  /// Cognito invokes the function that is assigned to the <i>custom message</i>
  /// trigger. When Amazon Cognito invokes this function, it passes a JSON
  /// payload, which the function receives as input. This payload contains a
  /// <code>clientMetadata</code> attribute, which provides the data that you
  /// assigned to the ClientMetadata parameter in your ResendConfirmationCode
  /// request. In your function code in Lambda, you can process the
  /// <code>clientMetadata</code> value to enhance your workflow for your
  /// specific needs.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html">
  /// Customizing user pool Workflows with Lambda Triggers</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// <note>
  /// When you use the ClientMetadata parameter, remember that Amazon Cognito
  /// won't do the following:
  ///
  /// <ul>
  /// <li>
  /// Store the ClientMetadata value. This data is available only to Lambda
  /// triggers that are assigned to a user pool to support custom workflows. If
  /// your user pool configuration doesn't include triggers, the ClientMetadata
  /// parameter serves no purpose.
  /// </li>
  /// <li>
  /// Validate the ClientMetadata value.
  /// </li>
  /// <li>
  /// Encrypt the ClientMetadata value. Don't use Amazon Cognito to provide
  /// sensitive information.
  /// </li>
  /// </ul> </note>
  ///
  /// Parameter [secretHash] :
  /// A keyed-hash message authentication code (HMAC) calculated using the
  /// secret key of a user pool client and username plus the client ID in the
  /// message.
  ///
  /// Parameter [userContextData] :
  /// Contextual data about your user session, such as the device fingerprint,
  /// IP address, or location. Amazon Cognito advanced security evaluates the
  /// risk of an authentication event based on the context that your app
  /// generates and passes to Amazon Cognito when it makes API requests.
  Future<ResendConfirmationCodeResponse> resendConfirmationCode({
    required String clientId,
    required String username,
    AnalyticsMetadataType? analyticsMetadata,
    Map<String, String>? clientMetadata,
    String? secretHash,
    UserContextDataType? userContextData,
  }) async {
    ArgumentError.checkNotNull(clientId, 'clientId');
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringLength(
      'secretHash',
      secretHash,
      1,
      128,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.ResendConfirmationCode'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      signed: false,
      // TODO queryParams
      headers: headers,
      payload: {
        'ClientId': clientId,
        'Username': username,
        if (analyticsMetadata != null) 'AnalyticsMetadata': analyticsMetadata,
        if (clientMetadata != null) 'ClientMetadata': clientMetadata,
        if (secretHash != null) 'SecretHash': secretHash,
        if (userContextData != null) 'UserContextData': userContextData,
      },
    );

    return ResendConfirmationCodeResponse.fromJson(jsonResponse.body);
  }

  /// Responds to the authentication challenge.
  /// <note>
  /// This action might generate an SMS text message. Starting June 1, 2021, US
  /// telecom carriers require you to register an origination phone number
  /// before you can send SMS messages to US phone numbers. If you use SMS text
  /// messages in Amazon Cognito, you must register a phone number with <a
  /// href="https://console.aws.amazon.com/pinpoint/home/">Amazon Pinpoint</a>.
  /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
  /// Cognito users who must receive SMS messages might not be able to sign up,
  /// activate their accounts, or sign in.
  ///
  /// If you have never used SMS text messages with Amazon Cognito or any other
  /// Amazon Web Service, Amazon Simple Notification Service might place your
  /// account in the SMS sandbox. In <i> <a
  /// href="https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html">sandbox
  /// mode</a> </i>, you can send messages only to verified phone numbers. After
  /// you test your app while in the sandbox environment, you can move out of
  /// the sandbox and into production. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-sms-userpool-settings.html">
  /// SMS message settings for Amazon Cognito user pools</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// </note>
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [CodeMismatchException].
  /// May throw [ExpiredCodeException].
  /// May throw [UnexpectedLambdaException].
  /// May throw [UserLambdaValidationException].
  /// May throw [InvalidPasswordException].
  /// May throw [InvalidLambdaResponseException].
  /// May throw [TooManyRequestsException].
  /// May throw [InvalidUserPoolConfigurationException].
  /// May throw [MFAMethodNotFoundException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InvalidSmsRoleAccessPolicyException].
  /// May throw [InvalidSmsRoleTrustRelationshipException].
  /// May throw [AliasExistsException].
  /// May throw [InternalErrorException].
  /// May throw [SoftwareTokenMFANotFoundException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [challengeName] :
  /// The challenge name. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_InitiateAuth.html">InitiateAuth</a>.
  ///
  /// <code>ADMIN_NO_SRP_AUTH</code> isn't a valid value.
  ///
  /// Parameter [clientId] :
  /// The app client ID.
  ///
  /// Parameter [analyticsMetadata] :
  /// The Amazon Pinpoint analytics metadata that contributes to your metrics
  /// for <code>RespondToAuthChallenge</code> calls.
  ///
  /// Parameter [challengeResponses] :
  /// The challenge responses. These are inputs corresponding to the value of
  /// <code>ChallengeName</code>, for example:
  /// <note>
  /// <code>SECRET_HASH</code> (if app client is configured with client secret)
  /// applies to all of the inputs that follow (including
  /// <code>SOFTWARE_TOKEN_MFA</code>).
  /// </note>
  /// <ul>
  /// <li>
  /// <code>SMS_MFA</code>: <code>SMS_MFA_CODE</code>, <code>USERNAME</code>.
  /// </li>
  /// <li>
  /// <code>PASSWORD_VERIFIER</code>: <code>PASSWORD_CLAIM_SIGNATURE</code>,
  /// <code>PASSWORD_CLAIM_SECRET_BLOCK</code>, <code>TIMESTAMP</code>,
  /// <code>USERNAME</code>.
  /// <note>
  /// <code>PASSWORD_VERIFIER</code> requires <code>DEVICE_KEY</code> when you
  /// sign in with a remembered device.
  /// </note> </li>
  /// <li>
  /// <code>NEW_PASSWORD_REQUIRED</code>: <code>NEW_PASSWORD</code>,
  /// <code>USERNAME</code>, <code>SECRET_HASH</code> (if app client is
  /// configured with client secret). To set any required attributes that Amazon
  /// Cognito returned as <code>requiredAttributes</code> in the
  /// <code>InitiateAuth</code> response, add a
  /// <code>userAttributes.<i>attributename</i> </code> parameter. This
  /// parameter can also set values for writable attributes that aren't required
  /// by your user pool.
  /// <note>
  /// In a <code>NEW_PASSWORD_REQUIRED</code> challenge response, you can't
  /// modify a required attribute that already has a value. In
  /// <code>RespondToAuthChallenge</code>, set a value for any keys that Amazon
  /// Cognito returned in the <code>requiredAttributes</code> parameter, then
  /// use the <code>UpdateUserAttributes</code> API operation to modify the
  /// value of any additional attributes.
  /// </note> </li>
  /// <li>
  /// <code>SOFTWARE_TOKEN_MFA</code>: <code>USERNAME</code> and
  /// <code>SOFTWARE_TOKEN_MFA_CODE</code> are required attributes.
  /// </li>
  /// <li>
  /// <code>DEVICE_SRP_AUTH</code> requires <code>USERNAME</code>,
  /// <code>DEVICE_KEY</code>, <code>SRP_A</code> (and
  /// <code>SECRET_HASH</code>).
  /// </li>
  /// <li>
  /// <code>DEVICE_PASSWORD_VERIFIER</code> requires everything that
  /// <code>PASSWORD_VERIFIER</code> requires, plus <code>DEVICE_KEY</code>.
  /// </li>
  /// <li>
  /// <code>MFA_SETUP</code> requires <code>USERNAME</code>, plus you must use
  /// the session value returned by <code>VerifySoftwareToken</code> in the
  /// <code>Session</code> parameter.
  /// </li>
  /// </ul>
  ///
  /// Parameter [clientMetadata] :
  /// A map of custom key-value pairs that you can provide as input for any
  /// custom workflows that this action triggers.
  ///
  /// You create custom workflows by assigning Lambda functions to user pool
  /// triggers. When you use the RespondToAuthChallenge API action, Amazon
  /// Cognito invokes any functions that are assigned to the following triggers:
  /// <i>post authentication</i>, <i>pre token generation</i>, <i>define auth
  /// challenge</i>, <i>create auth challenge</i>, and <i>verify auth
  /// challenge</i>. When Amazon Cognito invokes any of these functions, it
  /// passes a JSON payload, which the function receives as input. This payload
  /// contains a <code>clientMetadata</code> attribute, which provides the data
  /// that you assigned to the ClientMetadata parameter in your
  /// RespondToAuthChallenge request. In your function code in Lambda, you can
  /// process the <code>clientMetadata</code> value to enhance your workflow for
  /// your specific needs.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html">
  /// Customizing user pool Workflows with Lambda Triggers</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// <note>
  /// When you use the ClientMetadata parameter, remember that Amazon Cognito
  /// won't do the following:
  ///
  /// <ul>
  /// <li>
  /// Store the ClientMetadata value. This data is available only to Lambda
  /// triggers that are assigned to a user pool to support custom workflows. If
  /// your user pool configuration doesn't include triggers, the ClientMetadata
  /// parameter serves no purpose.
  /// </li>
  /// <li>
  /// Validate the ClientMetadata value.
  /// </li>
  /// <li>
  /// Encrypt the ClientMetadata value. Don't use Amazon Cognito to provide
  /// sensitive information.
  /// </li>
  /// </ul> </note>
  ///
  /// Parameter [session] :
  /// The session that should be passed both ways in challenge-response calls to
  /// the service. If <code>InitiateAuth</code> or
  /// <code>RespondToAuthChallenge</code> API call determines that the caller
  /// must pass another challenge, they return a session with other challenge
  /// parameters. This session should be passed as it is to the next
  /// <code>RespondToAuthChallenge</code> API call.
  ///
  /// Parameter [userContextData] :
  /// Contextual data about your user session, such as the device fingerprint,
  /// IP address, or location. Amazon Cognito advanced security evaluates the
  /// risk of an authentication event based on the context that your app
  /// generates and passes to Amazon Cognito when it makes API requests.
  Future<RespondToAuthChallengeResponse> respondToAuthChallenge({
    required ChallengeNameType challengeName,
    required String clientId,
    AnalyticsMetadataType? analyticsMetadata,
    Map<String, String>? challengeResponses,
    Map<String, String>? clientMetadata,
    String? session,
    UserContextDataType? userContextData,
  }) async {
    ArgumentError.checkNotNull(challengeName, 'challengeName');
    ArgumentError.checkNotNull(clientId, 'clientId');
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringLength(
      'session',
      session,
      20,
      2048,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.RespondToAuthChallenge'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      signed: false,
      // TODO queryParams
      headers: headers,
      payload: {
        'ChallengeName': challengeName.toValue(),
        'ClientId': clientId,
        if (analyticsMetadata != null) 'AnalyticsMetadata': analyticsMetadata,
        if (challengeResponses != null)
          'ChallengeResponses': challengeResponses,
        if (clientMetadata != null) 'ClientMetadata': clientMetadata,
        if (session != null) 'Session': session,
        if (userContextData != null) 'UserContextData': userContextData,
      },
    );

    return RespondToAuthChallengeResponse.fromJson(jsonResponse.body);
  }

  /// Revokes all of the access tokens generated by the specified refresh token.
  /// After the token is revoked, you can't use the revoked token to access
  /// Amazon Cognito authenticated APIs.
  ///
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  /// May throw [UnauthorizedException].
  /// May throw [InvalidParameterException].
  /// May throw [UnsupportedOperationException].
  /// May throw [UnsupportedTokenTypeException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [clientId] :
  /// The client ID for the token that you want to revoke.
  ///
  /// Parameter [token] :
  /// The refresh token that you want to revoke.
  ///
  /// Parameter [clientSecret] :
  /// The secret for the client ID. This is required only if the client ID has a
  /// secret.
  Future<void> revokeToken({
    required String clientId,
    required String token,
    String? clientSecret,
  }) async {
    ArgumentError.checkNotNull(clientId, 'clientId');
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(token, 'token');
    _s.validateStringLength(
      'clientSecret',
      clientSecret,
      1,
      64,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.RevokeToken'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ClientId': clientId,
        'Token': token,
        if (clientSecret != null) 'ClientSecret': clientSecret,
      },
    );
  }

  /// Configures actions on detected risks. To delete the risk configuration for
  /// <code>UserPoolId</code> or <code>ClientId</code>, pass null values for all
  /// four configuration types.
  ///
  /// To activate Amazon Cognito advanced security features, update the user
  /// pool to include the <code>UserPoolAddOns</code>
  /// key<code>AdvancedSecurityMode</code>.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserPoolAddOnNotEnabledException].
  /// May throw [CodeDeliveryFailureException].
  /// May throw [InvalidEmailRoleAccessPolicyException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  ///
  /// Parameter [accountTakeoverRiskConfiguration] :
  /// The account takeover risk configuration.
  ///
  /// Parameter [clientId] :
  /// The app client ID. If <code>ClientId</code> is null, then the risk
  /// configuration is mapped to <code>userPoolId</code>. When the client ID is
  /// null, the same risk configuration is applied to all the clients in the
  /// userPool.
  ///
  /// Otherwise, <code>ClientId</code> is mapped to the client. When the client
  /// ID isn't null, the user pool configuration is overridden and the risk
  /// configuration for the client is used instead.
  ///
  /// Parameter [compromisedCredentialsRiskConfiguration] :
  /// The compromised credentials risk configuration.
  ///
  /// Parameter [riskExceptionConfiguration] :
  /// The configuration to override the risk decision.
  Future<SetRiskConfigurationResponse> setRiskConfiguration({
    required String userPoolId,
    AccountTakeoverRiskConfigurationType? accountTakeoverRiskConfiguration,
    String? clientId,
    CompromisedCredentialsRiskConfigurationType?
        compromisedCredentialsRiskConfiguration,
    RiskExceptionConfigurationType? riskExceptionConfiguration,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.SetRiskConfiguration'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        if (accountTakeoverRiskConfiguration != null)
          'AccountTakeoverRiskConfiguration': accountTakeoverRiskConfiguration,
        if (clientId != null) 'ClientId': clientId,
        if (compromisedCredentialsRiskConfiguration != null)
          'CompromisedCredentialsRiskConfiguration':
              compromisedCredentialsRiskConfiguration,
        if (riskExceptionConfiguration != null)
          'RiskExceptionConfiguration': riskExceptionConfiguration,
      },
    );

    return SetRiskConfigurationResponse.fromJson(jsonResponse.body);
  }

  /// Sets the user interface (UI) customization information for a user pool's
  /// built-in app UI.
  ///
  /// You can specify app UI customization settings for a single client (with a
  /// specific <code>clientId</code>) or for all clients (by setting the
  /// <code>clientId</code> to <code>ALL</code>). If you specify
  /// <code>ALL</code>, the default configuration is used for every client that
  /// has no previously set UI customization. If you specify UI customization
  /// settings for a particular client, it will no longer return to the
  /// <code>ALL</code> configuration.
  /// <note>
  /// To use this API, your user pool must have a domain associated with it.
  /// Otherwise, there is no place to host the app's pages, and the service will
  /// throw an error.
  /// </note>
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool.
  ///
  /// Parameter [css] :
  /// The CSS values in the UI customization.
  ///
  /// Parameter [clientId] :
  /// The client ID for the client app.
  ///
  /// Parameter [imageFile] :
  /// The uploaded logo image for the UI customization.
  Future<SetUICustomizationResponse> setUICustomization({
    required String userPoolId,
    String? css,
    String? clientId,
    Uint8List? imageFile,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.SetUICustomization'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        if (css != null) 'CSS': css,
        if (clientId != null) 'ClientId': clientId,
        if (imageFile != null) 'ImageFile': base64Encode(imageFile),
      },
    );

    return SetUICustomizationResponse.fromJson(jsonResponse.body);
  }

  /// Set the user's multi-factor authentication (MFA) method preference,
  /// including which MFA factors are activated and if any are preferred. Only
  /// one factor can be set as preferred. The preferred MFA factor will be used
  /// to authenticate a user if multiple factors are activated. If multiple
  /// options are activated and no preference is set, a challenge to choose an
  /// MFA option will be returned during sign-in. If an MFA type is activated
  /// for a user, the user will be prompted for MFA during all sign-in attempts
  /// unless device tracking is turned on and the device has been trusted. If
  /// you want MFA to be applied selectively based on the assessed risk level of
  /// sign-in attempts, deactivate MFA for users and turn on Adaptive
  /// Authentication for the user pool.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [accessToken] :
  /// A valid access token that Amazon Cognito issued to the user whose MFA
  /// preference you want to set.
  ///
  /// Parameter [sMSMfaSettings] :
  /// The SMS text message multi-factor authentication (MFA) settings.
  ///
  /// Parameter [softwareTokenMfaSettings] :
  /// The time-based one-time password (TOTP) software token MFA settings.
  Future<void> setUserMFAPreference({
    required String accessToken,
    SMSMfaSettingsType? sMSMfaSettings,
    SoftwareTokenMfaSettingsType? softwareTokenMfaSettings,
  }) async {
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.SetUserMFAPreference'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AccessToken': accessToken,
        if (sMSMfaSettings != null) 'SMSMfaSettings': sMSMfaSettings,
        if (softwareTokenMfaSettings != null)
          'SoftwareTokenMfaSettings': softwareTokenMfaSettings,
      },
    );
  }

  /// Sets the user pool multi-factor authentication (MFA) configuration.
  /// <note>
  /// This action might generate an SMS text message. Starting June 1, 2021, US
  /// telecom carriers require you to register an origination phone number
  /// before you can send SMS messages to US phone numbers. If you use SMS text
  /// messages in Amazon Cognito, you must register a phone number with <a
  /// href="https://console.aws.amazon.com/pinpoint/home/">Amazon Pinpoint</a>.
  /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
  /// Cognito users who must receive SMS messages might not be able to sign up,
  /// activate their accounts, or sign in.
  ///
  /// If you have never used SMS text messages with Amazon Cognito or any other
  /// Amazon Web Service, Amazon Simple Notification Service might place your
  /// account in the SMS sandbox. In <i> <a
  /// href="https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html">sandbox
  /// mode</a> </i>, you can send messages only to verified phone numbers. After
  /// you test your app while in the sandbox environment, you can move out of
  /// the sandbox and into production. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-sms-userpool-settings.html">
  /// SMS message settings for Amazon Cognito user pools</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// </note>
  ///
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidSmsRoleAccessPolicyException].
  /// May throw [InvalidSmsRoleTrustRelationshipException].
  /// May throw [NotAuthorizedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  ///
  /// Parameter [mfaConfiguration] :
  /// The MFA configuration. If you set the MfaConfiguration value to ‘ON’, only
  /// users who have set up an MFA factor can sign in. To learn more, see <a
  /// href="cognito/latest/developerguide/user-pool-settings-mfa.html">Adding
  /// Multi-Factor Authentication (MFA) to a user pool</a>. Valid values
  /// include:
  ///
  /// <ul>
  /// <li>
  /// <code>OFF</code> MFA won't be used for any users.
  /// </li>
  /// <li>
  /// <code>ON</code> MFA is required for all users to sign in.
  /// </li>
  /// <li>
  /// <code>OPTIONAL</code> MFA will be required only for individual users who
  /// have an MFA factor activated.
  /// </li>
  /// </ul>
  ///
  /// Parameter [smsMfaConfiguration] :
  /// The SMS text message MFA configuration.
  ///
  /// Parameter [softwareTokenMfaConfiguration] :
  /// The software token MFA configuration.
  Future<SetUserPoolMfaConfigResponse> setUserPoolMfaConfig({
    required String userPoolId,
    UserPoolMfaType? mfaConfiguration,
    SmsMfaConfigType? smsMfaConfiguration,
    SoftwareTokenMfaConfigType? softwareTokenMfaConfiguration,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.SetUserPoolMfaConfig'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        if (mfaConfiguration != null)
          'MfaConfiguration': mfaConfiguration.toValue(),
        if (smsMfaConfiguration != null)
          'SmsMfaConfiguration': smsMfaConfiguration,
        if (softwareTokenMfaConfiguration != null)
          'SoftwareTokenMfaConfiguration': softwareTokenMfaConfiguration,
      },
    );

    return SetUserPoolMfaConfigResponse.fromJson(jsonResponse.body);
  }

  /// <i>This action is no longer supported.</i> You can use it to configure
  /// only SMS MFA. You can't use it to configure time-based one-time password
  /// (TOTP) software token MFA. To configure either type of MFA, use <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_SetUserMFAPreference.html">SetUserMFAPreference</a>
  /// instead.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [accessToken] :
  /// A valid access token that Amazon Cognito issued to the user whose user
  /// settings you want to configure.
  ///
  /// Parameter [mFAOptions] :
  /// You can use this parameter only to set an SMS configuration that uses SMS
  /// for delivery.
  Future<void> setUserSettings({
    required String accessToken,
    required List<MFAOptionType> mFAOptions,
  }) async {
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    ArgumentError.checkNotNull(mFAOptions, 'mFAOptions');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.SetUserSettings'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      signed: false,
      // TODO queryParams
      headers: headers,
      payload: {
        'AccessToken': accessToken,
        'MFAOptions': mFAOptions,
      },
    );
  }

  /// Registers the user in the specified user pool and creates a user name,
  /// password, and user attributes.
  /// <note>
  /// This action might generate an SMS text message. Starting June 1, 2021, US
  /// telecom carriers require you to register an origination phone number
  /// before you can send SMS messages to US phone numbers. If you use SMS text
  /// messages in Amazon Cognito, you must register a phone number with <a
  /// href="https://console.aws.amazon.com/pinpoint/home/">Amazon Pinpoint</a>.
  /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
  /// Cognito users who must receive SMS messages might not be able to sign up,
  /// activate their accounts, or sign in.
  ///
  /// If you have never used SMS text messages with Amazon Cognito or any other
  /// Amazon Web Service, Amazon Simple Notification Service might place your
  /// account in the SMS sandbox. In <i> <a
  /// href="https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html">sandbox
  /// mode</a> </i>, you can send messages only to verified phone numbers. After
  /// you test your app while in the sandbox environment, you can move out of
  /// the sandbox and into production. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-sms-userpool-settings.html">
  /// SMS message settings for Amazon Cognito user pools</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// </note>
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [UnexpectedLambdaException].
  /// May throw [UserLambdaValidationException].
  /// May throw [NotAuthorizedException].
  /// May throw [InvalidPasswordException].
  /// May throw [InvalidLambdaResponseException].
  /// May throw [UsernameExistsException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  /// May throw [InvalidSmsRoleAccessPolicyException].
  /// May throw [InvalidSmsRoleTrustRelationshipException].
  /// May throw [InvalidEmailRoleAccessPolicyException].
  /// May throw [CodeDeliveryFailureException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [clientId] :
  /// The ID of the client associated with the user pool.
  ///
  /// Parameter [password] :
  /// The password of the user you want to register.
  ///
  /// Parameter [username] :
  /// The user name of the user you want to register.
  ///
  /// Parameter [analyticsMetadata] :
  /// The Amazon Pinpoint analytics metadata that contributes to your metrics
  /// for <code>SignUp</code> calls.
  ///
  /// Parameter [clientMetadata] :
  /// A map of custom key-value pairs that you can provide as input for any
  /// custom workflows that this action triggers.
  ///
  /// You create custom workflows by assigning Lambda functions to user pool
  /// triggers. When you use the SignUp API action, Amazon Cognito invokes any
  /// functions that are assigned to the following triggers: <i>pre sign-up</i>,
  /// <i>custom message</i>, and <i>post confirmation</i>. When Amazon Cognito
  /// invokes any of these functions, it passes a JSON payload, which the
  /// function receives as input. This payload contains a
  /// <code>clientMetadata</code> attribute, which provides the data that you
  /// assigned to the ClientMetadata parameter in your SignUp request. In your
  /// function code in Lambda, you can process the <code>clientMetadata</code>
  /// value to enhance your workflow for your specific needs.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html">
  /// Customizing user pool Workflows with Lambda Triggers</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// <note>
  /// When you use the ClientMetadata parameter, remember that Amazon Cognito
  /// won't do the following:
  ///
  /// <ul>
  /// <li>
  /// Store the ClientMetadata value. This data is available only to Lambda
  /// triggers that are assigned to a user pool to support custom workflows. If
  /// your user pool configuration doesn't include triggers, the ClientMetadata
  /// parameter serves no purpose.
  /// </li>
  /// <li>
  /// Validate the ClientMetadata value.
  /// </li>
  /// <li>
  /// Encrypt the ClientMetadata value. Don't use Amazon Cognito to provide
  /// sensitive information.
  /// </li>
  /// </ul> </note>
  ///
  /// Parameter [secretHash] :
  /// A keyed-hash message authentication code (HMAC) calculated using the
  /// secret key of a user pool client and username plus the client ID in the
  /// message.
  ///
  /// Parameter [userAttributes] :
  /// An array of name-value pairs representing user attributes.
  ///
  /// For custom attributes, you must prepend the <code>custom:</code> prefix to
  /// the attribute name.
  ///
  /// Parameter [userContextData] :
  /// Contextual data about your user session, such as the device fingerprint,
  /// IP address, or location. Amazon Cognito advanced security evaluates the
  /// risk of an authentication event based on the context that your app
  /// generates and passes to Amazon Cognito when it makes API requests.
  ///
  /// Parameter [validationData] :
  /// The validation data in the request to register a user.
  Future<SignUpResponse> signUp({
    required String clientId,
    required String password,
    required String username,
    AnalyticsMetadataType? analyticsMetadata,
    Map<String, String>? clientMetadata,
    String? secretHash,
    List<AttributeType>? userAttributes,
    UserContextDataType? userContextData,
    List<AttributeType>? validationData,
  }) async {
    ArgumentError.checkNotNull(clientId, 'clientId');
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(password, 'password');
    _s.validateStringLength(
      'password',
      password,
      0,
      256,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    _s.validateStringLength(
      'secretHash',
      secretHash,
      1,
      128,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.SignUp'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      signed: false,
      // TODO queryParams
      headers: headers,
      payload: {
        'ClientId': clientId,
        'Password': password,
        'Username': username,
        if (analyticsMetadata != null) 'AnalyticsMetadata': analyticsMetadata,
        if (clientMetadata != null) 'ClientMetadata': clientMetadata,
        if (secretHash != null) 'SecretHash': secretHash,
        if (userAttributes != null) 'UserAttributes': userAttributes,
        if (userContextData != null) 'UserContextData': userContextData,
        if (validationData != null) 'ValidationData': validationData,
      },
    );

    return SignUpResponse.fromJson(jsonResponse.body);
  }

  /// Starts the user import.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  /// May throw [PreconditionNotMetException].
  /// May throw [NotAuthorizedException].
  ///
  /// Parameter [jobId] :
  /// The job ID for the user import job.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool that the users are being imported into.
  Future<StartUserImportJobResponse> startUserImportJob({
    required String jobId,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(jobId, 'jobId');
    _s.validateStringLength(
      'jobId',
      jobId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.StartUserImportJob'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'JobId': jobId,
        'UserPoolId': userPoolId,
      },
    );

    return StartUserImportJobResponse.fromJson(jsonResponse.body);
  }

  /// Stops the user import job.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  /// May throw [PreconditionNotMetException].
  /// May throw [NotAuthorizedException].
  ///
  /// Parameter [jobId] :
  /// The job ID for the user import job.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool that the users are being imported into.
  Future<StopUserImportJobResponse> stopUserImportJob({
    required String jobId,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(jobId, 'jobId');
    _s.validateStringLength(
      'jobId',
      jobId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.StopUserImportJob'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'JobId': jobId,
        'UserPoolId': userPoolId,
      },
    );

    return StopUserImportJobResponse.fromJson(jsonResponse.body);
  }

  /// Assigns a set of tags to an Amazon Cognito user pool. A tag is a label
  /// that you can use to categorize and manage user pools in different ways,
  /// such as by purpose, owner, environment, or other criteria.
  ///
  /// Each tag consists of a key and value, both of which you define. A key is a
  /// general category for more specific values. For example, if you have two
  /// versions of a user pool, one for testing and another for production, you
  /// might assign an <code>Environment</code> tag key to both user pools. The
  /// value of this key might be <code>Test</code> for one user pool, and
  /// <code>Production</code> for the other.
  ///
  /// Tags are useful for cost tracking and access control. You can activate
  /// your tags so that they appear on the Billing and Cost Management console,
  /// where you can track the costs associated with your user pools. In an
  /// Identity and Access Management policy, you can constrain permissions for
  /// user pools based on specific tags or tag values.
  ///
  /// You can use this action up to 5 times per second, per account. A user pool
  /// can have as many as 50 tags.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [InvalidParameterException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [resourceArn] :
  /// The Amazon Resource Name (ARN) of the user pool to assign the tags to.
  ///
  /// Parameter [tags] :
  /// The tags to assign to the user pool.
  Future<void> tagResource({
    required String resourceArn,
    required Map<String, String> tags,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateStringLength(
      'resourceArn',
      resourceArn,
      20,
      2048,
      isRequired: true,
    );
    ArgumentError.checkNotNull(tags, 'tags');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.TagResource'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ResourceArn': resourceArn,
        'Tags': tags,
      },
    );
  }

  /// Removes the specified tags from an Amazon Cognito user pool. You can use
  /// this action up to 5 times per second, per account.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [InvalidParameterException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [resourceArn] :
  /// The Amazon Resource Name (ARN) of the user pool that the tags are assigned
  /// to.
  ///
  /// Parameter [tagKeys] :
  /// The keys of the tags to remove from the user pool.
  Future<void> untagResource({
    required String resourceArn,
    required List<String> tagKeys,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateStringLength(
      'resourceArn',
      resourceArn,
      20,
      2048,
      isRequired: true,
    );
    ArgumentError.checkNotNull(tagKeys, 'tagKeys');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.UntagResource'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ResourceArn': resourceArn,
        'TagKeys': tagKeys,
      },
    );
  }

  /// Provides the feedback for an authentication event, whether it was from a
  /// valid user or not. This feedback is used for improving the risk evaluation
  /// decision for the user pool as part of Amazon Cognito advanced security.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserNotFoundException].
  /// May throw [UserPoolAddOnNotEnabledException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [eventId] :
  /// The event ID.
  ///
  /// Parameter [feedbackToken] :
  /// The feedback token.
  ///
  /// Parameter [feedbackValue] :
  /// The authentication event feedback value.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  ///
  /// Parameter [username] :
  /// The user pool username.
  Future<void> updateAuthEventFeedback({
    required String eventId,
    required String feedbackToken,
    required FeedbackValueType feedbackValue,
    required String userPoolId,
    required String username,
  }) async {
    ArgumentError.checkNotNull(eventId, 'eventId');
    _s.validateStringLength(
      'eventId',
      eventId,
      1,
      50,
      isRequired: true,
    );
    ArgumentError.checkNotNull(feedbackToken, 'feedbackToken');
    ArgumentError.checkNotNull(feedbackValue, 'feedbackValue');
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    ArgumentError.checkNotNull(username, 'username');
    _s.validateStringLength(
      'username',
      username,
      1,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSCognitoIdentityProviderService.UpdateAuthEventFeedback'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'EventId': eventId,
        'FeedbackToken': feedbackToken,
        'FeedbackValue': feedbackValue.toValue(),
        'UserPoolId': userPoolId,
        'Username': username,
      },
    );
  }

  /// Updates the device status.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [InvalidUserPoolConfigurationException].
  /// May throw [TooManyRequestsException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [accessToken] :
  /// A valid access token that Amazon Cognito issued to the user whose device
  /// status you want to update.
  ///
  /// Parameter [deviceKey] :
  /// The device key.
  ///
  /// Parameter [deviceRememberedStatus] :
  /// The status of whether a device is remembered.
  Future<void> updateDeviceStatus({
    required String accessToken,
    required String deviceKey,
    DeviceRememberedStatusType? deviceRememberedStatus,
  }) async {
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    ArgumentError.checkNotNull(deviceKey, 'deviceKey');
    _s.validateStringLength(
      'deviceKey',
      deviceKey,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.UpdateDeviceStatus'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AccessToken': accessToken,
        'DeviceKey': deviceKey,
        if (deviceRememberedStatus != null)
          'DeviceRememberedStatus': deviceRememberedStatus.toValue(),
      },
    );
  }

  /// Updates the specified group with the specified attributes.
  ///
  /// Calling this action requires developer credentials.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [groupName] :
  /// The name of the group.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool.
  ///
  /// Parameter [description] :
  /// A string containing the new description of the group.
  ///
  /// Parameter [precedence] :
  /// The new precedence value for the group. For more information about this
  /// parameter, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_CreateGroup.html">CreateGroup</a>.
  ///
  /// Parameter [roleArn] :
  /// The new role Amazon Resource Name (ARN) for the group. This is used for
  /// setting the <code>cognito:roles</code> and
  /// <code>cognito:preferred_role</code> claims in the token.
  Future<UpdateGroupResponse> updateGroup({
    required String groupName,
    required String userPoolId,
    String? description,
    int? precedence,
    String? roleArn,
  }) async {
    ArgumentError.checkNotNull(groupName, 'groupName');
    _s.validateStringLength(
      'groupName',
      groupName,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateStringLength(
      'description',
      description,
      0,
      2048,
    );
    _s.validateNumRange(
      'precedence',
      precedence,
      0,
      1152921504606846976,
    );
    _s.validateStringLength(
      'roleArn',
      roleArn,
      20,
      2048,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.UpdateGroup'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'GroupName': groupName,
        'UserPoolId': userPoolId,
        if (description != null) 'Description': description,
        if (precedence != null) 'Precedence': precedence,
        if (roleArn != null) 'RoleArn': roleArn,
      },
    );

    return UpdateGroupResponse.fromJson(jsonResponse.body);
  }

  /// Updates IdP information for a user pool.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [UnsupportedIdentityProviderException].
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [providerName] :
  /// The IdP name.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID.
  ///
  /// Parameter [attributeMapping] :
  /// The IdP attribute mapping to be changed.
  ///
  /// Parameter [idpIdentifiers] :
  /// A list of IdP identifiers.
  ///
  /// Parameter [providerDetails] :
  /// The IdP details to be updated, such as <code>MetadataURL</code> and
  /// <code>MetadataFile</code>.
  Future<UpdateIdentityProviderResponse> updateIdentityProvider({
    required String providerName,
    required String userPoolId,
    Map<String, String>? attributeMapping,
    List<String>? idpIdentifiers,
    Map<String, String>? providerDetails,
  }) async {
    ArgumentError.checkNotNull(providerName, 'providerName');
    _s.validateStringLength(
      'providerName',
      providerName,
      1,
      32,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.UpdateIdentityProvider'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ProviderName': providerName,
        'UserPoolId': userPoolId,
        if (attributeMapping != null) 'AttributeMapping': attributeMapping,
        if (idpIdentifiers != null) 'IdpIdentifiers': idpIdentifiers,
        if (providerDetails != null) 'ProviderDetails': providerDetails,
      },
    );

    return UpdateIdentityProviderResponse.fromJson(jsonResponse.body);
  }

  /// Updates the name and scopes of resource server. All other fields are
  /// read-only.
  /// <important>
  /// If you don't provide a value for an attribute, it is set to the default
  /// value.
  /// </important>
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [identifier] :
  /// The identifier for the resource server.
  ///
  /// Parameter [name] :
  /// The name of the resource server.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool.
  ///
  /// Parameter [scopes] :
  /// The scope values to be set for the resource server.
  Future<UpdateResourceServerResponse> updateResourceServer({
    required String identifier,
    required String name,
    required String userPoolId,
    List<ResourceServerScopeType>? scopes,
  }) async {
    ArgumentError.checkNotNull(identifier, 'identifier');
    _s.validateStringLength(
      'identifier',
      identifier,
      1,
      256,
      isRequired: true,
    );
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      256,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.UpdateResourceServer'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Identifier': identifier,
        'Name': name,
        'UserPoolId': userPoolId,
        if (scopes != null) 'Scopes': scopes,
      },
    );

    return UpdateResourceServerResponse.fromJson(jsonResponse.body);
  }

  /// Allows a user to update a specific attribute (one at a time).
  /// <note>
  /// This action might generate an SMS text message. Starting June 1, 2021, US
  /// telecom carriers require you to register an origination phone number
  /// before you can send SMS messages to US phone numbers. If you use SMS text
  /// messages in Amazon Cognito, you must register a phone number with <a
  /// href="https://console.aws.amazon.com/pinpoint/home/">Amazon Pinpoint</a>.
  /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
  /// Cognito users who must receive SMS messages might not be able to sign up,
  /// activate their accounts, or sign in.
  ///
  /// If you have never used SMS text messages with Amazon Cognito or any other
  /// Amazon Web Service, Amazon Simple Notification Service might place your
  /// account in the SMS sandbox. In <i> <a
  /// href="https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html">sandbox
  /// mode</a> </i>, you can send messages only to verified phone numbers. After
  /// you test your app while in the sandbox environment, you can move out of
  /// the sandbox and into production. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-sms-userpool-settings.html">
  /// SMS message settings for Amazon Cognito user pools</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// </note>
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [CodeMismatchException].
  /// May throw [ExpiredCodeException].
  /// May throw [NotAuthorizedException].
  /// May throw [UnexpectedLambdaException].
  /// May throw [UserLambdaValidationException].
  /// May throw [InvalidLambdaResponseException].
  /// May throw [TooManyRequestsException].
  /// May throw [AliasExistsException].
  /// May throw [InvalidSmsRoleAccessPolicyException].
  /// May throw [InvalidSmsRoleTrustRelationshipException].
  /// May throw [InvalidEmailRoleAccessPolicyException].
  /// May throw [CodeDeliveryFailureException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [accessToken] :
  /// A valid access token that Amazon Cognito issued to the user whose user
  /// attributes you want to update.
  ///
  /// Parameter [userAttributes] :
  /// An array of name-value pairs representing user attributes.
  ///
  /// For custom attributes, you must prepend the <code>custom:</code> prefix to
  /// the attribute name.
  ///
  /// If you have set an attribute to require verification before Amazon Cognito
  /// updates its value, this request doesn’t immediately update the value of
  /// that attribute. After your user receives and responds to a verification
  /// message to verify the new value, Amazon Cognito updates the attribute
  /// value. Your user can sign in and receive messages with the original
  /// attribute value until they verify the new value.
  ///
  /// Parameter [clientMetadata] :
  /// A map of custom key-value pairs that you can provide as input for any
  /// custom workflows that this action initiates.
  ///
  /// You create custom workflows by assigning Lambda functions to user pool
  /// triggers. When you use the UpdateUserAttributes API action, Amazon Cognito
  /// invokes the function that is assigned to the <i>custom message</i>
  /// trigger. When Amazon Cognito invokes this function, it passes a JSON
  /// payload, which the function receives as input. This payload contains a
  /// <code>clientMetadata</code> attribute, which provides the data that you
  /// assigned to the ClientMetadata parameter in your UpdateUserAttributes
  /// request. In your function code in Lambda, you can process the
  /// <code>clientMetadata</code> value to enhance your workflow for your
  /// specific needs.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html">
  /// Customizing user pool Workflows with Lambda Triggers</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// <note>
  /// When you use the ClientMetadata parameter, remember that Amazon Cognito
  /// won't do the following:
  ///
  /// <ul>
  /// <li>
  /// Store the ClientMetadata value. This data is available only to Lambda
  /// triggers that are assigned to a user pool to support custom workflows. If
  /// your user pool configuration doesn't include triggers, the ClientMetadata
  /// parameter serves no purpose.
  /// </li>
  /// <li>
  /// Validate the ClientMetadata value.
  /// </li>
  /// <li>
  /// Encrypt the ClientMetadata value. Don't use Amazon Cognito to provide
  /// sensitive information.
  /// </li>
  /// </ul> </note>
  Future<UpdateUserAttributesResponse> updateUserAttributes({
    required String accessToken,
    required List<AttributeType> userAttributes,
    Map<String, String>? clientMetadata,
  }) async {
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    ArgumentError.checkNotNull(userAttributes, 'userAttributes');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.UpdateUserAttributes'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      signed: false,
      // TODO queryParams
      headers: headers,
      payload: {
        'AccessToken': accessToken,
        'UserAttributes': userAttributes,
        if (clientMetadata != null) 'ClientMetadata': clientMetadata,
      },
    );

    return UpdateUserAttributesResponse.fromJson(jsonResponse.body);
  }

  /// Updates the specified user pool with the specified attributes. You can get
  /// a list of the current user pool settings using <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_DescribeUserPool.html">DescribeUserPool</a>.
  /// If you don't provide a value for an attribute, it will be set to the
  /// default value.
  /// <note>
  /// This action might generate an SMS text message. Starting June 1, 2021, US
  /// telecom carriers require you to register an origination phone number
  /// before you can send SMS messages to US phone numbers. If you use SMS text
  /// messages in Amazon Cognito, you must register a phone number with <a
  /// href="https://console.aws.amazon.com/pinpoint/home/">Amazon Pinpoint</a>.
  /// Amazon Cognito uses the registered number automatically. Otherwise, Amazon
  /// Cognito users who must receive SMS messages might not be able to sign up,
  /// activate their accounts, or sign in.
  ///
  /// If you have never used SMS text messages with Amazon Cognito or any other
  /// Amazon Web Service, Amazon Simple Notification Service might place your
  /// account in the SMS sandbox. In <i> <a
  /// href="https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html">sandbox
  /// mode</a> </i>, you can send messages only to verified phone numbers. After
  /// you test your app while in the sandbox environment, you can move out of
  /// the sandbox and into production. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-sms-userpool-settings.html">
  /// SMS message settings for Amazon Cognito user pools</a> in the <i>Amazon
  /// Cognito Developer Guide</i>.
  /// </note>
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [ConcurrentModificationException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [UserImportInProgressException].
  /// May throw [InternalErrorException].
  /// May throw [InvalidSmsRoleAccessPolicyException].
  /// May throw [InvalidSmsRoleTrustRelationshipException].
  /// May throw [UserPoolTaggingException].
  /// May throw [InvalidEmailRoleAccessPolicyException].
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool you want to update.
  ///
  /// Parameter [accountRecoverySetting] :
  /// The available verified method a user can use to recover their password
  /// when they call <code>ForgotPassword</code>. You can use this setting to
  /// define a preferred method when a user has more than one method available.
  /// With this setting, SMS doesn't qualify for a valid password recovery
  /// mechanism if the user also has SMS multi-factor authentication (MFA)
  /// activated. In the absence of this setting, Amazon Cognito uses the legacy
  /// behavior to determine the recovery method where SMS is preferred through
  /// email.
  ///
  /// Parameter [adminCreateUserConfig] :
  /// The configuration for <code>AdminCreateUser</code> requests.
  ///
  /// Parameter [autoVerifiedAttributes] :
  /// The attributes that are automatically verified when Amazon Cognito
  /// requests to update user pools.
  ///
  /// Parameter [deviceConfiguration] :
  /// The device-remembering configuration for a user pool. A null value
  /// indicates that you have deactivated device remembering in your user pool.
  /// <note>
  /// When you provide a value for any <code>DeviceConfiguration</code> field,
  /// you activate the Amazon Cognito device-remembering feature.
  /// </note>
  ///
  /// Parameter [emailConfiguration] :
  /// The email configuration of your user pool. The email configuration type
  /// sets your preferred sending method, Amazon Web Services Region, and sender
  /// for email invitation and verification messages from your user pool.
  ///
  /// Parameter [emailVerificationMessage] :
  /// The contents of the email verification message.
  ///
  /// Parameter [emailVerificationSubject] :
  /// The subject of the email verification message.
  ///
  /// Parameter [lambdaConfig] :
  /// The Lambda configuration information from the request to update the user
  /// pool.
  ///
  /// Parameter [mfaConfiguration] :
  /// Possible values include:
  ///
  /// <ul>
  /// <li>
  /// <code>OFF</code> - MFA tokens aren't required and can't be specified
  /// during user registration.
  /// </li>
  /// <li>
  /// <code>ON</code> - MFA tokens are required for all user registrations. You
  /// can only specify ON when you're initially creating a user pool. You can
  /// use the <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_SetUserPoolMfaConfig.html">SetUserPoolMfaConfig</a>
  /// API operation to turn MFA "ON" for existing user pools.
  /// </li>
  /// <li>
  /// <code>OPTIONAL</code> - Users have the option when registering to create
  /// an MFA token.
  /// </li>
  /// </ul>
  ///
  /// Parameter [policies] :
  /// A container with the policies you want to update in a user pool.
  ///
  /// Parameter [smsAuthenticationMessage] :
  /// The contents of the SMS authentication message.
  ///
  /// Parameter [smsConfiguration] :
  /// The SMS configuration with the settings that your Amazon Cognito user pool
  /// must use to send an SMS message from your Amazon Web Services account
  /// through Amazon Simple Notification Service. To send SMS messages with
  /// Amazon SNS in the Amazon Web Services Region that you want, the Amazon
  /// Cognito user pool uses an Identity and Access Management (IAM) role in
  /// your Amazon Web Services account.
  ///
  /// Parameter [smsVerificationMessage] :
  /// A container with information about the SMS verification message.
  ///
  /// Parameter [userAttributeUpdateSettings] :
  /// The settings for updates to user attributes. These settings include the
  /// property <code>AttributesRequireVerificationBeforeUpdate</code>, a
  /// user-pool setting that tells Amazon Cognito how to handle changes to the
  /// value of your users' email address and phone number attributes. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-email-phone-verification.html#user-pool-settings-verifications-verify-attribute-updates">
  /// Verifying updates to email addresses and phone numbers</a>.
  ///
  /// Parameter [userPoolAddOns] :
  /// Enables advanced security risk detection. Set the key
  /// <code>AdvancedSecurityMode</code> to the value "AUDIT".
  ///
  /// Parameter [userPoolTags] :
  /// The tag keys and values to assign to the user pool. A tag is a label that
  /// you can use to categorize and manage user pools in different ways, such as
  /// by purpose, owner, environment, or other criteria.
  ///
  /// Parameter [verificationMessageTemplate] :
  /// The template for verification messages.
  Future<void> updateUserPool({
    required String userPoolId,
    AccountRecoverySettingType? accountRecoverySetting,
    AdminCreateUserConfigType? adminCreateUserConfig,
    List<VerifiedAttributeType>? autoVerifiedAttributes,
    DeviceConfigurationType? deviceConfiguration,
    EmailConfigurationType? emailConfiguration,
    String? emailVerificationMessage,
    String? emailVerificationSubject,
    LambdaConfigType? lambdaConfig,
    UserPoolMfaType? mfaConfiguration,
    UserPoolPolicyType? policies,
    String? smsAuthenticationMessage,
    SmsConfigurationType? smsConfiguration,
    String? smsVerificationMessage,
    UserAttributeUpdateSettingsType? userAttributeUpdateSettings,
    UserPoolAddOnsType? userPoolAddOns,
    Map<String, String>? userPoolTags,
    VerificationMessageTemplateType? verificationMessageTemplate,
  }) async {
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateStringLength(
      'emailVerificationMessage',
      emailVerificationMessage,
      6,
      20000,
    );
    _s.validateStringLength(
      'emailVerificationSubject',
      emailVerificationSubject,
      1,
      140,
    );
    _s.validateStringLength(
      'smsAuthenticationMessage',
      smsAuthenticationMessage,
      6,
      140,
    );
    _s.validateStringLength(
      'smsVerificationMessage',
      smsVerificationMessage,
      6,
      140,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.UpdateUserPool'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserPoolId': userPoolId,
        if (accountRecoverySetting != null)
          'AccountRecoverySetting': accountRecoverySetting,
        if (adminCreateUserConfig != null)
          'AdminCreateUserConfig': adminCreateUserConfig,
        if (autoVerifiedAttributes != null)
          'AutoVerifiedAttributes':
              autoVerifiedAttributes.map((e) => e.toValue()).toList(),
        if (deviceConfiguration != null)
          'DeviceConfiguration': deviceConfiguration,
        if (emailConfiguration != null)
          'EmailConfiguration': emailConfiguration,
        if (emailVerificationMessage != null)
          'EmailVerificationMessage': emailVerificationMessage,
        if (emailVerificationSubject != null)
          'EmailVerificationSubject': emailVerificationSubject,
        if (lambdaConfig != null) 'LambdaConfig': lambdaConfig,
        if (mfaConfiguration != null)
          'MfaConfiguration': mfaConfiguration.toValue(),
        if (policies != null) 'Policies': policies,
        if (smsAuthenticationMessage != null)
          'SmsAuthenticationMessage': smsAuthenticationMessage,
        if (smsConfiguration != null) 'SmsConfiguration': smsConfiguration,
        if (smsVerificationMessage != null)
          'SmsVerificationMessage': smsVerificationMessage,
        if (userAttributeUpdateSettings != null)
          'UserAttributeUpdateSettings': userAttributeUpdateSettings,
        if (userPoolAddOns != null) 'UserPoolAddOns': userPoolAddOns,
        if (userPoolTags != null) 'UserPoolTags': userPoolTags,
        if (verificationMessageTemplate != null)
          'VerificationMessageTemplate': verificationMessageTemplate,
      },
    );
  }

  /// Updates the specified user pool app client with the specified attributes.
  /// You can get a list of the current user pool app client settings using <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_DescribeUserPoolClient.html">DescribeUserPoolClient</a>.
  /// <important>
  /// If you don't provide a value for an attribute, it will be set to the
  /// default value.
  /// </important>
  /// You can also use this operation to enable token revocation for user pool
  /// clients. For more information about revoking tokens, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_RevokeToken.html">RevokeToken</a>.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [ConcurrentModificationException].
  /// May throw [TooManyRequestsException].
  /// May throw [NotAuthorizedException].
  /// May throw [ScopeDoesNotExistException].
  /// May throw [InvalidOAuthFlowException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [clientId] :
  /// The ID of the client associated with the user pool.
  ///
  /// Parameter [userPoolId] :
  /// The user pool ID for the user pool where you want to update the user pool
  /// client.
  ///
  /// Parameter [accessTokenValidity] :
  /// The access token time limit. After this limit expires, your user can't use
  /// their access token. To specify the time unit for
  /// <code>AccessTokenValidity</code> as <code>seconds</code>,
  /// <code>minutes</code>, <code>hours</code>, or <code>days</code>, set a
  /// <code>TokenValidityUnits</code> value in your API request.
  ///
  /// For example, when you set <code>AccessTokenValidity</code> to
  /// <code>10</code> and <code>TokenValidityUnits</code> to <code>hours</code>,
  /// your user can authorize access with their access token for 10 hours.
  ///
  /// The default time unit for <code>AccessTokenValidity</code> in an API
  /// request is hours. <i>Valid range</i> is displayed below in seconds.
  ///
  /// Parameter [allowedOAuthFlows] :
  /// The allowed OAuth flows.
  /// <dl> <dt>code</dt> <dd>
  /// Use a code grant flow, which provides an authorization code as the
  /// response. This code can be exchanged for access tokens with the
  /// <code>/oauth2/token</code> endpoint.
  /// </dd> <dt>implicit</dt> <dd>
  /// Issue the access token (and, optionally, ID token, based on scopes)
  /// directly to your user.
  /// </dd> <dt>client_credentials</dt> <dd>
  /// Issue the access token from the <code>/oauth2/token</code> endpoint
  /// directly to a non-person user using a combination of the client ID and
  /// client secret.
  /// </dd> </dl>
  ///
  /// Parameter [allowedOAuthFlowsUserPoolClient] :
  /// Set to true if the client is allowed to follow the OAuth protocol when
  /// interacting with Amazon Cognito user pools.
  ///
  /// Parameter [allowedOAuthScopes] :
  /// The allowed OAuth scopes. Possible values provided by OAuth are
  /// <code>phone</code>, <code>email</code>, <code>openid</code>, and
  /// <code>profile</code>. Possible values provided by Amazon Web Services are
  /// <code>aws.cognito.signin.user.admin</code>. Custom scopes created in
  /// Resource Servers are also supported.
  ///
  /// Parameter [analyticsConfiguration] :
  /// The Amazon Pinpoint analytics configuration necessary to collect metrics
  /// for this user pool.
  /// <note>
  /// In Amazon Web Services Regions where Amazon Pinpoint isn't available, user
  /// pools only support sending events to Amazon Pinpoint projects in
  /// us-east-1. In Regions where Amazon Pinpoint is available, user pools
  /// support sending events to Amazon Pinpoint projects within that same
  /// Region.
  /// </note>
  ///
  /// Parameter [callbackURLs] :
  /// A list of allowed redirect (callback) URLs for the IdPs.
  ///
  /// A redirect URI must:
  ///
  /// <ul>
  /// <li>
  /// Be an absolute URI.
  /// </li>
  /// <li>
  /// Be registered with the authorization server.
  /// </li>
  /// <li>
  /// Not include a fragment component.
  /// </li>
  /// </ul>
  /// See <a href="https://tools.ietf.org/html/rfc6749#section-3.1.2">OAuth 2.0
  /// - Redirection Endpoint</a>.
  ///
  /// Amazon Cognito requires HTTPS over HTTP except for http://localhost for
  /// testing purposes only.
  ///
  /// App callback URLs such as <code>myapp://example</code> are also supported.
  ///
  /// Parameter [clientName] :
  /// The client name from the update user pool client request.
  ///
  /// Parameter [defaultRedirectURI] :
  /// The default redirect URI. Must be in the <code>CallbackURLs</code> list.
  ///
  /// A redirect URI must:
  ///
  /// <ul>
  /// <li>
  /// Be an absolute URI.
  /// </li>
  /// <li>
  /// Be registered with the authorization server.
  /// </li>
  /// <li>
  /// Not include a fragment component.
  /// </li>
  /// </ul>
  /// See <a href="https://tools.ietf.org/html/rfc6749#section-3.1.2">OAuth 2.0
  /// - Redirection Endpoint</a>.
  ///
  /// Amazon Cognito requires HTTPS over HTTP except for
  /// <code>http://localhost</code> for testing purposes only.
  ///
  /// App callback URLs such as <code>myapp://example</code> are also supported.
  ///
  /// Parameter [enablePropagateAdditionalUserContextData] :
  /// Activates the propagation of additional user context data. For more
  /// information about propagation of user context data, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-advanced-security.html">
  /// Adding advanced security to a user pool</a>. If you don’t include this
  /// parameter, you can't send device fingerprint information, including source
  /// IP address, to Amazon Cognito advanced security. You can only activate
  /// <code>EnablePropagateAdditionalUserContextData</code> in an app client
  /// that has a client secret.
  ///
  /// Parameter [enableTokenRevocation] :
  /// Activates or deactivates token revocation. For more information about
  /// revoking tokens, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_RevokeToken.html">RevokeToken</a>.
  ///
  /// Parameter [explicitAuthFlows] :
  /// The authentication flows that are supported by the user pool clients. Flow
  /// names without the <code>ALLOW_</code> prefix are no longer supported in
  /// favor of new names with the <code>ALLOW_</code> prefix. Note that values
  /// with <code>ALLOW_</code> prefix must be used only along with values with
  /// the <code>ALLOW_</code> prefix.
  ///
  /// Valid values include:
  ///
  /// <ul>
  /// <li>
  /// <code>ALLOW_ADMIN_USER_PASSWORD_AUTH</code>: Enable admin based user
  /// password authentication flow <code>ADMIN_USER_PASSWORD_AUTH</code>. This
  /// setting replaces the <code>ADMIN_NO_SRP_AUTH</code> setting. With this
  /// authentication flow, Amazon Cognito receives the password in the request
  /// instead of using the Secure Remote Password (SRP) protocol to verify
  /// passwords.
  /// </li>
  /// <li>
  /// <code>ALLOW_CUSTOM_AUTH</code>: Enable Lambda trigger based
  /// authentication.
  /// </li>
  /// <li>
  /// <code>ALLOW_USER_PASSWORD_AUTH</code>: Enable user password-based
  /// authentication. In this flow, Amazon Cognito receives the password in the
  /// request instead of using the SRP protocol to verify passwords.
  /// </li>
  /// <li>
  /// <code>ALLOW_USER_SRP_AUTH</code>: Enable SRP-based authentication.
  /// </li>
  /// <li>
  /// <code>ALLOW_REFRESH_TOKEN_AUTH</code>: Enable authflow to refresh tokens.
  /// </li>
  /// </ul>
  ///
  /// Parameter [idTokenValidity] :
  /// The ID token time limit. After this limit expires, your user can't use
  /// their ID token. To specify the time unit for <code>IdTokenValidity</code>
  /// as <code>seconds</code>, <code>minutes</code>, <code>hours</code>, or
  /// <code>days</code>, set a <code>TokenValidityUnits</code> value in your API
  /// request.
  ///
  /// For example, when you set <code>IdTokenValidity</code> as <code>10</code>
  /// and <code>TokenValidityUnits</code> as <code>hours</code>, your user can
  /// authenticate their session with their ID token for 10 hours.
  ///
  /// The default time unit for <code>AccessTokenValidity</code> in an API
  /// request is hours. <i>Valid range</i> is displayed below in seconds.
  ///
  /// Parameter [logoutURLs] :
  /// A list of allowed logout URLs for the IdPs.
  ///
  /// Parameter [preventUserExistenceErrors] :
  /// Errors and responses that you want Amazon Cognito APIs to return during
  /// authentication, account confirmation, and password recovery when the user
  /// doesn't exist in the user pool. When set to <code>ENABLED</code> and the
  /// user doesn't exist, authentication returns an error indicating either the
  /// username or password was incorrect. Account confirmation and password
  /// recovery return a response indicating a code was sent to a simulated
  /// destination. When set to <code>LEGACY</code>, those APIs return a
  /// <code>UserNotFoundException</code> exception if the user doesn't exist in
  /// the user pool.
  ///
  /// Valid values include:
  ///
  /// <ul>
  /// <li>
  /// <code>ENABLED</code> - This prevents user existence-related errors.
  /// </li>
  /// <li>
  /// <code>LEGACY</code> - This represents the early behavior of Amazon Cognito
  /// where user existence related errors aren't prevented.
  /// </li>
  /// </ul>
  ///
  /// Parameter [readAttributes] :
  /// The read-only attributes of the user pool.
  ///
  /// Parameter [refreshTokenValidity] :
  /// The refresh token time limit. After this limit expires, your user can't
  /// use their refresh token. To specify the time unit for
  /// <code>RefreshTokenValidity</code> as <code>seconds</code>,
  /// <code>minutes</code>, <code>hours</code>, or <code>days</code>, set a
  /// <code>TokenValidityUnits</code> value in your API request.
  ///
  /// For example, when you set <code>RefreshTokenValidity</code> as
  /// <code>10</code> and <code>TokenValidityUnits</code> as <code>days</code>,
  /// your user can refresh their session and retrieve new access and ID tokens
  /// for 10 days.
  ///
  /// The default time unit for <code>RefreshTokenValidity</code> in an API
  /// request is days. You can't set <code>RefreshTokenValidity</code> to 0. If
  /// you do, Amazon Cognito overrides the value with the default value of 30
  /// days. <i>Valid range</i> is displayed below in seconds.
  ///
  /// Parameter [supportedIdentityProviders] :
  /// A list of provider names for the IdPs that this client supports. The
  /// following are supported: <code>COGNITO</code>, <code>Facebook</code>,
  /// <code>Google</code>, <code>SignInWithApple</code>,
  /// <code>LoginWithAmazon</code>, and the names of your own SAML and OIDC
  /// providers.
  ///
  /// Parameter [tokenValidityUnits] :
  /// The units in which the validity times are represented. The default unit
  /// for RefreshToken is days, and the default for ID and access tokens is
  /// hours.
  ///
  /// Parameter [writeAttributes] :
  /// The writeable attributes of the user pool.
  Future<UpdateUserPoolClientResponse> updateUserPoolClient({
    required String clientId,
    required String userPoolId,
    int? accessTokenValidity,
    List<OAuthFlowType>? allowedOAuthFlows,
    bool? allowedOAuthFlowsUserPoolClient,
    List<String>? allowedOAuthScopes,
    AnalyticsConfigurationType? analyticsConfiguration,
    List<String>? callbackURLs,
    String? clientName,
    String? defaultRedirectURI,
    bool? enablePropagateAdditionalUserContextData,
    bool? enableTokenRevocation,
    List<ExplicitAuthFlowsType>? explicitAuthFlows,
    int? idTokenValidity,
    List<String>? logoutURLs,
    PreventUserExistenceErrorTypes? preventUserExistenceErrors,
    List<String>? readAttributes,
    int? refreshTokenValidity,
    List<String>? supportedIdentityProviders,
    TokenValidityUnitsType? tokenValidityUnits,
    List<String>? writeAttributes,
  }) async {
    ArgumentError.checkNotNull(clientId, 'clientId');
    _s.validateStringLength(
      'clientId',
      clientId,
      1,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    _s.validateNumRange(
      'accessTokenValidity',
      accessTokenValidity,
      1,
      86400,
    );
    _s.validateStringLength(
      'clientName',
      clientName,
      1,
      128,
    );
    _s.validateStringLength(
      'defaultRedirectURI',
      defaultRedirectURI,
      1,
      1024,
    );
    _s.validateNumRange(
      'idTokenValidity',
      idTokenValidity,
      1,
      86400,
    );
    _s.validateNumRange(
      'refreshTokenValidity',
      refreshTokenValidity,
      0,
      315360000,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.UpdateUserPoolClient'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ClientId': clientId,
        'UserPoolId': userPoolId,
        if (accessTokenValidity != null)
          'AccessTokenValidity': accessTokenValidity,
        if (allowedOAuthFlows != null)
          'AllowedOAuthFlows':
              allowedOAuthFlows.map((e) => e.toValue()).toList(),
        if (allowedOAuthFlowsUserPoolClient != null)
          'AllowedOAuthFlowsUserPoolClient': allowedOAuthFlowsUserPoolClient,
        if (allowedOAuthScopes != null)
          'AllowedOAuthScopes': allowedOAuthScopes,
        if (analyticsConfiguration != null)
          'AnalyticsConfiguration': analyticsConfiguration,
        if (callbackURLs != null) 'CallbackURLs': callbackURLs,
        if (clientName != null) 'ClientName': clientName,
        if (defaultRedirectURI != null)
          'DefaultRedirectURI': defaultRedirectURI,
        if (enablePropagateAdditionalUserContextData != null)
          'EnablePropagateAdditionalUserContextData':
              enablePropagateAdditionalUserContextData,
        if (enableTokenRevocation != null)
          'EnableTokenRevocation': enableTokenRevocation,
        if (explicitAuthFlows != null)
          'ExplicitAuthFlows':
              explicitAuthFlows.map((e) => e.toValue()).toList(),
        if (idTokenValidity != null) 'IdTokenValidity': idTokenValidity,
        if (logoutURLs != null) 'LogoutURLs': logoutURLs,
        if (preventUserExistenceErrors != null)
          'PreventUserExistenceErrors': preventUserExistenceErrors.toValue(),
        if (readAttributes != null) 'ReadAttributes': readAttributes,
        if (refreshTokenValidity != null)
          'RefreshTokenValidity': refreshTokenValidity,
        if (supportedIdentityProviders != null)
          'SupportedIdentityProviders': supportedIdentityProviders,
        if (tokenValidityUnits != null)
          'TokenValidityUnits': tokenValidityUnits,
        if (writeAttributes != null) 'WriteAttributes': writeAttributes,
      },
    );

    return UpdateUserPoolClientResponse.fromJson(jsonResponse.body);
  }

  /// Updates the Secure Sockets Layer (SSL) certificate for the custom domain
  /// for your user pool.
  ///
  /// You can use this operation to provide the Amazon Resource Name (ARN) of a
  /// new certificate to Amazon Cognito. You can't use it to change the domain
  /// for a user pool.
  ///
  /// A custom domain is used to host the Amazon Cognito hosted UI, which
  /// provides sign-up and sign-in pages for your application. When you set up a
  /// custom domain, you provide a certificate that you manage with Certificate
  /// Manager (ACM). When necessary, you can use this operation to change the
  /// certificate that you applied to your custom domain.
  ///
  /// Usually, this is unnecessary following routine certificate renewal with
  /// ACM. When you renew your existing certificate in ACM, the ARN for your
  /// certificate remains the same, and your custom domain uses the new
  /// certificate automatically.
  ///
  /// However, if you replace your existing certificate with a new one, ACM
  /// gives the new certificate a new ARN. To apply the new certificate to your
  /// custom domain, you must provide this ARN to Amazon Cognito.
  ///
  /// When you add your new certificate in ACM, you must choose US East (N.
  /// Virginia) as the Amazon Web Services Region.
  ///
  /// After you submit your request, Amazon Cognito requires up to 1 hour to
  /// distribute your new certificate to your custom domain.
  ///
  /// For more information about adding a custom domain to your user pool, see
  /// <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-add-custom-domain.html">Using
  /// Your Own Domain for the Hosted UI</a>.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [NotAuthorizedException].
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalErrorException].
  ///
  /// Parameter [customDomainConfig] :
  /// The configuration for a custom domain that hosts the sign-up and sign-in
  /// pages for your application. Use this object to specify an SSL certificate
  /// that is managed by ACM.
  ///
  /// Parameter [domain] :
  /// The domain name for the custom domain that hosts the sign-up and sign-in
  /// pages for your application. One example might be
  /// <code>auth.example.com</code>.
  ///
  /// This string can include only lowercase letters, numbers, and hyphens.
  /// Don't use a hyphen for the first or last character. Use periods to
  /// separate subdomain names.
  ///
  /// Parameter [userPoolId] :
  /// The ID of the user pool that is associated with the custom domain whose
  /// certificate you're updating.
  Future<UpdateUserPoolDomainResponse> updateUserPoolDomain({
    required CustomDomainConfigType customDomainConfig,
    required String domain,
    required String userPoolId,
  }) async {
    ArgumentError.checkNotNull(customDomainConfig, 'customDomainConfig');
    ArgumentError.checkNotNull(domain, 'domain');
    _s.validateStringLength(
      'domain',
      domain,
      1,
      63,
      isRequired: true,
    );
    ArgumentError.checkNotNull(userPoolId, 'userPoolId');
    _s.validateStringLength(
      'userPoolId',
      userPoolId,
      1,
      55,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.UpdateUserPoolDomain'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'CustomDomainConfig': customDomainConfig,
        'Domain': domain,
        'UserPoolId': userPoolId,
      },
    );

    return UpdateUserPoolDomainResponse.fromJson(jsonResponse.body);
  }

  /// Use this API to register a user's entered time-based one-time password
  /// (TOTP) code and mark the user's software token MFA status as "verified" if
  /// successful. The request takes an access token or a session string, but not
  /// both.
  ///
  /// May throw [InvalidParameterException].
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidUserPoolConfigurationException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [EnableSoftwareTokenMFAException].
  /// May throw [NotAuthorizedException].
  /// May throw [SoftwareTokenMFANotFoundException].
  /// May throw [CodeMismatchException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [userCode] :
  /// The one- time password computed using the secret code returned by <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AssociateSoftwareToken.html">AssociateSoftwareToken</a>.
  ///
  /// Parameter [accessToken] :
  /// A valid access token that Amazon Cognito issued to the user whose software
  /// token you want to verify.
  ///
  /// Parameter [friendlyDeviceName] :
  /// The friendly device name.
  ///
  /// Parameter [session] :
  /// The session that should be passed both ways in challenge-response calls to
  /// the service.
  Future<VerifySoftwareTokenResponse> verifySoftwareToken({
    required String userCode,
    String? accessToken,
    String? friendlyDeviceName,
    String? session,
  }) async {
    ArgumentError.checkNotNull(userCode, 'userCode');
    _s.validateStringLength(
      'userCode',
      userCode,
      6,
      6,
      isRequired: true,
    );
    _s.validateStringLength(
      'session',
      session,
      20,
      2048,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.VerifySoftwareToken'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'UserCode': userCode,
        if (accessToken != null) 'AccessToken': accessToken,
        if (friendlyDeviceName != null)
          'FriendlyDeviceName': friendlyDeviceName,
        if (session != null) 'Session': session,
      },
    );

    return VerifySoftwareTokenResponse.fromJson(jsonResponse.body);
  }

  /// Verifies the specified user attributes in the user pool.
  ///
  /// If your user pool requires verification before Amazon Cognito updates the
  /// attribute value, VerifyUserAttribute updates the affected attribute to its
  /// pending value. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_UserAttributeUpdateSettingsType.html">
  /// UserAttributeUpdateSettingsType</a>.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterException].
  /// May throw [CodeMismatchException].
  /// May throw [ExpiredCodeException].
  /// May throw [NotAuthorizedException].
  /// May throw [TooManyRequestsException].
  /// May throw [LimitExceededException].
  /// May throw [PasswordResetRequiredException].
  /// May throw [UserNotFoundException].
  /// May throw [UserNotConfirmedException].
  /// May throw [InternalErrorException].
  /// May throw [AliasExistsException].
  /// May throw [ForbiddenException].
  ///
  /// Parameter [accessToken] :
  /// A valid access token that Amazon Cognito issued to the user whose user
  /// attributes you want to verify.
  ///
  /// Parameter [attributeName] :
  /// The attribute name in the request to verify user attributes.
  ///
  /// Parameter [code] :
  /// The verification code in the request to verify user attributes.
  Future<void> verifyUserAttribute({
    required String accessToken,
    required String attributeName,
    required String code,
  }) async {
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    ArgumentError.checkNotNull(attributeName, 'attributeName');
    _s.validateStringLength(
      'attributeName',
      attributeName,
      1,
      32,
      isRequired: true,
    );
    ArgumentError.checkNotNull(code, 'code');
    _s.validateStringLength(
      'code',
      code,
      1,
      2048,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSCognitoIdentityProviderService.VerifyUserAttribute'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      signed: false,
      // TODO queryParams
      headers: headers,
      payload: {
        'AccessToken': accessToken,
        'AttributeName': attributeName,
        'Code': code,
      },
    );
  }
}

/// The data type for <code>AccountRecoverySetting</code>.
class AccountRecoverySettingType {
  /// The list of <code>RecoveryOptionTypes</code>.
  final List<RecoveryOptionType>? recoveryMechanisms;

  AccountRecoverySettingType({
    this.recoveryMechanisms,
  });
  factory AccountRecoverySettingType.fromJson(Map<String, dynamic> json) {
    return AccountRecoverySettingType(
      recoveryMechanisms: (json['RecoveryMechanisms'] as List?)
          ?.whereNotNull()
          .map((e) => RecoveryOptionType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final recoveryMechanisms = this.recoveryMechanisms;
    return {
      if (recoveryMechanisms != null) 'RecoveryMechanisms': recoveryMechanisms,
    };
  }
}

/// Account takeover action type.
class AccountTakeoverActionType {
  /// The action to take in response to the account takeover action. Valid values
  /// are as follows:
  ///
  /// <ul>
  /// <li>
  /// <code>BLOCK</code> Choosing this action will block the request.
  /// </li>
  /// <li>
  /// <code>MFA_IF_CONFIGURED</code> Present an MFA challenge if user has
  /// configured it, else allow the request.
  /// </li>
  /// <li>
  /// <code>MFA_REQUIRED</code> Present an MFA challenge if user has configured
  /// it, else block the request.
  /// </li>
  /// <li>
  /// <code>NO_ACTION</code> Allow the user to sign in.
  /// </li>
  /// </ul>
  final AccountTakeoverEventActionType eventAction;

  /// Flag specifying whether to send a notification.
  final bool notify;

  AccountTakeoverActionType({
    required this.eventAction,
    required this.notify,
  });
  factory AccountTakeoverActionType.fromJson(Map<String, dynamic> json) {
    return AccountTakeoverActionType(
      eventAction:
          (json['EventAction'] as String).toAccountTakeoverEventActionType(),
      notify: json['Notify'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    final eventAction = this.eventAction;
    final notify = this.notify;
    return {
      'EventAction': eventAction.toValue(),
      'Notify': notify,
    };
  }
}

/// Account takeover actions type.
class AccountTakeoverActionsType {
  /// Action to take for a high risk.
  final AccountTakeoverActionType? highAction;

  /// Action to take for a low risk.
  final AccountTakeoverActionType? lowAction;

  /// Action to take for a medium risk.
  final AccountTakeoverActionType? mediumAction;

  AccountTakeoverActionsType({
    this.highAction,
    this.lowAction,
    this.mediumAction,
  });
  factory AccountTakeoverActionsType.fromJson(Map<String, dynamic> json) {
    return AccountTakeoverActionsType(
      highAction: json['HighAction'] != null
          ? AccountTakeoverActionType.fromJson(
              json['HighAction'] as Map<String, dynamic>)
          : null,
      lowAction: json['LowAction'] != null
          ? AccountTakeoverActionType.fromJson(
              json['LowAction'] as Map<String, dynamic>)
          : null,
      mediumAction: json['MediumAction'] != null
          ? AccountTakeoverActionType.fromJson(
              json['MediumAction'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final highAction = this.highAction;
    final lowAction = this.lowAction;
    final mediumAction = this.mediumAction;
    return {
      if (highAction != null) 'HighAction': highAction,
      if (lowAction != null) 'LowAction': lowAction,
      if (mediumAction != null) 'MediumAction': mediumAction,
    };
  }
}

enum AccountTakeoverEventActionType {
  block,
  mfaIfConfigured,
  mfaRequired,
  noAction,
}

extension on AccountTakeoverEventActionType {
  String toValue() {
    switch (this) {
      case AccountTakeoverEventActionType.block:
        return 'BLOCK';
      case AccountTakeoverEventActionType.mfaIfConfigured:
        return 'MFA_IF_CONFIGURED';
      case AccountTakeoverEventActionType.mfaRequired:
        return 'MFA_REQUIRED';
      case AccountTakeoverEventActionType.noAction:
        return 'NO_ACTION';
    }
  }
}

extension on String {
  AccountTakeoverEventActionType toAccountTakeoverEventActionType() {
    switch (this) {
      case 'BLOCK':
        return AccountTakeoverEventActionType.block;
      case 'MFA_IF_CONFIGURED':
        return AccountTakeoverEventActionType.mfaIfConfigured;
      case 'MFA_REQUIRED':
        return AccountTakeoverEventActionType.mfaRequired;
      case 'NO_ACTION':
        return AccountTakeoverEventActionType.noAction;
    }
    throw Exception(
        '$this is not known in enum AccountTakeoverEventActionType');
  }
}

/// Configuration for mitigation actions and notification for different levels
/// of risk detected for a potential account takeover.
class AccountTakeoverRiskConfigurationType {
  /// Account takeover risk configuration actions.
  final AccountTakeoverActionsType actions;

  /// The notify configuration used to construct email notifications.
  final NotifyConfigurationType? notifyConfiguration;

  AccountTakeoverRiskConfigurationType({
    required this.actions,
    this.notifyConfiguration,
  });
  factory AccountTakeoverRiskConfigurationType.fromJson(
      Map<String, dynamic> json) {
    return AccountTakeoverRiskConfigurationType(
      actions: AccountTakeoverActionsType.fromJson(
          json['Actions'] as Map<String, dynamic>),
      notifyConfiguration: json['NotifyConfiguration'] != null
          ? NotifyConfigurationType.fromJson(
              json['NotifyConfiguration'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final actions = this.actions;
    final notifyConfiguration = this.notifyConfiguration;
    return {
      'Actions': actions,
      if (notifyConfiguration != null)
        'NotifyConfiguration': notifyConfiguration,
    };
  }
}

/// Represents the response from the server for the request to add custom
/// attributes.
class AddCustomAttributesResponse {
  AddCustomAttributesResponse();
  factory AddCustomAttributesResponse.fromJson(Map<String, dynamic> _) {
    return AddCustomAttributesResponse();
  }
}

/// Represents the response from the server for the request to confirm
/// registration.
class AdminConfirmSignUpResponse {
  AdminConfirmSignUpResponse();
  factory AdminConfirmSignUpResponse.fromJson(Map<String, dynamic> _) {
    return AdminConfirmSignUpResponse();
  }
}

/// The configuration for creating a new user profile.
class AdminCreateUserConfigType {
  /// Set to <code>True</code> if only the administrator is allowed to create user
  /// profiles. Set to <code>False</code> if users can sign themselves up via an
  /// app.
  final bool? allowAdminCreateUserOnly;

  /// The message template to be used for the welcome message to new users.
  ///
  /// See also <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-message-customizations.html#cognito-user-pool-settings-user-invitation-message-customization">Customizing
  /// User Invitation Messages</a>.
  final MessageTemplateType? inviteMessageTemplate;

  /// The user account expiration limit, in days, after which a new account that
  /// hasn't signed in is no longer usable. To reset the account after that time
  /// limit, you must call <code>AdminCreateUser</code> again, specifying
  /// <code>"RESEND"</code> for the <code>MessageAction</code> parameter. The
  /// default value for this parameter is 7.
  /// <note>
  /// If you set a value for <code>TemporaryPasswordValidityDays</code> in
  /// <code>PasswordPolicy</code>, that value will be used, and
  /// <code>UnusedAccountValidityDays</code> will be no longer be an available
  /// parameter for that user pool.
  /// </note>
  final int? unusedAccountValidityDays;

  AdminCreateUserConfigType({
    this.allowAdminCreateUserOnly,
    this.inviteMessageTemplate,
    this.unusedAccountValidityDays,
  });
  factory AdminCreateUserConfigType.fromJson(Map<String, dynamic> json) {
    return AdminCreateUserConfigType(
      allowAdminCreateUserOnly: json['AllowAdminCreateUserOnly'] as bool?,
      inviteMessageTemplate: json['InviteMessageTemplate'] != null
          ? MessageTemplateType.fromJson(
              json['InviteMessageTemplate'] as Map<String, dynamic>)
          : null,
      unusedAccountValidityDays: json['UnusedAccountValidityDays'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final allowAdminCreateUserOnly = this.allowAdminCreateUserOnly;
    final inviteMessageTemplate = this.inviteMessageTemplate;
    final unusedAccountValidityDays = this.unusedAccountValidityDays;
    return {
      if (allowAdminCreateUserOnly != null)
        'AllowAdminCreateUserOnly': allowAdminCreateUserOnly,
      if (inviteMessageTemplate != null)
        'InviteMessageTemplate': inviteMessageTemplate,
      if (unusedAccountValidityDays != null)
        'UnusedAccountValidityDays': unusedAccountValidityDays,
    };
  }
}

/// Represents the response from the server to the request to create the user.
class AdminCreateUserResponse {
  /// The newly created user.
  final UserType? user;

  AdminCreateUserResponse({
    this.user,
  });
  factory AdminCreateUserResponse.fromJson(Map<String, dynamic> json) {
    return AdminCreateUserResponse(
      user: json['User'] != null
          ? UserType.fromJson(json['User'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Represents the response received from the server for a request to delete
/// user attributes.
class AdminDeleteUserAttributesResponse {
  AdminDeleteUserAttributesResponse();
  factory AdminDeleteUserAttributesResponse.fromJson(Map<String, dynamic> _) {
    return AdminDeleteUserAttributesResponse();
  }
}

class AdminDisableProviderForUserResponse {
  AdminDisableProviderForUserResponse();
  factory AdminDisableProviderForUserResponse.fromJson(Map<String, dynamic> _) {
    return AdminDisableProviderForUserResponse();
  }
}

/// Represents the response received from the server to disable the user as an
/// administrator.
class AdminDisableUserResponse {
  AdminDisableUserResponse();
  factory AdminDisableUserResponse.fromJson(Map<String, dynamic> _) {
    return AdminDisableUserResponse();
  }
}

/// Represents the response from the server for the request to enable a user as
/// an administrator.
class AdminEnableUserResponse {
  AdminEnableUserResponse();
  factory AdminEnableUserResponse.fromJson(Map<String, dynamic> _) {
    return AdminEnableUserResponse();
  }
}

/// Gets the device response, as an administrator.
class AdminGetDeviceResponse {
  /// The device.
  final DeviceType device;

  AdminGetDeviceResponse({
    required this.device,
  });
  factory AdminGetDeviceResponse.fromJson(Map<String, dynamic> json) {
    return AdminGetDeviceResponse(
      device: DeviceType.fromJson(json['Device'] as Map<String, dynamic>),
    );
  }
}

/// Represents the response from the server from the request to get the
/// specified user as an administrator.
class AdminGetUserResponse {
  /// The user name of the user about whom you're receiving information.
  final String username;

  /// Indicates that the status is <code>enabled</code>.
  final bool? enabled;

  /// <i>This response parameter is no longer supported.</i> It provides
  /// information only about SMS MFA configurations. It doesn't provide
  /// information about time-based one-time password (TOTP) software token MFA
  /// configurations. To look up information about either type of MFA
  /// configuration, use UserMFASettingList instead.
  final List<MFAOptionType>? mFAOptions;

  /// The user's preferred MFA setting.
  final String? preferredMfaSetting;

  /// An array of name-value pairs representing user attributes.
  final List<AttributeType>? userAttributes;

  /// The date the user was created.
  final DateTime? userCreateDate;

  /// The date the user was last modified.
  final DateTime? userLastModifiedDate;

  /// The MFA options that are activated for the user. The possible values in this
  /// list are <code>SMS_MFA</code> and <code>SOFTWARE_TOKEN_MFA</code>.
  final List<String>? userMFASettingList;

  /// The user status. Can be one of the following:
  ///
  /// <ul>
  /// <li>
  /// UNCONFIRMED - User has been created but not confirmed.
  /// </li>
  /// <li>
  /// CONFIRMED - User has been confirmed.
  /// </li>
  /// <li>
  /// ARCHIVED - User is no longer active.
  /// </li>
  /// <li>
  /// UNKNOWN - User status isn't known.
  /// </li>
  /// <li>
  /// RESET_REQUIRED - User is confirmed, but the user must request a code and
  /// reset their password before they can sign in.
  /// </li>
  /// <li>
  /// FORCE_CHANGE_PASSWORD - The user is confirmed and the user can sign in using
  /// a temporary password, but on first sign-in, the user must change their
  /// password to a new value before doing anything else.
  /// </li>
  /// </ul>
  final UserStatusType? userStatus;

  AdminGetUserResponse({
    required this.username,
    this.enabled,
    this.mFAOptions,
    this.preferredMfaSetting,
    this.userAttributes,
    this.userCreateDate,
    this.userLastModifiedDate,
    this.userMFASettingList,
    this.userStatus,
  });
  factory AdminGetUserResponse.fromJson(Map<String, dynamic> json) {
    return AdminGetUserResponse(
      username: json['Username'] as String,
      enabled: json['Enabled'] as bool?,
      mFAOptions: (json['MFAOptions'] as List?)
          ?.whereNotNull()
          .map((e) => MFAOptionType.fromJson(e as Map<String, dynamic>))
          .toList(),
      preferredMfaSetting: json['PreferredMfaSetting'] as String?,
      userAttributes: (json['UserAttributes'] as List?)
          ?.whereNotNull()
          .map((e) => AttributeType.fromJson(e as Map<String, dynamic>))
          .toList(),
      userCreateDate: timeStampFromJson(json['UserCreateDate']),
      userLastModifiedDate: timeStampFromJson(json['UserLastModifiedDate']),
      userMFASettingList: (json['UserMFASettingList'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      userStatus: (json['UserStatus'] as String?)?.toUserStatusType(),
    );
  }
}

/// Initiates the authentication response, as an administrator.
class AdminInitiateAuthResponse {
  /// The result of the authentication response. This is only returned if the
  /// caller doesn't need to pass another challenge. If the caller does need to
  /// pass another challenge before it gets tokens, <code>ChallengeName</code>,
  /// <code>ChallengeParameters</code>, and <code>Session</code> are returned.
  final AuthenticationResultType? authenticationResult;

  /// The name of the challenge that you're responding to with this call. This is
  /// returned in the <code>AdminInitiateAuth</code> response if you must pass
  /// another challenge.
  ///
  /// <ul>
  /// <li>
  /// <code>MFA_SETUP</code>: If MFA is required, users who don't have at least
  /// one of the MFA methods set up are presented with an <code>MFA_SETUP</code>
  /// challenge. The user must set up at least one MFA type to continue to
  /// authenticate.
  /// </li>
  /// <li>
  /// <code>SELECT_MFA_TYPE</code>: Selects the MFA type. Valid MFA options are
  /// <code>SMS_MFA</code> for text SMS MFA, and <code>SOFTWARE_TOKEN_MFA</code>
  /// for time-based one-time password (TOTP) software token MFA.
  /// </li>
  /// <li>
  /// <code>SMS_MFA</code>: Next challenge is to supply an
  /// <code>SMS_MFA_CODE</code>, delivered via SMS.
  /// </li>
  /// <li>
  /// <code>PASSWORD_VERIFIER</code>: Next challenge is to supply
  /// <code>PASSWORD_CLAIM_SIGNATURE</code>,
  /// <code>PASSWORD_CLAIM_SECRET_BLOCK</code>, and <code>TIMESTAMP</code> after
  /// the client-side SRP calculations.
  /// </li>
  /// <li>
  /// <code>CUSTOM_CHALLENGE</code>: This is returned if your custom
  /// authentication flow determines that the user should pass another challenge
  /// before tokens are issued.
  /// </li>
  /// <li>
  /// <code>DEVICE_SRP_AUTH</code>: If device tracking was activated in your user
  /// pool and the previous challenges were passed, this challenge is returned so
  /// that Amazon Cognito can start tracking this device.
  /// </li>
  /// <li>
  /// <code>DEVICE_PASSWORD_VERIFIER</code>: Similar to
  /// <code>PASSWORD_VERIFIER</code>, but for devices only.
  /// </li>
  /// <li>
  /// <code>ADMIN_NO_SRP_AUTH</code>: This is returned if you must authenticate
  /// with <code>USERNAME</code> and <code>PASSWORD</code> directly. An app client
  /// must be enabled to use this flow.
  /// </li>
  /// <li>
  /// <code>NEW_PASSWORD_REQUIRED</code>: For users who are required to change
  /// their passwords after successful first login. Respond to this challenge with
  /// <code>NEW_PASSWORD</code> and any required attributes that Amazon Cognito
  /// returned in the <code>requiredAttributes</code> parameter. You can also set
  /// values for attributes that aren't required by your user pool and that your
  /// app client can write. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AdminRespondToAuthChallenge.html">AdminRespondToAuthChallenge</a>.
  /// <note>
  /// In a <code>NEW_PASSWORD_REQUIRED</code> challenge response, you can't modify
  /// a required attribute that already has a value. In
  /// <code>AdminRespondToAuthChallenge</code>, set a value for any keys that
  /// Amazon Cognito returned in the <code>requiredAttributes</code> parameter,
  /// then use the <code>AdminUpdateUserAttributes</code> API operation to modify
  /// the value of any additional attributes.
  /// </note> </li>
  /// <li>
  /// <code>MFA_SETUP</code>: For users who are required to set up an MFA factor
  /// before they can sign in. The MFA types activated for the user pool will be
  /// listed in the challenge parameters <code>MFA_CAN_SETUP</code> value.
  ///
  /// To set up software token MFA, use the session returned here from
  /// <code>InitiateAuth</code> as an input to
  /// <code>AssociateSoftwareToken</code>, and use the session returned by
  /// <code>VerifySoftwareToken</code> as an input to
  /// <code>RespondToAuthChallenge</code> with challenge name
  /// <code>MFA_SETUP</code> to complete sign-in. To set up SMS MFA, users will
  /// need help from an administrator to add a phone number to their account and
  /// then call <code>InitiateAuth</code> again to restart sign-in.
  /// </li>
  /// </ul>
  final ChallengeNameType? challengeName;

  /// The challenge parameters. These are returned to you in the
  /// <code>AdminInitiateAuth</code> response if you must pass another challenge.
  /// The responses in this parameter should be used to compute inputs to the next
  /// call (<code>AdminRespondToAuthChallenge</code>).
  ///
  /// All challenges require <code>USERNAME</code> and <code>SECRET_HASH</code>
  /// (if applicable).
  ///
  /// The value of the <code>USER_ID_FOR_SRP</code> attribute is the user's actual
  /// username, not an alias (such as email address or phone number), even if you
  /// specified an alias in your call to <code>AdminInitiateAuth</code>. This
  /// happens because, in the <code>AdminRespondToAuthChallenge</code> API
  /// <code>ChallengeResponses</code>, the <code>USERNAME</code> attribute can't
  /// be an alias.
  final Map<String, String>? challengeParameters;

  /// The session that should be passed both ways in challenge-response calls to
  /// the service. If <code>AdminInitiateAuth</code> or
  /// <code>AdminRespondToAuthChallenge</code> API call determines that the caller
  /// must pass another challenge, they return a session with other challenge
  /// parameters. This session should be passed as it is to the next
  /// <code>AdminRespondToAuthChallenge</code> API call.
  final String? session;

  AdminInitiateAuthResponse({
    this.authenticationResult,
    this.challengeName,
    this.challengeParameters,
    this.session,
  });
  factory AdminInitiateAuthResponse.fromJson(Map<String, dynamic> json) {
    return AdminInitiateAuthResponse(
      authenticationResult: json['AuthenticationResult'] != null
          ? AuthenticationResultType.fromJson(
              json['AuthenticationResult'] as Map<String, dynamic>)
          : null,
      challengeName: (json['ChallengeName'] as String?)?.toChallengeNameType(),
      challengeParameters:
          (json['ChallengeParameters'] as Map<String, dynamic>?)
              ?.map((k, e) => MapEntry(k, e as String)),
      session: json['Session'] as String?,
    );
  }
}

class AdminLinkProviderForUserResponse {
  AdminLinkProviderForUserResponse();
  factory AdminLinkProviderForUserResponse.fromJson(Map<String, dynamic> _) {
    return AdminLinkProviderForUserResponse();
  }
}

/// Lists the device's response, as an administrator.
class AdminListDevicesResponse {
  /// The devices in the list of devices response.
  final List<DeviceType>? devices;

  /// The pagination token.
  final String? paginationToken;

  AdminListDevicesResponse({
    this.devices,
    this.paginationToken,
  });
  factory AdminListDevicesResponse.fromJson(Map<String, dynamic> json) {
    return AdminListDevicesResponse(
      devices: (json['Devices'] as List?)
          ?.whereNotNull()
          .map((e) => DeviceType.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginationToken: json['PaginationToken'] as String?,
    );
  }
}

class AdminListGroupsForUserResponse {
  /// The groups that the user belongs to.
  final List<GroupType>? groups;

  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  final String? nextToken;

  AdminListGroupsForUserResponse({
    this.groups,
    this.nextToken,
  });
  factory AdminListGroupsForUserResponse.fromJson(Map<String, dynamic> json) {
    return AdminListGroupsForUserResponse(
      groups: (json['Groups'] as List?)
          ?.whereNotNull()
          .map((e) => GroupType.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class AdminListUserAuthEventsResponse {
  /// The response object. It includes the <code>EventID</code>,
  /// <code>EventType</code>, <code>CreationDate</code>, <code>EventRisk</code>,
  /// and <code>EventResponse</code>.
  final List<AuthEventType>? authEvents;

  /// A pagination token.
  final String? nextToken;

  AdminListUserAuthEventsResponse({
    this.authEvents,
    this.nextToken,
  });
  factory AdminListUserAuthEventsResponse.fromJson(Map<String, dynamic> json) {
    return AdminListUserAuthEventsResponse(
      authEvents: (json['AuthEvents'] as List?)
          ?.whereNotNull()
          .map((e) => AuthEventType.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

/// Represents the response from the server to reset a user password as an
/// administrator.
class AdminResetUserPasswordResponse {
  AdminResetUserPasswordResponse();
  factory AdminResetUserPasswordResponse.fromJson(Map<String, dynamic> _) {
    return AdminResetUserPasswordResponse();
  }
}

/// Responds to the authentication challenge, as an administrator.
class AdminRespondToAuthChallengeResponse {
  /// The result returned by the server in response to the authentication request.
  final AuthenticationResultType? authenticationResult;

  /// The name of the challenge. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AdminInitiateAuth.html">AdminInitiateAuth</a>.
  final ChallengeNameType? challengeName;

  /// The challenge parameters. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AdminInitiateAuth.html">AdminInitiateAuth</a>.
  final Map<String, String>? challengeParameters;

  /// The session that should be passed both ways in challenge-response calls to
  /// the service. If the caller must pass another challenge, they return a
  /// session with other challenge parameters. This session should be passed as it
  /// is to the next <code>RespondToAuthChallenge</code> API call.
  final String? session;

  AdminRespondToAuthChallengeResponse({
    this.authenticationResult,
    this.challengeName,
    this.challengeParameters,
    this.session,
  });
  factory AdminRespondToAuthChallengeResponse.fromJson(
      Map<String, dynamic> json) {
    return AdminRespondToAuthChallengeResponse(
      authenticationResult: json['AuthenticationResult'] != null
          ? AuthenticationResultType.fromJson(
              json['AuthenticationResult'] as Map<String, dynamic>)
          : null,
      challengeName: (json['ChallengeName'] as String?)?.toChallengeNameType(),
      challengeParameters:
          (json['ChallengeParameters'] as Map<String, dynamic>?)
              ?.map((k, e) => MapEntry(k, e as String)),
      session: json['Session'] as String?,
    );
  }
}

class AdminSetUserMFAPreferenceResponse {
  AdminSetUserMFAPreferenceResponse();
  factory AdminSetUserMFAPreferenceResponse.fromJson(Map<String, dynamic> _) {
    return AdminSetUserMFAPreferenceResponse();
  }
}

class AdminSetUserPasswordResponse {
  AdminSetUserPasswordResponse();
  factory AdminSetUserPasswordResponse.fromJson(Map<String, dynamic> _) {
    return AdminSetUserPasswordResponse();
  }
}

/// Represents the response from the server to set user settings as an
/// administrator.
class AdminSetUserSettingsResponse {
  AdminSetUserSettingsResponse();
  factory AdminSetUserSettingsResponse.fromJson(Map<String, dynamic> _) {
    return AdminSetUserSettingsResponse();
  }
}

class AdminUpdateAuthEventFeedbackResponse {
  AdminUpdateAuthEventFeedbackResponse();
  factory AdminUpdateAuthEventFeedbackResponse.fromJson(
      Map<String, dynamic> _) {
    return AdminUpdateAuthEventFeedbackResponse();
  }
}

/// The status response to the request to update the device, as an
/// administrator.
class AdminUpdateDeviceStatusResponse {
  AdminUpdateDeviceStatusResponse();
  factory AdminUpdateDeviceStatusResponse.fromJson(Map<String, dynamic> _) {
    return AdminUpdateDeviceStatusResponse();
  }
}

/// Represents the response from the server for the request to update user
/// attributes as an administrator.
class AdminUpdateUserAttributesResponse {
  AdminUpdateUserAttributesResponse();
  factory AdminUpdateUserAttributesResponse.fromJson(Map<String, dynamic> _) {
    return AdminUpdateUserAttributesResponse();
  }
}

/// The global sign-out response, as an administrator.
class AdminUserGlobalSignOutResponse {
  AdminUserGlobalSignOutResponse();
  factory AdminUserGlobalSignOutResponse.fromJson(Map<String, dynamic> _) {
    return AdminUserGlobalSignOutResponse();
  }
}

enum AdvancedSecurityModeType {
  off,
  audit,
  enforced,
}

extension on AdvancedSecurityModeType {
  String toValue() {
    switch (this) {
      case AdvancedSecurityModeType.off:
        return 'OFF';
      case AdvancedSecurityModeType.audit:
        return 'AUDIT';
      case AdvancedSecurityModeType.enforced:
        return 'ENFORCED';
    }
  }
}

extension on String {
  AdvancedSecurityModeType toAdvancedSecurityModeType() {
    switch (this) {
      case 'OFF':
        return AdvancedSecurityModeType.off;
      case 'AUDIT':
        return AdvancedSecurityModeType.audit;
      case 'ENFORCED':
        return AdvancedSecurityModeType.enforced;
    }
    throw Exception('$this is not known in enum AdvancedSecurityModeType');
  }
}

enum AliasAttributeType {
  phoneNumber,
  email,
  preferredUsername,
}

extension on AliasAttributeType {
  String toValue() {
    switch (this) {
      case AliasAttributeType.phoneNumber:
        return 'phone_number';
      case AliasAttributeType.email:
        return 'email';
      case AliasAttributeType.preferredUsername:
        return 'preferred_username';
    }
  }
}

extension on String {
  AliasAttributeType toAliasAttributeType() {
    switch (this) {
      case 'phone_number':
        return AliasAttributeType.phoneNumber;
      case 'email':
        return AliasAttributeType.email;
      case 'preferred_username':
        return AliasAttributeType.preferredUsername;
    }
    throw Exception('$this is not known in enum AliasAttributeType');
  }
}

/// The Amazon Pinpoint analytics configuration necessary to collect metrics for
/// a user pool.
/// <note>
/// In Regions where Amazon Pinpointisn't available, user pools only support
/// sending events to Amazon Pinpoint projects in us-east-1. In Regions where
/// Amazon Pinpoint is available, user pools support sending events to Amazon
/// Pinpoint projects within that same Region.
/// </note>
class AnalyticsConfigurationType {
  /// The Amazon Resource Name (ARN) of an Amazon Pinpoint project. You can use
  /// the Amazon Pinpoint project to integrate with the chosen user pool Client.
  /// Amazon Cognito publishes events to the Amazon Pinpoint project that the app
  /// ARN declares.
  final String? applicationArn;

  /// The application ID for an Amazon Pinpoint application.
  final String? applicationId;

  /// The external ID.
  final String? externalId;

  /// The ARN of an Identity and Access Management role that authorizes Amazon
  /// Cognito to publish events to Amazon Pinpoint analytics.
  final String? roleArn;

  /// If <code>UserDataShared</code> is <code>true</code>, Amazon Cognito includes
  /// user data in the events that it publishes to Amazon Pinpoint analytics.
  final bool? userDataShared;

  AnalyticsConfigurationType({
    this.applicationArn,
    this.applicationId,
    this.externalId,
    this.roleArn,
    this.userDataShared,
  });
  factory AnalyticsConfigurationType.fromJson(Map<String, dynamic> json) {
    return AnalyticsConfigurationType(
      applicationArn: json['ApplicationArn'] as String?,
      applicationId: json['ApplicationId'] as String?,
      externalId: json['ExternalId'] as String?,
      roleArn: json['RoleArn'] as String?,
      userDataShared: json['UserDataShared'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    final applicationArn = this.applicationArn;
    final applicationId = this.applicationId;
    final externalId = this.externalId;
    final roleArn = this.roleArn;
    final userDataShared = this.userDataShared;
    return {
      if (applicationArn != null) 'ApplicationArn': applicationArn,
      if (applicationId != null) 'ApplicationId': applicationId,
      if (externalId != null) 'ExternalId': externalId,
      if (roleArn != null) 'RoleArn': roleArn,
      if (userDataShared != null) 'UserDataShared': userDataShared,
    };
  }
}

/// An Amazon Pinpoint analytics endpoint.
///
/// An endpoint uniquely identifies a mobile device, email address, or phone
/// number that can receive messages from Amazon Pinpoint analytics. For more
/// information about Amazon Web Services Regions that can contain Amazon
/// Pinpoint resources for use with Amazon Cognito user pools, see <a
/// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-pinpoint-integration.html">Using
/// Amazon Pinpoint analytics with Amazon Cognito user pools</a>.
class AnalyticsMetadataType {
  /// The endpoint ID.
  final String? analyticsEndpointId;

  AnalyticsMetadataType({
    this.analyticsEndpointId,
  });
  Map<String, dynamic> toJson() {
    final analyticsEndpointId = this.analyticsEndpointId;
    return {
      if (analyticsEndpointId != null)
        'AnalyticsEndpointId': analyticsEndpointId,
    };
  }
}

class AssociateSoftwareTokenResponse {
  /// A unique generated shared secret code that is used in the TOTP algorithm to
  /// generate a one-time code.
  final String? secretCode;

  /// The session that should be passed both ways in challenge-response calls to
  /// the service. This allows authentication of the user as part of the MFA setup
  /// process.
  final String? session;

  AssociateSoftwareTokenResponse({
    this.secretCode,
    this.session,
  });
  factory AssociateSoftwareTokenResponse.fromJson(Map<String, dynamic> json) {
    return AssociateSoftwareTokenResponse(
      secretCode: json['SecretCode'] as String?,
      session: json['Session'] as String?,
    );
  }
}

enum AttributeDataType {
  string,
  number,
  dateTime,
  boolean,
}

extension on AttributeDataType {
  String toValue() {
    switch (this) {
      case AttributeDataType.string:
        return 'String';
      case AttributeDataType.number:
        return 'Number';
      case AttributeDataType.dateTime:
        return 'DateTime';
      case AttributeDataType.boolean:
        return 'Boolean';
    }
  }
}

extension on String {
  AttributeDataType toAttributeDataType() {
    switch (this) {
      case 'String':
        return AttributeDataType.string;
      case 'Number':
        return AttributeDataType.number;
      case 'DateTime':
        return AttributeDataType.dateTime;
      case 'Boolean':
        return AttributeDataType.boolean;
    }
    throw Exception('$this is not known in enum AttributeDataType');
  }
}

/// Specifies whether the attribute is standard or custom.
class AttributeType {
  /// The name of the attribute.
  final String name;

  /// The value of the attribute.
  final String? value;

  AttributeType({
    required this.name,
    this.value,
  });
  factory AttributeType.fromJson(Map<String, dynamic> json) {
    return AttributeType(
      name: json['Name'] as String,
      value: json['Value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final name = this.name;
    final value = this.value;
    return {
      'Name': name,
      if (value != null) 'Value': value,
    };
  }
}

/// The authentication event type.
class AuthEventType {
  /// The challenge responses.
  final List<ChallengeResponseType>? challengeResponses;

  /// The creation date
  final DateTime? creationDate;

  /// The user context data captured at the time of an event request. This value
  /// provides additional information about the client from which event the
  /// request is received.
  final EventContextDataType? eventContextData;

  /// A flag specifying the user feedback captured at the time of an event request
  /// is good or bad.
  final EventFeedbackType? eventFeedback;

  /// The event ID.
  final String? eventId;

  /// The event response.
  final EventResponseType? eventResponse;

  /// The event risk.
  final EventRiskType? eventRisk;

  /// The event type.
  final EventType? eventType;

  AuthEventType({
    this.challengeResponses,
    this.creationDate,
    this.eventContextData,
    this.eventFeedback,
    this.eventId,
    this.eventResponse,
    this.eventRisk,
    this.eventType,
  });
  factory AuthEventType.fromJson(Map<String, dynamic> json) {
    return AuthEventType(
      challengeResponses: (json['ChallengeResponses'] as List?)
          ?.whereNotNull()
          .map((e) => ChallengeResponseType.fromJson(e as Map<String, dynamic>))
          .toList(),
      creationDate: timeStampFromJson(json['CreationDate']),
      eventContextData: json['EventContextData'] != null
          ? EventContextDataType.fromJson(
              json['EventContextData'] as Map<String, dynamic>)
          : null,
      eventFeedback: json['EventFeedback'] != null
          ? EventFeedbackType.fromJson(
              json['EventFeedback'] as Map<String, dynamic>)
          : null,
      eventId: json['EventId'] as String?,
      eventResponse: (json['EventResponse'] as String?)?.toEventResponseType(),
      eventRisk: json['EventRisk'] != null
          ? EventRiskType.fromJson(json['EventRisk'] as Map<String, dynamic>)
          : null,
      eventType: (json['EventType'] as String?)?.toEventType(),
    );
  }
}

enum AuthFlowType {
  userSrpAuth,
  refreshTokenAuth,
  refreshToken,
  customAuth,
  adminNoSrpAuth,
  userPasswordAuth,
  adminUserPasswordAuth,
}

extension on AuthFlowType {
  String toValue() {
    switch (this) {
      case AuthFlowType.userSrpAuth:
        return 'USER_SRP_AUTH';
      case AuthFlowType.refreshTokenAuth:
        return 'REFRESH_TOKEN_AUTH';
      case AuthFlowType.refreshToken:
        return 'REFRESH_TOKEN';
      case AuthFlowType.customAuth:
        return 'CUSTOM_AUTH';
      case AuthFlowType.adminNoSrpAuth:
        return 'ADMIN_NO_SRP_AUTH';
      case AuthFlowType.userPasswordAuth:
        return 'USER_PASSWORD_AUTH';
      case AuthFlowType.adminUserPasswordAuth:
        return 'ADMIN_USER_PASSWORD_AUTH';
    }
  }
}

extension on String {
  AuthFlowType toAuthFlowType() {
    switch (this) {
      case 'USER_SRP_AUTH':
        return AuthFlowType.userSrpAuth;
      case 'REFRESH_TOKEN_AUTH':
        return AuthFlowType.refreshTokenAuth;
      case 'REFRESH_TOKEN':
        return AuthFlowType.refreshToken;
      case 'CUSTOM_AUTH':
        return AuthFlowType.customAuth;
      case 'ADMIN_NO_SRP_AUTH':
        return AuthFlowType.adminNoSrpAuth;
      case 'USER_PASSWORD_AUTH':
        return AuthFlowType.userPasswordAuth;
      case 'ADMIN_USER_PASSWORD_AUTH':
        return AuthFlowType.adminUserPasswordAuth;
    }
    throw Exception('$this is not known in enum AuthFlowType');
  }
}

/// The authentication result.
class AuthenticationResultType {
  /// A valid access token that Amazon Cognito issued to the user who you want to
  /// authenticate.
  final String? accessToken;

  /// The expiration period of the authentication result in seconds.
  final int? expiresIn;

  /// The ID token.
  final String? idToken;

  /// The new device metadata from an authentication result.
  final NewDeviceMetadataType? newDeviceMetadata;

  /// The refresh token.
  final String? refreshToken;

  /// The token type.
  final String? tokenType;

  AuthenticationResultType({
    this.accessToken,
    this.expiresIn,
    this.idToken,
    this.newDeviceMetadata,
    this.refreshToken,
    this.tokenType,
  });
  factory AuthenticationResultType.fromJson(Map<String, dynamic> json) {
    return AuthenticationResultType(
      accessToken: json['AccessToken'] as String?,
      expiresIn: json['ExpiresIn'] as int?,
      idToken: json['IdToken'] as String?,
      newDeviceMetadata: json['NewDeviceMetadata'] != null
          ? NewDeviceMetadataType.fromJson(
              json['NewDeviceMetadata'] as Map<String, dynamic>)
          : null,
      refreshToken: json['RefreshToken'] as String?,
      tokenType: json['TokenType'] as String?,
    );
  }
}

enum ChallengeName {
  password,
  mfa,
}

extension on ChallengeName {
  String toValue() {
    switch (this) {
      case ChallengeName.password:
        return 'Password';
      case ChallengeName.mfa:
        return 'Mfa';
    }
  }
}

extension on String {
  ChallengeName toChallengeName() {
    switch (this) {
      case 'Password':
        return ChallengeName.password;
      case 'Mfa':
        return ChallengeName.mfa;
    }
    throw Exception('$this is not known in enum ChallengeName');
  }
}

enum ChallengeNameType {
  smsMfa,
  softwareTokenMfa,
  selectMfaType,
  mfaSetup,
  passwordVerifier,
  customChallenge,
  deviceSrpAuth,
  devicePasswordVerifier,
  adminNoSrpAuth,
  newPasswordRequired,
}

extension on ChallengeNameType {
  String toValue() {
    switch (this) {
      case ChallengeNameType.smsMfa:
        return 'SMS_MFA';
      case ChallengeNameType.softwareTokenMfa:
        return 'SOFTWARE_TOKEN_MFA';
      case ChallengeNameType.selectMfaType:
        return 'SELECT_MFA_TYPE';
      case ChallengeNameType.mfaSetup:
        return 'MFA_SETUP';
      case ChallengeNameType.passwordVerifier:
        return 'PASSWORD_VERIFIER';
      case ChallengeNameType.customChallenge:
        return 'CUSTOM_CHALLENGE';
      case ChallengeNameType.deviceSrpAuth:
        return 'DEVICE_SRP_AUTH';
      case ChallengeNameType.devicePasswordVerifier:
        return 'DEVICE_PASSWORD_VERIFIER';
      case ChallengeNameType.adminNoSrpAuth:
        return 'ADMIN_NO_SRP_AUTH';
      case ChallengeNameType.newPasswordRequired:
        return 'NEW_PASSWORD_REQUIRED';
    }
  }
}

extension on String {
  ChallengeNameType toChallengeNameType() {
    switch (this) {
      case 'SMS_MFA':
        return ChallengeNameType.smsMfa;
      case 'SOFTWARE_TOKEN_MFA':
        return ChallengeNameType.softwareTokenMfa;
      case 'SELECT_MFA_TYPE':
        return ChallengeNameType.selectMfaType;
      case 'MFA_SETUP':
        return ChallengeNameType.mfaSetup;
      case 'PASSWORD_VERIFIER':
        return ChallengeNameType.passwordVerifier;
      case 'CUSTOM_CHALLENGE':
        return ChallengeNameType.customChallenge;
      case 'DEVICE_SRP_AUTH':
        return ChallengeNameType.deviceSrpAuth;
      case 'DEVICE_PASSWORD_VERIFIER':
        return ChallengeNameType.devicePasswordVerifier;
      case 'ADMIN_NO_SRP_AUTH':
        return ChallengeNameType.adminNoSrpAuth;
      case 'NEW_PASSWORD_REQUIRED':
        return ChallengeNameType.newPasswordRequired;
    }
    throw Exception('$this is not known in enum ChallengeNameType');
  }
}

enum ChallengeResponse {
  success,
  failure,
}

extension on ChallengeResponse {
  String toValue() {
    switch (this) {
      case ChallengeResponse.success:
        return 'Success';
      case ChallengeResponse.failure:
        return 'Failure';
    }
  }
}

extension on String {
  ChallengeResponse toChallengeResponse() {
    switch (this) {
      case 'Success':
        return ChallengeResponse.success;
      case 'Failure':
        return ChallengeResponse.failure;
    }
    throw Exception('$this is not known in enum ChallengeResponse');
  }
}

/// The challenge response type.
class ChallengeResponseType {
  /// The challenge name.
  final ChallengeName? challengeName;

  /// The challenge response.
  final ChallengeResponse? challengeResponse;

  ChallengeResponseType({
    this.challengeName,
    this.challengeResponse,
  });
  factory ChallengeResponseType.fromJson(Map<String, dynamic> json) {
    return ChallengeResponseType(
      challengeName: (json['ChallengeName'] as String?)?.toChallengeName(),
      challengeResponse:
          (json['ChallengeResponse'] as String?)?.toChallengeResponse(),
    );
  }
}

/// The response from the server to the change password request.
class ChangePasswordResponse {
  ChangePasswordResponse();
  factory ChangePasswordResponse.fromJson(Map<String, dynamic> _) {
    return ChangePasswordResponse();
  }
}

/// The delivery details for an email or SMS message that Amazon Cognito sent
/// for authentication or verification.
class CodeDeliveryDetailsType {
  /// The name of the attribute that Amazon Cognito verifies with the code.
  final String? attributeName;

  /// The method that Amazon Cognito used to send the code.
  final DeliveryMediumType? deliveryMedium;

  /// The email address or phone number destination where Amazon Cognito sent the
  /// code.
  final String? destination;

  CodeDeliveryDetailsType({
    this.attributeName,
    this.deliveryMedium,
    this.destination,
  });
  factory CodeDeliveryDetailsType.fromJson(Map<String, dynamic> json) {
    return CodeDeliveryDetailsType(
      attributeName: json['AttributeName'] as String?,
      deliveryMedium:
          (json['DeliveryMedium'] as String?)?.toDeliveryMediumType(),
      destination: json['Destination'] as String?,
    );
  }
}

/// The compromised credentials actions type.
class CompromisedCredentialsActionsType {
  /// The event action.
  final CompromisedCredentialsEventActionType eventAction;

  CompromisedCredentialsActionsType({
    required this.eventAction,
  });
  factory CompromisedCredentialsActionsType.fromJson(
      Map<String, dynamic> json) {
    return CompromisedCredentialsActionsType(
      eventAction: (json['EventAction'] as String)
          .toCompromisedCredentialsEventActionType(),
    );
  }

  Map<String, dynamic> toJson() {
    final eventAction = this.eventAction;
    return {
      'EventAction': eventAction.toValue(),
    };
  }
}

enum CompromisedCredentialsEventActionType {
  block,
  noAction,
}

extension on CompromisedCredentialsEventActionType {
  String toValue() {
    switch (this) {
      case CompromisedCredentialsEventActionType.block:
        return 'BLOCK';
      case CompromisedCredentialsEventActionType.noAction:
        return 'NO_ACTION';
    }
  }
}

extension on String {
  CompromisedCredentialsEventActionType
      toCompromisedCredentialsEventActionType() {
    switch (this) {
      case 'BLOCK':
        return CompromisedCredentialsEventActionType.block;
      case 'NO_ACTION':
        return CompromisedCredentialsEventActionType.noAction;
    }
    throw Exception(
        '$this is not known in enum CompromisedCredentialsEventActionType');
  }
}

/// The compromised credentials risk configuration type.
class CompromisedCredentialsRiskConfigurationType {
  /// The compromised credentials risk configuration actions.
  final CompromisedCredentialsActionsType actions;

  /// Perform the action for these events. The default is to perform all events if
  /// no event filter is specified.
  final List<EventFilterType>? eventFilter;

  CompromisedCredentialsRiskConfigurationType({
    required this.actions,
    this.eventFilter,
  });
  factory CompromisedCredentialsRiskConfigurationType.fromJson(
      Map<String, dynamic> json) {
    return CompromisedCredentialsRiskConfigurationType(
      actions: CompromisedCredentialsActionsType.fromJson(
          json['Actions'] as Map<String, dynamic>),
      eventFilter: (json['EventFilter'] as List?)
          ?.whereNotNull()
          .map((e) => (e as String).toEventFilterType())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final actions = this.actions;
    final eventFilter = this.eventFilter;
    return {
      'Actions': actions,
      if (eventFilter != null)
        'EventFilter': eventFilter.map((e) => e.toValue()).toList(),
    };
  }
}

/// Confirms the device response.
class ConfirmDeviceResponse {
  /// Indicates whether the user confirmation must confirm the device response.
  final bool? userConfirmationNecessary;

  ConfirmDeviceResponse({
    this.userConfirmationNecessary,
  });
  factory ConfirmDeviceResponse.fromJson(Map<String, dynamic> json) {
    return ConfirmDeviceResponse(
      userConfirmationNecessary: json['UserConfirmationNecessary'] as bool?,
    );
  }
}

/// The response from the server that results from a user's request to retrieve
/// a forgotten password.
class ConfirmForgotPasswordResponse {
  ConfirmForgotPasswordResponse();
  factory ConfirmForgotPasswordResponse.fromJson(Map<String, dynamic> _) {
    return ConfirmForgotPasswordResponse();
  }
}

/// Represents the response from the server for the registration confirmation.
class ConfirmSignUpResponse {
  ConfirmSignUpResponse();
  factory ConfirmSignUpResponse.fromJson(Map<String, dynamic> _) {
    return ConfirmSignUpResponse();
  }
}

/// Contextual user data type used for evaluating the risk of an unexpected
/// event by Amazon Cognito advanced security.
class ContextDataType {
  /// HttpHeaders received on your server in same order.
  final List<HttpHeader> httpHeaders;

  /// The source IP address of your user's device.
  final String ipAddress;

  /// Your server endpoint where this API is invoked.
  final String serverName;

  /// Your server path where this API is invoked.
  final String serverPath;

  /// Encoded device-fingerprint details that your app collected with the Amazon
  /// Cognito context data collection library. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-adaptive-authentication.html#user-pool-settings-adaptive-authentication-device-fingerprint">Adding
  /// user device and session data to API requests</a>.
  final String? encodedData;

  ContextDataType({
    required this.httpHeaders,
    required this.ipAddress,
    required this.serverName,
    required this.serverPath,
    this.encodedData,
  });
  Map<String, dynamic> toJson() {
    final httpHeaders = this.httpHeaders;
    final ipAddress = this.ipAddress;
    final serverName = this.serverName;
    final serverPath = this.serverPath;
    final encodedData = this.encodedData;
    return {
      'HttpHeaders': httpHeaders,
      'IpAddress': ipAddress,
      'ServerName': serverName,
      'ServerPath': serverPath,
      if (encodedData != null) 'EncodedData': encodedData,
    };
  }
}

class CreateGroupResponse {
  /// The group object for the group.
  final GroupType? group;

  CreateGroupResponse({
    this.group,
  });
  factory CreateGroupResponse.fromJson(Map<String, dynamic> json) {
    return CreateGroupResponse(
      group: json['Group'] != null
          ? GroupType.fromJson(json['Group'] as Map<String, dynamic>)
          : null,
    );
  }
}

class CreateIdentityProviderResponse {
  /// The newly created IdP object.
  final IdentityProviderType identityProvider;

  CreateIdentityProviderResponse({
    required this.identityProvider,
  });
  factory CreateIdentityProviderResponse.fromJson(Map<String, dynamic> json) {
    return CreateIdentityProviderResponse(
      identityProvider: IdentityProviderType.fromJson(
          json['IdentityProvider'] as Map<String, dynamic>),
    );
  }
}

class CreateResourceServerResponse {
  /// The newly created resource server.
  final ResourceServerType resourceServer;

  CreateResourceServerResponse({
    required this.resourceServer,
  });
  factory CreateResourceServerResponse.fromJson(Map<String, dynamic> json) {
    return CreateResourceServerResponse(
      resourceServer: ResourceServerType.fromJson(
          json['ResourceServer'] as Map<String, dynamic>),
    );
  }
}

/// Represents the response from the server to the request to create the user
/// import job.
class CreateUserImportJobResponse {
  /// The job object that represents the user import job.
  final UserImportJobType? userImportJob;

  CreateUserImportJobResponse({
    this.userImportJob,
  });
  factory CreateUserImportJobResponse.fromJson(Map<String, dynamic> json) {
    return CreateUserImportJobResponse(
      userImportJob: json['UserImportJob'] != null
          ? UserImportJobType.fromJson(
              json['UserImportJob'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Represents the response from the server to create a user pool client.
class CreateUserPoolClientResponse {
  /// The user pool client that was just created.
  final UserPoolClientType? userPoolClient;

  CreateUserPoolClientResponse({
    this.userPoolClient,
  });
  factory CreateUserPoolClientResponse.fromJson(Map<String, dynamic> json) {
    return CreateUserPoolClientResponse(
      userPoolClient: json['UserPoolClient'] != null
          ? UserPoolClientType.fromJson(
              json['UserPoolClient'] as Map<String, dynamic>)
          : null,
    );
  }
}

class CreateUserPoolDomainResponse {
  /// The Amazon CloudFront endpoint that you use as the target of the alias that
  /// you set up with your Domain Name Service (DNS) provider.
  final String? cloudFrontDomain;

  CreateUserPoolDomainResponse({
    this.cloudFrontDomain,
  });
  factory CreateUserPoolDomainResponse.fromJson(Map<String, dynamic> json) {
    return CreateUserPoolDomainResponse(
      cloudFrontDomain: json['CloudFrontDomain'] as String?,
    );
  }
}

/// Represents the response from the server for the request to create a user
/// pool.
class CreateUserPoolResponse {
  /// A container for the user pool details.
  final UserPoolType? userPool;

  CreateUserPoolResponse({
    this.userPool,
  });
  factory CreateUserPoolResponse.fromJson(Map<String, dynamic> json) {
    return CreateUserPoolResponse(
      userPool: json['UserPool'] != null
          ? UserPoolType.fromJson(json['UserPool'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// The configuration for a custom domain that hosts the sign-up and sign-in
/// webpages for your application.
class CustomDomainConfigType {
  /// The Amazon Resource Name (ARN) of an Certificate Manager SSL certificate.
  /// You use this certificate for the subdomain of your custom domain.
  final String certificateArn;

  CustomDomainConfigType({
    required this.certificateArn,
  });
  factory CustomDomainConfigType.fromJson(Map<String, dynamic> json) {
    return CustomDomainConfigType(
      certificateArn: json['CertificateArn'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final certificateArn = this.certificateArn;
    return {
      'CertificateArn': certificateArn,
    };
  }
}

/// A custom email sender Lambda configuration type.
class CustomEmailLambdaVersionConfigType {
  /// The Amazon Resource Name (ARN) of the Lambda function that Amazon Cognito
  /// activates to send email notifications to users.
  final String lambdaArn;

  /// Signature of the "request" attribute in the "event" information Amazon
  /// Cognito passes to your custom email Lambda function. The only supported
  /// value is <code>V1_0</code>.
  final CustomEmailSenderLambdaVersionType lambdaVersion;

  CustomEmailLambdaVersionConfigType({
    required this.lambdaArn,
    required this.lambdaVersion,
  });
  factory CustomEmailLambdaVersionConfigType.fromJson(
      Map<String, dynamic> json) {
    return CustomEmailLambdaVersionConfigType(
      lambdaArn: json['LambdaArn'] as String,
      lambdaVersion: (json['LambdaVersion'] as String)
          .toCustomEmailSenderLambdaVersionType(),
    );
  }

  Map<String, dynamic> toJson() {
    final lambdaArn = this.lambdaArn;
    final lambdaVersion = this.lambdaVersion;
    return {
      'LambdaArn': lambdaArn,
      'LambdaVersion': lambdaVersion.toValue(),
    };
  }
}

enum CustomEmailSenderLambdaVersionType {
  v1_0,
}

extension on CustomEmailSenderLambdaVersionType {
  String toValue() {
    switch (this) {
      case CustomEmailSenderLambdaVersionType.v1_0:
        return 'V1_0';
    }
  }
}

extension on String {
  CustomEmailSenderLambdaVersionType toCustomEmailSenderLambdaVersionType() {
    switch (this) {
      case 'V1_0':
        return CustomEmailSenderLambdaVersionType.v1_0;
    }
    throw Exception(
        '$this is not known in enum CustomEmailSenderLambdaVersionType');
  }
}

/// A custom SMS sender Lambda configuration type.
class CustomSMSLambdaVersionConfigType {
  /// The Amazon Resource Name (ARN) of the Lambda function that Amazon Cognito
  /// activates to send SMS notifications to users.
  final String lambdaArn;

  /// Signature of the "request" attribute in the "event" information that Amazon
  /// Cognito passes to your custom SMS Lambda function. The only supported value
  /// is <code>V1_0</code>.
  final CustomSMSSenderLambdaVersionType lambdaVersion;

  CustomSMSLambdaVersionConfigType({
    required this.lambdaArn,
    required this.lambdaVersion,
  });
  factory CustomSMSLambdaVersionConfigType.fromJson(Map<String, dynamic> json) {
    return CustomSMSLambdaVersionConfigType(
      lambdaArn: json['LambdaArn'] as String,
      lambdaVersion: (json['LambdaVersion'] as String)
          .toCustomSMSSenderLambdaVersionType(),
    );
  }

  Map<String, dynamic> toJson() {
    final lambdaArn = this.lambdaArn;
    final lambdaVersion = this.lambdaVersion;
    return {
      'LambdaArn': lambdaArn,
      'LambdaVersion': lambdaVersion.toValue(),
    };
  }
}

enum CustomSMSSenderLambdaVersionType {
  v1_0,
}

extension on CustomSMSSenderLambdaVersionType {
  String toValue() {
    switch (this) {
      case CustomSMSSenderLambdaVersionType.v1_0:
        return 'V1_0';
    }
  }
}

extension on String {
  CustomSMSSenderLambdaVersionType toCustomSMSSenderLambdaVersionType() {
    switch (this) {
      case 'V1_0':
        return CustomSMSSenderLambdaVersionType.v1_0;
    }
    throw Exception(
        '$this is not known in enum CustomSMSSenderLambdaVersionType');
  }
}

enum DefaultEmailOptionType {
  confirmWithLink,
  confirmWithCode,
}

extension on DefaultEmailOptionType {
  String toValue() {
    switch (this) {
      case DefaultEmailOptionType.confirmWithLink:
        return 'CONFIRM_WITH_LINK';
      case DefaultEmailOptionType.confirmWithCode:
        return 'CONFIRM_WITH_CODE';
    }
  }
}

extension on String {
  DefaultEmailOptionType toDefaultEmailOptionType() {
    switch (this) {
      case 'CONFIRM_WITH_LINK':
        return DefaultEmailOptionType.confirmWithLink;
      case 'CONFIRM_WITH_CODE':
        return DefaultEmailOptionType.confirmWithCode;
    }
    throw Exception('$this is not known in enum DefaultEmailOptionType');
  }
}

/// Represents the response from the server to delete user attributes.
class DeleteUserAttributesResponse {
  DeleteUserAttributesResponse();
  factory DeleteUserAttributesResponse.fromJson(Map<String, dynamic> _) {
    return DeleteUserAttributesResponse();
  }
}

class DeleteUserPoolDomainResponse {
  DeleteUserPoolDomainResponse();
  factory DeleteUserPoolDomainResponse.fromJson(Map<String, dynamic> _) {
    return DeleteUserPoolDomainResponse();
  }
}

enum DeliveryMediumType {
  sms,
  email,
}

extension on DeliveryMediumType {
  String toValue() {
    switch (this) {
      case DeliveryMediumType.sms:
        return 'SMS';
      case DeliveryMediumType.email:
        return 'EMAIL';
    }
  }
}

extension on String {
  DeliveryMediumType toDeliveryMediumType() {
    switch (this) {
      case 'SMS':
        return DeliveryMediumType.sms;
      case 'EMAIL':
        return DeliveryMediumType.email;
    }
    throw Exception('$this is not known in enum DeliveryMediumType');
  }
}

class DescribeIdentityProviderResponse {
  /// The IdP that was deleted.
  final IdentityProviderType identityProvider;

  DescribeIdentityProviderResponse({
    required this.identityProvider,
  });
  factory DescribeIdentityProviderResponse.fromJson(Map<String, dynamic> json) {
    return DescribeIdentityProviderResponse(
      identityProvider: IdentityProviderType.fromJson(
          json['IdentityProvider'] as Map<String, dynamic>),
    );
  }
}

class DescribeResourceServerResponse {
  /// The resource server.
  final ResourceServerType resourceServer;

  DescribeResourceServerResponse({
    required this.resourceServer,
  });
  factory DescribeResourceServerResponse.fromJson(Map<String, dynamic> json) {
    return DescribeResourceServerResponse(
      resourceServer: ResourceServerType.fromJson(
          json['ResourceServer'] as Map<String, dynamic>),
    );
  }
}

class DescribeRiskConfigurationResponse {
  /// The risk configuration.
  final RiskConfigurationType riskConfiguration;

  DescribeRiskConfigurationResponse({
    required this.riskConfiguration,
  });
  factory DescribeRiskConfigurationResponse.fromJson(
      Map<String, dynamic> json) {
    return DescribeRiskConfigurationResponse(
      riskConfiguration: RiskConfigurationType.fromJson(
          json['RiskConfiguration'] as Map<String, dynamic>),
    );
  }
}

/// Represents the response from the server to the request to describe the user
/// import job.
class DescribeUserImportJobResponse {
  /// The job object that represents the user import job.
  final UserImportJobType? userImportJob;

  DescribeUserImportJobResponse({
    this.userImportJob,
  });
  factory DescribeUserImportJobResponse.fromJson(Map<String, dynamic> json) {
    return DescribeUserImportJobResponse(
      userImportJob: json['UserImportJob'] != null
          ? UserImportJobType.fromJson(
              json['UserImportJob'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Represents the response from the server from a request to describe the user
/// pool client.
class DescribeUserPoolClientResponse {
  /// The user pool client from a server response to describe the user pool
  /// client.
  final UserPoolClientType? userPoolClient;

  DescribeUserPoolClientResponse({
    this.userPoolClient,
  });
  factory DescribeUserPoolClientResponse.fromJson(Map<String, dynamic> json) {
    return DescribeUserPoolClientResponse(
      userPoolClient: json['UserPoolClient'] != null
          ? UserPoolClientType.fromJson(
              json['UserPoolClient'] as Map<String, dynamic>)
          : null,
    );
  }
}

class DescribeUserPoolDomainResponse {
  /// A domain description object containing information about the domain.
  final DomainDescriptionType? domainDescription;

  DescribeUserPoolDomainResponse({
    this.domainDescription,
  });
  factory DescribeUserPoolDomainResponse.fromJson(Map<String, dynamic> json) {
    return DescribeUserPoolDomainResponse(
      domainDescription: json['DomainDescription'] != null
          ? DomainDescriptionType.fromJson(
              json['DomainDescription'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Represents the response to describe the user pool.
class DescribeUserPoolResponse {
  /// The container of metadata returned by the server to describe the pool.
  final UserPoolType? userPool;

  DescribeUserPoolResponse({
    this.userPool,
  });
  factory DescribeUserPoolResponse.fromJson(Map<String, dynamic> json) {
    return DescribeUserPoolResponse(
      userPool: json['UserPool'] != null
          ? UserPoolType.fromJson(json['UserPool'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// The device-remembering configuration for a user pool. A null value indicates
/// that you have deactivated device remembering in your user pool.
/// <note>
/// When you provide a value for any <code>DeviceConfiguration</code> field, you
/// activate the Amazon Cognito device-remembering feature.
/// </note>
class DeviceConfigurationType {
  /// When true, device authentication can replace SMS and time-based one-time
  /// password (TOTP) factors for multi-factor authentication (MFA).
  /// <note>
  /// Regardless of the value of this field, users that sign in with new devices
  /// that have not been confirmed or remembered must provide a second factor if
  /// your user pool requires MFA.
  /// </note>
  final bool? challengeRequiredOnNewDevice;

  /// When true, Amazon Cognito doesn't remember newly-confirmed devices. Users
  /// who want to authenticate with their device can instead opt in to remembering
  /// their device. To collect a choice from your user, create an input prompt in
  /// your app and return the value that the user chooses in an <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_UpdateDeviceStatus.html">UpdateDeviceStatus</a>
  /// API request.
  final bool? deviceOnlyRememberedOnUserPrompt;

  DeviceConfigurationType({
    this.challengeRequiredOnNewDevice,
    this.deviceOnlyRememberedOnUserPrompt,
  });
  factory DeviceConfigurationType.fromJson(Map<String, dynamic> json) {
    return DeviceConfigurationType(
      challengeRequiredOnNewDevice:
          json['ChallengeRequiredOnNewDevice'] as bool?,
      deviceOnlyRememberedOnUserPrompt:
          json['DeviceOnlyRememberedOnUserPrompt'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    final challengeRequiredOnNewDevice = this.challengeRequiredOnNewDevice;
    final deviceOnlyRememberedOnUserPrompt =
        this.deviceOnlyRememberedOnUserPrompt;
    return {
      if (challengeRequiredOnNewDevice != null)
        'ChallengeRequiredOnNewDevice': challengeRequiredOnNewDevice,
      if (deviceOnlyRememberedOnUserPrompt != null)
        'DeviceOnlyRememberedOnUserPrompt': deviceOnlyRememberedOnUserPrompt,
    };
  }
}

enum DeviceRememberedStatusType {
  remembered,
  notRemembered,
}

extension on DeviceRememberedStatusType {
  String toValue() {
    switch (this) {
      case DeviceRememberedStatusType.remembered:
        return 'remembered';
      case DeviceRememberedStatusType.notRemembered:
        return 'not_remembered';
    }
  }
}

extension on String {
  DeviceRememberedStatusType toDeviceRememberedStatusType() {
    switch (this) {
      case 'remembered':
        return DeviceRememberedStatusType.remembered;
      case 'not_remembered':
        return DeviceRememberedStatusType.notRemembered;
    }
    throw Exception('$this is not known in enum DeviceRememberedStatusType');
  }
}

/// The device verifier against which it is authenticated.
class DeviceSecretVerifierConfigType {
  /// The password verifier.
  final String? passwordVerifier;

  /// The <a href="https://en.wikipedia.org/wiki/Salt_(cryptography)">salt</a>
  final String? salt;

  DeviceSecretVerifierConfigType({
    this.passwordVerifier,
    this.salt,
  });
  Map<String, dynamic> toJson() {
    final passwordVerifier = this.passwordVerifier;
    final salt = this.salt;
    return {
      if (passwordVerifier != null) 'PasswordVerifier': passwordVerifier,
      if (salt != null) 'Salt': salt,
    };
  }
}

/// The device type.
class DeviceType {
  /// The device attributes.
  final List<AttributeType>? deviceAttributes;

  /// The creation date of the device.
  final DateTime? deviceCreateDate;

  /// The device key.
  final String? deviceKey;

  /// The date when the device was last authenticated.
  final DateTime? deviceLastAuthenticatedDate;

  /// The last modified date of the device.
  final DateTime? deviceLastModifiedDate;

  DeviceType({
    this.deviceAttributes,
    this.deviceCreateDate,
    this.deviceKey,
    this.deviceLastAuthenticatedDate,
    this.deviceLastModifiedDate,
  });
  factory DeviceType.fromJson(Map<String, dynamic> json) {
    return DeviceType(
      deviceAttributes: (json['DeviceAttributes'] as List?)
          ?.whereNotNull()
          .map((e) => AttributeType.fromJson(e as Map<String, dynamic>))
          .toList(),
      deviceCreateDate: timeStampFromJson(json['DeviceCreateDate']),
      deviceKey: json['DeviceKey'] as String?,
      deviceLastAuthenticatedDate:
          timeStampFromJson(json['DeviceLastAuthenticatedDate']),
      deviceLastModifiedDate: timeStampFromJson(json['DeviceLastModifiedDate']),
    );
  }
}

/// A container for information about a domain.
class DomainDescriptionType {
  /// The Amazon Web Services ID for the user pool owner.
  final String? awsAccountId;

  /// The Amazon Resource Name (ARN) of the Amazon CloudFront distribution.
  final String? cloudFrontDistribution;

  /// The configuration for a custom domain that hosts the sign-up and sign-in
  /// webpages for your application.
  final CustomDomainConfigType? customDomainConfig;

  /// The domain string. For custom domains, this is the fully-qualified domain
  /// name, such as <code>auth.example.com</code>. For Amazon Cognito prefix
  /// domains, this is the prefix alone, such as <code>auth</code>.
  final String? domain;

  /// The Amazon S3 bucket where the static files for this domain are stored.
  final String? s3Bucket;

  /// The domain status.
  final DomainStatusType? status;

  /// The user pool ID.
  final String? userPoolId;

  /// The app version.
  final String? version;

  DomainDescriptionType({
    this.awsAccountId,
    this.cloudFrontDistribution,
    this.customDomainConfig,
    this.domain,
    this.s3Bucket,
    this.status,
    this.userPoolId,
    this.version,
  });
  factory DomainDescriptionType.fromJson(Map<String, dynamic> json) {
    return DomainDescriptionType(
      awsAccountId: json['AWSAccountId'] as String?,
      cloudFrontDistribution: json['CloudFrontDistribution'] as String?,
      customDomainConfig: json['CustomDomainConfig'] != null
          ? CustomDomainConfigType.fromJson(
              json['CustomDomainConfig'] as Map<String, dynamic>)
          : null,
      domain: json['Domain'] as String?,
      s3Bucket: json['S3Bucket'] as String?,
      status: (json['Status'] as String?)?.toDomainStatusType(),
      userPoolId: json['UserPoolId'] as String?,
      version: json['Version'] as String?,
    );
  }
}

enum DomainStatusType {
  creating,
  deleting,
  updating,
  active,
  failed,
}

extension on DomainStatusType {
  String toValue() {
    switch (this) {
      case DomainStatusType.creating:
        return 'CREATING';
      case DomainStatusType.deleting:
        return 'DELETING';
      case DomainStatusType.updating:
        return 'UPDATING';
      case DomainStatusType.active:
        return 'ACTIVE';
      case DomainStatusType.failed:
        return 'FAILED';
    }
  }
}

extension on String {
  DomainStatusType toDomainStatusType() {
    switch (this) {
      case 'CREATING':
        return DomainStatusType.creating;
      case 'DELETING':
        return DomainStatusType.deleting;
      case 'UPDATING':
        return DomainStatusType.updating;
      case 'ACTIVE':
        return DomainStatusType.active;
      case 'FAILED':
        return DomainStatusType.failed;
    }
    throw Exception('$this is not known in enum DomainStatusType');
  }
}

/// The email configuration of your user pool. The email configuration type sets
/// your preferred sending method, Amazon Web Services Region, and sender for
/// messages from your user pool.
/// <note>
/// Amazon Cognito can send email messages with Amazon Simple Email Service
/// resources in the Amazon Web Services Region where you created your user
/// pool, and in alternate Regions in some cases. For more information on the
/// supported Regions, see <a
/// href="https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-email.html">Email
/// settings for Amazon Cognito user pools</a>.
/// </note>
class EmailConfigurationType {
  /// The set of configuration rules that can be applied to emails sent using
  /// Amazon Simple Email Service. A configuration set is applied to an email by
  /// including a reference to the configuration set in the headers of the email.
  /// Once applied, all of the rules in that configuration set are applied to the
  /// email. Configuration sets can be used to apply the following types of rules
  /// to emails:
  /// <dl> <dt>Event publishing</dt> <dd>
  /// Amazon Simple Email Service can track the number of send, delivery, open,
  /// click, bounce, and complaint events for each email sent. Use event
  /// publishing to send information about these events to other Amazon Web
  /// Services services such as and Amazon CloudWatch
  /// </dd> <dt>IP pool management</dt> <dd>
  /// When leasing dedicated IP addresses with Amazon Simple Email Service, you
  /// can create groups of IP addresses, called dedicated IP pools. You can then
  /// associate the dedicated IP pools with configuration sets.
  /// </dd> </dl>
  final String? configurationSet;

  /// Specifies whether Amazon Cognito uses its built-in functionality to send
  /// your users email messages, or uses your Amazon Simple Email Service email
  /// configuration. Specify one of the following values:
  /// <dl> <dt>COGNITO_DEFAULT</dt> <dd>
  /// When Amazon Cognito emails your users, it uses its built-in email
  /// functionality. When you use the default option, Amazon Cognito allows only a
  /// limited number of emails each day for your user pool. For typical production
  /// environments, the default email limit is less than the required delivery
  /// volume. To achieve a higher delivery volume, specify DEVELOPER to use your
  /// Amazon SES email configuration.
  ///
  /// To look up the email delivery limit for the default option, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/limits.html">Limits
  /// in </a> in the <i> Developer Guide</i>.
  ///
  /// The default FROM address is <code>no-reply@verificationemail.com</code>. To
  /// customize the FROM address, provide the Amazon Resource Name (ARN) of an
  /// Amazon SES verified email address for the <code>SourceArn</code> parameter.
  /// </dd> <dt>DEVELOPER</dt> <dd>
  /// When Amazon Cognito emails your users, it uses your Amazon SES
  /// configuration. Amazon Cognito calls Amazon SES on your behalf to send email
  /// from your verified email address. When you use this option, the email
  /// delivery limits are the same limits that apply to your Amazon SES verified
  /// email address in your Amazon Web Services account.
  ///
  /// If you use this option, provide the ARN of an Amazon SES verified email
  /// address for the <code>SourceArn</code> parameter.
  ///
  /// Before Amazon Cognito can email your users, it requires additional
  /// permissions to call Amazon SES on your behalf. When you update your user
  /// pool with this option, Amazon Cognito creates a <i>service-linked role</i>,
  /// which is a type of role, in your Amazon Web Services account. This role
  /// contains the permissions that allow to access Amazon SES and send email
  /// messages with your address. For more information about the service-linked
  /// role that Amazon Cognito creates, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/using-service-linked-roles.html">Using
  /// Service-Linked Roles for Amazon Cognito</a> in the <i>Amazon Cognito
  /// Developer Guide</i>.
  /// </dd> </dl>
  final EmailSendingAccountType? emailSendingAccount;

  /// Either the sender’s email address or the sender’s name with their email
  /// address. For example, <code>testuser@example.com</code> or <code>Test User
  /// &lt;testuser@example.com&gt;</code>. This address appears before the body of
  /// the email.
  final String? from;

  /// The destination to which the receiver of the email should reply.
  final String? replyToEmailAddress;

  /// The ARN of a verified email address in Amazon SES. Amazon Cognito uses this
  /// email address in one of the following ways, depending on the value that you
  /// specify for the <code>EmailSendingAccount</code> parameter:
  ///
  /// <ul>
  /// <li>
  /// If you specify <code>COGNITO_DEFAULT</code>, Amazon Cognito uses this
  /// address as the custom FROM address when it emails your users using its
  /// built-in email account.
  /// </li>
  /// <li>
  /// If you specify <code>DEVELOPER</code>, Amazon Cognito emails your users with
  /// this address by calling Amazon SES on your behalf.
  /// </li>
  /// </ul>
  /// The Region value of the <code>SourceArn</code> parameter must indicate a
  /// supported Amazon Web Services Region of your user pool. Typically, the
  /// Region in the <code>SourceArn</code> and the user pool Region are the same.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-email.html#user-pool-email-developer-region-mapping">Amazon
  /// SES email configuration regions</a> in the <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools.html">Amazon
  /// Cognito Developer Guide</a>.
  final String? sourceArn;

  EmailConfigurationType({
    this.configurationSet,
    this.emailSendingAccount,
    this.from,
    this.replyToEmailAddress,
    this.sourceArn,
  });
  factory EmailConfigurationType.fromJson(Map<String, dynamic> json) {
    return EmailConfigurationType(
      configurationSet: json['ConfigurationSet'] as String?,
      emailSendingAccount:
          (json['EmailSendingAccount'] as String?)?.toEmailSendingAccountType(),
      from: json['From'] as String?,
      replyToEmailAddress: json['ReplyToEmailAddress'] as String?,
      sourceArn: json['SourceArn'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final configurationSet = this.configurationSet;
    final emailSendingAccount = this.emailSendingAccount;
    final from = this.from;
    final replyToEmailAddress = this.replyToEmailAddress;
    final sourceArn = this.sourceArn;
    return {
      if (configurationSet != null) 'ConfigurationSet': configurationSet,
      if (emailSendingAccount != null)
        'EmailSendingAccount': emailSendingAccount.toValue(),
      if (from != null) 'From': from,
      if (replyToEmailAddress != null)
        'ReplyToEmailAddress': replyToEmailAddress,
      if (sourceArn != null) 'SourceArn': sourceArn,
    };
  }
}

enum EmailSendingAccountType {
  cognitoDefault,
  developer,
}

extension on EmailSendingAccountType {
  String toValue() {
    switch (this) {
      case EmailSendingAccountType.cognitoDefault:
        return 'COGNITO_DEFAULT';
      case EmailSendingAccountType.developer:
        return 'DEVELOPER';
    }
  }
}

extension on String {
  EmailSendingAccountType toEmailSendingAccountType() {
    switch (this) {
      case 'COGNITO_DEFAULT':
        return EmailSendingAccountType.cognitoDefault;
      case 'DEVELOPER':
        return EmailSendingAccountType.developer;
    }
    throw Exception('$this is not known in enum EmailSendingAccountType');
  }
}

/// Specifies the user context data captured at the time of an event request.
class EventContextDataType {
  /// The user's city.
  final String? city;

  /// The user's country.
  final String? country;

  /// The user's device name.
  final String? deviceName;

  /// The source IP address of your user's device.
  final String? ipAddress;

  /// The user's time zone.
  final String? timezone;

  EventContextDataType({
    this.city,
    this.country,
    this.deviceName,
    this.ipAddress,
    this.timezone,
  });
  factory EventContextDataType.fromJson(Map<String, dynamic> json) {
    return EventContextDataType(
      city: json['City'] as String?,
      country: json['Country'] as String?,
      deviceName: json['DeviceName'] as String?,
      ipAddress: json['IpAddress'] as String?,
      timezone: json['Timezone'] as String?,
    );
  }
}

/// Specifies the event feedback type.
class EventFeedbackType {
  /// The event feedback value.
  final FeedbackValueType feedbackValue;

  /// The provider.
  final String provider;

  /// The event feedback date.
  final DateTime? feedbackDate;

  EventFeedbackType({
    required this.feedbackValue,
    required this.provider,
    this.feedbackDate,
  });
  factory EventFeedbackType.fromJson(Map<String, dynamic> json) {
    return EventFeedbackType(
      feedbackValue: (json['FeedbackValue'] as String).toFeedbackValueType(),
      provider: json['Provider'] as String,
      feedbackDate: timeStampFromJson(json['FeedbackDate']),
    );
  }
}

enum EventFilterType {
  signIn,
  passwordChange,
  signUp,
}

extension on EventFilterType {
  String toValue() {
    switch (this) {
      case EventFilterType.signIn:
        return 'SIGN_IN';
      case EventFilterType.passwordChange:
        return 'PASSWORD_CHANGE';
      case EventFilterType.signUp:
        return 'SIGN_UP';
    }
  }
}

extension on String {
  EventFilterType toEventFilterType() {
    switch (this) {
      case 'SIGN_IN':
        return EventFilterType.signIn;
      case 'PASSWORD_CHANGE':
        return EventFilterType.passwordChange;
      case 'SIGN_UP':
        return EventFilterType.signUp;
    }
    throw Exception('$this is not known in enum EventFilterType');
  }
}

enum EventResponseType {
  success,
  failure,
}

extension on EventResponseType {
  String toValue() {
    switch (this) {
      case EventResponseType.success:
        return 'Success';
      case EventResponseType.failure:
        return 'Failure';
    }
  }
}

extension on String {
  EventResponseType toEventResponseType() {
    switch (this) {
      case 'Success':
        return EventResponseType.success;
      case 'Failure':
        return EventResponseType.failure;
    }
    throw Exception('$this is not known in enum EventResponseType');
  }
}

/// The event risk type.
class EventRiskType {
  /// Indicates whether compromised credentials were detected during an
  /// authentication event.
  final bool? compromisedCredentialsDetected;

  /// The risk decision.
  final RiskDecisionType? riskDecision;

  /// The risk level.
  final RiskLevelType? riskLevel;

  EventRiskType({
    this.compromisedCredentialsDetected,
    this.riskDecision,
    this.riskLevel,
  });
  factory EventRiskType.fromJson(Map<String, dynamic> json) {
    return EventRiskType(
      compromisedCredentialsDetected:
          json['CompromisedCredentialsDetected'] as bool?,
      riskDecision: (json['RiskDecision'] as String?)?.toRiskDecisionType(),
      riskLevel: (json['RiskLevel'] as String?)?.toRiskLevelType(),
    );
  }
}

enum EventType {
  signIn,
  signUp,
  forgotPassword,
}

extension on EventType {
  String toValue() {
    switch (this) {
      case EventType.signIn:
        return 'SignIn';
      case EventType.signUp:
        return 'SignUp';
      case EventType.forgotPassword:
        return 'ForgotPassword';
    }
  }
}

extension on String {
  EventType toEventType() {
    switch (this) {
      case 'SignIn':
        return EventType.signIn;
      case 'SignUp':
        return EventType.signUp;
      case 'ForgotPassword':
        return EventType.forgotPassword;
    }
    throw Exception('$this is not known in enum EventType');
  }
}

enum ExplicitAuthFlowsType {
  adminNoSrpAuth,
  customAuthFlowOnly,
  userPasswordAuth,
  allowAdminUserPasswordAuth,
  allowCustomAuth,
  allowUserPasswordAuth,
  allowUserSrpAuth,
  allowRefreshTokenAuth,
}

extension on ExplicitAuthFlowsType {
  String toValue() {
    switch (this) {
      case ExplicitAuthFlowsType.adminNoSrpAuth:
        return 'ADMIN_NO_SRP_AUTH';
      case ExplicitAuthFlowsType.customAuthFlowOnly:
        return 'CUSTOM_AUTH_FLOW_ONLY';
      case ExplicitAuthFlowsType.userPasswordAuth:
        return 'USER_PASSWORD_AUTH';
      case ExplicitAuthFlowsType.allowAdminUserPasswordAuth:
        return 'ALLOW_ADMIN_USER_PASSWORD_AUTH';
      case ExplicitAuthFlowsType.allowCustomAuth:
        return 'ALLOW_CUSTOM_AUTH';
      case ExplicitAuthFlowsType.allowUserPasswordAuth:
        return 'ALLOW_USER_PASSWORD_AUTH';
      case ExplicitAuthFlowsType.allowUserSrpAuth:
        return 'ALLOW_USER_SRP_AUTH';
      case ExplicitAuthFlowsType.allowRefreshTokenAuth:
        return 'ALLOW_REFRESH_TOKEN_AUTH';
    }
  }
}

extension on String {
  ExplicitAuthFlowsType toExplicitAuthFlowsType() {
    switch (this) {
      case 'ADMIN_NO_SRP_AUTH':
        return ExplicitAuthFlowsType.adminNoSrpAuth;
      case 'CUSTOM_AUTH_FLOW_ONLY':
        return ExplicitAuthFlowsType.customAuthFlowOnly;
      case 'USER_PASSWORD_AUTH':
        return ExplicitAuthFlowsType.userPasswordAuth;
      case 'ALLOW_ADMIN_USER_PASSWORD_AUTH':
        return ExplicitAuthFlowsType.allowAdminUserPasswordAuth;
      case 'ALLOW_CUSTOM_AUTH':
        return ExplicitAuthFlowsType.allowCustomAuth;
      case 'ALLOW_USER_PASSWORD_AUTH':
        return ExplicitAuthFlowsType.allowUserPasswordAuth;
      case 'ALLOW_USER_SRP_AUTH':
        return ExplicitAuthFlowsType.allowUserSrpAuth;
      case 'ALLOW_REFRESH_TOKEN_AUTH':
        return ExplicitAuthFlowsType.allowRefreshTokenAuth;
    }
    throw Exception('$this is not known in enum ExplicitAuthFlowsType');
  }
}

enum FeedbackValueType {
  valid,
  invalid,
}

extension on FeedbackValueType {
  String toValue() {
    switch (this) {
      case FeedbackValueType.valid:
        return 'Valid';
      case FeedbackValueType.invalid:
        return 'Invalid';
    }
  }
}

extension on String {
  FeedbackValueType toFeedbackValueType() {
    switch (this) {
      case 'Valid':
        return FeedbackValueType.valid;
      case 'Invalid':
        return FeedbackValueType.invalid;
    }
    throw Exception('$this is not known in enum FeedbackValueType');
  }
}

/// The response from Amazon Cognito to a request to reset a password.
class ForgotPasswordResponse {
  /// The code delivery details returned by the server in response to the request
  /// to reset a password.
  final CodeDeliveryDetailsType? codeDeliveryDetails;

  ForgotPasswordResponse({
    this.codeDeliveryDetails,
  });
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      codeDeliveryDetails: json['CodeDeliveryDetails'] != null
          ? CodeDeliveryDetailsType.fromJson(
              json['CodeDeliveryDetails'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Represents the response from the server to the request to get the header
/// information of the CSV file for the user import job.
class GetCSVHeaderResponse {
  /// The header information of the CSV file for the user import job.
  final List<String>? cSVHeader;

  /// The user pool ID for the user pool that the users are to be imported into.
  final String? userPoolId;

  GetCSVHeaderResponse({
    this.cSVHeader,
    this.userPoolId,
  });
  factory GetCSVHeaderResponse.fromJson(Map<String, dynamic> json) {
    return GetCSVHeaderResponse(
      cSVHeader: (json['CSVHeader'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      userPoolId: json['UserPoolId'] as String?,
    );
  }
}

/// Gets the device response.
class GetDeviceResponse {
  /// The device.
  final DeviceType device;

  GetDeviceResponse({
    required this.device,
  });
  factory GetDeviceResponse.fromJson(Map<String, dynamic> json) {
    return GetDeviceResponse(
      device: DeviceType.fromJson(json['Device'] as Map<String, dynamic>),
    );
  }
}

class GetGroupResponse {
  /// The group object for the group.
  final GroupType? group;

  GetGroupResponse({
    this.group,
  });
  factory GetGroupResponse.fromJson(Map<String, dynamic> json) {
    return GetGroupResponse(
      group: json['Group'] != null
          ? GroupType.fromJson(json['Group'] as Map<String, dynamic>)
          : null,
    );
  }
}

class GetIdentityProviderByIdentifierResponse {
  /// The IdP object.
  final IdentityProviderType identityProvider;

  GetIdentityProviderByIdentifierResponse({
    required this.identityProvider,
  });
  factory GetIdentityProviderByIdentifierResponse.fromJson(
      Map<String, dynamic> json) {
    return GetIdentityProviderByIdentifierResponse(
      identityProvider: IdentityProviderType.fromJson(
          json['IdentityProvider'] as Map<String, dynamic>),
    );
  }
}

/// Response from Amazon Cognito for a signing certificate request.
class GetSigningCertificateResponse {
  /// The signing certificate.
  final String? certificate;

  GetSigningCertificateResponse({
    this.certificate,
  });
  factory GetSigningCertificateResponse.fromJson(Map<String, dynamic> json) {
    return GetSigningCertificateResponse(
      certificate: json['Certificate'] as String?,
    );
  }
}

class GetUICustomizationResponse {
  /// The UI customization information.
  final UICustomizationType uICustomization;

  GetUICustomizationResponse({
    required this.uICustomization,
  });
  factory GetUICustomizationResponse.fromJson(Map<String, dynamic> json) {
    return GetUICustomizationResponse(
      uICustomization: UICustomizationType.fromJson(
          json['UICustomization'] as Map<String, dynamic>),
    );
  }
}

/// The verification code response returned by the server response to get the
/// user attribute verification code.
class GetUserAttributeVerificationCodeResponse {
  /// The code delivery details returned by the server in response to the request
  /// to get the user attribute verification code.
  final CodeDeliveryDetailsType? codeDeliveryDetails;

  GetUserAttributeVerificationCodeResponse({
    this.codeDeliveryDetails,
  });
  factory GetUserAttributeVerificationCodeResponse.fromJson(
      Map<String, dynamic> json) {
    return GetUserAttributeVerificationCodeResponse(
      codeDeliveryDetails: json['CodeDeliveryDetails'] != null
          ? CodeDeliveryDetailsType.fromJson(
              json['CodeDeliveryDetails'] as Map<String, dynamic>)
          : null,
    );
  }
}

class GetUserPoolMfaConfigResponse {
  /// The multi-factor authentication (MFA) configuration. Valid values include:
  ///
  /// <ul>
  /// <li>
  /// <code>OFF</code> MFA won't be used for any users.
  /// </li>
  /// <li>
  /// <code>ON</code> MFA is required for all users to sign in.
  /// </li>
  /// <li>
  /// <code>OPTIONAL</code> MFA will be required only for individual users who
  /// have an MFA factor activated.
  /// </li>
  /// </ul>
  final UserPoolMfaType? mfaConfiguration;

  /// The SMS text message multi-factor authentication (MFA) configuration.
  final SmsMfaConfigType? smsMfaConfiguration;

  /// The software token multi-factor authentication (MFA) configuration.
  final SoftwareTokenMfaConfigType? softwareTokenMfaConfiguration;

  GetUserPoolMfaConfigResponse({
    this.mfaConfiguration,
    this.smsMfaConfiguration,
    this.softwareTokenMfaConfiguration,
  });
  factory GetUserPoolMfaConfigResponse.fromJson(Map<String, dynamic> json) {
    return GetUserPoolMfaConfigResponse(
      mfaConfiguration:
          (json['MfaConfiguration'] as String?)?.toUserPoolMfaType(),
      smsMfaConfiguration: json['SmsMfaConfiguration'] != null
          ? SmsMfaConfigType.fromJson(
              json['SmsMfaConfiguration'] as Map<String, dynamic>)
          : null,
      softwareTokenMfaConfiguration:
          json['SoftwareTokenMfaConfiguration'] != null
              ? SoftwareTokenMfaConfigType.fromJson(
                  json['SoftwareTokenMfaConfiguration'] as Map<String, dynamic>)
              : null,
    );
  }
}

/// Represents the response from the server from the request to get information
/// about the user.
class GetUserResponse {
  /// An array of name-value pairs representing user attributes.
  ///
  /// For custom attributes, you must prepend the <code>custom:</code> prefix to
  /// the attribute name.
  final List<AttributeType> userAttributes;

  /// The user name of the user you want to retrieve from the get user request.
  final String username;

  /// <i>This response parameter is no longer supported.</i> It provides
  /// information only about SMS MFA configurations. It doesn't provide
  /// information about time-based one-time password (TOTP) software token MFA
  /// configurations. To look up information about either type of MFA
  /// configuration, use UserMFASettingList instead.
  final List<MFAOptionType>? mFAOptions;

  /// The user's preferred MFA setting.
  final String? preferredMfaSetting;

  /// The MFA options that are activated for the user. The possible values in this
  /// list are <code>SMS_MFA</code> and <code>SOFTWARE_TOKEN_MFA</code>.
  final List<String>? userMFASettingList;

  GetUserResponse({
    required this.userAttributes,
    required this.username,
    this.mFAOptions,
    this.preferredMfaSetting,
    this.userMFASettingList,
  });
  factory GetUserResponse.fromJson(Map<String, dynamic> json) {
    return GetUserResponse(
      userAttributes: (json['UserAttributes'] as List)
          .whereNotNull()
          .map((e) => AttributeType.fromJson(e as Map<String, dynamic>))
          .toList(),
      username: json['Username'] as String,
      mFAOptions: (json['MFAOptions'] as List?)
          ?.whereNotNull()
          .map((e) => MFAOptionType.fromJson(e as Map<String, dynamic>))
          .toList(),
      preferredMfaSetting: json['PreferredMfaSetting'] as String?,
      userMFASettingList: (json['UserMFASettingList'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }
}

/// The response to the request to sign out all devices.
class GlobalSignOutResponse {
  GlobalSignOutResponse();
  factory GlobalSignOutResponse.fromJson(Map<String, dynamic> _) {
    return GlobalSignOutResponse();
  }
}

/// The group type.
class GroupType {
  /// The date the group was created.
  final DateTime? creationDate;

  /// A string containing the description of the group.
  final String? description;

  /// The name of the group.
  final String? groupName;

  /// The date the group was last modified.
  final DateTime? lastModifiedDate;

  /// A non-negative integer value that specifies the precedence of this group
  /// relative to the other groups that a user can belong to in the user pool.
  /// Zero is the highest precedence value. Groups with lower
  /// <code>Precedence</code> values take precedence over groups with higher
  /// ornull <code>Precedence</code> values. If a user belongs to two or more
  /// groups, it is the group with the lowest precedence value whose role ARN is
  /// given in the user's tokens for the <code>cognito:roles</code> and
  /// <code>cognito:preferred_role</code> claims.
  ///
  /// Two groups can have the same <code>Precedence</code> value. If this happens,
  /// neither group takes precedence over the other. If two groups with the same
  /// <code>Precedence</code> have the same role ARN, that role is used in the
  /// <code>cognito:preferred_role</code> claim in tokens for users in each group.
  /// If the two groups have different role ARNs, the
  /// <code>cognito:preferred_role</code> claim isn't set in users' tokens.
  ///
  /// The default <code>Precedence</code> value is null.
  final int? precedence;

  /// The role Amazon Resource Name (ARN) for the group.
  final String? roleArn;

  /// The user pool ID for the user pool.
  final String? userPoolId;

  GroupType({
    this.creationDate,
    this.description,
    this.groupName,
    this.lastModifiedDate,
    this.precedence,
    this.roleArn,
    this.userPoolId,
  });
  factory GroupType.fromJson(Map<String, dynamic> json) {
    return GroupType(
      creationDate: timeStampFromJson(json['CreationDate']),
      description: json['Description'] as String?,
      groupName: json['GroupName'] as String?,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      precedence: json['Precedence'] as int?,
      roleArn: json['RoleArn'] as String?,
      userPoolId: json['UserPoolId'] as String?,
    );
  }
}

/// The HTTP header.
class HttpHeader {
  /// The header name.
  final String? headerName;

  /// The header value.
  final String? headerValue;

  HttpHeader({
    this.headerName,
    this.headerValue,
  });
  Map<String, dynamic> toJson() {
    final headerName = this.headerName;
    final headerValue = this.headerValue;
    return {
      if (headerName != null) 'headerName': headerName,
      if (headerValue != null) 'headerValue': headerValue,
    };
  }
}

/// A container for information about an IdP.
class IdentityProviderType {
  /// A mapping of IdP attributes to standard and custom user pool attributes.
  final Map<String, String>? attributeMapping;

  /// The date the IdP was created.
  final DateTime? creationDate;

  /// A list of IdP identifiers.
  final List<String>? idpIdentifiers;

  /// The date the IdP was last modified.
  final DateTime? lastModifiedDate;

  /// The IdP details. The following list describes the provider detail keys for
  /// each IdP type.
  ///
  /// <ul>
  /// <li>
  /// For Google and Login with Amazon:
  ///
  /// <ul>
  /// <li>
  /// client_id
  /// </li>
  /// <li>
  /// client_secret
  /// </li>
  /// <li>
  /// authorize_scopes
  /// </li>
  /// </ul> </li>
  /// <li>
  /// For Facebook:
  ///
  /// <ul>
  /// <li>
  /// client_id
  /// </li>
  /// <li>
  /// client_secret
  /// </li>
  /// <li>
  /// authorize_scopes
  /// </li>
  /// <li>
  /// api_version
  /// </li>
  /// </ul> </li>
  /// <li>
  /// For Sign in with Apple:
  ///
  /// <ul>
  /// <li>
  /// client_id
  /// </li>
  /// <li>
  /// team_id
  /// </li>
  /// <li>
  /// key_id
  /// </li>
  /// <li>
  /// private_key
  ///
  /// <i>You can submit a private_key when you add or update an IdP. Describe
  /// operations don't return the private key.</i>
  /// </li>
  /// <li>
  /// authorize_scopes
  /// </li>
  /// </ul> </li>
  /// <li>
  /// For OIDC providers:
  ///
  /// <ul>
  /// <li>
  /// client_id
  /// </li>
  /// <li>
  /// client_secret
  /// </li>
  /// <li>
  /// attributes_request_method
  /// </li>
  /// <li>
  /// oidc_issuer
  /// </li>
  /// <li>
  /// authorize_scopes
  /// </li>
  /// <li>
  /// The following keys are only present if Amazon Cognito didn't discover them
  /// at the <code>oidc_issuer</code> URL.
  ///
  /// <ul>
  /// <li>
  /// authorize_url
  /// </li>
  /// <li>
  /// token_url
  /// </li>
  /// <li>
  /// attributes_url
  /// </li>
  /// <li>
  /// jwks_uri
  /// </li>
  /// </ul> </li>
  /// <li>
  /// Amazon Cognito sets the value of the following keys automatically. They are
  /// read-only.
  ///
  /// <ul>
  /// <li>
  /// attributes_url_add_attributes
  /// </li>
  /// </ul> </li>
  /// </ul> </li>
  /// <li>
  /// For SAML providers:
  ///
  /// <ul>
  /// <li>
  /// MetadataFile or MetadataURL
  /// </li>
  /// <li>
  /// IDPSignout <i>optional</i>
  /// </li>
  /// </ul> </li>
  /// </ul>
  final Map<String, String>? providerDetails;

  /// The IdP name.
  final String? providerName;

  /// The IdP type.
  final IdentityProviderTypeType? providerType;

  /// The user pool ID.
  final String? userPoolId;

  IdentityProviderType({
    this.attributeMapping,
    this.creationDate,
    this.idpIdentifiers,
    this.lastModifiedDate,
    this.providerDetails,
    this.providerName,
    this.providerType,
    this.userPoolId,
  });
  factory IdentityProviderType.fromJson(Map<String, dynamic> json) {
    return IdentityProviderType(
      attributeMapping: (json['AttributeMapping'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      creationDate: timeStampFromJson(json['CreationDate']),
      idpIdentifiers: (json['IdpIdentifiers'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      providerDetails: (json['ProviderDetails'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      providerName: json['ProviderName'] as String?,
      providerType:
          (json['ProviderType'] as String?)?.toIdentityProviderTypeType(),
      userPoolId: json['UserPoolId'] as String?,
    );
  }
}

enum IdentityProviderTypeType {
  saml,
  facebook,
  google,
  loginWithAmazon,
  signInWithApple,
  oidc,
}

extension on IdentityProviderTypeType {
  String toValue() {
    switch (this) {
      case IdentityProviderTypeType.saml:
        return 'SAML';
      case IdentityProviderTypeType.facebook:
        return 'Facebook';
      case IdentityProviderTypeType.google:
        return 'Google';
      case IdentityProviderTypeType.loginWithAmazon:
        return 'LoginWithAmazon';
      case IdentityProviderTypeType.signInWithApple:
        return 'SignInWithApple';
      case IdentityProviderTypeType.oidc:
        return 'OIDC';
    }
  }
}

extension on String {
  IdentityProviderTypeType toIdentityProviderTypeType() {
    switch (this) {
      case 'SAML':
        return IdentityProviderTypeType.saml;
      case 'Facebook':
        return IdentityProviderTypeType.facebook;
      case 'Google':
        return IdentityProviderTypeType.google;
      case 'LoginWithAmazon':
        return IdentityProviderTypeType.loginWithAmazon;
      case 'SignInWithApple':
        return IdentityProviderTypeType.signInWithApple;
      case 'OIDC':
        return IdentityProviderTypeType.oidc;
    }
    throw Exception('$this is not known in enum IdentityProviderTypeType');
  }
}

/// Initiates the authentication response.
class InitiateAuthResponse {
  /// The result of the authentication response. This result is only returned if
  /// the caller doesn't need to pass another challenge. If the caller does need
  /// to pass another challenge before it gets tokens, <code>ChallengeName</code>,
  /// <code>ChallengeParameters</code>, and <code>Session</code> are returned.
  final AuthenticationResultType? authenticationResult;

  /// The name of the challenge that you're responding to with this call. This
  /// name is returned in the <code>AdminInitiateAuth</code> response if you must
  /// pass another challenge.
  ///
  /// Valid values include the following:
  /// <note>
  /// All of the following challenges require <code>USERNAME</code> and
  /// <code>SECRET_HASH</code> (if applicable) in the parameters.
  /// </note>
  /// <ul>
  /// <li>
  /// <code>SMS_MFA</code>: Next challenge is to supply an
  /// <code>SMS_MFA_CODE</code>, delivered via SMS.
  /// </li>
  /// <li>
  /// <code>PASSWORD_VERIFIER</code>: Next challenge is to supply
  /// <code>PASSWORD_CLAIM_SIGNATURE</code>,
  /// <code>PASSWORD_CLAIM_SECRET_BLOCK</code>, and <code>TIMESTAMP</code> after
  /// the client-side SRP calculations.
  /// </li>
  /// <li>
  /// <code>CUSTOM_CHALLENGE</code>: This is returned if your custom
  /// authentication flow determines that the user should pass another challenge
  /// before tokens are issued.
  /// </li>
  /// <li>
  /// <code>DEVICE_SRP_AUTH</code>: If device tracking was activated on your user
  /// pool and the previous challenges were passed, this challenge is returned so
  /// that Amazon Cognito can start tracking this device.
  /// </li>
  /// <li>
  /// <code>DEVICE_PASSWORD_VERIFIER</code>: Similar to
  /// <code>PASSWORD_VERIFIER</code>, but for devices only.
  /// </li>
  /// <li>
  /// <code>NEW_PASSWORD_REQUIRED</code>: For users who are required to change
  /// their passwords after successful first login.
  ///
  /// Respond to this challenge with <code>NEW_PASSWORD</code> and any required
  /// attributes that Amazon Cognito returned in the
  /// <code>requiredAttributes</code> parameter. You can also set values for
  /// attributes that aren't required by your user pool and that your app client
  /// can write. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_RespondToAuthChallenge.html">RespondToAuthChallenge</a>.
  /// <note>
  /// In a <code>NEW_PASSWORD_REQUIRED</code> challenge response, you can't modify
  /// a required attribute that already has a value. In
  /// <code>RespondToAuthChallenge</code>, set a value for any keys that Amazon
  /// Cognito returned in the <code>requiredAttributes</code> parameter, then use
  /// the <code>UpdateUserAttributes</code> API operation to modify the value of
  /// any additional attributes.
  /// </note> </li>
  /// <li>
  /// <code>MFA_SETUP</code>: For users who are required to setup an MFA factor
  /// before they can sign in. The MFA types activated for the user pool will be
  /// listed in the challenge parameters <code>MFA_CAN_SETUP</code> value.
  ///
  /// To set up software token MFA, use the session returned here from
  /// <code>InitiateAuth</code> as an input to
  /// <code>AssociateSoftwareToken</code>. Use the session returned by
  /// <code>VerifySoftwareToken</code> as an input to
  /// <code>RespondToAuthChallenge</code> with challenge name
  /// <code>MFA_SETUP</code> to complete sign-in. To set up SMS MFA, an
  /// administrator should help the user to add a phone number to their account,
  /// and then the user should call <code>InitiateAuth</code> again to restart
  /// sign-in.
  /// </li>
  /// </ul>
  final ChallengeNameType? challengeName;

  /// The challenge parameters. These are returned in the
  /// <code>InitiateAuth</code> response if you must pass another challenge. The
  /// responses in this parameter should be used to compute inputs to the next
  /// call (<code>RespondToAuthChallenge</code>).
  ///
  /// All challenges require <code>USERNAME</code> and <code>SECRET_HASH</code>
  /// (if applicable).
  final Map<String, String>? challengeParameters;

  /// The session that should pass both ways in challenge-response calls to the
  /// service. If the caller must pass another challenge, they return a session
  /// with other challenge parameters. This session should be passed as it is to
  /// the next <code>RespondToAuthChallenge</code> API call.
  final String? session;

  InitiateAuthResponse({
    this.authenticationResult,
    this.challengeName,
    this.challengeParameters,
    this.session,
  });
  factory InitiateAuthResponse.fromJson(Map<String, dynamic> json) {
    return InitiateAuthResponse(
      authenticationResult: json['AuthenticationResult'] != null
          ? AuthenticationResultType.fromJson(
              json['AuthenticationResult'] as Map<String, dynamic>)
          : null,
      challengeName: (json['ChallengeName'] as String?)?.toChallengeNameType(),
      challengeParameters:
          (json['ChallengeParameters'] as Map<String, dynamic>?)
              ?.map((k, e) => MapEntry(k, e as String)),
      session: json['Session'] as String?,
    );
  }
}

/// Specifies the configuration for Lambda triggers.
class LambdaConfigType {
  /// Creates an authentication challenge.
  final String? createAuthChallenge;

  /// A custom email sender Lambda trigger.
  final CustomEmailLambdaVersionConfigType? customEmailSender;

  /// A custom Message Lambda trigger.
  final String? customMessage;

  /// A custom SMS sender Lambda trigger.
  final CustomSMSLambdaVersionConfigType? customSMSSender;

  /// Defines the authentication challenge.
  final String? defineAuthChallenge;

  /// The Amazon Resource Name (ARN) of an <a
  /// href="/kms/latest/developerguide/concepts.html#master_keys">KMS key</a>.
  /// Amazon Cognito uses the key to encrypt codes and temporary passwords sent to
  /// <code>CustomEmailSender</code> and <code>CustomSMSSender</code>.
  final String? kMSKeyID;

  /// A post-authentication Lambda trigger.
  final String? postAuthentication;

  /// A post-confirmation Lambda trigger.
  final String? postConfirmation;

  /// A pre-authentication Lambda trigger.
  final String? preAuthentication;

  /// A pre-registration Lambda trigger.
  final String? preSignUp;

  /// A Lambda trigger that is invoked before token generation.
  final String? preTokenGeneration;

  /// The user migration Lambda config type.
  final String? userMigration;

  /// Verifies the authentication challenge response.
  final String? verifyAuthChallengeResponse;

  LambdaConfigType({
    this.createAuthChallenge,
    this.customEmailSender,
    this.customMessage,
    this.customSMSSender,
    this.defineAuthChallenge,
    this.kMSKeyID,
    this.postAuthentication,
    this.postConfirmation,
    this.preAuthentication,
    this.preSignUp,
    this.preTokenGeneration,
    this.userMigration,
    this.verifyAuthChallengeResponse,
  });
  factory LambdaConfigType.fromJson(Map<String, dynamic> json) {
    return LambdaConfigType(
      createAuthChallenge: json['CreateAuthChallenge'] as String?,
      customEmailSender: json['CustomEmailSender'] != null
          ? CustomEmailLambdaVersionConfigType.fromJson(
              json['CustomEmailSender'] as Map<String, dynamic>)
          : null,
      customMessage: json['CustomMessage'] as String?,
      customSMSSender: json['CustomSMSSender'] != null
          ? CustomSMSLambdaVersionConfigType.fromJson(
              json['CustomSMSSender'] as Map<String, dynamic>)
          : null,
      defineAuthChallenge: json['DefineAuthChallenge'] as String?,
      kMSKeyID: json['KMSKeyID'] as String?,
      postAuthentication: json['PostAuthentication'] as String?,
      postConfirmation: json['PostConfirmation'] as String?,
      preAuthentication: json['PreAuthentication'] as String?,
      preSignUp: json['PreSignUp'] as String?,
      preTokenGeneration: json['PreTokenGeneration'] as String?,
      userMigration: json['UserMigration'] as String?,
      verifyAuthChallengeResponse:
          json['VerifyAuthChallengeResponse'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final createAuthChallenge = this.createAuthChallenge;
    final customEmailSender = this.customEmailSender;
    final customMessage = this.customMessage;
    final customSMSSender = this.customSMSSender;
    final defineAuthChallenge = this.defineAuthChallenge;
    final kMSKeyID = this.kMSKeyID;
    final postAuthentication = this.postAuthentication;
    final postConfirmation = this.postConfirmation;
    final preAuthentication = this.preAuthentication;
    final preSignUp = this.preSignUp;
    final preTokenGeneration = this.preTokenGeneration;
    final userMigration = this.userMigration;
    final verifyAuthChallengeResponse = this.verifyAuthChallengeResponse;
    return {
      if (createAuthChallenge != null)
        'CreateAuthChallenge': createAuthChallenge,
      if (customEmailSender != null) 'CustomEmailSender': customEmailSender,
      if (customMessage != null) 'CustomMessage': customMessage,
      if (customSMSSender != null) 'CustomSMSSender': customSMSSender,
      if (defineAuthChallenge != null)
        'DefineAuthChallenge': defineAuthChallenge,
      if (kMSKeyID != null) 'KMSKeyID': kMSKeyID,
      if (postAuthentication != null) 'PostAuthentication': postAuthentication,
      if (postConfirmation != null) 'PostConfirmation': postConfirmation,
      if (preAuthentication != null) 'PreAuthentication': preAuthentication,
      if (preSignUp != null) 'PreSignUp': preSignUp,
      if (preTokenGeneration != null) 'PreTokenGeneration': preTokenGeneration,
      if (userMigration != null) 'UserMigration': userMigration,
      if (verifyAuthChallengeResponse != null)
        'VerifyAuthChallengeResponse': verifyAuthChallengeResponse,
    };
  }
}

/// Represents the response to list devices.
class ListDevicesResponse {
  /// The devices returned in the list devices response.
  final List<DeviceType>? devices;

  /// The pagination token for the list device response.
  final String? paginationToken;

  ListDevicesResponse({
    this.devices,
    this.paginationToken,
  });
  factory ListDevicesResponse.fromJson(Map<String, dynamic> json) {
    return ListDevicesResponse(
      devices: (json['Devices'] as List?)
          ?.whereNotNull()
          .map((e) => DeviceType.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginationToken: json['PaginationToken'] as String?,
    );
  }
}

class ListGroupsResponse {
  /// The group objects for the groups.
  final List<GroupType>? groups;

  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  final String? nextToken;

  ListGroupsResponse({
    this.groups,
    this.nextToken,
  });
  factory ListGroupsResponse.fromJson(Map<String, dynamic> json) {
    return ListGroupsResponse(
      groups: (json['Groups'] as List?)
          ?.whereNotNull()
          .map((e) => GroupType.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListIdentityProvidersResponse {
  /// A list of IdP objects.
  final List<ProviderDescription> providers;

  /// A pagination token.
  final String? nextToken;

  ListIdentityProvidersResponse({
    required this.providers,
    this.nextToken,
  });
  factory ListIdentityProvidersResponse.fromJson(Map<String, dynamic> json) {
    return ListIdentityProvidersResponse(
      providers: (json['Providers'] as List)
          .whereNotNull()
          .map((e) => ProviderDescription.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListResourceServersResponse {
  /// The resource servers.
  final List<ResourceServerType> resourceServers;

  /// A pagination token.
  final String? nextToken;

  ListResourceServersResponse({
    required this.resourceServers,
    this.nextToken,
  });
  factory ListResourceServersResponse.fromJson(Map<String, dynamic> json) {
    return ListResourceServersResponse(
      resourceServers: (json['ResourceServers'] as List)
          .whereNotNull()
          .map((e) => ResourceServerType.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListTagsForResourceResponse {
  /// The tags that are assigned to the user pool.
  final Map<String, String>? tags;

  ListTagsForResourceResponse({
    this.tags,
  });
  factory ListTagsForResourceResponse.fromJson(Map<String, dynamic> json) {
    return ListTagsForResourceResponse(
      tags: (json['Tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

/// Represents the response from the server to the request to list the user
/// import jobs.
class ListUserImportJobsResponse {
  /// An identifier that can be used to return the next set of user import jobs in
  /// the list.
  final String? paginationToken;

  /// The user import jobs.
  final List<UserImportJobType>? userImportJobs;

  ListUserImportJobsResponse({
    this.paginationToken,
    this.userImportJobs,
  });
  factory ListUserImportJobsResponse.fromJson(Map<String, dynamic> json) {
    return ListUserImportJobsResponse(
      paginationToken: json['PaginationToken'] as String?,
      userImportJobs: (json['UserImportJobs'] as List?)
          ?.whereNotNull()
          .map((e) => UserImportJobType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Represents the response from the server that lists user pool clients.
class ListUserPoolClientsResponse {
  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  final String? nextToken;

  /// The user pool clients in the response that lists user pool clients.
  final List<UserPoolClientDescription>? userPoolClients;

  ListUserPoolClientsResponse({
    this.nextToken,
    this.userPoolClients,
  });
  factory ListUserPoolClientsResponse.fromJson(Map<String, dynamic> json) {
    return ListUserPoolClientsResponse(
      nextToken: json['NextToken'] as String?,
      userPoolClients: (json['UserPoolClients'] as List?)
          ?.whereNotNull()
          .map((e) =>
              UserPoolClientDescription.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Represents the response to list user pools.
class ListUserPoolsResponse {
  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  final String? nextToken;

  /// The user pools from the response to list users.
  final List<UserPoolDescriptionType>? userPools;

  ListUserPoolsResponse({
    this.nextToken,
    this.userPools,
  });
  factory ListUserPoolsResponse.fromJson(Map<String, dynamic> json) {
    return ListUserPoolsResponse(
      nextToken: json['NextToken'] as String?,
      userPools: (json['UserPools'] as List?)
          ?.whereNotNull()
          .map((e) =>
              UserPoolDescriptionType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListUsersInGroupResponse {
  /// An identifier that you can use in a later request to return the next set of
  /// items in the list.
  final String? nextToken;

  /// The users returned in the request to list users.
  final List<UserType>? users;

  ListUsersInGroupResponse({
    this.nextToken,
    this.users,
  });
  factory ListUsersInGroupResponse.fromJson(Map<String, dynamic> json) {
    return ListUsersInGroupResponse(
      nextToken: json['NextToken'] as String?,
      users: (json['Users'] as List?)
          ?.whereNotNull()
          .map((e) => UserType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// The response from the request to list users.
class ListUsersResponse {
  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  final String? paginationToken;

  /// The users returned in the request to list users.
  final List<UserType>? users;

  ListUsersResponse({
    this.paginationToken,
    this.users,
  });
  factory ListUsersResponse.fromJson(Map<String, dynamic> json) {
    return ListUsersResponse(
      paginationToken: json['PaginationToken'] as String?,
      users: (json['Users'] as List?)
          ?.whereNotNull()
          .map((e) => UserType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// <i>This data type is no longer supported.</i> Applies only to SMS
/// multi-factor authentication (MFA) configurations. Does not apply to
/// time-based one-time password (TOTP) software token MFA configurations.
class MFAOptionType {
  /// The attribute name of the MFA option type. The only valid value is
  /// <code>phone_number</code>.
  final String? attributeName;

  /// The delivery medium to send the MFA code. You can use this parameter to set
  /// only the <code>SMS</code> delivery medium value.
  final DeliveryMediumType? deliveryMedium;

  MFAOptionType({
    this.attributeName,
    this.deliveryMedium,
  });
  factory MFAOptionType.fromJson(Map<String, dynamic> json) {
    return MFAOptionType(
      attributeName: json['AttributeName'] as String?,
      deliveryMedium:
          (json['DeliveryMedium'] as String?)?.toDeliveryMediumType(),
    );
  }

  Map<String, dynamic> toJson() {
    final attributeName = this.attributeName;
    final deliveryMedium = this.deliveryMedium;
    return {
      if (attributeName != null) 'AttributeName': attributeName,
      if (deliveryMedium != null) 'DeliveryMedium': deliveryMedium.toValue(),
    };
  }
}

enum MessageActionType {
  resend,
  suppress,
}

extension on MessageActionType {
  String toValue() {
    switch (this) {
      case MessageActionType.resend:
        return 'RESEND';
      case MessageActionType.suppress:
        return 'SUPPRESS';
    }
  }
}

extension on String {
  MessageActionType toMessageActionType() {
    switch (this) {
      case 'RESEND':
        return MessageActionType.resend;
      case 'SUPPRESS':
        return MessageActionType.suppress;
    }
    throw Exception('$this is not known in enum MessageActionType');
  }
}

/// The message template structure.
class MessageTemplateType {
  /// The message template for email messages. EmailMessage is allowed only if <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount">EmailSendingAccount</a>
  /// is DEVELOPER.
  final String? emailMessage;

  /// The subject line for email messages. EmailSubject is allowed only if <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount">EmailSendingAccount</a>
  /// is DEVELOPER.
  final String? emailSubject;

  /// The message template for SMS messages.
  final String? sMSMessage;

  MessageTemplateType({
    this.emailMessage,
    this.emailSubject,
    this.sMSMessage,
  });
  factory MessageTemplateType.fromJson(Map<String, dynamic> json) {
    return MessageTemplateType(
      emailMessage: json['EmailMessage'] as String?,
      emailSubject: json['EmailSubject'] as String?,
      sMSMessage: json['SMSMessage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final emailMessage = this.emailMessage;
    final emailSubject = this.emailSubject;
    final sMSMessage = this.sMSMessage;
    return {
      if (emailMessage != null) 'EmailMessage': emailMessage,
      if (emailSubject != null) 'EmailSubject': emailSubject,
      if (sMSMessage != null) 'SMSMessage': sMSMessage,
    };
  }
}

/// The new device metadata type.
class NewDeviceMetadataType {
  /// The device group key.
  final String? deviceGroupKey;

  /// The device key.
  final String? deviceKey;

  NewDeviceMetadataType({
    this.deviceGroupKey,
    this.deviceKey,
  });
  factory NewDeviceMetadataType.fromJson(Map<String, dynamic> json) {
    return NewDeviceMetadataType(
      deviceGroupKey: json['DeviceGroupKey'] as String?,
      deviceKey: json['DeviceKey'] as String?,
    );
  }
}

/// The notify configuration type.
class NotifyConfigurationType {
  /// The Amazon Resource Name (ARN) of the identity that is associated with the
  /// sending authorization policy. This identity permits Amazon Cognito to send
  /// for the email address specified in the <code>From</code> parameter.
  final String sourceArn;

  /// Email template used when a detected risk event is blocked.
  final NotifyEmailType? blockEmail;

  /// The email address that is sending the email. The address must be either
  /// individually verified with Amazon Simple Email Service, or from a domain
  /// that has been verified with Amazon SES.
  final String? from;

  /// The multi-factor authentication (MFA) email template used when MFA is
  /// challenged as part of a detected risk.
  final NotifyEmailType? mfaEmail;

  /// The email template used when a detected risk event is allowed.
  final NotifyEmailType? noActionEmail;

  /// The destination to which the receiver of an email should reply to.
  final String? replyTo;

  NotifyConfigurationType({
    required this.sourceArn,
    this.blockEmail,
    this.from,
    this.mfaEmail,
    this.noActionEmail,
    this.replyTo,
  });
  factory NotifyConfigurationType.fromJson(Map<String, dynamic> json) {
    return NotifyConfigurationType(
      sourceArn: json['SourceArn'] as String,
      blockEmail: json['BlockEmail'] != null
          ? NotifyEmailType.fromJson(json['BlockEmail'] as Map<String, dynamic>)
          : null,
      from: json['From'] as String?,
      mfaEmail: json['MfaEmail'] != null
          ? NotifyEmailType.fromJson(json['MfaEmail'] as Map<String, dynamic>)
          : null,
      noActionEmail: json['NoActionEmail'] != null
          ? NotifyEmailType.fromJson(
              json['NoActionEmail'] as Map<String, dynamic>)
          : null,
      replyTo: json['ReplyTo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final sourceArn = this.sourceArn;
    final blockEmail = this.blockEmail;
    final from = this.from;
    final mfaEmail = this.mfaEmail;
    final noActionEmail = this.noActionEmail;
    final replyTo = this.replyTo;
    return {
      'SourceArn': sourceArn,
      if (blockEmail != null) 'BlockEmail': blockEmail,
      if (from != null) 'From': from,
      if (mfaEmail != null) 'MfaEmail': mfaEmail,
      if (noActionEmail != null) 'NoActionEmail': noActionEmail,
      if (replyTo != null) 'ReplyTo': replyTo,
    };
  }
}

/// The notify email type.
class NotifyEmailType {
  /// The email subject.
  final String subject;

  /// The email HTML body.
  final String? htmlBody;

  /// The email text body.
  final String? textBody;

  NotifyEmailType({
    required this.subject,
    this.htmlBody,
    this.textBody,
  });
  factory NotifyEmailType.fromJson(Map<String, dynamic> json) {
    return NotifyEmailType(
      subject: json['Subject'] as String,
      htmlBody: json['HtmlBody'] as String?,
      textBody: json['TextBody'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final subject = this.subject;
    final htmlBody = this.htmlBody;
    final textBody = this.textBody;
    return {
      'Subject': subject,
      if (htmlBody != null) 'HtmlBody': htmlBody,
      if (textBody != null) 'TextBody': textBody,
    };
  }
}

/// The minimum and maximum values of an attribute that is of the number data
/// type.
class NumberAttributeConstraintsType {
  /// The maximum value of an attribute that is of the number data type.
  final String? maxValue;

  /// The minimum value of an attribute that is of the number data type.
  final String? minValue;

  NumberAttributeConstraintsType({
    this.maxValue,
    this.minValue,
  });
  factory NumberAttributeConstraintsType.fromJson(Map<String, dynamic> json) {
    return NumberAttributeConstraintsType(
      maxValue: json['MaxValue'] as String?,
      minValue: json['MinValue'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final maxValue = this.maxValue;
    final minValue = this.minValue;
    return {
      if (maxValue != null) 'MaxValue': maxValue,
      if (minValue != null) 'MinValue': minValue,
    };
  }
}

enum OAuthFlowType {
  code,
  implicit,
  clientCredentials,
}

extension on OAuthFlowType {
  String toValue() {
    switch (this) {
      case OAuthFlowType.code:
        return 'code';
      case OAuthFlowType.implicit:
        return 'implicit';
      case OAuthFlowType.clientCredentials:
        return 'client_credentials';
    }
  }
}

extension on String {
  OAuthFlowType toOAuthFlowType() {
    switch (this) {
      case 'code':
        return OAuthFlowType.code;
      case 'implicit':
        return OAuthFlowType.implicit;
      case 'client_credentials':
        return OAuthFlowType.clientCredentials;
    }
    throw Exception('$this is not known in enum OAuthFlowType');
  }
}

/// The password policy type.
class PasswordPolicyType {
  /// The minimum length of the password in the policy that you have set. This
  /// value can't be less than 6.
  final int? minimumLength;

  /// In the password policy that you have set, refers to whether you have
  /// required users to use at least one lowercase letter in their password.
  final bool? requireLowercase;

  /// In the password policy that you have set, refers to whether you have
  /// required users to use at least one number in their password.
  final bool? requireNumbers;

  /// In the password policy that you have set, refers to whether you have
  /// required users to use at least one symbol in their password.
  final bool? requireSymbols;

  /// In the password policy that you have set, refers to whether you have
  /// required users to use at least one uppercase letter in their password.
  final bool? requireUppercase;

  /// The number of days a temporary password is valid in the password policy. If
  /// the user doesn't sign in during this time, an administrator must reset their
  /// password.
  /// <note>
  /// When you set <code>TemporaryPasswordValidityDays</code> for a user pool, you
  /// can no longer set a value for the legacy
  /// <code>UnusedAccountValidityDays</code> parameter in that user pool.
  /// </note>
  final int? temporaryPasswordValidityDays;

  PasswordPolicyType({
    this.minimumLength,
    this.requireLowercase,
    this.requireNumbers,
    this.requireSymbols,
    this.requireUppercase,
    this.temporaryPasswordValidityDays,
  });
  factory PasswordPolicyType.fromJson(Map<String, dynamic> json) {
    return PasswordPolicyType(
      minimumLength: json['MinimumLength'] as int?,
      requireLowercase: json['RequireLowercase'] as bool?,
      requireNumbers: json['RequireNumbers'] as bool?,
      requireSymbols: json['RequireSymbols'] as bool?,
      requireUppercase: json['RequireUppercase'] as bool?,
      temporaryPasswordValidityDays:
          json['TemporaryPasswordValidityDays'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final minimumLength = this.minimumLength;
    final requireLowercase = this.requireLowercase;
    final requireNumbers = this.requireNumbers;
    final requireSymbols = this.requireSymbols;
    final requireUppercase = this.requireUppercase;
    final temporaryPasswordValidityDays = this.temporaryPasswordValidityDays;
    return {
      if (minimumLength != null) 'MinimumLength': minimumLength,
      if (requireLowercase != null) 'RequireLowercase': requireLowercase,
      if (requireNumbers != null) 'RequireNumbers': requireNumbers,
      if (requireSymbols != null) 'RequireSymbols': requireSymbols,
      if (requireUppercase != null) 'RequireUppercase': requireUppercase,
      if (temporaryPasswordValidityDays != null)
        'TemporaryPasswordValidityDays': temporaryPasswordValidityDays,
    };
  }
}

enum PreventUserExistenceErrorTypes {
  legacy,
  enabled,
}

extension on PreventUserExistenceErrorTypes {
  String toValue() {
    switch (this) {
      case PreventUserExistenceErrorTypes.legacy:
        return 'LEGACY';
      case PreventUserExistenceErrorTypes.enabled:
        return 'ENABLED';
    }
  }
}

extension on String {
  PreventUserExistenceErrorTypes toPreventUserExistenceErrorTypes() {
    switch (this) {
      case 'LEGACY':
        return PreventUserExistenceErrorTypes.legacy;
      case 'ENABLED':
        return PreventUserExistenceErrorTypes.enabled;
    }
    throw Exception(
        '$this is not known in enum PreventUserExistenceErrorTypes');
  }
}

/// A container for IdP details.
class ProviderDescription {
  /// The date the provider was added to the user pool.
  final DateTime? creationDate;

  /// The date the provider was last modified.
  final DateTime? lastModifiedDate;

  /// The IdP name.
  final String? providerName;

  /// The IdP type.
  final IdentityProviderTypeType? providerType;

  ProviderDescription({
    this.creationDate,
    this.lastModifiedDate,
    this.providerName,
    this.providerType,
  });
  factory ProviderDescription.fromJson(Map<String, dynamic> json) {
    return ProviderDescription(
      creationDate: timeStampFromJson(json['CreationDate']),
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      providerName: json['ProviderName'] as String?,
      providerType:
          (json['ProviderType'] as String?)?.toIdentityProviderTypeType(),
    );
  }
}

/// A container for information about an IdP for a user pool.
class ProviderUserIdentifierType {
  /// The name of the provider attribute to link to, such as <code>NameID</code>.
  final String? providerAttributeName;

  /// The value of the provider attribute to link to, such as
  /// <code>xxxxx_account</code>.
  final String? providerAttributeValue;

  /// The name of the provider, such as Facebook, Google, or Login with Amazon.
  final String? providerName;

  ProviderUserIdentifierType({
    this.providerAttributeName,
    this.providerAttributeValue,
    this.providerName,
  });
  Map<String, dynamic> toJson() {
    final providerAttributeName = this.providerAttributeName;
    final providerAttributeValue = this.providerAttributeValue;
    final providerName = this.providerName;
    return {
      if (providerAttributeName != null)
        'ProviderAttributeName': providerAttributeName,
      if (providerAttributeValue != null)
        'ProviderAttributeValue': providerAttributeValue,
      if (providerName != null) 'ProviderName': providerName,
    };
  }
}

enum RecoveryOptionNameType {
  verifiedEmail,
  verifiedPhoneNumber,
  adminOnly,
}

extension on RecoveryOptionNameType {
  String toValue() {
    switch (this) {
      case RecoveryOptionNameType.verifiedEmail:
        return 'verified_email';
      case RecoveryOptionNameType.verifiedPhoneNumber:
        return 'verified_phone_number';
      case RecoveryOptionNameType.adminOnly:
        return 'admin_only';
    }
  }
}

extension on String {
  RecoveryOptionNameType toRecoveryOptionNameType() {
    switch (this) {
      case 'verified_email':
        return RecoveryOptionNameType.verifiedEmail;
      case 'verified_phone_number':
        return RecoveryOptionNameType.verifiedPhoneNumber;
      case 'admin_only':
        return RecoveryOptionNameType.adminOnly;
    }
    throw Exception('$this is not known in enum RecoveryOptionNameType');
  }
}

/// A map containing a priority as a key, and recovery method name as a value.
class RecoveryOptionType {
  /// The recovery method for a user.
  final RecoveryOptionNameType name;

  /// A positive integer specifying priority of a method with 1 being the highest
  /// priority.
  final int priority;

  RecoveryOptionType({
    required this.name,
    required this.priority,
  });
  factory RecoveryOptionType.fromJson(Map<String, dynamic> json) {
    return RecoveryOptionType(
      name: (json['Name'] as String).toRecoveryOptionNameType(),
      priority: json['Priority'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final name = this.name;
    final priority = this.priority;
    return {
      'Name': name.toValue(),
      'Priority': priority,
    };
  }
}

/// The response from the server when Amazon Cognito makes the request to resend
/// a confirmation code.
class ResendConfirmationCodeResponse {
  /// The code delivery details returned by the server in response to the request
  /// to resend the confirmation code.
  final CodeDeliveryDetailsType? codeDeliveryDetails;

  ResendConfirmationCodeResponse({
    this.codeDeliveryDetails,
  });
  factory ResendConfirmationCodeResponse.fromJson(Map<String, dynamic> json) {
    return ResendConfirmationCodeResponse(
      codeDeliveryDetails: json['CodeDeliveryDetails'] != null
          ? CodeDeliveryDetailsType.fromJson(
              json['CodeDeliveryDetails'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// A resource server scope.
class ResourceServerScopeType {
  /// A description of the scope.
  final String scopeDescription;

  /// The name of the scope.
  final String scopeName;

  ResourceServerScopeType({
    required this.scopeDescription,
    required this.scopeName,
  });
  factory ResourceServerScopeType.fromJson(Map<String, dynamic> json) {
    return ResourceServerScopeType(
      scopeDescription: json['ScopeDescription'] as String,
      scopeName: json['ScopeName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final scopeDescription = this.scopeDescription;
    final scopeName = this.scopeName;
    return {
      'ScopeDescription': scopeDescription,
      'ScopeName': scopeName,
    };
  }
}

/// A container for information about a resource server for a user pool.
class ResourceServerType {
  /// The identifier for the resource server.
  final String? identifier;

  /// The name of the resource server.
  final String? name;

  /// A list of scopes that are defined for the resource server.
  final List<ResourceServerScopeType>? scopes;

  /// The user pool ID for the user pool that hosts the resource server.
  final String? userPoolId;

  ResourceServerType({
    this.identifier,
    this.name,
    this.scopes,
    this.userPoolId,
  });
  factory ResourceServerType.fromJson(Map<String, dynamic> json) {
    return ResourceServerType(
      identifier: json['Identifier'] as String?,
      name: json['Name'] as String?,
      scopes: (json['Scopes'] as List?)
          ?.whereNotNull()
          .map((e) =>
              ResourceServerScopeType.fromJson(e as Map<String, dynamic>))
          .toList(),
      userPoolId: json['UserPoolId'] as String?,
    );
  }
}

/// The response to respond to the authentication challenge.
class RespondToAuthChallengeResponse {
  /// The result returned by the server in response to the request to respond to
  /// the authentication challenge.
  final AuthenticationResultType? authenticationResult;

  /// The challenge name. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_InitiateAuth.html">InitiateAuth</a>.
  final ChallengeNameType? challengeName;

  /// The challenge parameters. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_InitiateAuth.html">InitiateAuth</a>.
  final Map<String, String>? challengeParameters;

  /// The session that should be passed both ways in challenge-response calls to
  /// the service. If the caller must pass another challenge, they return a
  /// session with other challenge parameters. This session should be passed as it
  /// is to the next <code>RespondToAuthChallenge</code> API call.
  final String? session;

  RespondToAuthChallengeResponse({
    this.authenticationResult,
    this.challengeName,
    this.challengeParameters,
    this.session,
  });
  factory RespondToAuthChallengeResponse.fromJson(Map<String, dynamic> json) {
    return RespondToAuthChallengeResponse(
      authenticationResult: json['AuthenticationResult'] != null
          ? AuthenticationResultType.fromJson(
              json['AuthenticationResult'] as Map<String, dynamic>)
          : null,
      challengeName: (json['ChallengeName'] as String?)?.toChallengeNameType(),
      challengeParameters:
          (json['ChallengeParameters'] as Map<String, dynamic>?)
              ?.map((k, e) => MapEntry(k, e as String)),
      session: json['Session'] as String?,
    );
  }
}

class RevokeTokenResponse {
  RevokeTokenResponse();
  factory RevokeTokenResponse.fromJson(Map<String, dynamic> _) {
    return RevokeTokenResponse();
  }
}

/// The risk configuration type.
class RiskConfigurationType {
  /// The account takeover risk configuration object, including the
  /// <code>NotifyConfiguration</code> object and <code>Actions</code> to take if
  /// there is an account takeover.
  final AccountTakeoverRiskConfigurationType? accountTakeoverRiskConfiguration;

  /// The app client ID.
  final String? clientId;

  /// The compromised credentials risk configuration object, including the
  /// <code>EventFilter</code> and the <code>EventAction</code>.
  final CompromisedCredentialsRiskConfigurationType?
      compromisedCredentialsRiskConfiguration;

  /// The last modified date.
  final DateTime? lastModifiedDate;

  /// The configuration to override the risk decision.
  final RiskExceptionConfigurationType? riskExceptionConfiguration;

  /// The user pool ID.
  final String? userPoolId;

  RiskConfigurationType({
    this.accountTakeoverRiskConfiguration,
    this.clientId,
    this.compromisedCredentialsRiskConfiguration,
    this.lastModifiedDate,
    this.riskExceptionConfiguration,
    this.userPoolId,
  });
  factory RiskConfigurationType.fromJson(Map<String, dynamic> json) {
    return RiskConfigurationType(
      accountTakeoverRiskConfiguration:
          json['AccountTakeoverRiskConfiguration'] != null
              ? AccountTakeoverRiskConfigurationType.fromJson(
                  json['AccountTakeoverRiskConfiguration']
                      as Map<String, dynamic>)
              : null,
      clientId: json['ClientId'] as String?,
      compromisedCredentialsRiskConfiguration:
          json['CompromisedCredentialsRiskConfiguration'] != null
              ? CompromisedCredentialsRiskConfigurationType.fromJson(
                  json['CompromisedCredentialsRiskConfiguration']
                      as Map<String, dynamic>)
              : null,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      riskExceptionConfiguration: json['RiskExceptionConfiguration'] != null
          ? RiskExceptionConfigurationType.fromJson(
              json['RiskExceptionConfiguration'] as Map<String, dynamic>)
          : null,
      userPoolId: json['UserPoolId'] as String?,
    );
  }
}

enum RiskDecisionType {
  noRisk,
  accountTakeover,
  block,
}

extension on RiskDecisionType {
  String toValue() {
    switch (this) {
      case RiskDecisionType.noRisk:
        return 'NoRisk';
      case RiskDecisionType.accountTakeover:
        return 'AccountTakeover';
      case RiskDecisionType.block:
        return 'Block';
    }
  }
}

extension on String {
  RiskDecisionType toRiskDecisionType() {
    switch (this) {
      case 'NoRisk':
        return RiskDecisionType.noRisk;
      case 'AccountTakeover':
        return RiskDecisionType.accountTakeover;
      case 'Block':
        return RiskDecisionType.block;
    }
    throw Exception('$this is not known in enum RiskDecisionType');
  }
}

/// The type of the configuration to override the risk decision.
class RiskExceptionConfigurationType {
  /// Overrides the risk decision to always block the pre-authentication requests.
  /// The IP range is in CIDR notation, a compact representation of an IP address
  /// and its routing prefix.
  final List<String>? blockedIPRangeList;

  /// Risk detection isn't performed on the IP addresses in this range list. The
  /// IP range is in CIDR notation.
  final List<String>? skippedIPRangeList;

  RiskExceptionConfigurationType({
    this.blockedIPRangeList,
    this.skippedIPRangeList,
  });
  factory RiskExceptionConfigurationType.fromJson(Map<String, dynamic> json) {
    return RiskExceptionConfigurationType(
      blockedIPRangeList: (json['BlockedIPRangeList'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      skippedIPRangeList: (json['SkippedIPRangeList'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final blockedIPRangeList = this.blockedIPRangeList;
    final skippedIPRangeList = this.skippedIPRangeList;
    return {
      if (blockedIPRangeList != null) 'BlockedIPRangeList': blockedIPRangeList,
      if (skippedIPRangeList != null) 'SkippedIPRangeList': skippedIPRangeList,
    };
  }
}

enum RiskLevelType {
  low,
  medium,
  high,
}

extension on RiskLevelType {
  String toValue() {
    switch (this) {
      case RiskLevelType.low:
        return 'Low';
      case RiskLevelType.medium:
        return 'Medium';
      case RiskLevelType.high:
        return 'High';
    }
  }
}

extension on String {
  RiskLevelType toRiskLevelType() {
    switch (this) {
      case 'Low':
        return RiskLevelType.low;
      case 'Medium':
        return RiskLevelType.medium;
      case 'High':
        return RiskLevelType.high;
    }
    throw Exception('$this is not known in enum RiskLevelType');
  }
}

/// The type used for enabling SMS multi-factor authentication (MFA) at the user
/// level. Phone numbers don't need to be verified to be used for SMS MFA. If an
/// MFA type is activated for a user, the user will be prompted for MFA during
/// all sign-in attempts, unless device tracking is turned on and the device has
/// been trusted. If you would like MFA to be applied selectively based on the
/// assessed risk level of sign-in attempts, deactivate MFA for users and turn
/// on Adaptive Authentication for the user pool.
class SMSMfaSettingsType {
  /// Specifies whether SMS text message MFA is activated. If an MFA type is
  /// activated for a user, the user will be prompted for MFA during all sign-in
  /// attempts, unless device tracking is turned on and the device has been
  /// trusted.
  final bool? enabled;

  /// Specifies whether SMS is the preferred MFA method.
  final bool? preferredMfa;

  SMSMfaSettingsType({
    this.enabled,
    this.preferredMfa,
  });
  Map<String, dynamic> toJson() {
    final enabled = this.enabled;
    final preferredMfa = this.preferredMfa;
    return {
      if (enabled != null) 'Enabled': enabled,
      if (preferredMfa != null) 'PreferredMfa': preferredMfa,
    };
  }
}

/// Contains information about the schema attribute.
class SchemaAttributeType {
  /// The attribute data type.
  final AttributeDataType? attributeDataType;

  /// <note>
  /// You should use <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_UserPoolClientType.html#CognitoUserPools-Type-UserPoolClientType-WriteAttributes">WriteAttributes</a>
  /// in the user pool client to control how attributes can be mutated for new use
  /// cases instead of using <code>DeveloperOnlyAttribute</code>.
  /// </note>
  /// Specifies whether the attribute type is developer only. This attribute can
  /// only be modified by an administrator. Users won't be able to modify this
  /// attribute using their access token. For example,
  /// <code>DeveloperOnlyAttribute</code> can be modified using
  /// AdminUpdateUserAttributes but can't be updated using UpdateUserAttributes.
  final bool? developerOnlyAttribute;

  /// Specifies whether the value of the attribute can be changed.
  ///
  /// For any user pool attribute that is mapped to an IdP attribute, you must set
  /// this parameter to <code>true</code>. Amazon Cognito updates mapped
  /// attributes when users sign in to your application through an IdP. If an
  /// attribute is immutable, Amazon Cognito throws an error when it attempts to
  /// update the attribute. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-specifying-attribute-mapping.html">Specifying
  /// Identity Provider Attribute Mappings for Your User Pool</a>.
  final bool? mutable;

  /// A schema attribute of the name type.
  final String? name;

  /// Specifies the constraints for an attribute of the number type.
  final NumberAttributeConstraintsType? numberAttributeConstraints;

  /// Specifies whether a user pool attribute is required. If the attribute is
  /// required and the user doesn't provide a value, registration or sign-in will
  /// fail.
  final bool? required;

  /// Specifies the constraints for an attribute of the string type.
  final StringAttributeConstraintsType? stringAttributeConstraints;

  SchemaAttributeType({
    this.attributeDataType,
    this.developerOnlyAttribute,
    this.mutable,
    this.name,
    this.numberAttributeConstraints,
    this.required,
    this.stringAttributeConstraints,
  });
  factory SchemaAttributeType.fromJson(Map<String, dynamic> json) {
    return SchemaAttributeType(
      attributeDataType:
          (json['AttributeDataType'] as String?)?.toAttributeDataType(),
      developerOnlyAttribute: json['DeveloperOnlyAttribute'] as bool?,
      mutable: json['Mutable'] as bool?,
      name: json['Name'] as String?,
      numberAttributeConstraints: json['NumberAttributeConstraints'] != null
          ? NumberAttributeConstraintsType.fromJson(
              json['NumberAttributeConstraints'] as Map<String, dynamic>)
          : null,
      required: json['Required'] as bool?,
      stringAttributeConstraints: json['StringAttributeConstraints'] != null
          ? StringAttributeConstraintsType.fromJson(
              json['StringAttributeConstraints'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final attributeDataType = this.attributeDataType;
    final developerOnlyAttribute = this.developerOnlyAttribute;
    final mutable = this.mutable;
    final name = this.name;
    final numberAttributeConstraints = this.numberAttributeConstraints;
    final required = this.required;
    final stringAttributeConstraints = this.stringAttributeConstraints;
    return {
      if (attributeDataType != null)
        'AttributeDataType': attributeDataType.toValue(),
      if (developerOnlyAttribute != null)
        'DeveloperOnlyAttribute': developerOnlyAttribute,
      if (mutable != null) 'Mutable': mutable,
      if (name != null) 'Name': name,
      if (numberAttributeConstraints != null)
        'NumberAttributeConstraints': numberAttributeConstraints,
      if (required != null) 'Required': required,
      if (stringAttributeConstraints != null)
        'StringAttributeConstraints': stringAttributeConstraints,
    };
  }
}

class SetRiskConfigurationResponse {
  /// The risk configuration.
  final RiskConfigurationType riskConfiguration;

  SetRiskConfigurationResponse({
    required this.riskConfiguration,
  });
  factory SetRiskConfigurationResponse.fromJson(Map<String, dynamic> json) {
    return SetRiskConfigurationResponse(
      riskConfiguration: RiskConfigurationType.fromJson(
          json['RiskConfiguration'] as Map<String, dynamic>),
    );
  }
}

class SetUICustomizationResponse {
  /// The UI customization information.
  final UICustomizationType uICustomization;

  SetUICustomizationResponse({
    required this.uICustomization,
  });
  factory SetUICustomizationResponse.fromJson(Map<String, dynamic> json) {
    return SetUICustomizationResponse(
      uICustomization: UICustomizationType.fromJson(
          json['UICustomization'] as Map<String, dynamic>),
    );
  }
}

class SetUserMFAPreferenceResponse {
  SetUserMFAPreferenceResponse();
  factory SetUserMFAPreferenceResponse.fromJson(Map<String, dynamic> _) {
    return SetUserMFAPreferenceResponse();
  }
}

class SetUserPoolMfaConfigResponse {
  /// The MFA configuration. Valid values include:
  ///
  /// <ul>
  /// <li>
  /// <code>OFF</code> MFA won't be used for any users.
  /// </li>
  /// <li>
  /// <code>ON</code> MFA is required for all users to sign in.
  /// </li>
  /// <li>
  /// <code>OPTIONAL</code> MFA will be required only for individual users who
  /// have an MFA factor enabled.
  /// </li>
  /// </ul>
  final UserPoolMfaType? mfaConfiguration;

  /// The SMS text message MFA configuration.
  final SmsMfaConfigType? smsMfaConfiguration;

  /// The software token MFA configuration.
  final SoftwareTokenMfaConfigType? softwareTokenMfaConfiguration;

  SetUserPoolMfaConfigResponse({
    this.mfaConfiguration,
    this.smsMfaConfiguration,
    this.softwareTokenMfaConfiguration,
  });
  factory SetUserPoolMfaConfigResponse.fromJson(Map<String, dynamic> json) {
    return SetUserPoolMfaConfigResponse(
      mfaConfiguration:
          (json['MfaConfiguration'] as String?)?.toUserPoolMfaType(),
      smsMfaConfiguration: json['SmsMfaConfiguration'] != null
          ? SmsMfaConfigType.fromJson(
              json['SmsMfaConfiguration'] as Map<String, dynamic>)
          : null,
      softwareTokenMfaConfiguration:
          json['SoftwareTokenMfaConfiguration'] != null
              ? SoftwareTokenMfaConfigType.fromJson(
                  json['SoftwareTokenMfaConfiguration'] as Map<String, dynamic>)
              : null,
    );
  }
}

/// The response from the server for a set user settings request.
class SetUserSettingsResponse {
  SetUserSettingsResponse();
  factory SetUserSettingsResponse.fromJson(Map<String, dynamic> _) {
    return SetUserSettingsResponse();
  }
}

/// The response from the server for a registration request.
class SignUpResponse {
  /// A response from the server indicating that a user registration has been
  /// confirmed.
  final bool userConfirmed;

  /// The UUID of the authenticated user. This isn't the same as
  /// <code>username</code>.
  final String userSub;

  /// The code delivery details returned by the server response to the user
  /// registration request.
  final CodeDeliveryDetailsType? codeDeliveryDetails;

  SignUpResponse({
    required this.userConfirmed,
    required this.userSub,
    this.codeDeliveryDetails,
  });
  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      userConfirmed: json['UserConfirmed'] as bool,
      userSub: json['UserSub'] as String,
      codeDeliveryDetails: json['CodeDeliveryDetails'] != null
          ? CodeDeliveryDetailsType.fromJson(
              json['CodeDeliveryDetails'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// The SMS configuration type is the settings that your Amazon Cognito user
/// pool must use to send an SMS message from your Amazon Web Services account
/// through Amazon Simple Notification Service. To send SMS messages with Amazon
/// SNS in the Amazon Web Services Region that you want, the Amazon Cognito user
/// pool uses an Identity and Access Management (IAM) role in your Amazon Web
/// Services account.
class SmsConfigurationType {
  /// The Amazon Resource Name (ARN) of the Amazon SNS caller. This is the ARN of
  /// the IAM role in your Amazon Web Services account that Amazon Cognito will
  /// use to send SMS messages. SMS messages are subject to a <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-email-phone-verification.html">spending
  /// limit</a>.
  final String snsCallerArn;

  /// The external ID provides additional security for your IAM role. You can use
  /// an <code>ExternalId</code> with the IAM role that you use with Amazon SNS to
  /// send SMS messages for your user pool. If you provide an
  /// <code>ExternalId</code>, your Amazon Cognito user pool includes it in the
  /// request to assume your IAM role. You can configure the role trust policy to
  /// require that Amazon Cognito, and any principal, provide the
  /// <code>ExternalID</code>. If you use the Amazon Cognito Management Console to
  /// create a role for SMS multi-factor authentication (MFA), Amazon Cognito
  /// creates a role with the required permissions and a trust policy that
  /// demonstrates use of the <code>ExternalId</code>.
  ///
  /// For more information about the <code>ExternalId</code> of a role, see <a
  /// href="https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user_externalid.html">How
  /// to use an external ID when granting access to your Amazon Web Services
  /// resources to a third party</a>
  final String? externalId;

  /// The Amazon Web Services Region to use with Amazon SNS integration. You can
  /// choose the same Region as your user pool, or a supported <b>Legacy Amazon
  /// SNS alternate Region</b>.
  ///
  /// Amazon Cognito resources in the Asia Pacific (Seoul) Amazon Web Services
  /// Region must use your Amazon SNS configuration in the Asia Pacific (Tokyo)
  /// Region. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-sms-settings.html">SMS
  /// message settings for Amazon Cognito user pools</a>.
  final String? snsRegion;

  SmsConfigurationType({
    required this.snsCallerArn,
    this.externalId,
    this.snsRegion,
  });
  factory SmsConfigurationType.fromJson(Map<String, dynamic> json) {
    return SmsConfigurationType(
      snsCallerArn: json['SnsCallerArn'] as String,
      externalId: json['ExternalId'] as String?,
      snsRegion: json['SnsRegion'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final snsCallerArn = this.snsCallerArn;
    final externalId = this.externalId;
    final snsRegion = this.snsRegion;
    return {
      'SnsCallerArn': snsCallerArn,
      if (externalId != null) 'ExternalId': externalId,
      if (snsRegion != null) 'SnsRegion': snsRegion,
    };
  }
}

/// The SMS text message multi-factor authentication (MFA) configuration type.
class SmsMfaConfigType {
  /// The SMS authentication message that will be sent to users with the code they
  /// must sign in. The message must contain the ‘{####}’ placeholder, which is
  /// replaced with the code. If the message isn't included, and default message
  /// will be used.
  final String? smsAuthenticationMessage;

  /// The SMS configuration with the settings that your Amazon Cognito user pool
  /// must use to send an SMS message from your Amazon Web Services account
  /// through Amazon Simple Notification Service. To request Amazon SNS in the
  /// Amazon Web Services Region that you want, the Amazon Cognito user pool uses
  /// an Identity and Access Management (IAM) role that you provide for your
  /// Amazon Web Services account.
  final SmsConfigurationType? smsConfiguration;

  SmsMfaConfigType({
    this.smsAuthenticationMessage,
    this.smsConfiguration,
  });
  factory SmsMfaConfigType.fromJson(Map<String, dynamic> json) {
    return SmsMfaConfigType(
      smsAuthenticationMessage: json['SmsAuthenticationMessage'] as String?,
      smsConfiguration: json['SmsConfiguration'] != null
          ? SmsConfigurationType.fromJson(
              json['SmsConfiguration'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final smsAuthenticationMessage = this.smsAuthenticationMessage;
    final smsConfiguration = this.smsConfiguration;
    return {
      if (smsAuthenticationMessage != null)
        'SmsAuthenticationMessage': smsAuthenticationMessage,
      if (smsConfiguration != null) 'SmsConfiguration': smsConfiguration,
    };
  }
}

/// The type used for enabling software token MFA at the user pool level.
class SoftwareTokenMfaConfigType {
  /// Specifies whether software token MFA is activated.
  final bool? enabled;

  SoftwareTokenMfaConfigType({
    this.enabled,
  });
  factory SoftwareTokenMfaConfigType.fromJson(Map<String, dynamic> json) {
    return SoftwareTokenMfaConfigType(
      enabled: json['Enabled'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    final enabled = this.enabled;
    return {
      if (enabled != null) 'Enabled': enabled,
    };
  }
}

/// The type used for enabling software token MFA at the user level. If an MFA
/// type is activated for a user, the user will be prompted for MFA during all
/// sign-in attempts, unless device tracking is turned on and the device has
/// been trusted. If you want MFA to be applied selectively based on the
/// assessed risk level of sign-in attempts, deactivate MFA for users and turn
/// on Adaptive Authentication for the user pool.
class SoftwareTokenMfaSettingsType {
  /// Specifies whether software token MFA is activated. If an MFA type is
  /// activated for a user, the user will be prompted for MFA during all sign-in
  /// attempts, unless device tracking is turned on and the device has been
  /// trusted.
  final bool? enabled;

  /// Specifies whether software token MFA is the preferred MFA method.
  final bool? preferredMfa;

  SoftwareTokenMfaSettingsType({
    this.enabled,
    this.preferredMfa,
  });
  Map<String, dynamic> toJson() {
    final enabled = this.enabled;
    final preferredMfa = this.preferredMfa;
    return {
      if (enabled != null) 'Enabled': enabled,
      if (preferredMfa != null) 'PreferredMfa': preferredMfa,
    };
  }
}

/// Represents the response from the server to the request to start the user
/// import job.
class StartUserImportJobResponse {
  /// The job object that represents the user import job.
  final UserImportJobType? userImportJob;

  StartUserImportJobResponse({
    this.userImportJob,
  });
  factory StartUserImportJobResponse.fromJson(Map<String, dynamic> json) {
    return StartUserImportJobResponse(
      userImportJob: json['UserImportJob'] != null
          ? UserImportJobType.fromJson(
              json['UserImportJob'] as Map<String, dynamic>)
          : null,
    );
  }
}

enum StatusType {
  enabled,
  disabled,
}

extension on StatusType {
  String toValue() {
    switch (this) {
      case StatusType.enabled:
        return 'Enabled';
      case StatusType.disabled:
        return 'Disabled';
    }
  }
}

extension on String {
  StatusType toStatusType() {
    switch (this) {
      case 'Enabled':
        return StatusType.enabled;
      case 'Disabled':
        return StatusType.disabled;
    }
    throw Exception('$this is not known in enum StatusType');
  }
}

/// Represents the response from the server to the request to stop the user
/// import job.
class StopUserImportJobResponse {
  /// The job object that represents the user import job.
  final UserImportJobType? userImportJob;

  StopUserImportJobResponse({
    this.userImportJob,
  });
  factory StopUserImportJobResponse.fromJson(Map<String, dynamic> json) {
    return StopUserImportJobResponse(
      userImportJob: json['UserImportJob'] != null
          ? UserImportJobType.fromJson(
              json['UserImportJob'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// The constraints associated with a string attribute.
class StringAttributeConstraintsType {
  /// The maximum length.
  final String? maxLength;

  /// The minimum length.
  final String? minLength;

  StringAttributeConstraintsType({
    this.maxLength,
    this.minLength,
  });
  factory StringAttributeConstraintsType.fromJson(Map<String, dynamic> json) {
    return StringAttributeConstraintsType(
      maxLength: json['MaxLength'] as String?,
      minLength: json['MinLength'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final maxLength = this.maxLength;
    final minLength = this.minLength;
    return {
      if (maxLength != null) 'MaxLength': maxLength,
      if (minLength != null) 'MinLength': minLength,
    };
  }
}

class TagResourceResponse {
  TagResourceResponse();
  factory TagResourceResponse.fromJson(Map<String, dynamic> _) {
    return TagResourceResponse();
  }
}

enum TimeUnitsType {
  seconds,
  minutes,
  hours,
  days,
}

extension on TimeUnitsType {
  String toValue() {
    switch (this) {
      case TimeUnitsType.seconds:
        return 'seconds';
      case TimeUnitsType.minutes:
        return 'minutes';
      case TimeUnitsType.hours:
        return 'hours';
      case TimeUnitsType.days:
        return 'days';
    }
  }
}

extension on String {
  TimeUnitsType toTimeUnitsType() {
    switch (this) {
      case 'seconds':
        return TimeUnitsType.seconds;
      case 'minutes':
        return TimeUnitsType.minutes;
      case 'hours':
        return TimeUnitsType.hours;
      case 'days':
        return TimeUnitsType.days;
    }
    throw Exception('$this is not known in enum TimeUnitsType');
  }
}

/// The data type TokenValidityUnits specifies the time units you use when you
/// set the duration of ID, access, and refresh tokens.
class TokenValidityUnitsType {
  /// A time unit of <code>seconds</code>, <code>minutes</code>,
  /// <code>hours</code>, or <code>days</code> for the value that you set in the
  /// <code>AccessTokenValidity</code> parameter. The default
  /// <code>AccessTokenValidity</code> time unit is hours.
  final TimeUnitsType? accessToken;

  /// A time unit of <code>seconds</code>, <code>minutes</code>,
  /// <code>hours</code>, or <code>days</code> for the value that you set in the
  /// <code>IdTokenValidity</code> parameter. The default
  /// <code>IdTokenValidity</code> time unit is hours.
  final TimeUnitsType? idToken;

  /// A time unit of <code>seconds</code>, <code>minutes</code>,
  /// <code>hours</code>, or <code>days</code> for the value that you set in the
  /// <code>RefreshTokenValidity</code> parameter. The default
  /// <code>RefreshTokenValidity</code> time unit is days.
  final TimeUnitsType? refreshToken;

  TokenValidityUnitsType({
    this.accessToken,
    this.idToken,
    this.refreshToken,
  });
  factory TokenValidityUnitsType.fromJson(Map<String, dynamic> json) {
    return TokenValidityUnitsType(
      accessToken: (json['AccessToken'] as String?)?.toTimeUnitsType(),
      idToken: (json['IdToken'] as String?)?.toTimeUnitsType(),
      refreshToken: (json['RefreshToken'] as String?)?.toTimeUnitsType(),
    );
  }

  Map<String, dynamic> toJson() {
    final accessToken = this.accessToken;
    final idToken = this.idToken;
    final refreshToken = this.refreshToken;
    return {
      if (accessToken != null) 'AccessToken': accessToken.toValue(),
      if (idToken != null) 'IdToken': idToken.toValue(),
      if (refreshToken != null) 'RefreshToken': refreshToken.toValue(),
    };
  }
}

/// A container for the UI customization information for a user pool's built-in
/// app UI.
class UICustomizationType {
  /// The CSS values in the UI customization.
  final String? css;

  /// The CSS version number.
  final String? cSSVersion;

  /// The client ID for the client app.
  final String? clientId;

  /// The creation date for the UI customization.
  final DateTime? creationDate;

  /// The logo image for the UI customization.
  final String? imageUrl;

  /// The last-modified date for the UI customization.
  final DateTime? lastModifiedDate;

  /// The user pool ID for the user pool.
  final String? userPoolId;

  UICustomizationType({
    this.css,
    this.cSSVersion,
    this.clientId,
    this.creationDate,
    this.imageUrl,
    this.lastModifiedDate,
    this.userPoolId,
  });
  factory UICustomizationType.fromJson(Map<String, dynamic> json) {
    return UICustomizationType(
      css: json['CSS'] as String?,
      cSSVersion: json['CSSVersion'] as String?,
      clientId: json['ClientId'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
      imageUrl: json['ImageUrl'] as String?,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      userPoolId: json['UserPoolId'] as String?,
    );
  }
}

class UntagResourceResponse {
  UntagResourceResponse();
  factory UntagResourceResponse.fromJson(Map<String, dynamic> _) {
    return UntagResourceResponse();
  }
}

class UpdateAuthEventFeedbackResponse {
  UpdateAuthEventFeedbackResponse();
  factory UpdateAuthEventFeedbackResponse.fromJson(Map<String, dynamic> _) {
    return UpdateAuthEventFeedbackResponse();
  }
}

/// The response to the request to update the device status.
class UpdateDeviceStatusResponse {
  UpdateDeviceStatusResponse();
  factory UpdateDeviceStatusResponse.fromJson(Map<String, dynamic> _) {
    return UpdateDeviceStatusResponse();
  }
}

class UpdateGroupResponse {
  /// The group object for the group.
  final GroupType? group;

  UpdateGroupResponse({
    this.group,
  });
  factory UpdateGroupResponse.fromJson(Map<String, dynamic> json) {
    return UpdateGroupResponse(
      group: json['Group'] != null
          ? GroupType.fromJson(json['Group'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UpdateIdentityProviderResponse {
  /// The IdP object.
  final IdentityProviderType identityProvider;

  UpdateIdentityProviderResponse({
    required this.identityProvider,
  });
  factory UpdateIdentityProviderResponse.fromJson(Map<String, dynamic> json) {
    return UpdateIdentityProviderResponse(
      identityProvider: IdentityProviderType.fromJson(
          json['IdentityProvider'] as Map<String, dynamic>),
    );
  }
}

class UpdateResourceServerResponse {
  /// The resource server.
  final ResourceServerType resourceServer;

  UpdateResourceServerResponse({
    required this.resourceServer,
  });
  factory UpdateResourceServerResponse.fromJson(Map<String, dynamic> json) {
    return UpdateResourceServerResponse(
      resourceServer: ResourceServerType.fromJson(
          json['ResourceServer'] as Map<String, dynamic>),
    );
  }
}

/// Represents the response from the server for the request to update user
/// attributes.
class UpdateUserAttributesResponse {
  /// The code delivery details list from the server for the request to update
  /// user attributes.
  final List<CodeDeliveryDetailsType>? codeDeliveryDetailsList;

  UpdateUserAttributesResponse({
    this.codeDeliveryDetailsList,
  });
  factory UpdateUserAttributesResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserAttributesResponse(
      codeDeliveryDetailsList: (json['CodeDeliveryDetailsList'] as List?)
          ?.whereNotNull()
          .map((e) =>
              CodeDeliveryDetailsType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Represents the response from the server to the request to update the user
/// pool client.
class UpdateUserPoolClientResponse {
  /// The user pool client value from the response from the server when you
  /// request to update the user pool client.
  final UserPoolClientType? userPoolClient;

  UpdateUserPoolClientResponse({
    this.userPoolClient,
  });
  factory UpdateUserPoolClientResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserPoolClientResponse(
      userPoolClient: json['UserPoolClient'] != null
          ? UserPoolClientType.fromJson(
              json['UserPoolClient'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// The UpdateUserPoolDomain response output.
class UpdateUserPoolDomainResponse {
  /// The Amazon CloudFront endpoint that Amazon Cognito set up when you added the
  /// custom domain to your user pool.
  final String? cloudFrontDomain;

  UpdateUserPoolDomainResponse({
    this.cloudFrontDomain,
  });
  factory UpdateUserPoolDomainResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserPoolDomainResponse(
      cloudFrontDomain: json['CloudFrontDomain'] as String?,
    );
  }
}

/// Represents the response from the server when you make a request to update
/// the user pool.
class UpdateUserPoolResponse {
  UpdateUserPoolResponse();
  factory UpdateUserPoolResponse.fromJson(Map<String, dynamic> _) {
    return UpdateUserPoolResponse();
  }
}

/// The settings for updates to user attributes. These settings include the
/// property <code>AttributesRequireVerificationBeforeUpdate</code>, a user-pool
/// setting that tells Amazon Cognito how to handle changes to the value of your
/// users' email address and phone number attributes. For more information, see
/// <a
/// href="https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-email-phone-verification.html#user-pool-settings-verifications-verify-attribute-updates">
/// Verifying updates to email addresses and phone numbers</a>.
class UserAttributeUpdateSettingsType {
  /// Requires that your user verifies their email address, phone number, or both
  /// before Amazon Cognito updates the value of that attribute. When you update a
  /// user attribute that has this option activated, Amazon Cognito sends a
  /// verification message to the new phone number or email address. Amazon
  /// Cognito doesn’t change the value of the attribute until your user responds
  /// to the verification message and confirms the new value.
  ///
  /// You can verify an updated email address or phone number with a <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_VerifyUserAttribute.html">VerifyUserAttribute</a>
  /// API request. You can also call the <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_UpdateUserAttributes.html">UpdateUserAttributes</a>
  /// or <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AdminUpdateUserAttributes.html">AdminUpdateUserAttributes</a>
  /// API and set <code>email_verified</code> or
  /// <code>phone_number_verified</code> to true.
  ///
  /// When <code>AttributesRequireVerificationBeforeUpdate</code> is false, your
  /// user pool doesn't require that your users verify attribute changes before
  /// Amazon Cognito updates them. In a user pool where
  /// <code>AttributesRequireVerificationBeforeUpdate</code> is false, API
  /// operations that change attribute values can immediately update a user’s
  /// <code>email</code> or <code>phone_number</code> attribute.
  final List<VerifiedAttributeType>? attributesRequireVerificationBeforeUpdate;

  UserAttributeUpdateSettingsType({
    this.attributesRequireVerificationBeforeUpdate,
  });
  factory UserAttributeUpdateSettingsType.fromJson(Map<String, dynamic> json) {
    return UserAttributeUpdateSettingsType(
      attributesRequireVerificationBeforeUpdate:
          (json['AttributesRequireVerificationBeforeUpdate'] as List?)
              ?.whereNotNull()
              .map((e) => (e as String).toVerifiedAttributeType())
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final attributesRequireVerificationBeforeUpdate =
        this.attributesRequireVerificationBeforeUpdate;
    return {
      if (attributesRequireVerificationBeforeUpdate != null)
        'AttributesRequireVerificationBeforeUpdate':
            attributesRequireVerificationBeforeUpdate
                .map((e) => e.toValue())
                .toList(),
    };
  }
}

/// Contextual data, such as the user's device fingerprint, IP address, or
/// location, used for evaluating the risk of an unexpected event by Amazon
/// Cognito advanced security.
class UserContextDataType {
  /// Encoded device-fingerprint details that your app collected with the Amazon
  /// Cognito context data collection library. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-adaptive-authentication.html#user-pool-settings-adaptive-authentication-device-fingerprint">Adding
  /// user device and session data to API requests</a>.
  final String? encodedData;

  /// The source IP address of your user's device.
  final String? ipAddress;

  UserContextDataType({
    this.encodedData,
    this.ipAddress,
  });
  Map<String, dynamic> toJson() {
    final encodedData = this.encodedData;
    final ipAddress = this.ipAddress;
    return {
      if (encodedData != null) 'EncodedData': encodedData,
      if (ipAddress != null) 'IpAddress': ipAddress,
    };
  }
}

enum UserImportJobStatusType {
  created,
  pending,
  inProgress,
  stopping,
  expired,
  stopped,
  failed,
  succeeded,
}

extension on UserImportJobStatusType {
  String toValue() {
    switch (this) {
      case UserImportJobStatusType.created:
        return 'Created';
      case UserImportJobStatusType.pending:
        return 'Pending';
      case UserImportJobStatusType.inProgress:
        return 'InProgress';
      case UserImportJobStatusType.stopping:
        return 'Stopping';
      case UserImportJobStatusType.expired:
        return 'Expired';
      case UserImportJobStatusType.stopped:
        return 'Stopped';
      case UserImportJobStatusType.failed:
        return 'Failed';
      case UserImportJobStatusType.succeeded:
        return 'Succeeded';
    }
  }
}

extension on String {
  UserImportJobStatusType toUserImportJobStatusType() {
    switch (this) {
      case 'Created':
        return UserImportJobStatusType.created;
      case 'Pending':
        return UserImportJobStatusType.pending;
      case 'InProgress':
        return UserImportJobStatusType.inProgress;
      case 'Stopping':
        return UserImportJobStatusType.stopping;
      case 'Expired':
        return UserImportJobStatusType.expired;
      case 'Stopped':
        return UserImportJobStatusType.stopped;
      case 'Failed':
        return UserImportJobStatusType.failed;
      case 'Succeeded':
        return UserImportJobStatusType.succeeded;
    }
    throw Exception('$this is not known in enum UserImportJobStatusType');
  }
}

/// The user import job type.
class UserImportJobType {
  /// The role Amazon Resource Name (ARN) for the Amazon CloudWatch Logging role
  /// for the user import job. For more information, see "Creating the CloudWatch
  /// Logs IAM Role" in the Amazon Cognito Developer Guide.
  final String? cloudWatchLogsRoleArn;

  /// The date when the user import job was completed.
  final DateTime? completionDate;

  /// The message returned when the user import job is completed.
  final String? completionMessage;

  /// The date the user import job was created.
  final DateTime? creationDate;

  /// The number of users that couldn't be imported.
  final int? failedUsers;

  /// The number of users that were successfully imported.
  final int? importedUsers;

  /// The job ID for the user import job.
  final String? jobId;

  /// The job name for the user import job.
  final String? jobName;

  /// The pre-signed URL to be used to upload the <code>.csv</code> file.
  final String? preSignedUrl;

  /// The number of users that were skipped.
  final int? skippedUsers;

  /// The date when the user import job was started.
  final DateTime? startDate;

  /// The status of the user import job. One of the following:
  ///
  /// <ul>
  /// <li>
  /// <code>Created</code> - The job was created but not started.
  /// </li>
  /// <li>
  /// <code>Pending</code> - A transition state. You have started the job, but it
  /// has not begun importing users yet.
  /// </li>
  /// <li>
  /// <code>InProgress</code> - The job has started, and users are being imported.
  /// </li>
  /// <li>
  /// <code>Stopping</code> - You have stopped the job, but the job has not
  /// stopped importing users yet.
  /// </li>
  /// <li>
  /// <code>Stopped</code> - You have stopped the job, and the job has stopped
  /// importing users.
  /// </li>
  /// <li>
  /// <code>Succeeded</code> - The job has completed successfully.
  /// </li>
  /// <li>
  /// <code>Failed</code> - The job has stopped due to an error.
  /// </li>
  /// <li>
  /// <code>Expired</code> - You created a job, but did not start the job within
  /// 24-48 hours. All data associated with the job was deleted, and the job can't
  /// be started.
  /// </li>
  /// </ul>
  final UserImportJobStatusType? status;

  /// The user pool ID for the user pool that the users are being imported into.
  final String? userPoolId;

  UserImportJobType({
    this.cloudWatchLogsRoleArn,
    this.completionDate,
    this.completionMessage,
    this.creationDate,
    this.failedUsers,
    this.importedUsers,
    this.jobId,
    this.jobName,
    this.preSignedUrl,
    this.skippedUsers,
    this.startDate,
    this.status,
    this.userPoolId,
  });
  factory UserImportJobType.fromJson(Map<String, dynamic> json) {
    return UserImportJobType(
      cloudWatchLogsRoleArn: json['CloudWatchLogsRoleArn'] as String?,
      completionDate: timeStampFromJson(json['CompletionDate']),
      completionMessage: json['CompletionMessage'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
      failedUsers: json['FailedUsers'] as int?,
      importedUsers: json['ImportedUsers'] as int?,
      jobId: json['JobId'] as String?,
      jobName: json['JobName'] as String?,
      preSignedUrl: json['PreSignedUrl'] as String?,
      skippedUsers: json['SkippedUsers'] as int?,
      startDate: timeStampFromJson(json['StartDate']),
      status: (json['Status'] as String?)?.toUserImportJobStatusType(),
      userPoolId: json['UserPoolId'] as String?,
    );
  }
}

/// The user pool add-ons type.
class UserPoolAddOnsType {
  /// The advanced security mode.
  final AdvancedSecurityModeType advancedSecurityMode;

  UserPoolAddOnsType({
    required this.advancedSecurityMode,
  });
  factory UserPoolAddOnsType.fromJson(Map<String, dynamic> json) {
    return UserPoolAddOnsType(
      advancedSecurityMode:
          (json['AdvancedSecurityMode'] as String).toAdvancedSecurityModeType(),
    );
  }

  Map<String, dynamic> toJson() {
    final advancedSecurityMode = this.advancedSecurityMode;
    return {
      'AdvancedSecurityMode': advancedSecurityMode.toValue(),
    };
  }
}

/// The description of the user pool client.
class UserPoolClientDescription {
  /// The ID of the client associated with the user pool.
  final String? clientId;

  /// The client name from the user pool client description.
  final String? clientName;

  /// The user pool ID for the user pool where you want to describe the user pool
  /// client.
  final String? userPoolId;

  UserPoolClientDescription({
    this.clientId,
    this.clientName,
    this.userPoolId,
  });
  factory UserPoolClientDescription.fromJson(Map<String, dynamic> json) {
    return UserPoolClientDescription(
      clientId: json['ClientId'] as String?,
      clientName: json['ClientName'] as String?,
      userPoolId: json['UserPoolId'] as String?,
    );
  }
}

/// Contains information about a user pool client.
class UserPoolClientType {
  /// The access token time limit. After this limit expires, your user can't use
  /// their access token. To specify the time unit for
  /// <code>AccessTokenValidity</code> as <code>seconds</code>,
  /// <code>minutes</code>, <code>hours</code>, or <code>days</code>, set a
  /// <code>TokenValidityUnits</code> value in your API request.
  ///
  /// For example, when you set <code>AccessTokenValidity</code> to
  /// <code>10</code> and <code>TokenValidityUnits</code> to <code>hours</code>,
  /// your user can authorize access with their access token for 10 hours.
  ///
  /// The default time unit for <code>AccessTokenValidity</code> in an API request
  /// is hours. <i>Valid range</i> is displayed below in seconds.
  final int? accessTokenValidity;

  /// The allowed OAuth flows.
  /// <dl> <dt>code</dt> <dd>
  /// Use a code grant flow, which provides an authorization code as the response.
  /// This code can be exchanged for access tokens with the
  /// <code>/oauth2/token</code> endpoint.
  /// </dd> <dt>implicit</dt> <dd>
  /// Issue the access token (and, optionally, ID token, based on scopes) directly
  /// to your user.
  /// </dd> <dt>client_credentials</dt> <dd>
  /// Issue the access token from the <code>/oauth2/token</code> endpoint directly
  /// to a non-person user using a combination of the client ID and client secret.
  /// </dd> </dl>
  final List<OAuthFlowType>? allowedOAuthFlows;

  /// Set to true if the client is allowed to follow the OAuth protocol when
  /// interacting with Amazon Cognito user pools.
  final bool? allowedOAuthFlowsUserPoolClient;

  /// The OAuth scopes that your app client supports. Possible values that OAuth
  /// provides are <code>phone</code>, <code>email</code>, <code>openid</code>,
  /// and <code>profile</code>. Possible values that Amazon Web Services provides
  /// are <code>aws.cognito.signin.user.admin</code>. Amazon Cognito also supports
  /// custom scopes that you create in Resource Servers.
  final List<String>? allowedOAuthScopes;

  /// The Amazon Pinpoint analytics configuration for the user pool client.
  /// <note>
  /// Amazon Cognito user pools only support sending events to Amazon Pinpoint
  /// projects in the US East (N. Virginia) us-east-1 Region, regardless of the
  /// Region where the user pool resides.
  /// </note>
  final AnalyticsConfigurationType? analyticsConfiguration;

  /// A list of allowed redirect (callback) URLs for the IdPs.
  ///
  /// A redirect URI must:
  ///
  /// <ul>
  /// <li>
  /// Be an absolute URI.
  /// </li>
  /// <li>
  /// Be registered with the authorization server.
  /// </li>
  /// <li>
  /// Not include a fragment component.
  /// </li>
  /// </ul>
  /// See <a href="https://tools.ietf.org/html/rfc6749#section-3.1.2">OAuth 2.0 -
  /// Redirection Endpoint</a>.
  ///
  /// Amazon Cognito requires HTTPS over HTTP except for http://localhost for
  /// testing purposes only.
  ///
  /// App callback URLs such as myapp://example are also supported.
  final List<String>? callbackURLs;

  /// The ID of the client associated with the user pool.
  final String? clientId;

  /// The client name from the user pool request of the client type.
  final String? clientName;

  /// The client secret from the user pool request of the client type.
  final String? clientSecret;

  /// The date the user pool client was created.
  final DateTime? creationDate;

  /// The default redirect URI. Must be in the <code>CallbackURLs</code> list.
  ///
  /// A redirect URI must:
  ///
  /// <ul>
  /// <li>
  /// Be an absolute URI.
  /// </li>
  /// <li>
  /// Be registered with the authorization server.
  /// </li>
  /// <li>
  /// Not include a fragment component.
  /// </li>
  /// </ul>
  /// See <a href="https://tools.ietf.org/html/rfc6749#section-3.1.2">OAuth 2.0 -
  /// Redirection Endpoint</a>.
  ///
  /// Amazon Cognito requires HTTPS over HTTP except for http://localhost for
  /// testing purposes only.
  ///
  /// App callback URLs such as myapp://example are also supported.
  final String? defaultRedirectURI;

  /// When <code>EnablePropagateAdditionalUserContextData</code> is true, Amazon
  /// Cognito accepts an <code>IpAddress</code> value that you send in the
  /// <code>UserContextData</code> parameter. The <code>UserContextData</code>
  /// parameter sends information to Amazon Cognito advanced security for risk
  /// analysis. You can send <code>UserContextData</code> when you sign in Amazon
  /// Cognito native users with the <code>InitiateAuth</code> and
  /// <code>RespondToAuthChallenge</code> API operations.
  ///
  /// When <code>EnablePropagateAdditionalUserContextData</code> is false, you
  /// can't send your user's source IP address to Amazon Cognito advanced security
  /// with unauthenticated API operations.
  /// <code>EnablePropagateAdditionalUserContextData</code> doesn't affect whether
  /// you can send a source IP address in a <code>ContextData</code> parameter
  /// with the authenticated API operations <code>AdminInitiateAuth</code> and
  /// <code>AdminRespondToAuthChallenge</code>.
  ///
  /// You can only activate <code>EnablePropagateAdditionalUserContextData</code>
  /// in an app client that has a client secret. For more information about
  /// propagation of user context data, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-adaptive-authentication.html#user-pool-settings-adaptive-authentication-device-fingerprint">Adding
  /// user device and session data to API requests</a>.
  final bool? enablePropagateAdditionalUserContextData;

  /// Indicates whether token revocation is activated for the user pool client.
  /// When you create a new user pool client, token revocation is activated by
  /// default. For more information about revoking tokens, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_RevokeToken.html">RevokeToken</a>.
  final bool? enableTokenRevocation;

  /// The authentication flows that are supported by the user pool clients. Flow
  /// names without the <code>ALLOW_</code> prefix are no longer supported in
  /// favor of new names with the <code>ALLOW_</code> prefix. Note that values
  /// with <code>ALLOW_</code> prefix must be used only along with values
  /// including the <code>ALLOW_</code> prefix.
  ///
  /// Valid values include:
  ///
  /// <ul>
  /// <li>
  /// <code>ALLOW_ADMIN_USER_PASSWORD_AUTH</code>: Enable admin based user
  /// password authentication flow <code>ADMIN_USER_PASSWORD_AUTH</code>. This
  /// setting replaces the <code>ADMIN_NO_SRP_AUTH</code> setting. With this
  /// authentication flow, Amazon Cognito receives the password in the request
  /// instead of using the Secure Remote Password (SRP) protocol to verify
  /// passwords.
  /// </li>
  /// <li>
  /// <code>ALLOW_CUSTOM_AUTH</code>: Enable Lambda trigger based authentication.
  /// </li>
  /// <li>
  /// <code>ALLOW_USER_PASSWORD_AUTH</code>: Enable user password-based
  /// authentication. In this flow, Amazon Cognito receives the password in the
  /// request instead of using the SRP protocol to verify passwords.
  /// </li>
  /// <li>
  /// <code>ALLOW_USER_SRP_AUTH</code>: Enable SRP-based authentication.
  /// </li>
  /// <li>
  /// <code>ALLOW_REFRESH_TOKEN_AUTH</code>: Enable authflow to refresh tokens.
  /// </li>
  /// </ul>
  final List<ExplicitAuthFlowsType>? explicitAuthFlows;

  /// The ID token time limit. After this limit expires, your user can't use their
  /// ID token. To specify the time unit for <code>IdTokenValidity</code> as
  /// <code>seconds</code>, <code>minutes</code>, <code>hours</code>, or
  /// <code>days</code>, set a <code>TokenValidityUnits</code> value in your API
  /// request.
  ///
  /// For example, when you set <code>IdTokenValidity</code> as <code>10</code>
  /// and <code>TokenValidityUnits</code> as <code>hours</code>, your user can
  /// authenticate their session with their ID token for 10 hours.
  ///
  /// The default time unit for <code>AccessTokenValidity</code> in an API request
  /// is hours. <i>Valid range</i> is displayed below in seconds.
  final int? idTokenValidity;

  /// The date the user pool client was last modified.
  final DateTime? lastModifiedDate;

  /// A list of allowed logout URLs for the IdPs.
  final List<String>? logoutURLs;

  /// Errors and responses that you want Amazon Cognito APIs to return during
  /// authentication, account confirmation, and password recovery when the user
  /// doesn't exist in the user pool. When set to <code>ENABLED</code> and the
  /// user doesn't exist, authentication returns an error indicating either the
  /// username or password was incorrect. Account confirmation and password
  /// recovery return a response indicating a code was sent to a simulated
  /// destination. When set to <code>LEGACY</code>, those APIs return a
  /// <code>UserNotFoundException</code> exception if the user doesn't exist in
  /// the user pool.
  ///
  /// Valid values include:
  ///
  /// <ul>
  /// <li>
  /// <code>ENABLED</code> - This prevents user existence-related errors.
  /// </li>
  /// <li>
  /// <code>LEGACY</code> - This represents the old behavior of Amazon Cognito
  /// where user existence related errors aren't prevented.
  /// </li>
  /// </ul>
  final PreventUserExistenceErrorTypes? preventUserExistenceErrors;

  /// The Read-only attributes.
  final List<String>? readAttributes;

  /// The refresh token time limit. After this limit expires, your user can't use
  /// their refresh token. To specify the time unit for
  /// <code>RefreshTokenValidity</code> as <code>seconds</code>,
  /// <code>minutes</code>, <code>hours</code>, or <code>days</code>, set a
  /// <code>TokenValidityUnits</code> value in your API request.
  ///
  /// For example, when you set <code>RefreshTokenValidity</code> as
  /// <code>10</code> and <code>TokenValidityUnits</code> as <code>days</code>,
  /// your user can refresh their session and retrieve new access and ID tokens
  /// for 10 days.
  ///
  /// The default time unit for <code>RefreshTokenValidity</code> in an API
  /// request is days. You can't set <code>RefreshTokenValidity</code> to 0. If
  /// you do, Amazon Cognito overrides the value with the default value of 30
  /// days. <i>Valid range</i> is displayed below in seconds.
  final int? refreshTokenValidity;

  /// A list of provider names for the IdPs that this client supports. The
  /// following are supported: <code>COGNITO</code>, <code>Facebook</code>,
  /// <code>Google</code>, <code>SignInWithApple</code>,
  /// <code>LoginWithAmazon</code>, and the names of your own SAML and OIDC
  /// providers.
  final List<String>? supportedIdentityProviders;

  /// The time units used to specify the token validity times of each token type:
  /// ID, access, and refresh.
  final TokenValidityUnitsType? tokenValidityUnits;

  /// The user pool ID for the user pool client.
  final String? userPoolId;

  /// The writeable attributes.
  final List<String>? writeAttributes;

  UserPoolClientType({
    this.accessTokenValidity,
    this.allowedOAuthFlows,
    this.allowedOAuthFlowsUserPoolClient,
    this.allowedOAuthScopes,
    this.analyticsConfiguration,
    this.callbackURLs,
    this.clientId,
    this.clientName,
    this.clientSecret,
    this.creationDate,
    this.defaultRedirectURI,
    this.enablePropagateAdditionalUserContextData,
    this.enableTokenRevocation,
    this.explicitAuthFlows,
    this.idTokenValidity,
    this.lastModifiedDate,
    this.logoutURLs,
    this.preventUserExistenceErrors,
    this.readAttributes,
    this.refreshTokenValidity,
    this.supportedIdentityProviders,
    this.tokenValidityUnits,
    this.userPoolId,
    this.writeAttributes,
  });
  factory UserPoolClientType.fromJson(Map<String, dynamic> json) {
    return UserPoolClientType(
      accessTokenValidity: json['AccessTokenValidity'] as int?,
      allowedOAuthFlows: (json['AllowedOAuthFlows'] as List?)
          ?.whereNotNull()
          .map((e) => (e as String).toOAuthFlowType())
          .toList(),
      allowedOAuthFlowsUserPoolClient:
          json['AllowedOAuthFlowsUserPoolClient'] as bool?,
      allowedOAuthScopes: (json['AllowedOAuthScopes'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      analyticsConfiguration: json['AnalyticsConfiguration'] != null
          ? AnalyticsConfigurationType.fromJson(
              json['AnalyticsConfiguration'] as Map<String, dynamic>)
          : null,
      callbackURLs: (json['CallbackURLs'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      clientId: json['ClientId'] as String?,
      clientName: json['ClientName'] as String?,
      clientSecret: json['ClientSecret'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
      defaultRedirectURI: json['DefaultRedirectURI'] as String?,
      enablePropagateAdditionalUserContextData:
          json['EnablePropagateAdditionalUserContextData'] as bool?,
      enableTokenRevocation: json['EnableTokenRevocation'] as bool?,
      explicitAuthFlows: (json['ExplicitAuthFlows'] as List?)
          ?.whereNotNull()
          .map((e) => (e as String).toExplicitAuthFlowsType())
          .toList(),
      idTokenValidity: json['IdTokenValidity'] as int?,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      logoutURLs: (json['LogoutURLs'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      preventUserExistenceErrors:
          (json['PreventUserExistenceErrors'] as String?)
              ?.toPreventUserExistenceErrorTypes(),
      readAttributes: (json['ReadAttributes'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      refreshTokenValidity: json['RefreshTokenValidity'] as int?,
      supportedIdentityProviders: (json['SupportedIdentityProviders'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      tokenValidityUnits: json['TokenValidityUnits'] != null
          ? TokenValidityUnitsType.fromJson(
              json['TokenValidityUnits'] as Map<String, dynamic>)
          : null,
      userPoolId: json['UserPoolId'] as String?,
      writeAttributes: (json['WriteAttributes'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }
}

/// A user pool description.
class UserPoolDescriptionType {
  /// The date the user pool description was created.
  final DateTime? creationDate;

  /// The ID in a user pool description.
  final String? id;

  /// The Lambda configuration information in a user pool description.
  final LambdaConfigType? lambdaConfig;

  /// The date the user pool description was last modified.
  final DateTime? lastModifiedDate;

  /// The name in a user pool description.
  final String? name;

  /// The user pool status in a user pool description.
  final StatusType? status;

  UserPoolDescriptionType({
    this.creationDate,
    this.id,
    this.lambdaConfig,
    this.lastModifiedDate,
    this.name,
    this.status,
  });
  factory UserPoolDescriptionType.fromJson(Map<String, dynamic> json) {
    return UserPoolDescriptionType(
      creationDate: timeStampFromJson(json['CreationDate']),
      id: json['Id'] as String?,
      lambdaConfig: json['LambdaConfig'] != null
          ? LambdaConfigType.fromJson(
              json['LambdaConfig'] as Map<String, dynamic>)
          : null,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      name: json['Name'] as String?,
      status: (json['Status'] as String?)?.toStatusType(),
    );
  }
}

enum UserPoolMfaType {
  off,
  on,
  optional,
}

extension on UserPoolMfaType {
  String toValue() {
    switch (this) {
      case UserPoolMfaType.off:
        return 'OFF';
      case UserPoolMfaType.on:
        return 'ON';
      case UserPoolMfaType.optional:
        return 'OPTIONAL';
    }
  }
}

extension on String {
  UserPoolMfaType toUserPoolMfaType() {
    switch (this) {
      case 'OFF':
        return UserPoolMfaType.off;
      case 'ON':
        return UserPoolMfaType.on;
      case 'OPTIONAL':
        return UserPoolMfaType.optional;
    }
    throw Exception('$this is not known in enum UserPoolMfaType');
  }
}

/// The policy associated with a user pool.
class UserPoolPolicyType {
  /// The password policy.
  final PasswordPolicyType? passwordPolicy;

  UserPoolPolicyType({
    this.passwordPolicy,
  });
  factory UserPoolPolicyType.fromJson(Map<String, dynamic> json) {
    return UserPoolPolicyType(
      passwordPolicy: json['PasswordPolicy'] != null
          ? PasswordPolicyType.fromJson(
              json['PasswordPolicy'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final passwordPolicy = this.passwordPolicy;
    return {
      if (passwordPolicy != null) 'PasswordPolicy': passwordPolicy,
    };
  }
}

/// A container for information about the user pool.
class UserPoolType {
  /// The available verified method a user can use to recover their password when
  /// they call <code>ForgotPassword</code>. You can use this setting to define a
  /// preferred method when a user has more than one method available. With this
  /// setting, SMS doesn't qualify for a valid password recovery mechanism if the
  /// user also has SMS multi-factor authentication (MFA) activated. In the
  /// absence of this setting, Amazon Cognito uses the legacy behavior to
  /// determine the recovery method where SMS is preferred through email.
  final AccountRecoverySettingType? accountRecoverySetting;

  /// The configuration for <code>AdminCreateUser</code> requests.
  final AdminCreateUserConfigType? adminCreateUserConfig;

  /// The attributes that are aliased in a user pool.
  final List<AliasAttributeType>? aliasAttributes;

  /// The Amazon Resource Name (ARN) for the user pool.
  final String? arn;

  /// The attributes that are auto-verified in a user pool.
  final List<VerifiedAttributeType>? autoVerifiedAttributes;

  /// The date the user pool was created.
  final DateTime? creationDate;

  /// A custom domain name that you provide to Amazon Cognito. This parameter
  /// applies only if you use a custom domain to host the sign-up and sign-in
  /// pages for your application. An example of a custom domain name might be
  /// <code>auth.example.com</code>.
  ///
  /// For more information about adding a custom domain to your user pool, see <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-add-custom-domain.html">Using
  /// Your Own Domain for the Hosted UI</a>.
  final String? customDomain;

  /// The device-remembering configuration for a user pool. A null value indicates
  /// that you have deactivated device remembering in your user pool.
  /// <note>
  /// When you provide a value for any <code>DeviceConfiguration</code> field, you
  /// activate the Amazon Cognito device-remembering feature.
  /// </note>
  final DeviceConfigurationType? deviceConfiguration;

  /// The domain prefix, if the user pool has a domain associated with it.
  final String? domain;

  /// The email configuration of your user pool. The email configuration type sets
  /// your preferred sending method, Amazon Web Services Region, and sender for
  /// messages tfrom your user pool.
  final EmailConfigurationType? emailConfiguration;

  /// Deprecated. Review error codes from API requests with
  /// <code>EventSource:cognito-idp.amazonaws.com</code> in CloudTrail for
  /// information about problems with user pool email configuration.
  final String? emailConfigurationFailure;

  /// The contents of the email verification message.
  final String? emailVerificationMessage;

  /// The subject of the email verification message.
  final String? emailVerificationSubject;

  /// A number estimating the size of the user pool.
  final int? estimatedNumberOfUsers;

  /// The ID of the user pool.
  final String? id;

  /// The Lambda triggers associated with the user pool.
  final LambdaConfigType? lambdaConfig;

  /// The date the user pool was last modified.
  final DateTime? lastModifiedDate;

  /// Can be one of the following values:
  ///
  /// <ul>
  /// <li>
  /// <code>OFF</code> - MFA tokens aren't required and can't be specified during
  /// user registration.
  /// </li>
  /// <li>
  /// <code>ON</code> - MFA tokens are required for all user registrations. You
  /// can only specify required when you're initially creating a user pool.
  /// </li>
  /// <li>
  /// <code>OPTIONAL</code> - Users have the option when registering to create an
  /// MFA token.
  /// </li>
  /// </ul>
  final UserPoolMfaType? mfaConfiguration;

  /// The name of the user pool.
  final String? name;

  /// The policies associated with the user pool.
  final UserPoolPolicyType? policies;

  /// A container with the schema attributes of a user pool.
  final List<SchemaAttributeType>? schemaAttributes;

  /// The contents of the SMS authentication message.
  final String? smsAuthenticationMessage;

  /// The SMS configuration with the settings that your Amazon Cognito user pool
  /// must use to send an SMS message from your Amazon Web Services account
  /// through Amazon Simple Notification Service. To send SMS messages with Amazon
  /// SNS in the Amazon Web Services Region that you want, the Amazon Cognito user
  /// pool uses an Identity and Access Management (IAM) role in your Amazon Web
  /// Services account.
  final SmsConfigurationType? smsConfiguration;

  /// The reason why the SMS configuration can't send the messages to your users.
  ///
  /// This message might include comma-separated values to describe why your SMS
  /// configuration can't send messages to user pool end users.
  /// <dl> <dt>InvalidSmsRoleAccessPolicyException</dt> <dd>
  /// The Identity and Access Management role that Amazon Cognito uses to send SMS
  /// messages isn't properly configured. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_SmsConfigurationType.html">SmsConfigurationType</a>.
  /// </dd> <dt>SNSSandbox</dt> <dd>
  /// The Amazon Web Services account is in the SNS SMS Sandbox and messages will
  /// only reach verified end users. This parameter won’t get populated with
  /// SNSSandbox if the IAM user creating the user pool doesn’t have SNS
  /// permissions. To learn how to move your Amazon Web Services account out of
  /// the sandbox, see <a
  /// href="https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox-moving-to-production.html">Moving
  /// out of the SMS sandbox</a>.
  /// </dd> </dl>
  final String? smsConfigurationFailure;

  /// The contents of the SMS verification message.
  final String? smsVerificationMessage;

  /// The status of a user pool.
  final StatusType? status;

  /// The settings for updates to user attributes. These settings include the
  /// property <code>AttributesRequireVerificationBeforeUpdate</code>, a user-pool
  /// setting that tells Amazon Cognito how to handle changes to the value of your
  /// users' email address and phone number attributes. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-email-phone-verification.html#user-pool-settings-verifications-verify-attribute-updates">
  /// Verifying updates to email addresses and phone numbers</a>.
  final UserAttributeUpdateSettingsType? userAttributeUpdateSettings;

  /// The user pool add-ons.
  final UserPoolAddOnsType? userPoolAddOns;

  /// The tags that are assigned to the user pool. A tag is a label that you can
  /// apply to user pools to categorize and manage them in different ways, such as
  /// by purpose, owner, environment, or other criteria.
  final Map<String, String>? userPoolTags;

  /// Specifies whether a user can use an email address or phone number as a
  /// username when they sign up.
  final List<UsernameAttributeType>? usernameAttributes;

  /// Case sensitivity of the username input for the selected sign-in option. For
  /// example, when case sensitivity is set to <code>False</code>, users can sign
  /// in using either "username" or "Username". This configuration is immutable
  /// once it has been set. For more information, see <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_UsernameConfigurationType.html">UsernameConfigurationType</a>.
  final UsernameConfigurationType? usernameConfiguration;

  /// The template for verification messages.
  final VerificationMessageTemplateType? verificationMessageTemplate;

  UserPoolType({
    this.accountRecoverySetting,
    this.adminCreateUserConfig,
    this.aliasAttributes,
    this.arn,
    this.autoVerifiedAttributes,
    this.creationDate,
    this.customDomain,
    this.deviceConfiguration,
    this.domain,
    this.emailConfiguration,
    this.emailConfigurationFailure,
    this.emailVerificationMessage,
    this.emailVerificationSubject,
    this.estimatedNumberOfUsers,
    this.id,
    this.lambdaConfig,
    this.lastModifiedDate,
    this.mfaConfiguration,
    this.name,
    this.policies,
    this.schemaAttributes,
    this.smsAuthenticationMessage,
    this.smsConfiguration,
    this.smsConfigurationFailure,
    this.smsVerificationMessage,
    this.status,
    this.userAttributeUpdateSettings,
    this.userPoolAddOns,
    this.userPoolTags,
    this.usernameAttributes,
    this.usernameConfiguration,
    this.verificationMessageTemplate,
  });
  factory UserPoolType.fromJson(Map<String, dynamic> json) {
    return UserPoolType(
      accountRecoverySetting: json['AccountRecoverySetting'] != null
          ? AccountRecoverySettingType.fromJson(
              json['AccountRecoverySetting'] as Map<String, dynamic>)
          : null,
      adminCreateUserConfig: json['AdminCreateUserConfig'] != null
          ? AdminCreateUserConfigType.fromJson(
              json['AdminCreateUserConfig'] as Map<String, dynamic>)
          : null,
      aliasAttributes: (json['AliasAttributes'] as List?)
          ?.whereNotNull()
          .map((e) => (e as String).toAliasAttributeType())
          .toList(),
      arn: json['Arn'] as String?,
      autoVerifiedAttributes: (json['AutoVerifiedAttributes'] as List?)
          ?.whereNotNull()
          .map((e) => (e as String).toVerifiedAttributeType())
          .toList(),
      creationDate: timeStampFromJson(json['CreationDate']),
      customDomain: json['CustomDomain'] as String?,
      deviceConfiguration: json['DeviceConfiguration'] != null
          ? DeviceConfigurationType.fromJson(
              json['DeviceConfiguration'] as Map<String, dynamic>)
          : null,
      domain: json['Domain'] as String?,
      emailConfiguration: json['EmailConfiguration'] != null
          ? EmailConfigurationType.fromJson(
              json['EmailConfiguration'] as Map<String, dynamic>)
          : null,
      emailConfigurationFailure: json['EmailConfigurationFailure'] as String?,
      emailVerificationMessage: json['EmailVerificationMessage'] as String?,
      emailVerificationSubject: json['EmailVerificationSubject'] as String?,
      estimatedNumberOfUsers: json['EstimatedNumberOfUsers'] as int?,
      id: json['Id'] as String?,
      lambdaConfig: json['LambdaConfig'] != null
          ? LambdaConfigType.fromJson(
              json['LambdaConfig'] as Map<String, dynamic>)
          : null,
      lastModifiedDate: timeStampFromJson(json['LastModifiedDate']),
      mfaConfiguration:
          (json['MfaConfiguration'] as String?)?.toUserPoolMfaType(),
      name: json['Name'] as String?,
      policies: json['Policies'] != null
          ? UserPoolPolicyType.fromJson(
              json['Policies'] as Map<String, dynamic>)
          : null,
      schemaAttributes: (json['SchemaAttributes'] as List?)
          ?.whereNotNull()
          .map((e) => SchemaAttributeType.fromJson(e as Map<String, dynamic>))
          .toList(),
      smsAuthenticationMessage: json['SmsAuthenticationMessage'] as String?,
      smsConfiguration: json['SmsConfiguration'] != null
          ? SmsConfigurationType.fromJson(
              json['SmsConfiguration'] as Map<String, dynamic>)
          : null,
      smsConfigurationFailure: json['SmsConfigurationFailure'] as String?,
      smsVerificationMessage: json['SmsVerificationMessage'] as String?,
      status: (json['Status'] as String?)?.toStatusType(),
      userAttributeUpdateSettings: json['UserAttributeUpdateSettings'] != null
          ? UserAttributeUpdateSettingsType.fromJson(
              json['UserAttributeUpdateSettings'] as Map<String, dynamic>)
          : null,
      userPoolAddOns: json['UserPoolAddOns'] != null
          ? UserPoolAddOnsType.fromJson(
              json['UserPoolAddOns'] as Map<String, dynamic>)
          : null,
      userPoolTags: (json['UserPoolTags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      usernameAttributes: (json['UsernameAttributes'] as List?)
          ?.whereNotNull()
          .map((e) => (e as String).toUsernameAttributeType())
          .toList(),
      usernameConfiguration: json['UsernameConfiguration'] != null
          ? UsernameConfigurationType.fromJson(
              json['UsernameConfiguration'] as Map<String, dynamic>)
          : null,
      verificationMessageTemplate: json['VerificationMessageTemplate'] != null
          ? VerificationMessageTemplateType.fromJson(
              json['VerificationMessageTemplate'] as Map<String, dynamic>)
          : null,
    );
  }
}

enum UserStatusType {
  unconfirmed,
  confirmed,
  archived,
  compromised,
  unknown,
  resetRequired,
  forceChangePassword,
}

extension on UserStatusType {
  String toValue() {
    switch (this) {
      case UserStatusType.unconfirmed:
        return 'UNCONFIRMED';
      case UserStatusType.confirmed:
        return 'CONFIRMED';
      case UserStatusType.archived:
        return 'ARCHIVED';
      case UserStatusType.compromised:
        return 'COMPROMISED';
      case UserStatusType.unknown:
        return 'UNKNOWN';
      case UserStatusType.resetRequired:
        return 'RESET_REQUIRED';
      case UserStatusType.forceChangePassword:
        return 'FORCE_CHANGE_PASSWORD';
    }
  }
}

extension on String {
  UserStatusType toUserStatusType() {
    switch (this) {
      case 'UNCONFIRMED':
        return UserStatusType.unconfirmed;
      case 'CONFIRMED':
        return UserStatusType.confirmed;
      case 'ARCHIVED':
        return UserStatusType.archived;
      case 'COMPROMISED':
        return UserStatusType.compromised;
      case 'UNKNOWN':
        return UserStatusType.unknown;
      case 'RESET_REQUIRED':
        return UserStatusType.resetRequired;
      case 'FORCE_CHANGE_PASSWORD':
        return UserStatusType.forceChangePassword;
    }
    throw Exception('$this is not known in enum UserStatusType');
  }
}

/// A user profile in a Amazon Cognito user pool.
class UserType {
  /// A container with information about the user type attributes.
  final List<AttributeType>? attributes;

  /// Specifies whether the user is enabled.
  final bool? enabled;

  /// The MFA options for the user.
  final List<MFAOptionType>? mFAOptions;

  /// The creation date of the user.
  final DateTime? userCreateDate;

  /// The last modified date of the user.
  final DateTime? userLastModifiedDate;

  /// The user status. This can be one of the following:
  ///
  /// <ul>
  /// <li>
  /// UNCONFIRMED - User has been created but not confirmed.
  /// </li>
  /// <li>
  /// CONFIRMED - User has been confirmed.
  /// </li>
  /// <li>
  /// EXTERNAL_PROVIDER - User signed in with a third-party IdP.
  /// </li>
  /// <li>
  /// ARCHIVED - User is no longer active.
  /// </li>
  /// <li>
  /// UNKNOWN - User status isn't known.
  /// </li>
  /// <li>
  /// RESET_REQUIRED - User is confirmed, but the user must request a code and
  /// reset their password before they can sign in.
  /// </li>
  /// <li>
  /// FORCE_CHANGE_PASSWORD - The user is confirmed and the user can sign in using
  /// a temporary password, but on first sign-in, the user must change their
  /// password to a new value before doing anything else.
  /// </li>
  /// </ul>
  final UserStatusType? userStatus;

  /// The user name of the user you want to describe.
  final String? username;

  UserType({
    this.attributes,
    this.enabled,
    this.mFAOptions,
    this.userCreateDate,
    this.userLastModifiedDate,
    this.userStatus,
    this.username,
  });
  factory UserType.fromJson(Map<String, dynamic> json) {
    return UserType(
      attributes: (json['Attributes'] as List?)
          ?.whereNotNull()
          .map((e) => AttributeType.fromJson(e as Map<String, dynamic>))
          .toList(),
      enabled: json['Enabled'] as bool?,
      mFAOptions: (json['MFAOptions'] as List?)
          ?.whereNotNull()
          .map((e) => MFAOptionType.fromJson(e as Map<String, dynamic>))
          .toList(),
      userCreateDate: timeStampFromJson(json['UserCreateDate']),
      userLastModifiedDate: timeStampFromJson(json['UserLastModifiedDate']),
      userStatus: (json['UserStatus'] as String?)?.toUserStatusType(),
      username: json['Username'] as String?,
    );
  }
}

enum UsernameAttributeType {
  phoneNumber,
  email,
}

extension on UsernameAttributeType {
  String toValue() {
    switch (this) {
      case UsernameAttributeType.phoneNumber:
        return 'phone_number';
      case UsernameAttributeType.email:
        return 'email';
    }
  }
}

extension on String {
  UsernameAttributeType toUsernameAttributeType() {
    switch (this) {
      case 'phone_number':
        return UsernameAttributeType.phoneNumber;
      case 'email':
        return UsernameAttributeType.email;
    }
    throw Exception('$this is not known in enum UsernameAttributeType');
  }
}

/// The username configuration type.
class UsernameConfigurationType {
  /// Specifies whether user name case sensitivity will be applied for all users
  /// in the user pool through Amazon Cognito APIs.
  ///
  /// Valid values include:
  /// <dl> <dt>True</dt> <dd>
  /// Enables case sensitivity for all username input. When this option is set to
  /// <code>True</code>, users must sign in using the exact capitalization of
  /// their given username, such as “UserName”. This is the default value.
  /// </dd> <dt>False</dt> <dd>
  /// Enables case insensitivity for all username input. For example, when this
  /// option is set to <code>False</code>, users can sign in using either
  /// "username" or "Username". This option also enables both
  /// <code>preferred_username</code> and <code>email</code> alias to be case
  /// insensitive, in addition to the <code>username</code> attribute.
  /// </dd> </dl>
  final bool caseSensitive;

  UsernameConfigurationType({
    required this.caseSensitive,
  });
  factory UsernameConfigurationType.fromJson(Map<String, dynamic> json) {
    return UsernameConfigurationType(
      caseSensitive: json['CaseSensitive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    final caseSensitive = this.caseSensitive;
    return {
      'CaseSensitive': caseSensitive,
    };
  }
}

/// The template for verification messages.
class VerificationMessageTemplateType {
  /// The default email option.
  final DefaultEmailOptionType? defaultEmailOption;

  /// The template for email messages that Amazon Cognito sends to your users. You
  /// can set an <code>EmailMessage</code> template only if the value of <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount">
  /// EmailSendingAccount</a> is <code>DEVELOPER</code>. When your <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount">EmailSendingAccount</a>
  /// is <code>DEVELOPER</code>, your user pool sends email messages with your own
  /// Amazon SES configuration.
  final String? emailMessage;

  /// The email message template for sending a confirmation link to the user. You
  /// can set an <code>EmailMessageByLink</code> template only if the value of <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount">
  /// EmailSendingAccount</a> is <code>DEVELOPER</code>. When your <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount">EmailSendingAccount</a>
  /// is <code>DEVELOPER</code>, your user pool sends email messages with your own
  /// Amazon SES configuration.
  final String? emailMessageByLink;

  /// The subject line for the email message template. You can set an
  /// <code>EmailSubject</code> template only if the value of <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount">
  /// EmailSendingAccount</a> is <code>DEVELOPER</code>. When your <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount">EmailSendingAccount</a>
  /// is <code>DEVELOPER</code>, your user pool sends email messages with your own
  /// Amazon SES configuration.
  final String? emailSubject;

  /// The subject line for the email message template for sending a confirmation
  /// link to the user. You can set an <code>EmailSubjectByLink</code> template
  /// only if the value of <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount">
  /// EmailSendingAccount</a> is <code>DEVELOPER</code>. When your <a
  /// href="https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_EmailConfigurationType.html#CognitoUserPools-Type-EmailConfigurationType-EmailSendingAccount">EmailSendingAccount</a>
  /// is <code>DEVELOPER</code>, your user pool sends email messages with your own
  /// Amazon SES configuration.
  final String? emailSubjectByLink;

  /// The template for SMS messages that Amazon Cognito sends to your users.
  final String? smsMessage;

  VerificationMessageTemplateType({
    this.defaultEmailOption,
    this.emailMessage,
    this.emailMessageByLink,
    this.emailSubject,
    this.emailSubjectByLink,
    this.smsMessage,
  });
  factory VerificationMessageTemplateType.fromJson(Map<String, dynamic> json) {
    return VerificationMessageTemplateType(
      defaultEmailOption:
          (json['DefaultEmailOption'] as String?)?.toDefaultEmailOptionType(),
      emailMessage: json['EmailMessage'] as String?,
      emailMessageByLink: json['EmailMessageByLink'] as String?,
      emailSubject: json['EmailSubject'] as String?,
      emailSubjectByLink: json['EmailSubjectByLink'] as String?,
      smsMessage: json['SmsMessage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final defaultEmailOption = this.defaultEmailOption;
    final emailMessage = this.emailMessage;
    final emailMessageByLink = this.emailMessageByLink;
    final emailSubject = this.emailSubject;
    final emailSubjectByLink = this.emailSubjectByLink;
    final smsMessage = this.smsMessage;
    return {
      if (defaultEmailOption != null)
        'DefaultEmailOption': defaultEmailOption.toValue(),
      if (emailMessage != null) 'EmailMessage': emailMessage,
      if (emailMessageByLink != null) 'EmailMessageByLink': emailMessageByLink,
      if (emailSubject != null) 'EmailSubject': emailSubject,
      if (emailSubjectByLink != null) 'EmailSubjectByLink': emailSubjectByLink,
      if (smsMessage != null) 'SmsMessage': smsMessage,
    };
  }
}

enum VerifiedAttributeType {
  phoneNumber,
  email,
}

extension on VerifiedAttributeType {
  String toValue() {
    switch (this) {
      case VerifiedAttributeType.phoneNumber:
        return 'phone_number';
      case VerifiedAttributeType.email:
        return 'email';
    }
  }
}

extension on String {
  VerifiedAttributeType toVerifiedAttributeType() {
    switch (this) {
      case 'phone_number':
        return VerifiedAttributeType.phoneNumber;
      case 'email':
        return VerifiedAttributeType.email;
    }
    throw Exception('$this is not known in enum VerifiedAttributeType');
  }
}

class VerifySoftwareTokenResponse {
  /// The session that should be passed both ways in challenge-response calls to
  /// the service.
  final String? session;

  /// The status of the verify software token.
  final VerifySoftwareTokenResponseType? status;

  VerifySoftwareTokenResponse({
    this.session,
    this.status,
  });
  factory VerifySoftwareTokenResponse.fromJson(Map<String, dynamic> json) {
    return VerifySoftwareTokenResponse(
      session: json['Session'] as String?,
      status: (json['Status'] as String?)?.toVerifySoftwareTokenResponseType(),
    );
  }
}

enum VerifySoftwareTokenResponseType {
  success,
  error,
}

extension on VerifySoftwareTokenResponseType {
  String toValue() {
    switch (this) {
      case VerifySoftwareTokenResponseType.success:
        return 'SUCCESS';
      case VerifySoftwareTokenResponseType.error:
        return 'ERROR';
    }
  }
}

extension on String {
  VerifySoftwareTokenResponseType toVerifySoftwareTokenResponseType() {
    switch (this) {
      case 'SUCCESS':
        return VerifySoftwareTokenResponseType.success;
      case 'ERROR':
        return VerifySoftwareTokenResponseType.error;
    }
    throw Exception(
        '$this is not known in enum VerifySoftwareTokenResponseType');
  }
}

/// A container representing the response from the server from the request to
/// verify user attributes.
class VerifyUserAttributeResponse {
  VerifyUserAttributeResponse();
  factory VerifyUserAttributeResponse.fromJson(Map<String, dynamic> _) {
    return VerifyUserAttributeResponse();
  }
}

class AliasExistsException extends _s.GenericAwsException {
  AliasExistsException({String? type, String? message})
      : super(type: type, code: 'AliasExistsException', message: message);
}

class CodeDeliveryFailureException extends _s.GenericAwsException {
  CodeDeliveryFailureException({String? type, String? message})
      : super(
            type: type, code: 'CodeDeliveryFailureException', message: message);
}

class CodeMismatchException extends _s.GenericAwsException {
  CodeMismatchException({String? type, String? message})
      : super(type: type, code: 'CodeMismatchException', message: message);
}

class ConcurrentModificationException extends _s.GenericAwsException {
  ConcurrentModificationException({String? type, String? message})
      : super(
            type: type,
            code: 'ConcurrentModificationException',
            message: message);
}

class DuplicateProviderException extends _s.GenericAwsException {
  DuplicateProviderException({String? type, String? message})
      : super(type: type, code: 'DuplicateProviderException', message: message);
}

class EnableSoftwareTokenMFAException extends _s.GenericAwsException {
  EnableSoftwareTokenMFAException({String? type, String? message})
      : super(
            type: type,
            code: 'EnableSoftwareTokenMFAException',
            message: message);
}

class ExpiredCodeException extends _s.GenericAwsException {
  ExpiredCodeException({String? type, String? message})
      : super(type: type, code: 'ExpiredCodeException', message: message);
}

class ForbiddenException extends _s.GenericAwsException {
  ForbiddenException({String? type, String? message})
      : super(type: type, code: 'ForbiddenException', message: message);
}

class GroupExistsException extends _s.GenericAwsException {
  GroupExistsException({String? type, String? message})
      : super(type: type, code: 'GroupExistsException', message: message);
}

class InternalErrorException extends _s.GenericAwsException {
  InternalErrorException({String? type, String? message})
      : super(type: type, code: 'InternalErrorException', message: message);
}

class InvalidEmailRoleAccessPolicyException extends _s.GenericAwsException {
  InvalidEmailRoleAccessPolicyException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidEmailRoleAccessPolicyException',
            message: message);
}

class InvalidLambdaResponseException extends _s.GenericAwsException {
  InvalidLambdaResponseException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidLambdaResponseException',
            message: message);
}

class InvalidOAuthFlowException extends _s.GenericAwsException {
  InvalidOAuthFlowException({String? type, String? message})
      : super(type: type, code: 'InvalidOAuthFlowException', message: message);
}

class InvalidParameterException extends _s.GenericAwsException {
  InvalidParameterException({String? type, String? message})
      : super(type: type, code: 'InvalidParameterException', message: message);
}

class InvalidPasswordException extends _s.GenericAwsException {
  InvalidPasswordException({String? type, String? message})
      : super(type: type, code: 'InvalidPasswordException', message: message);
}

class InvalidSmsRoleAccessPolicyException extends _s.GenericAwsException {
  InvalidSmsRoleAccessPolicyException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidSmsRoleAccessPolicyException',
            message: message);
}

class InvalidSmsRoleTrustRelationshipException extends _s.GenericAwsException {
  InvalidSmsRoleTrustRelationshipException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidSmsRoleTrustRelationshipException',
            message: message);
}

class InvalidUserPoolConfigurationException extends _s.GenericAwsException {
  InvalidUserPoolConfigurationException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidUserPoolConfigurationException',
            message: message);
}

class LimitExceededException extends _s.GenericAwsException {
  LimitExceededException({String? type, String? message})
      : super(type: type, code: 'LimitExceededException', message: message);
}

class MFAMethodNotFoundException extends _s.GenericAwsException {
  MFAMethodNotFoundException({String? type, String? message})
      : super(type: type, code: 'MFAMethodNotFoundException', message: message);
}

class NotAuthorizedException extends _s.GenericAwsException {
  NotAuthorizedException({String? type, String? message})
      : super(type: type, code: 'NotAuthorizedException', message: message);
}

class PasswordResetRequiredException extends _s.GenericAwsException {
  PasswordResetRequiredException({String? type, String? message})
      : super(
            type: type,
            code: 'PasswordResetRequiredException',
            message: message);
}

class PreconditionNotMetException extends _s.GenericAwsException {
  PreconditionNotMetException({String? type, String? message})
      : super(
            type: type, code: 'PreconditionNotMetException', message: message);
}

class ResourceNotFoundException extends _s.GenericAwsException {
  ResourceNotFoundException({String? type, String? message})
      : super(type: type, code: 'ResourceNotFoundException', message: message);
}

class ScopeDoesNotExistException extends _s.GenericAwsException {
  ScopeDoesNotExistException({String? type, String? message})
      : super(type: type, code: 'ScopeDoesNotExistException', message: message);
}

class SoftwareTokenMFANotFoundException extends _s.GenericAwsException {
  SoftwareTokenMFANotFoundException({String? type, String? message})
      : super(
            type: type,
            code: 'SoftwareTokenMFANotFoundException',
            message: message);
}

class TooManyFailedAttemptsException extends _s.GenericAwsException {
  TooManyFailedAttemptsException({String? type, String? message})
      : super(
            type: type,
            code: 'TooManyFailedAttemptsException',
            message: message);
}

class TooManyRequestsException extends _s.GenericAwsException {
  TooManyRequestsException({String? type, String? message})
      : super(type: type, code: 'TooManyRequestsException', message: message);
}

class UnauthorizedException extends _s.GenericAwsException {
  UnauthorizedException({String? type, String? message})
      : super(type: type, code: 'UnauthorizedException', message: message);
}

class UnexpectedLambdaException extends _s.GenericAwsException {
  UnexpectedLambdaException({String? type, String? message})
      : super(type: type, code: 'UnexpectedLambdaException', message: message);
}

class UnsupportedIdentityProviderException extends _s.GenericAwsException {
  UnsupportedIdentityProviderException({String? type, String? message})
      : super(
            type: type,
            code: 'UnsupportedIdentityProviderException',
            message: message);
}

class UnsupportedOperationException extends _s.GenericAwsException {
  UnsupportedOperationException({String? type, String? message})
      : super(
            type: type,
            code: 'UnsupportedOperationException',
            message: message);
}

class UnsupportedTokenTypeException extends _s.GenericAwsException {
  UnsupportedTokenTypeException({String? type, String? message})
      : super(
            type: type,
            code: 'UnsupportedTokenTypeException',
            message: message);
}

class UnsupportedUserStateException extends _s.GenericAwsException {
  UnsupportedUserStateException({String? type, String? message})
      : super(
            type: type,
            code: 'UnsupportedUserStateException',
            message: message);
}

class UserImportInProgressException extends _s.GenericAwsException {
  UserImportInProgressException({String? type, String? message})
      : super(
            type: type,
            code: 'UserImportInProgressException',
            message: message);
}

class UserLambdaValidationException extends _s.GenericAwsException {
  UserLambdaValidationException({String? type, String? message})
      : super(
            type: type,
            code: 'UserLambdaValidationException',
            message: message);
}

class UserNotConfirmedException extends _s.GenericAwsException {
  UserNotConfirmedException({String? type, String? message})
      : super(type: type, code: 'UserNotConfirmedException', message: message);
}

class UserNotFoundException extends _s.GenericAwsException {
  UserNotFoundException({String? type, String? message})
      : super(type: type, code: 'UserNotFoundException', message: message);
}

class UserPoolAddOnNotEnabledException extends _s.GenericAwsException {
  UserPoolAddOnNotEnabledException({String? type, String? message})
      : super(
            type: type,
            code: 'UserPoolAddOnNotEnabledException',
            message: message);
}

class UserPoolTaggingException extends _s.GenericAwsException {
  UserPoolTaggingException({String? type, String? message})
      : super(type: type, code: 'UserPoolTaggingException', message: message);
}

class UsernameExistsException extends _s.GenericAwsException {
  UsernameExistsException({String? type, String? message})
      : super(type: type, code: 'UsernameExistsException', message: message);
}

final _exceptionFns = <String, _s.AwsExceptionFn>{
  'AliasExistsException': (type, message) =>
      AliasExistsException(type: type, message: message),
  'CodeDeliveryFailureException': (type, message) =>
      CodeDeliveryFailureException(type: type, message: message),
  'CodeMismatchException': (type, message) =>
      CodeMismatchException(type: type, message: message),
  'ConcurrentModificationException': (type, message) =>
      ConcurrentModificationException(type: type, message: message),
  'DuplicateProviderException': (type, message) =>
      DuplicateProviderException(type: type, message: message),
  'EnableSoftwareTokenMFAException': (type, message) =>
      EnableSoftwareTokenMFAException(type: type, message: message),
  'ExpiredCodeException': (type, message) =>
      ExpiredCodeException(type: type, message: message),
  'ForbiddenException': (type, message) =>
      ForbiddenException(type: type, message: message),
  'GroupExistsException': (type, message) =>
      GroupExistsException(type: type, message: message),
  'InternalErrorException': (type, message) =>
      InternalErrorException(type: type, message: message),
  'InvalidEmailRoleAccessPolicyException': (type, message) =>
      InvalidEmailRoleAccessPolicyException(type: type, message: message),
  'InvalidLambdaResponseException': (type, message) =>
      InvalidLambdaResponseException(type: type, message: message),
  'InvalidOAuthFlowException': (type, message) =>
      InvalidOAuthFlowException(type: type, message: message),
  'InvalidParameterException': (type, message) =>
      InvalidParameterException(type: type, message: message),
  'InvalidPasswordException': (type, message) =>
      InvalidPasswordException(type: type, message: message),
  'InvalidSmsRoleAccessPolicyException': (type, message) =>
      InvalidSmsRoleAccessPolicyException(type: type, message: message),
  'InvalidSmsRoleTrustRelationshipException': (type, message) =>
      InvalidSmsRoleTrustRelationshipException(type: type, message: message),
  'InvalidUserPoolConfigurationException': (type, message) =>
      InvalidUserPoolConfigurationException(type: type, message: message),
  'LimitExceededException': (type, message) =>
      LimitExceededException(type: type, message: message),
  'MFAMethodNotFoundException': (type, message) =>
      MFAMethodNotFoundException(type: type, message: message),
  'NotAuthorizedException': (type, message) =>
      NotAuthorizedException(type: type, message: message),
  'PasswordResetRequiredException': (type, message) =>
      PasswordResetRequiredException(type: type, message: message),
  'PreconditionNotMetException': (type, message) =>
      PreconditionNotMetException(type: type, message: message),
  'ResourceNotFoundException': (type, message) =>
      ResourceNotFoundException(type: type, message: message),
  'ScopeDoesNotExistException': (type, message) =>
      ScopeDoesNotExistException(type: type, message: message),
  'SoftwareTokenMFANotFoundException': (type, message) =>
      SoftwareTokenMFANotFoundException(type: type, message: message),
  'TooManyFailedAttemptsException': (type, message) =>
      TooManyFailedAttemptsException(type: type, message: message),
  'TooManyRequestsException': (type, message) =>
      TooManyRequestsException(type: type, message: message),
  'UnauthorizedException': (type, message) =>
      UnauthorizedException(type: type, message: message),
  'UnexpectedLambdaException': (type, message) =>
      UnexpectedLambdaException(type: type, message: message),
  'UnsupportedIdentityProviderException': (type, message) =>
      UnsupportedIdentityProviderException(type: type, message: message),
  'UnsupportedOperationException': (type, message) =>
      UnsupportedOperationException(type: type, message: message),
  'UnsupportedTokenTypeException': (type, message) =>
      UnsupportedTokenTypeException(type: type, message: message),
  'UnsupportedUserStateException': (type, message) =>
      UnsupportedUserStateException(type: type, message: message),
  'UserImportInProgressException': (type, message) =>
      UserImportInProgressException(type: type, message: message),
  'UserLambdaValidationException': (type, message) =>
      UserLambdaValidationException(type: type, message: message),
  'UserNotConfirmedException': (type, message) =>
      UserNotConfirmedException(type: type, message: message),
  'UserNotFoundException': (type, message) =>
      UserNotFoundException(type: type, message: message),
  'UserPoolAddOnNotEnabledException': (type, message) =>
      UserPoolAddOnNotEnabledException(type: type, message: message),
  'UserPoolTaggingException': (type, message) =>
      UserPoolTaggingException(type: type, message: message),
  'UsernameExistsException': (type, message) =>
      UsernameExistsException(type: type, message: message),
};
