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

/// Backup is a unified backup service designed to protect Amazon Web Services
/// services and their associated data. Backup simplifies the creation,
/// migration, restoration, and deletion of backups, while also providing
/// reporting and auditing.
class Backup {
  final _s.RestJsonProtocol _protocol;
  Backup({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.AwsClientCredentialsProvider? credentialsProvider,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.RestJsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'backup',
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

  /// Creates a backup plan using a backup plan name and backup rules. A backup
  /// plan is a document that contains information that Backup uses to schedule
  /// tasks that create recovery points for resources.
  ///
  /// If you call <code>CreateBackupPlan</code> with a plan that already exists,
  /// you receive an <code>AlreadyExistsException</code> exception.
  ///
  /// May throw [LimitExceededException].
  /// May throw [AlreadyExistsException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupPlan] :
  /// Specifies the body of a backup plan. Includes a
  /// <code>BackupPlanName</code> and one or more sets of <code>Rules</code>.
  ///
  /// Parameter [backupPlanTags] :
  /// To help organize your resources, you can assign your own metadata to the
  /// resources that you create. Each tag is a key-value pair. The specified
  /// tags are assigned to all backups created with this plan.
  ///
  /// Parameter [creatorRequestId] :
  /// Identifies the request and allows failed requests to be retried without
  /// the risk of running the operation twice. If the request includes a
  /// <code>CreatorRequestId</code> that matches an existing backup plan, that
  /// plan is returned. This parameter is optional.
  ///
  /// If used, this parameter must contain 1 to 50 alphanumeric or '-_.'
  /// characters.
  Future<CreateBackupPlanOutput> createBackupPlan({
    required BackupPlanInput backupPlan,
    Map<String, String>? backupPlanTags,
    String? creatorRequestId,
  }) async {
    ArgumentError.checkNotNull(backupPlan, 'backupPlan');
    final $payload = <String, dynamic>{
      'BackupPlan': backupPlan,
      if (backupPlanTags != null) 'BackupPlanTags': backupPlanTags,
      if (creatorRequestId != null) 'CreatorRequestId': creatorRequestId,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/backup/plans/',
      exceptionFnMap: _exceptionFns,
    );
    return CreateBackupPlanOutput.fromJson(response);
  }

  /// Creates a JSON document that specifies a set of resources to assign to a
  /// backup plan. For examples, see <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/assigning-resources.html#assigning-resources-json">Assigning
  /// resources programmatically</a>.
  ///
  /// May throw [LimitExceededException].
  /// May throw [AlreadyExistsException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupPlanId] :
  /// Uniquely identifies the backup plan to be associated with the selection of
  /// resources.
  ///
  /// Parameter [backupSelection] :
  /// Specifies the body of a request to assign a set of resources to a backup
  /// plan.
  ///
  /// Parameter [creatorRequestId] :
  /// A unique string that identifies the request and allows failed requests to
  /// be retried without the risk of running the operation twice. This parameter
  /// is optional.
  ///
  /// If used, this parameter must contain 1 to 50 alphanumeric or '-_.'
  /// characters.
  Future<CreateBackupSelectionOutput> createBackupSelection({
    required String backupPlanId,
    required BackupSelection backupSelection,
    String? creatorRequestId,
  }) async {
    ArgumentError.checkNotNull(backupPlanId, 'backupPlanId');
    ArgumentError.checkNotNull(backupSelection, 'backupSelection');
    final $payload = <String, dynamic>{
      'BackupSelection': backupSelection,
      if (creatorRequestId != null) 'CreatorRequestId': creatorRequestId,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri:
          '/backup/plans/${Uri.encodeComponent(backupPlanId)}/selections/',
      exceptionFnMap: _exceptionFns,
    );
    return CreateBackupSelectionOutput.fromJson(response);
  }

  /// Creates a logical container where backups are stored. A
  /// <code>CreateBackupVault</code> request includes a name, optionally one or
  /// more resource tags, an encryption key, and a request ID.
  /// <note>
  /// Do not include sensitive data, such as passport numbers, in the name of a
  /// backup vault.
  /// </note>
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  /// May throw [LimitExceededException].
  /// May throw [AlreadyExistsException].
  ///
  /// Parameter [backupVaultName] :
  /// The name of a logical container where backups are stored. Backup vaults
  /// are identified by names that are unique to the account used to create them
  /// and the Amazon Web Services Region where they are created. They consist of
  /// letters, numbers, and hyphens.
  ///
  /// Parameter [backupVaultTags] :
  /// Metadata that you can assign to help organize the resources that you
  /// create. Each tag is a key-value pair.
  ///
  /// Parameter [creatorRequestId] :
  /// A unique string that identifies the request and allows failed requests to
  /// be retried without the risk of running the operation twice. This parameter
  /// is optional.
  ///
  /// If used, this parameter must contain 1 to 50 alphanumeric or '-_.'
  /// characters.
  ///
  /// Parameter [encryptionKeyArn] :
  /// The server-side encryption key that is used to protect your backups; for
  /// example,
  /// <code>arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code>.
  Future<CreateBackupVaultOutput> createBackupVault({
    required String backupVaultName,
    Map<String, String>? backupVaultTags,
    String? creatorRequestId,
    String? encryptionKeyArn,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    final $payload = <String, dynamic>{
      if (backupVaultTags != null) 'BackupVaultTags': backupVaultTags,
      if (creatorRequestId != null) 'CreatorRequestId': creatorRequestId,
      if (encryptionKeyArn != null) 'EncryptionKeyArn': encryptionKeyArn,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/backup-vaults/${Uri.encodeComponent(backupVaultName)}',
      exceptionFnMap: _exceptionFns,
    );
    return CreateBackupVaultOutput.fromJson(response);
  }

  /// Creates a framework with one or more controls. A framework is a collection
  /// of controls that you can use to evaluate your backup practices. By using
  /// pre-built customizable controls to define your policies, you can evaluate
  /// whether your backup practices comply with your policies and which
  /// resources are not yet in compliance.
  ///
  /// May throw [AlreadyExistsException].
  /// May throw [LimitExceededException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [frameworkControls] :
  /// A list of the controls that make up the framework. Each control in the
  /// list has a name, input parameters, and scope.
  ///
  /// Parameter [frameworkName] :
  /// The unique name of the framework. The name must be between 1 and 256
  /// characters, starting with a letter, and consisting of letters (a-z, A-Z),
  /// numbers (0-9), and underscores (_).
  ///
  /// Parameter [frameworkDescription] :
  /// An optional description of the framework with a maximum of 1,024
  /// characters.
  ///
  /// Parameter [frameworkTags] :
  /// Metadata that you can assign to help organize the frameworks that you
  /// create. Each tag is a key-value pair.
  ///
  /// Parameter [idempotencyToken] :
  /// A customer-chosen string that you can use to distinguish between otherwise
  /// identical calls to <code>CreateFrameworkInput</code>. Retrying a
  /// successful request with the same idempotency token results in a success
  /// message with no action taken.
  Future<CreateFrameworkOutput> createFramework({
    required List<FrameworkControl> frameworkControls,
    required String frameworkName,
    String? frameworkDescription,
    Map<String, String>? frameworkTags,
    String? idempotencyToken,
  }) async {
    ArgumentError.checkNotNull(frameworkControls, 'frameworkControls');
    ArgumentError.checkNotNull(frameworkName, 'frameworkName');
    _s.validateStringLength(
      'frameworkName',
      frameworkName,
      1,
      256,
      isRequired: true,
    );
    _s.validateStringLength(
      'frameworkDescription',
      frameworkDescription,
      0,
      1024,
    );
    final $payload = <String, dynamic>{
      'FrameworkControls': frameworkControls,
      'FrameworkName': frameworkName,
      if (frameworkDescription != null)
        'FrameworkDescription': frameworkDescription,
      if (frameworkTags != null) 'FrameworkTags': frameworkTags,
      'IdempotencyToken': idempotencyToken ?? _s.generateIdempotencyToken(),
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/audit/frameworks',
      exceptionFnMap: _exceptionFns,
    );
    return CreateFrameworkOutput.fromJson(response);
  }

  /// Creates a report plan. A report plan is a document that contains
  /// information about the contents of the report and where Backup will deliver
  /// it.
  ///
  /// If you call <code>CreateReportPlan</code> with a plan that already exists,
  /// you receive an <code>AlreadyExistsException</code> exception.
  ///
  /// May throw [AlreadyExistsException].
  /// May throw [LimitExceededException].
  /// May throw [InvalidParameterValueException].
  /// May throw [ServiceUnavailableException].
  /// May throw [MissingParameterValueException].
  ///
  /// Parameter [reportDeliveryChannel] :
  /// A structure that contains information about where and how to deliver your
  /// reports, specifically your Amazon S3 bucket name, S3 key prefix, and the
  /// formats of your reports.
  ///
  /// Parameter [reportPlanName] :
  /// The unique name of the report plan. The name must be between 1 and 256
  /// characters, starting with a letter, and consisting of letters (a-z, A-Z),
  /// numbers (0-9), and underscores (_).
  ///
  /// Parameter [reportSetting] :
  /// Identifies the report template for the report. Reports are built using a
  /// report template. The report templates are:
  ///
  /// <code>RESOURCE_COMPLIANCE_REPORT | CONTROL_COMPLIANCE_REPORT |
  /// BACKUP_JOB_REPORT | COPY_JOB_REPORT | RESTORE_JOB_REPORT</code>
  ///
  /// If the report template is <code>RESOURCE_COMPLIANCE_REPORT</code> or
  /// <code>CONTROL_COMPLIANCE_REPORT</code>, this API resource also describes
  /// the report coverage by Amazon Web Services Regions and frameworks.
  ///
  /// Parameter [idempotencyToken] :
  /// A customer-chosen string that you can use to distinguish between otherwise
  /// identical calls to <code>CreateReportPlanInput</code>. Retrying a
  /// successful request with the same idempotency token results in a success
  /// message with no action taken.
  ///
  /// Parameter [reportPlanDescription] :
  /// An optional description of the report plan with a maximum of 1,024
  /// characters.
  ///
  /// Parameter [reportPlanTags] :
  /// Metadata that you can assign to help organize the report plans that you
  /// create. Each tag is a key-value pair.
  Future<CreateReportPlanOutput> createReportPlan({
    required ReportDeliveryChannel reportDeliveryChannel,
    required String reportPlanName,
    required ReportSetting reportSetting,
    String? idempotencyToken,
    String? reportPlanDescription,
    Map<String, String>? reportPlanTags,
  }) async {
    ArgumentError.checkNotNull(reportDeliveryChannel, 'reportDeliveryChannel');
    ArgumentError.checkNotNull(reportPlanName, 'reportPlanName');
    _s.validateStringLength(
      'reportPlanName',
      reportPlanName,
      1,
      256,
      isRequired: true,
    );
    ArgumentError.checkNotNull(reportSetting, 'reportSetting');
    _s.validateStringLength(
      'reportPlanDescription',
      reportPlanDescription,
      0,
      1024,
    );
    final $payload = <String, dynamic>{
      'ReportDeliveryChannel': reportDeliveryChannel,
      'ReportPlanName': reportPlanName,
      'ReportSetting': reportSetting,
      'IdempotencyToken': idempotencyToken ?? _s.generateIdempotencyToken(),
      if (reportPlanDescription != null)
        'ReportPlanDescription': reportPlanDescription,
      if (reportPlanTags != null) 'ReportPlanTags': reportPlanTags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/audit/report-plans',
      exceptionFnMap: _exceptionFns,
    );
    return CreateReportPlanOutput.fromJson(response);
  }

  /// Deletes a backup plan. A backup plan can only be deleted after all
  /// associated selections of resources have been deleted. Deleting a backup
  /// plan deletes the current version of a backup plan. Previous versions, if
  /// any, will still exist.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  /// May throw [InvalidRequestException].
  ///
  /// Parameter [backupPlanId] :
  /// Uniquely identifies a backup plan.
  Future<DeleteBackupPlanOutput> deleteBackupPlan({
    required String backupPlanId,
  }) async {
    ArgumentError.checkNotNull(backupPlanId, 'backupPlanId');
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/backup/plans/${Uri.encodeComponent(backupPlanId)}',
      exceptionFnMap: _exceptionFns,
    );
    return DeleteBackupPlanOutput.fromJson(response);
  }

  /// Deletes the resource selection associated with a backup plan that is
  /// specified by the <code>SelectionId</code>.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupPlanId] :
  /// Uniquely identifies a backup plan.
  ///
  /// Parameter [selectionId] :
  /// Uniquely identifies the body of a request to assign a set of resources to
  /// a backup plan.
  Future<void> deleteBackupSelection({
    required String backupPlanId,
    required String selectionId,
  }) async {
    ArgumentError.checkNotNull(backupPlanId, 'backupPlanId');
    ArgumentError.checkNotNull(selectionId, 'selectionId');
    await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri:
          '/backup/plans/${Uri.encodeComponent(backupPlanId)}/selections/${Uri.encodeComponent(selectionId)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes the backup vault identified by its name. A vault can be deleted
  /// only if it is empty.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  /// May throw [InvalidRequestException].
  ///
  /// Parameter [backupVaultName] :
  /// The name of a logical container where backups are stored. Backup vaults
  /// are identified by names that are unique to the account used to create them
  /// and the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  Future<void> deleteBackupVault({
    required String backupVaultName,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/backup-vaults/${Uri.encodeComponent(backupVaultName)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes the policy document that manages permissions on a backup vault.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupVaultName] :
  /// The name of a logical container where backups are stored. Backup vaults
  /// are identified by names that are unique to the account used to create them
  /// and the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  Future<void> deleteBackupVaultAccessPolicy({
    required String backupVaultName,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri:
          '/backup-vaults/${Uri.encodeComponent(backupVaultName)}/access-policy',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes Backup Vault Lock from a backup vault specified by a backup vault
  /// name.
  ///
  /// If the Vault Lock configuration is immutable, then you cannot delete Vault
  /// Lock using API operations, and you will receive an
  /// <code>InvalidRequestException</code> if you attempt to do so. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/vault-lock.html">Vault
  /// Lock</a> in the <i>Backup Developer Guide</i>.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [InvalidRequestException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupVaultName] :
  /// The name of the backup vault from which to delete Backup Vault Lock.
  Future<void> deleteBackupVaultLockConfiguration({
    required String backupVaultName,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri:
          '/backup-vaults/${Uri.encodeComponent(backupVaultName)}/vault-lock',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes event notifications for the specified backup vault.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupVaultName] :
  /// The name of a logical container where backups are stored. Backup vaults
  /// are identified by names that are unique to the account used to create them
  /// and the Region where they are created. They consist of lowercase letters,
  /// numbers, and hyphens.
  Future<void> deleteBackupVaultNotifications({
    required String backupVaultName,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri:
          '/backup-vaults/${Uri.encodeComponent(backupVaultName)}/notification-configuration',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes the framework specified by a framework name.
  ///
  /// May throw [MissingParameterValueException].
  /// May throw [InvalidParameterValueException].
  /// May throw [ServiceUnavailableException].
  /// May throw [ConflictException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [frameworkName] :
  /// The unique name of a framework.
  Future<void> deleteFramework({
    required String frameworkName,
  }) async {
    ArgumentError.checkNotNull(frameworkName, 'frameworkName');
    _s.validateStringLength(
      'frameworkName',
      frameworkName,
      1,
      256,
      isRequired: true,
    );
    await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/audit/frameworks/${Uri.encodeComponent(frameworkName)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes the recovery point specified by a recovery point ID.
  ///
  /// If the recovery point ID belongs to a continuous backup, calling this
  /// endpoint deletes the existing continuous backup and stops future
  /// continuous backup.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [InvalidResourceStateException].
  /// May throw [ServiceUnavailableException].
  /// May throw [InvalidRequestException].
  ///
  /// Parameter [backupVaultName] :
  /// The name of a logical container where backups are stored. Backup vaults
  /// are identified by names that are unique to the account used to create them
  /// and the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  ///
  /// Parameter [recoveryPointArn] :
  /// An Amazon Resource Name (ARN) that uniquely identifies a recovery point;
  /// for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  Future<void> deleteRecoveryPoint({
    required String backupVaultName,
    required String recoveryPointArn,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    ArgumentError.checkNotNull(recoveryPointArn, 'recoveryPointArn');
    await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri:
          '/backup-vaults/${Uri.encodeComponent(backupVaultName)}/recovery-points/${Uri.encodeComponent(recoveryPointArn)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes the report plan specified by a report plan name.
  ///
  /// May throw [MissingParameterValueException].
  /// May throw [InvalidParameterValueException].
  /// May throw [ConflictException].
  /// May throw [ServiceUnavailableException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [reportPlanName] :
  /// The unique name of a report plan.
  Future<void> deleteReportPlan({
    required String reportPlanName,
  }) async {
    ArgumentError.checkNotNull(reportPlanName, 'reportPlanName');
    _s.validateStringLength(
      'reportPlanName',
      reportPlanName,
      1,
      256,
      isRequired: true,
    );
    await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/audit/report-plans/${Uri.encodeComponent(reportPlanName)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Returns backup job details for the specified <code>BackupJobId</code>.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  /// May throw [DependencyFailureException].
  ///
  /// Parameter [backupJobId] :
  /// Uniquely identifies a request to Backup to back up a resource.
  Future<DescribeBackupJobOutput> describeBackupJob({
    required String backupJobId,
  }) async {
    ArgumentError.checkNotNull(backupJobId, 'backupJobId');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/backup-jobs/${Uri.encodeComponent(backupJobId)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeBackupJobOutput.fromJson(response);
  }

  /// Returns metadata about a backup vault specified by its name.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupVaultName] :
  /// The name of a logical container where backups are stored. Backup vaults
  /// are identified by names that are unique to the account used to create them
  /// and the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  Future<DescribeBackupVaultOutput> describeBackupVault({
    required String backupVaultName,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/backup-vaults/${Uri.encodeComponent(backupVaultName)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeBackupVaultOutput.fromJson(response);
  }

  /// Returns metadata associated with creating a copy of a resource.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [copyJobId] :
  /// Uniquely identifies a copy job.
  Future<DescribeCopyJobOutput> describeCopyJob({
    required String copyJobId,
  }) async {
    ArgumentError.checkNotNull(copyJobId, 'copyJobId');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/copy-jobs/${Uri.encodeComponent(copyJobId)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeCopyJobOutput.fromJson(response);
  }

  /// Returns the framework details for the specified
  /// <code>FrameworkName</code>.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [frameworkName] :
  /// The unique name of a framework.
  Future<DescribeFrameworkOutput> describeFramework({
    required String frameworkName,
  }) async {
    ArgumentError.checkNotNull(frameworkName, 'frameworkName');
    _s.validateStringLength(
      'frameworkName',
      frameworkName,
      1,
      256,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/audit/frameworks/${Uri.encodeComponent(frameworkName)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeFrameworkOutput.fromJson(response);
  }

  /// Describes whether the Amazon Web Services account is opted in to
  /// cross-account backup. Returns an error if the account is not a member of
  /// an Organizations organization. Example: <code>describe-global-settings
  /// --region us-west-2</code>
  ///
  /// May throw [InvalidRequestException].
  /// May throw [ServiceUnavailableException].
  Future<DescribeGlobalSettingsOutput> describeGlobalSettings() async {
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/global-settings',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeGlobalSettingsOutput.fromJson(response);
  }

  /// Returns information about a saved resource, including the last time it was
  /// backed up, its Amazon Resource Name (ARN), and the Amazon Web Services
  /// service type of the saved resource.
  ///
  /// May throw [MissingParameterValueException].
  /// May throw [InvalidParameterValueException].
  /// May throw [ServiceUnavailableException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [resourceArn] :
  /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
  /// format of the ARN depends on the resource type.
  Future<DescribeProtectedResourceOutput> describeProtectedResource({
    required String resourceArn,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/resources/${Uri.encodeComponent(resourceArn)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeProtectedResourceOutput.fromJson(response);
  }

  /// Returns metadata associated with a recovery point, including ID, status,
  /// encryption, and lifecycle.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupVaultName] :
  /// The name of a logical container where backups are stored. Backup vaults
  /// are identified by names that are unique to the account used to create them
  /// and the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  ///
  /// Parameter [recoveryPointArn] :
  /// An Amazon Resource Name (ARN) that uniquely identifies a recovery point;
  /// for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  Future<DescribeRecoveryPointOutput> describeRecoveryPoint({
    required String backupVaultName,
    required String recoveryPointArn,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    ArgumentError.checkNotNull(recoveryPointArn, 'recoveryPointArn');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/backup-vaults/${Uri.encodeComponent(backupVaultName)}/recovery-points/${Uri.encodeComponent(recoveryPointArn)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeRecoveryPointOutput.fromJson(response);
  }

  /// Returns the current service opt-in settings for the Region. If service
  /// opt-in is enabled for a service, Backup tries to protect that service's
  /// resources in this Region, when the resource is included in an on-demand
  /// backup or scheduled backup plan. Otherwise, Backup does not try to protect
  /// that service's resources in this Region.
  ///
  /// May throw [ServiceUnavailableException].
  Future<DescribeRegionSettingsOutput> describeRegionSettings() async {
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/account-settings',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeRegionSettingsOutput.fromJson(response);
  }

  /// Returns the details associated with creating a report as specified by its
  /// <code>ReportJobId</code>.
  ///
  /// May throw [ServiceUnavailableException].
  /// May throw [MissingParameterValueException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [reportJobId] :
  /// The identifier of the report job. A unique, randomly generated, Unicode,
  /// UTF-8 encoded string that is at most 1,024 bytes long. The report job ID
  /// cannot be edited.
  Future<DescribeReportJobOutput> describeReportJob({
    required String reportJobId,
  }) async {
    ArgumentError.checkNotNull(reportJobId, 'reportJobId');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/audit/report-jobs/${Uri.encodeComponent(reportJobId)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeReportJobOutput.fromJson(response);
  }

  /// Returns a list of all report plans for an Amazon Web Services account and
  /// Amazon Web Services Region.
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ResourceNotFoundException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [reportPlanName] :
  /// The unique name of a report plan.
  Future<DescribeReportPlanOutput> describeReportPlan({
    required String reportPlanName,
  }) async {
    ArgumentError.checkNotNull(reportPlanName, 'reportPlanName');
    _s.validateStringLength(
      'reportPlanName',
      reportPlanName,
      1,
      256,
      isRequired: true,
    );
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/audit/report-plans/${Uri.encodeComponent(reportPlanName)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeReportPlanOutput.fromJson(response);
  }

  /// Returns metadata associated with a restore job that is specified by a job
  /// ID.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  /// May throw [DependencyFailureException].
  ///
  /// Parameter [restoreJobId] :
  /// Uniquely identifies the job that restores a recovery point.
  Future<DescribeRestoreJobOutput> describeRestoreJob({
    required String restoreJobId,
  }) async {
    ArgumentError.checkNotNull(restoreJobId, 'restoreJobId');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/restore-jobs/${Uri.encodeComponent(restoreJobId)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeRestoreJobOutput.fromJson(response);
  }

  /// Deletes the specified continuous backup recovery point from Backup and
  /// releases control of that continuous backup to the source service, such as
  /// Amazon RDS. The source service will continue to create and retain
  /// continuous backups using the lifecycle that you specified in your original
  /// backup plan.
  ///
  /// Does not support snapshot backup recovery points.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [InvalidResourceStateException].
  /// May throw [ServiceUnavailableException].
  /// May throw [InvalidRequestException].
  ///
  /// Parameter [backupVaultName] :
  /// The unique name of an Backup vault.
  ///
  /// Parameter [recoveryPointArn] :
  /// An Amazon Resource Name (ARN) that uniquely identifies an Backup recovery
  /// point.
  Future<void> disassociateRecoveryPoint({
    required String backupVaultName,
    required String recoveryPointArn,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    ArgumentError.checkNotNull(recoveryPointArn, 'recoveryPointArn');
    await _protocol.send(
      payload: null,
      method: 'POST',
      requestUri:
          '/backup-vaults/${Uri.encodeComponent(backupVaultName)}/recovery-points/${Uri.encodeComponent(recoveryPointArn)}/disassociate',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Returns the backup plan that is specified by the plan ID as a backup
  /// template.
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [backupPlanId] :
  /// Uniquely identifies a backup plan.
  Future<ExportBackupPlanTemplateOutput> exportBackupPlanTemplate({
    required String backupPlanId,
  }) async {
    ArgumentError.checkNotNull(backupPlanId, 'backupPlanId');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/backup/plans/${Uri.encodeComponent(backupPlanId)}/toTemplate/',
      exceptionFnMap: _exceptionFns,
    );
    return ExportBackupPlanTemplateOutput.fromJson(response);
  }

  /// Returns <code>BackupPlan</code> details for the specified
  /// <code>BackupPlanId</code>. The details are the body of a backup plan in
  /// JSON format, in addition to plan metadata.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupPlanId] :
  /// Uniquely identifies a backup plan.
  ///
  /// Parameter [versionId] :
  /// Unique, randomly generated, Unicode, UTF-8 encoded strings that are at
  /// most 1,024 bytes long. Version IDs cannot be edited.
  Future<GetBackupPlanOutput> getBackupPlan({
    required String backupPlanId,
    String? versionId,
  }) async {
    ArgumentError.checkNotNull(backupPlanId, 'backupPlanId');
    final $query = <String, List<String>>{
      if (versionId != null) 'versionId': [versionId],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/backup/plans/${Uri.encodeComponent(backupPlanId)}/',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return GetBackupPlanOutput.fromJson(response);
  }

  /// Returns a valid JSON document specifying a backup plan or an error.
  ///
  /// May throw [LimitExceededException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  /// May throw [InvalidRequestException].
  ///
  /// Parameter [backupPlanTemplateJson] :
  /// A customer-supplied backup plan document in JSON format.
  Future<GetBackupPlanFromJSONOutput> getBackupPlanFromJSON({
    required String backupPlanTemplateJson,
  }) async {
    ArgumentError.checkNotNull(
        backupPlanTemplateJson, 'backupPlanTemplateJson');
    final $payload = <String, dynamic>{
      'BackupPlanTemplateJson': backupPlanTemplateJson,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/backup/template/json/toPlan',
      exceptionFnMap: _exceptionFns,
    );
    return GetBackupPlanFromJSONOutput.fromJson(response);
  }

  /// Returns the template specified by its <code>templateId</code> as a backup
  /// plan.
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [backupPlanTemplateId] :
  /// Uniquely identifies a stored backup plan template.
  Future<GetBackupPlanFromTemplateOutput> getBackupPlanFromTemplate({
    required String backupPlanTemplateId,
  }) async {
    ArgumentError.checkNotNull(backupPlanTemplateId, 'backupPlanTemplateId');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/backup/template/plans/${Uri.encodeComponent(backupPlanTemplateId)}/toPlan',
      exceptionFnMap: _exceptionFns,
    );
    return GetBackupPlanFromTemplateOutput.fromJson(response);
  }

  /// Returns selection metadata and a document in JSON format that specifies a
  /// list of resources that are associated with a backup plan.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupPlanId] :
  /// Uniquely identifies a backup plan.
  ///
  /// Parameter [selectionId] :
  /// Uniquely identifies the body of a request to assign a set of resources to
  /// a backup plan.
  Future<GetBackupSelectionOutput> getBackupSelection({
    required String backupPlanId,
    required String selectionId,
  }) async {
    ArgumentError.checkNotNull(backupPlanId, 'backupPlanId');
    ArgumentError.checkNotNull(selectionId, 'selectionId');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/backup/plans/${Uri.encodeComponent(backupPlanId)}/selections/${Uri.encodeComponent(selectionId)}',
      exceptionFnMap: _exceptionFns,
    );
    return GetBackupSelectionOutput.fromJson(response);
  }

  /// Returns the access policy document that is associated with the named
  /// backup vault.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupVaultName] :
  /// The name of a logical container where backups are stored. Backup vaults
  /// are identified by names that are unique to the account used to create them
  /// and the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  Future<GetBackupVaultAccessPolicyOutput> getBackupVaultAccessPolicy({
    required String backupVaultName,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/backup-vaults/${Uri.encodeComponent(backupVaultName)}/access-policy',
      exceptionFnMap: _exceptionFns,
    );
    return GetBackupVaultAccessPolicyOutput.fromJson(response);
  }

  /// Returns event notifications for the specified backup vault.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupVaultName] :
  /// The name of a logical container where backups are stored. Backup vaults
  /// are identified by names that are unique to the account used to create them
  /// and the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  Future<GetBackupVaultNotificationsOutput> getBackupVaultNotifications({
    required String backupVaultName,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/backup-vaults/${Uri.encodeComponent(backupVaultName)}/notification-configuration',
      exceptionFnMap: _exceptionFns,
    );
    return GetBackupVaultNotificationsOutput.fromJson(response);
  }

  /// Returns a set of metadata key-value pairs that were used to create the
  /// backup.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupVaultName] :
  /// The name of a logical container where backups are stored. Backup vaults
  /// are identified by names that are unique to the account used to create them
  /// and the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  ///
  /// Parameter [recoveryPointArn] :
  /// An Amazon Resource Name (ARN) that uniquely identifies a recovery point;
  /// for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  Future<GetRecoveryPointRestoreMetadataOutput>
      getRecoveryPointRestoreMetadata({
    required String backupVaultName,
    required String recoveryPointArn,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    ArgumentError.checkNotNull(recoveryPointArn, 'recoveryPointArn');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/backup-vaults/${Uri.encodeComponent(backupVaultName)}/recovery-points/${Uri.encodeComponent(recoveryPointArn)}/restore-metadata',
      exceptionFnMap: _exceptionFns,
    );
    return GetRecoveryPointRestoreMetadataOutput.fromJson(response);
  }

  /// Returns the Amazon Web Services resource types supported by Backup.
  ///
  /// May throw [ServiceUnavailableException].
  Future<GetSupportedResourceTypesOutput> getSupportedResourceTypes() async {
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/supported-resource-types',
      exceptionFnMap: _exceptionFns,
    );
    return GetSupportedResourceTypesOutput.fromJson(response);
  }

  /// Returns a list of existing backup jobs for an authenticated account for
  /// the last 30 days. For a longer period of time, consider using these <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/monitoring.html">monitoring
  /// tools</a>.
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [byAccountId] :
  /// The account ID to list the jobs from. Returns only backup jobs associated
  /// with the specified account ID.
  ///
  /// If used from an Organizations management account, passing <code>*</code>
  /// returns all jobs across the organization.
  ///
  /// Parameter [byBackupVaultName] :
  /// Returns only backup jobs that will be stored in the specified backup
  /// vault. Backup vaults are identified by names that are unique to the
  /// account used to create them and the Amazon Web Services Region where they
  /// are created. They consist of lowercase letters, numbers, and hyphens.
  ///
  /// Parameter [byCompleteAfter] :
  /// Returns only backup jobs completed after a date expressed in Unix format
  /// and Coordinated Universal Time (UTC).
  ///
  /// Parameter [byCompleteBefore] :
  /// Returns only backup jobs completed before a date expressed in Unix format
  /// and Coordinated Universal Time (UTC).
  ///
  /// Parameter [byCreatedAfter] :
  /// Returns only backup jobs that were created after the specified date.
  ///
  /// Parameter [byCreatedBefore] :
  /// Returns only backup jobs that were created before the specified date.
  ///
  /// Parameter [byResourceArn] :
  /// Returns only backup jobs that match the specified resource Amazon Resource
  /// Name (ARN).
  ///
  /// Parameter [byResourceType] :
  /// Returns only backup jobs for the specified resources:
  ///
  /// <ul>
  /// <li>
  /// <code>Aurora</code> for Amazon Aurora
  /// </li>
  /// <li>
  /// <code>DocumentDB</code> for Amazon DocumentDB (with MongoDB compatibility)
  /// </li>
  /// <li>
  /// <code>DynamoDB</code> for Amazon DynamoDB
  /// </li>
  /// <li>
  /// <code>EBS</code> for Amazon Elastic Block Store
  /// </li>
  /// <li>
  /// <code>EC2</code> for Amazon Elastic Compute Cloud
  /// </li>
  /// <li>
  /// <code>EFS</code> for Amazon Elastic File System
  /// </li>
  /// <li>
  /// <code>FSx</code> for Amazon FSx
  /// </li>
  /// <li>
  /// <code>Neptune</code> for Amazon Neptune
  /// </li>
  /// <li>
  /// <code>RDS</code> for Amazon Relational Database Service
  /// </li>
  /// <li>
  /// <code>Storage Gateway</code> for Storage Gateway
  /// </li>
  /// <li>
  /// <code>S3</code> for Amazon S3
  /// </li>
  /// <li>
  /// <code>VirtualMachine</code> for virtual machines
  /// </li>
  /// </ul>
  ///
  /// Parameter [byState] :
  /// Returns only backup jobs that are in the specified state.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to be returned.
  ///
  /// Parameter [nextToken] :
  /// The next item following a partial list of returned items. For example, if
  /// a request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list
  /// starting at the location pointed to by the next token.
  Future<ListBackupJobsOutput> listBackupJobs({
    String? byAccountId,
    String? byBackupVaultName,
    DateTime? byCompleteAfter,
    DateTime? byCompleteBefore,
    DateTime? byCreatedAfter,
    DateTime? byCreatedBefore,
    String? byResourceArn,
    String? byResourceType,
    BackupJobState? byState,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1000,
    );
    final $query = <String, List<String>>{
      if (byAccountId != null) 'accountId': [byAccountId],
      if (byBackupVaultName != null) 'backupVaultName': [byBackupVaultName],
      if (byCompleteAfter != null)
        'completeAfter': [_s.iso8601ToJson(byCompleteAfter).toString()],
      if (byCompleteBefore != null)
        'completeBefore': [_s.iso8601ToJson(byCompleteBefore).toString()],
      if (byCreatedAfter != null)
        'createdAfter': [_s.iso8601ToJson(byCreatedAfter).toString()],
      if (byCreatedBefore != null)
        'createdBefore': [_s.iso8601ToJson(byCreatedBefore).toString()],
      if (byResourceArn != null) 'resourceArn': [byResourceArn],
      if (byResourceType != null) 'resourceType': [byResourceType],
      if (byState != null) 'state': [byState.toValue()],
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/backup-jobs/',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListBackupJobsOutput.fromJson(response);
  }

  /// Returns metadata of your saved backup plan templates, including the
  /// template ID, name, and the creation and deletion dates.
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to be returned.
  ///
  /// Parameter [nextToken] :
  /// The next item following a partial list of returned items. For example, if
  /// a request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list
  /// starting at the location pointed to by the next token.
  Future<ListBackupPlanTemplatesOutput> listBackupPlanTemplates({
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1000,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/backup/template/plans',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListBackupPlanTemplatesOutput.fromJson(response);
  }

  /// Returns version metadata of your backup plans, including Amazon Resource
  /// Names (ARNs), backup plan IDs, creation and deletion dates, plan names,
  /// and version IDs.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupPlanId] :
  /// Uniquely identifies a backup plan.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to be returned.
  ///
  /// Parameter [nextToken] :
  /// The next item following a partial list of returned items. For example, if
  /// a request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list
  /// starting at the location pointed to by the next token.
  Future<ListBackupPlanVersionsOutput> listBackupPlanVersions({
    required String backupPlanId,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(backupPlanId, 'backupPlanId');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1000,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/backup/plans/${Uri.encodeComponent(backupPlanId)}/versions/',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListBackupPlanVersionsOutput.fromJson(response);
  }

  /// Returns a list of all active backup plans for an authenticated account.
  /// The list contains information such as Amazon Resource Names (ARNs), plan
  /// IDs, creation and deletion dates, version IDs, plan names, and creator
  /// request IDs.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [includeDeleted] :
  /// A Boolean value with a default value of <code>FALSE</code> that returns
  /// deleted backup plans when set to <code>TRUE</code>.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to be returned.
  ///
  /// Parameter [nextToken] :
  /// The next item following a partial list of returned items. For example, if
  /// a request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list
  /// starting at the location pointed to by the next token.
  Future<ListBackupPlansOutput> listBackupPlans({
    bool? includeDeleted,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1000,
    );
    final $query = <String, List<String>>{
      if (includeDeleted != null) 'includeDeleted': [includeDeleted.toString()],
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/backup/plans/',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListBackupPlansOutput.fromJson(response);
  }

  /// Returns an array containing metadata of the resources associated with the
  /// target backup plan.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupPlanId] :
  /// Uniquely identifies a backup plan.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to be returned.
  ///
  /// Parameter [nextToken] :
  /// The next item following a partial list of returned items. For example, if
  /// a request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list
  /// starting at the location pointed to by the next token.
  Future<ListBackupSelectionsOutput> listBackupSelections({
    required String backupPlanId,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(backupPlanId, 'backupPlanId');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1000,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/backup/plans/${Uri.encodeComponent(backupPlanId)}/selections/',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListBackupSelectionsOutput.fromJson(response);
  }

  /// Returns a list of recovery point storage containers along with information
  /// about them.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to be returned.
  ///
  /// Parameter [nextToken] :
  /// The next item following a partial list of returned items. For example, if
  /// a request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list
  /// starting at the location pointed to by the next token.
  Future<ListBackupVaultsOutput> listBackupVaults({
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1000,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/backup-vaults/',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListBackupVaultsOutput.fromJson(response);
  }

  /// Returns metadata about your copy jobs.
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [byAccountId] :
  /// The account ID to list the jobs from. Returns only copy jobs associated
  /// with the specified account ID.
  ///
  /// Parameter [byCompleteAfter] :
  /// Returns only copy jobs completed after a date expressed in Unix format and
  /// Coordinated Universal Time (UTC).
  ///
  /// Parameter [byCompleteBefore] :
  /// Returns only copy jobs completed before a date expressed in Unix format
  /// and Coordinated Universal Time (UTC).
  ///
  /// Parameter [byCreatedAfter] :
  /// Returns only copy jobs that were created after the specified date.
  ///
  /// Parameter [byCreatedBefore] :
  /// Returns only copy jobs that were created before the specified date.
  ///
  /// Parameter [byDestinationVaultArn] :
  /// An Amazon Resource Name (ARN) that uniquely identifies a source backup
  /// vault to copy from; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:aBackupVault</code>.
  ///
  /// Parameter [byResourceArn] :
  /// Returns only copy jobs that match the specified resource Amazon Resource
  /// Name (ARN).
  ///
  /// Parameter [byResourceType] :
  /// Returns only backup jobs for the specified resources:
  ///
  /// <ul>
  /// <li>
  /// <code>Aurora</code> for Amazon Aurora
  /// </li>
  /// <li>
  /// <code>DocumentDB</code> for Amazon DocumentDB (with MongoDB compatibility)
  /// </li>
  /// <li>
  /// <code>DynamoDB</code> for Amazon DynamoDB
  /// </li>
  /// <li>
  /// <code>EBS</code> for Amazon Elastic Block Store
  /// </li>
  /// <li>
  /// <code>EC2</code> for Amazon Elastic Compute Cloud
  /// </li>
  /// <li>
  /// <code>EFS</code> for Amazon Elastic File System
  /// </li>
  /// <li>
  /// <code>FSx</code> for Amazon FSx
  /// </li>
  /// <li>
  /// <code>Neptune</code> for Amazon Neptune
  /// </li>
  /// <li>
  /// <code>RDS</code> for Amazon Relational Database Service
  /// </li>
  /// <li>
  /// <code>Storage Gateway</code> for Storage Gateway
  /// </li>
  /// <li>
  /// <code>S3</code> for Amazon S3
  /// </li>
  /// <li>
  /// <code>VirtualMachine</code> for virtual machines
  /// </li>
  /// </ul>
  ///
  /// Parameter [byState] :
  /// Returns only copy jobs that are in the specified state.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to be returned.
  ///
  /// Parameter [nextToken] :
  /// The next item following a partial list of returned items. For example, if
  /// a request is made to return maxResults number of items, NextToken allows
  /// you to return more items in your list starting at the location pointed to
  /// by the next token.
  Future<ListCopyJobsOutput> listCopyJobs({
    String? byAccountId,
    DateTime? byCompleteAfter,
    DateTime? byCompleteBefore,
    DateTime? byCreatedAfter,
    DateTime? byCreatedBefore,
    String? byDestinationVaultArn,
    String? byResourceArn,
    String? byResourceType,
    CopyJobState? byState,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1000,
    );
    final $query = <String, List<String>>{
      if (byAccountId != null) 'accountId': [byAccountId],
      if (byCompleteAfter != null)
        'completeAfter': [_s.iso8601ToJson(byCompleteAfter).toString()],
      if (byCompleteBefore != null)
        'completeBefore': [_s.iso8601ToJson(byCompleteBefore).toString()],
      if (byCreatedAfter != null)
        'createdAfter': [_s.iso8601ToJson(byCreatedAfter).toString()],
      if (byCreatedBefore != null)
        'createdBefore': [_s.iso8601ToJson(byCreatedBefore).toString()],
      if (byDestinationVaultArn != null)
        'destinationVaultArn': [byDestinationVaultArn],
      if (byResourceArn != null) 'resourceArn': [byResourceArn],
      if (byResourceType != null) 'resourceType': [byResourceType],
      if (byState != null) 'state': [byState.toValue()],
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/copy-jobs/',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListCopyJobsOutput.fromJson(response);
  }

  /// Returns a list of all frameworks for an Amazon Web Services account and
  /// Amazon Web Services Region.
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [maxResults] :
  /// The number of desired results from 1 to 1000. Optional. If unspecified,
  /// the query will return 1 MB of data.
  ///
  /// Parameter [nextToken] :
  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  Future<ListFrameworksOutput> listFrameworks({
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1000,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'MaxResults': [maxResults.toString()],
      if (nextToken != null) 'NextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/audit/frameworks',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListFrameworksOutput.fromJson(response);
  }

  /// Returns an array of resources successfully backed up by Backup, including
  /// the time the resource was saved, an Amazon Resource Name (ARN) of the
  /// resource, and a resource type.
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to be returned.
  ///
  /// Parameter [nextToken] :
  /// The next item following a partial list of returned items. For example, if
  /// a request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list
  /// starting at the location pointed to by the next token.
  Future<ListProtectedResourcesOutput> listProtectedResources({
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1000,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/resources/',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListProtectedResourcesOutput.fromJson(response);
  }

  /// Returns detailed information about the recovery points stored in a backup
  /// vault.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupVaultName] :
  /// The name of a logical container where backups are stored. Backup vaults
  /// are identified by names that are unique to the account used to create them
  /// and the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  /// <note>
  /// Backup vault name might not be available when a supported service creates
  /// the backup.
  /// </note>
  ///
  /// Parameter [byBackupPlanId] :
  /// Returns only recovery points that match the specified backup plan ID.
  ///
  /// Parameter [byCreatedAfter] :
  /// Returns only recovery points that were created after the specified
  /// timestamp.
  ///
  /// Parameter [byCreatedBefore] :
  /// Returns only recovery points that were created before the specified
  /// timestamp.
  ///
  /// Parameter [byResourceArn] :
  /// Returns only recovery points that match the specified resource Amazon
  /// Resource Name (ARN).
  ///
  /// Parameter [byResourceType] :
  /// Returns only recovery points that match the specified resource type.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to be returned.
  ///
  /// Parameter [nextToken] :
  /// The next item following a partial list of returned items. For example, if
  /// a request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list
  /// starting at the location pointed to by the next token.
  Future<ListRecoveryPointsByBackupVaultOutput>
      listRecoveryPointsByBackupVault({
    required String backupVaultName,
    String? byBackupPlanId,
    DateTime? byCreatedAfter,
    DateTime? byCreatedBefore,
    String? byResourceArn,
    String? byResourceType,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1000,
    );
    final $query = <String, List<String>>{
      if (byBackupPlanId != null) 'backupPlanId': [byBackupPlanId],
      if (byCreatedAfter != null)
        'createdAfter': [_s.iso8601ToJson(byCreatedAfter).toString()],
      if (byCreatedBefore != null)
        'createdBefore': [_s.iso8601ToJson(byCreatedBefore).toString()],
      if (byResourceArn != null) 'resourceArn': [byResourceArn],
      if (byResourceType != null) 'resourceType': [byResourceType],
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/backup-vaults/${Uri.encodeComponent(backupVaultName)}/recovery-points/',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListRecoveryPointsByBackupVaultOutput.fromJson(response);
  }

  /// Returns detailed information about all the recovery points of the type
  /// specified by a resource Amazon Resource Name (ARN).
  /// <note>
  /// For Amazon EFS and Amazon EC2, this action only lists recovery points
  /// created by Backup.
  /// </note>
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [resourceArn] :
  /// An ARN that uniquely identifies a resource. The format of the ARN depends
  /// on the resource type.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to be returned.
  /// <note>
  /// Amazon RDS requires a value of at least 20.
  /// </note>
  ///
  /// Parameter [nextToken] :
  /// The next item following a partial list of returned items. For example, if
  /// a request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list
  /// starting at the location pointed to by the next token.
  Future<ListRecoveryPointsByResourceOutput> listRecoveryPointsByResource({
    required String resourceArn,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1000,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/resources/${Uri.encodeComponent(resourceArn)}/recovery-points/',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListRecoveryPointsByResourceOutput.fromJson(response);
  }

  /// Returns details about your report jobs.
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [byCreationAfter] :
  /// Returns only report jobs that were created after the date and time
  /// specified in Unix format and Coordinated Universal Time (UTC). For
  /// example, the value 1516925490 represents Friday, January 26, 2018 12:11:30
  /// AM.
  ///
  /// Parameter [byCreationBefore] :
  /// Returns only report jobs that were created before the date and time
  /// specified in Unix format and Coordinated Universal Time (UTC). For
  /// example, the value 1516925490 represents Friday, January 26, 2018 12:11:30
  /// AM.
  ///
  /// Parameter [byReportPlanName] :
  /// Returns only report jobs with the specified report plan name.
  ///
  /// Parameter [byStatus] :
  /// Returns only report jobs that are in the specified status. The statuses
  /// are:
  ///
  /// <code>CREATED | RUNNING | COMPLETED | FAILED</code>
  ///
  /// Parameter [maxResults] :
  /// The number of desired results from 1 to 1000. Optional. If unspecified,
  /// the query will return 1 MB of data.
  ///
  /// Parameter [nextToken] :
  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  Future<ListReportJobsOutput> listReportJobs({
    DateTime? byCreationAfter,
    DateTime? byCreationBefore,
    String? byReportPlanName,
    String? byStatus,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateStringLength(
      'byReportPlanName',
      byReportPlanName,
      1,
      256,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1000,
    );
    final $query = <String, List<String>>{
      if (byCreationAfter != null)
        'CreationAfter': [_s.iso8601ToJson(byCreationAfter).toString()],
      if (byCreationBefore != null)
        'CreationBefore': [_s.iso8601ToJson(byCreationBefore).toString()],
      if (byReportPlanName != null) 'ReportPlanName': [byReportPlanName],
      if (byStatus != null) 'Status': [byStatus],
      if (maxResults != null) 'MaxResults': [maxResults.toString()],
      if (nextToken != null) 'NextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/audit/report-jobs',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListReportJobsOutput.fromJson(response);
  }

  /// Returns a list of your report plans. For detailed information about a
  /// single report plan, use <code>DescribeReportPlan</code>.
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [maxResults] :
  /// The number of desired results from 1 to 1000. Optional. If unspecified,
  /// the query will return 1 MB of data.
  ///
  /// Parameter [nextToken] :
  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  Future<ListReportPlansOutput> listReportPlans({
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1000,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'MaxResults': [maxResults.toString()],
      if (nextToken != null) 'NextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/audit/report-plans',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListReportPlansOutput.fromJson(response);
  }

  /// Returns a list of jobs that Backup initiated to restore a saved resource,
  /// including details about the recovery process.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [byAccountId] :
  /// The account ID to list the jobs from. Returns only restore jobs associated
  /// with the specified account ID.
  ///
  /// Parameter [byCompleteAfter] :
  /// Returns only copy jobs completed after a date expressed in Unix format and
  /// Coordinated Universal Time (UTC).
  ///
  /// Parameter [byCompleteBefore] :
  /// Returns only copy jobs completed before a date expressed in Unix format
  /// and Coordinated Universal Time (UTC).
  ///
  /// Parameter [byCreatedAfter] :
  /// Returns only restore jobs that were created after the specified date.
  ///
  /// Parameter [byCreatedBefore] :
  /// Returns only restore jobs that were created before the specified date.
  ///
  /// Parameter [byStatus] :
  /// Returns only restore jobs associated with the specified job status.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to be returned.
  ///
  /// Parameter [nextToken] :
  /// The next item following a partial list of returned items. For example, if
  /// a request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list
  /// starting at the location pointed to by the next token.
  Future<ListRestoreJobsOutput> listRestoreJobs({
    String? byAccountId,
    DateTime? byCompleteAfter,
    DateTime? byCompleteBefore,
    DateTime? byCreatedAfter,
    DateTime? byCreatedBefore,
    RestoreJobStatus? byStatus,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1000,
    );
    final $query = <String, List<String>>{
      if (byAccountId != null) 'accountId': [byAccountId],
      if (byCompleteAfter != null)
        'completeAfter': [_s.iso8601ToJson(byCompleteAfter).toString()],
      if (byCompleteBefore != null)
        'completeBefore': [_s.iso8601ToJson(byCompleteBefore).toString()],
      if (byCreatedAfter != null)
        'createdAfter': [_s.iso8601ToJson(byCreatedAfter).toString()],
      if (byCreatedBefore != null)
        'createdBefore': [_s.iso8601ToJson(byCreatedBefore).toString()],
      if (byStatus != null) 'status': [byStatus.toValue()],
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/restore-jobs/',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListRestoreJobsOutput.fromJson(response);
  }

  /// Returns a list of key-value pairs assigned to a target recovery point,
  /// backup plan, or backup vault.
  ///
  /// <code>ListTags</code> only works for resource types that support full
  /// Backup management of their backups. Those resource types are listed in the
  /// "Full Backup management" section of the <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html#features-by-resource">
  /// Feature availability by resource</a> table.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [resourceArn] :
  /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
  /// format of the ARN depends on the type of resource. Valid targets for
  /// <code>ListTags</code> are recovery points, backup plans, and backup
  /// vaults.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of items to be returned.
  ///
  /// Parameter [nextToken] :
  /// The next item following a partial list of returned items. For example, if
  /// a request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list
  /// starting at the location pointed to by the next token.
  Future<ListTagsOutput> listTags({
    required String resourceArn,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      1000,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/tags/${Uri.encodeComponent(resourceArn)}/',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListTagsOutput.fromJson(response);
  }

  /// Sets a resource-based policy that is used to manage access permissions on
  /// the target backup vault. Requires a backup vault name and an access policy
  /// document in JSON format.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupVaultName] :
  /// The name of a logical container where backups are stored. Backup vaults
  /// are identified by names that are unique to the account used to create them
  /// and the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  ///
  /// Parameter [policy] :
  /// The backup vault access policy document in JSON format.
  Future<void> putBackupVaultAccessPolicy({
    required String backupVaultName,
    String? policy,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    final $payload = <String, dynamic>{
      if (policy != null) 'Policy': policy,
    };
    await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri:
          '/backup-vaults/${Uri.encodeComponent(backupVaultName)}/access-policy',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Applies Backup Vault Lock to a backup vault, preventing attempts to delete
  /// any recovery point stored in or created in a backup vault. Vault Lock also
  /// prevents attempts to update the lifecycle policy that controls the
  /// retention period of any recovery point currently stored in a backup vault.
  /// If specified, Vault Lock enforces a minimum and maximum retention period
  /// for future backup and copy jobs that target a backup vault.
  /// <note>
  /// Backup Vault Lock has yet to receive a third-party assessment for SEC
  /// 17a-4(f) and CFTC.
  /// </note>
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [InvalidRequestException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupVaultName] :
  /// The Backup Vault Lock configuration that specifies the name of the backup
  /// vault it protects.
  ///
  /// Parameter [changeableForDays] :
  /// The Backup Vault Lock configuration that specifies the number of days
  /// before the lock date. For example, setting <code>ChangeableForDays</code>
  /// to 30 on Jan. 1, 2022 at 8pm UTC will set the lock date to Jan. 31, 2022
  /// at 8pm UTC.
  ///
  /// Backup enforces a 72-hour cooling-off period before Vault Lock takes
  /// effect and becomes immutable. Therefore, you must set
  /// <code>ChangeableForDays</code> to 3 or greater.
  ///
  /// Before the lock date, you can delete Vault Lock from the vault using
  /// <code>DeleteBackupVaultLockConfiguration</code> or change the Vault Lock
  /// configuration using <code>PutBackupVaultLockConfiguration</code>. On and
  /// after the lock date, the Vault Lock becomes immutable and cannot be
  /// changed or deleted.
  ///
  /// If this parameter is not specified, you can delete Vault Lock from the
  /// vault using <code>DeleteBackupVaultLockConfiguration</code> or change the
  /// Vault Lock configuration using
  /// <code>PutBackupVaultLockConfiguration</code> at any time.
  ///
  /// Parameter [maxRetentionDays] :
  /// The Backup Vault Lock configuration that specifies the maximum retention
  /// period that the vault retains its recovery points. This setting can be
  /// useful if, for example, your organization's policies require you to
  /// destroy certain data after retaining it for four years (1460 days).
  ///
  /// If this parameter is not included, Vault Lock does not enforce a maximum
  /// retention period on the recovery points in the vault. If this parameter is
  /// included without a value, Vault Lock will not enforce a maximum retention
  /// period.
  ///
  /// If this parameter is specified, any backup or copy job to the vault must
  /// have a lifecycle policy with a retention period equal to or shorter than
  /// the maximum retention period. If the job's retention period is longer than
  /// that maximum retention period, then the vault fails the backup or copy
  /// job, and you should either modify your lifecycle settings or use a
  /// different vault. The longest maximum retention period you can specify is
  /// 36500 days (approximately 100 years). Recovery points already saved in the
  /// vault prior to Vault Lock are not affected.
  ///
  /// Parameter [minRetentionDays] :
  /// The Backup Vault Lock configuration that specifies the minimum retention
  /// period that the vault retains its recovery points. This setting can be
  /// useful if, for example, your organization's policies require you to retain
  /// certain data for at least seven years (2555 days).
  ///
  /// If this parameter is not specified, Vault Lock will not enforce a minimum
  /// retention period.
  ///
  /// If this parameter is specified, any backup or copy job to the vault must
  /// have a lifecycle policy with a retention period equal to or longer than
  /// the minimum retention period. If the job's retention period is shorter
  /// than that minimum retention period, then the vault fails that backup or
  /// copy job, and you should either modify your lifecycle settings or use a
  /// different vault. The shortest minimum retention period you can specify is
  /// 1 day. Recovery points already saved in the vault prior to Vault Lock are
  /// not affected.
  Future<void> putBackupVaultLockConfiguration({
    required String backupVaultName,
    int? changeableForDays,
    int? maxRetentionDays,
    int? minRetentionDays,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    final $payload = <String, dynamic>{
      if (changeableForDays != null) 'ChangeableForDays': changeableForDays,
      if (maxRetentionDays != null) 'MaxRetentionDays': maxRetentionDays,
      if (minRetentionDays != null) 'MinRetentionDays': minRetentionDays,
    };
    await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri:
          '/backup-vaults/${Uri.encodeComponent(backupVaultName)}/vault-lock',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Turns on notifications on a backup vault for the specified topic and
  /// events.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupVaultEvents] :
  /// An array of events that indicate the status of jobs to back up resources
  /// to the backup vault.
  ///
  /// For common use cases and code samples, see <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/sns-notifications.html">Using
  /// Amazon SNS to track Backup events</a>.
  ///
  /// The following events are supported:
  ///
  /// <ul>
  /// <li>
  /// <code>BACKUP_JOB_STARTED</code> | <code>BACKUP_JOB_COMPLETED</code>
  /// </li>
  /// <li>
  /// <code>COPY_JOB_STARTED</code> | <code>COPY_JOB_SUCCESSFUL</code> |
  /// <code>COPY_JOB_FAILED</code>
  /// </li>
  /// <li>
  /// <code>RESTORE_JOB_STARTED</code> | <code>RESTORE_JOB_COMPLETED</code> |
  /// <code>RECOVERY_POINT_MODIFIED</code>
  /// </li>
  /// <li>
  /// <code>S3_BACKUP_OBJECT_FAILED</code> |
  /// <code>S3_RESTORE_OBJECT_FAILED</code>
  /// </li>
  /// </ul> <note>
  /// Ignore the list below because it includes deprecated events. Refer to the
  /// list above.
  /// </note>
  ///
  /// Parameter [backupVaultName] :
  /// The name of a logical container where backups are stored. Backup vaults
  /// are identified by names that are unique to the account used to create them
  /// and the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  ///
  /// Parameter [sNSTopicArn] :
  /// The Amazon Resource Name (ARN) that specifies the topic for a backup
  /// vault’s events; for example,
  /// <code>arn:aws:sns:us-west-2:111122223333:MyVaultTopic</code>.
  Future<void> putBackupVaultNotifications({
    required List<BackupVaultEvent> backupVaultEvents,
    required String backupVaultName,
    required String sNSTopicArn,
  }) async {
    ArgumentError.checkNotNull(backupVaultEvents, 'backupVaultEvents');
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    ArgumentError.checkNotNull(sNSTopicArn, 'sNSTopicArn');
    final $payload = <String, dynamic>{
      'BackupVaultEvents': backupVaultEvents.map((e) => e.toValue()).toList(),
      'SNSTopicArn': sNSTopicArn,
    };
    await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri:
          '/backup-vaults/${Uri.encodeComponent(backupVaultName)}/notification-configuration',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Starts an on-demand backup job for the specified resource.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [InvalidRequestException].
  /// May throw [ServiceUnavailableException].
  /// May throw [LimitExceededException].
  ///
  /// Parameter [backupVaultName] :
  /// The name of a logical container where backups are stored. Backup vaults
  /// are identified by names that are unique to the account used to create them
  /// and the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  ///
  /// Parameter [iamRoleArn] :
  /// Specifies the IAM role ARN used to create the target recovery point; for
  /// example, <code>arn:aws:iam::123456789012:role/S3Access</code>.
  ///
  /// Parameter [resourceArn] :
  /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
  /// format of the ARN depends on the resource type.
  ///
  /// Parameter [backupOptions] :
  /// Specifies the backup option for a selected resource. This option is only
  /// available for Windows Volume Shadow Copy Service (VSS) backup jobs.
  ///
  /// Valid values: Set to <code>"WindowsVSS":"enabled"</code> to enable the
  /// <code>WindowsVSS</code> backup option and create a Windows VSS backup. Set
  /// to <code>"WindowsVSS""disabled"</code> to create a regular backup. The
  /// <code>WindowsVSS</code> option is not enabled by default.
  ///
  /// Parameter [completeWindowMinutes] :
  /// A value in minutes during which a successfully started backup must
  /// complete, or else Backup will cancel the job. This value is optional. This
  /// value begins counting down from when the backup was scheduled. It does not
  /// add additional time for <code>StartWindowMinutes</code>, or if the backup
  /// started later than scheduled.
  ///
  /// Parameter [idempotencyToken] :
  /// A customer-chosen string that you can use to distinguish between otherwise
  /// identical calls to <code>StartBackupJob</code>. Retrying a successful
  /// request with the same idempotency token results in a success message with
  /// no action taken.
  ///
  /// Parameter [lifecycle] :
  /// The lifecycle defines when a protected resource is transitioned to cold
  /// storage and when it expires. Backup will transition and expire backups
  /// automatically according to the lifecycle that you define.
  ///
  /// Backups transitioned to cold storage must be stored in cold storage for a
  /// minimum of 90 days. Therefore, the “retention” setting must be 90 days
  /// greater than the “transition to cold after days” setting. The “transition
  /// to cold after days” setting cannot be changed after a backup has been
  /// transitioned to cold.
  ///
  /// Resource types that are able to be transitioned to cold storage are listed
  /// in the "Lifecycle to cold storage" section of the <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html#features-by-resource">
  /// Feature availability by resource</a> table. Backup ignores this expression
  /// for other resource types.
  ///
  /// Parameter [recoveryPointTags] :
  /// To help organize your resources, you can assign your own metadata to the
  /// resources that you create. Each tag is a key-value pair.
  ///
  /// Parameter [startWindowMinutes] :
  /// A value in minutes after a backup is scheduled before a job will be
  /// canceled if it doesn't start successfully. This value is optional, and the
  /// default is 8 hours.
  Future<StartBackupJobOutput> startBackupJob({
    required String backupVaultName,
    required String iamRoleArn,
    required String resourceArn,
    Map<String, String>? backupOptions,
    int? completeWindowMinutes,
    String? idempotencyToken,
    Lifecycle? lifecycle,
    Map<String, String>? recoveryPointTags,
    int? startWindowMinutes,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    ArgumentError.checkNotNull(iamRoleArn, 'iamRoleArn');
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    final $payload = <String, dynamic>{
      'BackupVaultName': backupVaultName,
      'IamRoleArn': iamRoleArn,
      'ResourceArn': resourceArn,
      if (backupOptions != null) 'BackupOptions': backupOptions,
      if (completeWindowMinutes != null)
        'CompleteWindowMinutes': completeWindowMinutes,
      if (idempotencyToken != null) 'IdempotencyToken': idempotencyToken,
      if (lifecycle != null) 'Lifecycle': lifecycle,
      if (recoveryPointTags != null) 'RecoveryPointTags': recoveryPointTags,
      if (startWindowMinutes != null) 'StartWindowMinutes': startWindowMinutes,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/backup-jobs',
      exceptionFnMap: _exceptionFns,
    );
    return StartBackupJobOutput.fromJson(response);
  }

  /// Starts a job to create a one-time copy of the specified resource.
  ///
  /// Does not support continuous backups.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  /// May throw [LimitExceededException].
  /// May throw [InvalidRequestException].
  ///
  /// Parameter [destinationBackupVaultArn] :
  /// An Amazon Resource Name (ARN) that uniquely identifies a destination
  /// backup vault to copy to; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:aBackupVault</code>.
  ///
  /// Parameter [iamRoleArn] :
  /// Specifies the IAM role ARN used to copy the target recovery point; for
  /// example, <code>arn:aws:iam::123456789012:role/S3Access</code>.
  ///
  /// Parameter [recoveryPointArn] :
  /// An ARN that uniquely identifies a recovery point to use for the copy job;
  /// for example,
  /// arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45.
  ///
  /// Parameter [sourceBackupVaultName] :
  /// The name of a logical source container where backups are stored. Backup
  /// vaults are identified by names that are unique to the account used to
  /// create them and the Amazon Web Services Region where they are created.
  /// They consist of lowercase letters, numbers, and hyphens.
  ///
  /// Parameter [idempotencyToken] :
  /// A customer-chosen string that you can use to distinguish between otherwise
  /// identical calls to <code>StartCopyJob</code>. Retrying a successful
  /// request with the same idempotency token results in a success message with
  /// no action taken.
  Future<StartCopyJobOutput> startCopyJob({
    required String destinationBackupVaultArn,
    required String iamRoleArn,
    required String recoveryPointArn,
    required String sourceBackupVaultName,
    String? idempotencyToken,
    Lifecycle? lifecycle,
  }) async {
    ArgumentError.checkNotNull(
        destinationBackupVaultArn, 'destinationBackupVaultArn');
    ArgumentError.checkNotNull(iamRoleArn, 'iamRoleArn');
    ArgumentError.checkNotNull(recoveryPointArn, 'recoveryPointArn');
    ArgumentError.checkNotNull(sourceBackupVaultName, 'sourceBackupVaultName');
    final $payload = <String, dynamic>{
      'DestinationBackupVaultArn': destinationBackupVaultArn,
      'IamRoleArn': iamRoleArn,
      'RecoveryPointArn': recoveryPointArn,
      'SourceBackupVaultName': sourceBackupVaultName,
      if (idempotencyToken != null) 'IdempotencyToken': idempotencyToken,
      if (lifecycle != null) 'Lifecycle': lifecycle,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/copy-jobs',
      exceptionFnMap: _exceptionFns,
    );
    return StartCopyJobOutput.fromJson(response);
  }

  /// Starts an on-demand report job for the specified report plan.
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [ServiceUnavailableException].
  /// May throw [MissingParameterValueException].
  /// May throw [ResourceNotFoundException].
  ///
  /// Parameter [reportPlanName] :
  /// The unique name of a report plan.
  ///
  /// Parameter [idempotencyToken] :
  /// A customer-chosen string that you can use to distinguish between otherwise
  /// identical calls to <code>StartReportJobInput</code>. Retrying a successful
  /// request with the same idempotency token results in a success message with
  /// no action taken.
  Future<StartReportJobOutput> startReportJob({
    required String reportPlanName,
    String? idempotencyToken,
  }) async {
    ArgumentError.checkNotNull(reportPlanName, 'reportPlanName');
    _s.validateStringLength(
      'reportPlanName',
      reportPlanName,
      1,
      256,
      isRequired: true,
    );
    final $payload = <String, dynamic>{
      'IdempotencyToken': idempotencyToken ?? _s.generateIdempotencyToken(),
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/audit/report-jobs/${Uri.encodeComponent(reportPlanName)}',
      exceptionFnMap: _exceptionFns,
    );
    return StartReportJobOutput.fromJson(response);
  }

  /// Recovers the saved resource identified by an Amazon Resource Name (ARN).
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [metadata] :
  /// A set of metadata key-value pairs. Contains information, such as a
  /// resource name, required to restore a recovery point.
  ///
  /// You can get configuration metadata about a resource at the time it was
  /// backed up by calling <code>GetRecoveryPointRestoreMetadata</code>.
  /// However, values in addition to those provided by
  /// <code>GetRecoveryPointRestoreMetadata</code> might be required to restore
  /// a resource. For example, you might need to provide a new resource name if
  /// the original already exists.
  ///
  /// You need to specify specific metadata to restore an Amazon Elastic File
  /// System (Amazon EFS) instance:
  ///
  /// <ul>
  /// <li>
  /// <code>file-system-id</code>: The ID of the Amazon EFS file system that is
  /// backed up by Backup. Returned in
  /// <code>GetRecoveryPointRestoreMetadata</code>.
  /// </li>
  /// <li>
  /// <code>Encrypted</code>: A Boolean value that, if true, specifies that the
  /// file system is encrypted. If <code>KmsKeyId</code> is specified,
  /// <code>Encrypted</code> must be set to <code>true</code>.
  /// </li>
  /// <li>
  /// <code>KmsKeyId</code>: Specifies the Amazon Web Services KMS key that is
  /// used to encrypt the restored file system. You can specify a key from
  /// another Amazon Web Services account provided that key it is properly
  /// shared with your account via Amazon Web Services KMS.
  /// </li>
  /// <li>
  /// <code>PerformanceMode</code>: Specifies the throughput mode of the file
  /// system.
  /// </li>
  /// <li>
  /// <code>CreationToken</code>: A user-supplied value that ensures the
  /// uniqueness (idempotency) of the request.
  /// </li>
  /// <li>
  /// <code>newFileSystem</code>: A Boolean value that, if true, specifies that
  /// the recovery point is restored to a new Amazon EFS file system.
  /// </li>
  /// <li>
  /// <code>ItemsToRestore</code>: An array of one to five strings where each
  /// string is a file path. Use <code>ItemsToRestore</code> to restore specific
  /// files or directories rather than the entire file system. This parameter is
  /// optional. For example, <code>"itemsToRestore":"[\"/my.test\"]"</code>.
  /// </li>
  /// </ul>
  ///
  /// Parameter [recoveryPointArn] :
  /// An ARN that uniquely identifies a recovery point; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  ///
  /// Parameter [iamRoleArn] :
  /// The Amazon Resource Name (ARN) of the IAM role that Backup uses to create
  /// the target recovery point; for example,
  /// <code>arn:aws:iam::123456789012:role/S3Access</code>.
  ///
  /// Parameter [idempotencyToken] :
  /// A customer-chosen string that you can use to distinguish between otherwise
  /// identical calls to <code>StartRestoreJob</code>. Retrying a successful
  /// request with the same idempotency token results in a success message with
  /// no action taken.
  ///
  /// Parameter [resourceType] :
  /// Starts a job to restore a recovery point for one of the following
  /// resources:
  ///
  /// <ul>
  /// <li>
  /// <code>Aurora</code> for Amazon Aurora
  /// </li>
  /// <li>
  /// <code>DocumentDB</code> for Amazon DocumentDB (with MongoDB compatibility)
  /// </li>
  /// <li>
  /// <code>DynamoDB</code> for Amazon DynamoDB
  /// </li>
  /// <li>
  /// <code>EBS</code> for Amazon Elastic Block Store
  /// </li>
  /// <li>
  /// <code>EC2</code> for Amazon Elastic Compute Cloud
  /// </li>
  /// <li>
  /// <code>EFS</code> for Amazon Elastic File System
  /// </li>
  /// <li>
  /// <code>FSx</code> for Amazon FSx
  /// </li>
  /// <li>
  /// <code>Neptune</code> for Amazon Neptune
  /// </li>
  /// <li>
  /// <code>RDS</code> for Amazon Relational Database Service
  /// </li>
  /// <li>
  /// <code>Storage Gateway</code> for Storage Gateway
  /// </li>
  /// <li>
  /// <code>S3</code> for Amazon S3
  /// </li>
  /// <li>
  /// <code>VirtualMachine</code> for virtual machines
  /// </li>
  /// </ul>
  Future<StartRestoreJobOutput> startRestoreJob({
    required Map<String, String> metadata,
    required String recoveryPointArn,
    String? iamRoleArn,
    String? idempotencyToken,
    String? resourceType,
  }) async {
    ArgumentError.checkNotNull(metadata, 'metadata');
    ArgumentError.checkNotNull(recoveryPointArn, 'recoveryPointArn');
    final $payload = <String, dynamic>{
      'Metadata': metadata,
      'RecoveryPointArn': recoveryPointArn,
      if (iamRoleArn != null) 'IamRoleArn': iamRoleArn,
      if (idempotencyToken != null) 'IdempotencyToken': idempotencyToken,
      if (resourceType != null) 'ResourceType': resourceType,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/restore-jobs',
      exceptionFnMap: _exceptionFns,
    );
    return StartRestoreJobOutput.fromJson(response);
  }

  /// Attempts to cancel a job to create a one-time backup of a resource.
  ///
  /// May throw [MissingParameterValueException].
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [InvalidRequestException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupJobId] :
  /// Uniquely identifies a request to Backup to back up a resource.
  Future<void> stopBackupJob({
    required String backupJobId,
  }) async {
    ArgumentError.checkNotNull(backupJobId, 'backupJobId');
    await _protocol.send(
      payload: null,
      method: 'POST',
      requestUri: '/backup-jobs/${Uri.encodeComponent(backupJobId)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Assigns a set of key-value pairs to a recovery point, backup plan, or
  /// backup vault identified by an Amazon Resource Name (ARN).
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  /// May throw [LimitExceededException].
  ///
  /// Parameter [resourceArn] :
  /// An ARN that uniquely identifies a resource. The format of the ARN depends
  /// on the type of the tagged resource.
  ///
  /// Parameter [tags] :
  /// Key-value pairs that are used to help organize your resources. You can
  /// assign your own metadata to the resources you create. For clarity, this is
  /// the structure to assign tags:
  /// <code>[{"Key":"string","Value":"string"}]</code>.
  Future<void> tagResource({
    required String resourceArn,
    required Map<String, String> tags,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    ArgumentError.checkNotNull(tags, 'tags');
    final $payload = <String, dynamic>{
      'Tags': tags,
    };
    await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/tags/${Uri.encodeComponent(resourceArn)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Removes a set of key-value pairs from a recovery point, backup plan, or
  /// backup vault identified by an Amazon Resource Name (ARN)
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [resourceArn] :
  /// An ARN that uniquely identifies a resource. The format of the ARN depends
  /// on the type of the tagged resource.
  ///
  /// Parameter [tagKeyList] :
  /// A list of keys to identify which key-value tags to remove from a resource.
  Future<void> untagResource({
    required String resourceArn,
    required List<String> tagKeyList,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    ArgumentError.checkNotNull(tagKeyList, 'tagKeyList');
    final $payload = <String, dynamic>{
      'TagKeyList': tagKeyList,
    };
    await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/untag/${Uri.encodeComponent(resourceArn)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Updates an existing backup plan identified by its
  /// <code>backupPlanId</code> with the input document in JSON format. The new
  /// version is uniquely identified by a <code>VersionId</code>.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupPlan] :
  /// Specifies the body of a backup plan. Includes a
  /// <code>BackupPlanName</code> and one or more sets of <code>Rules</code>.
  ///
  /// Parameter [backupPlanId] :
  /// Uniquely identifies a backup plan.
  Future<UpdateBackupPlanOutput> updateBackupPlan({
    required BackupPlanInput backupPlan,
    required String backupPlanId,
  }) async {
    ArgumentError.checkNotNull(backupPlan, 'backupPlan');
    ArgumentError.checkNotNull(backupPlanId, 'backupPlanId');
    final $payload = <String, dynamic>{
      'BackupPlan': backupPlan,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/backup/plans/${Uri.encodeComponent(backupPlanId)}',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateBackupPlanOutput.fromJson(response);
  }

  /// Updates an existing framework identified by its <code>FrameworkName</code>
  /// with the input document in JSON format.
  ///
  /// May throw [AlreadyExistsException].
  /// May throw [ResourceNotFoundException].
  /// May throw [LimitExceededException].
  /// May throw [InvalidParameterValueException].
  /// May throw [MissingParameterValueException].
  /// May throw [ConflictException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [frameworkName] :
  /// The unique name of a framework. This name is between 1 and 256 characters,
  /// starting with a letter, and consisting of letters (a-z, A-Z), numbers
  /// (0-9), and underscores (_).
  ///
  /// Parameter [frameworkControls] :
  /// A list of the controls that make up the framework. Each control in the
  /// list has a name, input parameters, and scope.
  ///
  /// Parameter [frameworkDescription] :
  /// An optional description of the framework with a maximum 1,024 characters.
  ///
  /// Parameter [idempotencyToken] :
  /// A customer-chosen string that you can use to distinguish between otherwise
  /// identical calls to <code>UpdateFrameworkInput</code>. Retrying a
  /// successful request with the same idempotency token results in a success
  /// message with no action taken.
  Future<UpdateFrameworkOutput> updateFramework({
    required String frameworkName,
    List<FrameworkControl>? frameworkControls,
    String? frameworkDescription,
    String? idempotencyToken,
  }) async {
    ArgumentError.checkNotNull(frameworkName, 'frameworkName');
    _s.validateStringLength(
      'frameworkName',
      frameworkName,
      1,
      256,
      isRequired: true,
    );
    _s.validateStringLength(
      'frameworkDescription',
      frameworkDescription,
      0,
      1024,
    );
    final $payload = <String, dynamic>{
      if (frameworkControls != null) 'FrameworkControls': frameworkControls,
      if (frameworkDescription != null)
        'FrameworkDescription': frameworkDescription,
      'IdempotencyToken': idempotencyToken ?? _s.generateIdempotencyToken(),
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/audit/frameworks/${Uri.encodeComponent(frameworkName)}',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateFrameworkOutput.fromJson(response);
  }

  /// Updates whether the Amazon Web Services account is opted in to
  /// cross-account backup. Returns an error if the account is not an
  /// Organizations management account. Use the
  /// <code>DescribeGlobalSettings</code> API to determine the current settings.
  ///
  /// May throw [ServiceUnavailableException].
  /// May throw [MissingParameterValueException].
  /// May throw [InvalidParameterValueException].
  /// May throw [InvalidRequestException].
  ///
  /// Parameter [globalSettings] :
  /// A value for <code>isCrossAccountBackupEnabled</code> and a Region.
  /// Example: <code>update-global-settings --global-settings
  /// isCrossAccountBackupEnabled=false --region us-west-2</code>.
  Future<void> updateGlobalSettings({
    Map<String, String>? globalSettings,
  }) async {
    final $payload = <String, dynamic>{
      if (globalSettings != null) 'GlobalSettings': globalSettings,
    };
    await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/global-settings',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Sets the transition lifecycle of a recovery point.
  ///
  /// The lifecycle defines when a protected resource is transitioned to cold
  /// storage and when it expires. Backup transitions and expires backups
  /// automatically according to the lifecycle that you define.
  ///
  /// Backups transitioned to cold storage must be stored in cold storage for a
  /// minimum of 90 days. Therefore, the “retention” setting must be 90 days
  /// greater than the “transition to cold after days” setting. The “transition
  /// to cold after days” setting cannot be changed after a backup has been
  /// transitioned to cold.
  ///
  /// Resource types that are able to be transitioned to cold storage are listed
  /// in the "Lifecycle to cold storage" section of the <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html#features-by-resource">
  /// Feature availability by resource</a> table. Backup ignores this expression
  /// for other resource types.
  ///
  /// This operation does not support continuous backups.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [InvalidRequestException].
  /// May throw [MissingParameterValueException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [backupVaultName] :
  /// The name of a logical container where backups are stored. Backup vaults
  /// are identified by names that are unique to the account used to create them
  /// and the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  ///
  /// Parameter [recoveryPointArn] :
  /// An Amazon Resource Name (ARN) that uniquely identifies a recovery point;
  /// for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  ///
  /// Parameter [lifecycle] :
  /// The lifecycle defines when a protected resource is transitioned to cold
  /// storage and when it expires. Backup transitions and expires backups
  /// automatically according to the lifecycle that you define.
  ///
  /// Backups transitioned to cold storage must be stored in cold storage for a
  /// minimum of 90 days. Therefore, the “retention” setting must be 90 days
  /// greater than the “transition to cold after days” setting. The “transition
  /// to cold after days” setting cannot be changed after a backup has been
  /// transitioned to cold.
  Future<UpdateRecoveryPointLifecycleOutput> updateRecoveryPointLifecycle({
    required String backupVaultName,
    required String recoveryPointArn,
    Lifecycle? lifecycle,
  }) async {
    ArgumentError.checkNotNull(backupVaultName, 'backupVaultName');
    ArgumentError.checkNotNull(recoveryPointArn, 'recoveryPointArn');
    final $payload = <String, dynamic>{
      if (lifecycle != null) 'Lifecycle': lifecycle,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/backup-vaults/${Uri.encodeComponent(backupVaultName)}/recovery-points/${Uri.encodeComponent(recoveryPointArn)}',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateRecoveryPointLifecycleOutput.fromJson(response);
  }

  /// Updates the current service opt-in settings for the Region. If
  /// service-opt-in is enabled for a service, Backup tries to protect that
  /// service's resources in this Region, when the resource is included in an
  /// on-demand backup or scheduled backup plan. Otherwise, Backup does not try
  /// to protect that service's resources in this Region. Use the
  /// <code>DescribeRegionSettings</code> API to determine the resource types
  /// that are supported.
  ///
  /// May throw [ServiceUnavailableException].
  /// May throw [MissingParameterValueException].
  /// May throw [InvalidParameterValueException].
  ///
  /// Parameter [resourceTypeManagementPreference] :
  /// Enables or disables full Backup management of backups for a resource type.
  /// To enable full Backup management for DynamoDB along with <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/advanced-ddb-backup.html">
  /// Backup's advanced DynamoDB backup features</a>, follow the procedure to <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/advanced-ddb-backup.html#advanced-ddb-backup-enable-cli">
  /// enable advanced DynamoDB backup programmatically</a>.
  ///
  /// Parameter [resourceTypeOptInPreference] :
  /// Updates the list of services along with the opt-in preferences for the
  /// Region.
  Future<void> updateRegionSettings({
    Map<String, bool>? resourceTypeManagementPreference,
    Map<String, bool>? resourceTypeOptInPreference,
  }) async {
    final $payload = <String, dynamic>{
      if (resourceTypeManagementPreference != null)
        'ResourceTypeManagementPreference': resourceTypeManagementPreference,
      if (resourceTypeOptInPreference != null)
        'ResourceTypeOptInPreference': resourceTypeOptInPreference,
    };
    await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/account-settings',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Updates an existing report plan identified by its
  /// <code>ReportPlanName</code> with the input document in JSON format.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [ServiceUnavailableException].
  /// May throw [MissingParameterValueException].
  /// May throw [ConflictException].
  ///
  /// Parameter [reportPlanName] :
  /// The unique name of the report plan. This name is between 1 and 256
  /// characters, starting with a letter, and consisting of letters (a-z, A-Z),
  /// numbers (0-9), and underscores (_).
  ///
  /// Parameter [idempotencyToken] :
  /// A customer-chosen string that you can use to distinguish between otherwise
  /// identical calls to <code>UpdateReportPlanInput</code>. Retrying a
  /// successful request with the same idempotency token results in a success
  /// message with no action taken.
  ///
  /// Parameter [reportDeliveryChannel] :
  /// A structure that contains information about where to deliver your reports,
  /// specifically your Amazon S3 bucket name, S3 key prefix, and the formats of
  /// your reports.
  ///
  /// Parameter [reportPlanDescription] :
  /// An optional description of the report plan with a maximum 1,024
  /// characters.
  ///
  /// Parameter [reportSetting] :
  /// Identifies the report template for the report. Reports are built using a
  /// report template. The report templates are:
  ///
  /// <code>RESOURCE_COMPLIANCE_REPORT | CONTROL_COMPLIANCE_REPORT |
  /// BACKUP_JOB_REPORT | COPY_JOB_REPORT | RESTORE_JOB_REPORT</code>
  ///
  /// If the report template is <code>RESOURCE_COMPLIANCE_REPORT</code> or
  /// <code>CONTROL_COMPLIANCE_REPORT</code>, this API resource also describes
  /// the report coverage by Amazon Web Services Regions and frameworks.
  Future<UpdateReportPlanOutput> updateReportPlan({
    required String reportPlanName,
    String? idempotencyToken,
    ReportDeliveryChannel? reportDeliveryChannel,
    String? reportPlanDescription,
    ReportSetting? reportSetting,
  }) async {
    ArgumentError.checkNotNull(reportPlanName, 'reportPlanName');
    _s.validateStringLength(
      'reportPlanName',
      reportPlanName,
      1,
      256,
      isRequired: true,
    );
    _s.validateStringLength(
      'reportPlanDescription',
      reportPlanDescription,
      0,
      1024,
    );
    final $payload = <String, dynamic>{
      'IdempotencyToken': idempotencyToken ?? _s.generateIdempotencyToken(),
      if (reportDeliveryChannel != null)
        'ReportDeliveryChannel': reportDeliveryChannel,
      if (reportPlanDescription != null)
        'ReportPlanDescription': reportPlanDescription,
      if (reportSetting != null) 'ReportSetting': reportSetting,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/audit/report-plans/${Uri.encodeComponent(reportPlanName)}',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateReportPlanOutput.fromJson(response);
  }
}

/// A list of backup options for each resource type.
class AdvancedBackupSetting {
  /// Specifies the backup option for a selected resource. This option is only
  /// available for Windows VSS backup jobs.
  ///
  /// Valid values:
  ///
  /// Set to <code>"WindowsVSS":"enabled"</code> to enable the
  /// <code>WindowsVSS</code> backup option and create a Windows VSS backup.
  ///
  /// Set to <code>"WindowsVSS":"disabled"</code> to create a regular backup. The
  /// <code>WindowsVSS</code> option is not enabled by default.
  ///
  /// If you specify an invalid option, you get an
  /// <code>InvalidParameterValueException</code> exception.
  ///
  /// For more information about Windows VSS backups, see <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/windows-backups.html">Creating
  /// a VSS-Enabled Windows Backup</a>.
  final Map<String, String>? backupOptions;

  /// Specifies an object containing resource type and backup options. The only
  /// supported resource type is Amazon EC2 instances with Windows Volume Shadow
  /// Copy Service (VSS). For a CloudFormation example, see the <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/integrate-cloudformation-with-aws-backup.html">sample
  /// CloudFormation template to enable Windows VSS</a> in the <i>Backup User
  /// Guide</i>.
  ///
  /// Valid values: <code>EC2</code>.
  final String? resourceType;

  AdvancedBackupSetting({
    this.backupOptions,
    this.resourceType,
  });
  factory AdvancedBackupSetting.fromJson(Map<String, dynamic> json) {
    return AdvancedBackupSetting(
      backupOptions: (json['BackupOptions'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      resourceType: json['ResourceType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final backupOptions = this.backupOptions;
    final resourceType = this.resourceType;
    return {
      if (backupOptions != null) 'BackupOptions': backupOptions,
      if (resourceType != null) 'ResourceType': resourceType,
    };
  }
}

/// Contains detailed information about a backup job.
class BackupJob {
  /// The account ID that owns the backup job.
  final String? accountId;

  /// Uniquely identifies a request to Backup to back up a resource.
  final String? backupJobId;

  /// Specifies the backup option for a selected resource. This option is only
  /// available for Windows Volume Shadow Copy Service (VSS) backup jobs.
  ///
  /// Valid values: Set to <code>"WindowsVSS":"enabled"</code> to enable the
  /// <code>WindowsVSS</code> backup option and create a Windows VSS backup. Set
  /// to <code>"WindowsVSS":"disabled"</code> to create a regular backup. If you
  /// specify an invalid option, you get an
  /// <code>InvalidParameterValueException</code> exception.
  final Map<String, String>? backupOptions;

  /// The size, in bytes, of a backup.
  final int? backupSizeInBytes;

  /// Represents the type of backup for a backup job.
  final String? backupType;

  /// An Amazon Resource Name (ARN) that uniquely identifies a backup vault; for
  /// example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:aBackupVault</code>.
  final String? backupVaultArn;

  /// The name of a logical container where backups are stored. Backup vaults are
  /// identified by names that are unique to the account used to create them and
  /// the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  final String? backupVaultName;

  /// The size in bytes transferred to a backup vault at the time that the job
  /// status was queried.
  final int? bytesTransferred;

  /// The date and time a job to create a backup job is completed, in Unix format
  /// and Coordinated Universal Time (UTC). The value of
  /// <code>CompletionDate</code> is accurate to milliseconds. For example, the
  /// value 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? completionDate;

  /// Contains identifying information about the creation of a backup job,
  /// including the <code>BackupPlanArn</code>, <code>BackupPlanId</code>,
  /// <code>BackupPlanVersion</code>, and <code>BackupRuleId</code> of the backup
  /// plan used to create it.
  final RecoveryPointCreator? createdBy;

  /// The date and time a backup job is created, in Unix format and Coordinated
  /// Universal Time (UTC). The value of <code>CreationDate</code> is accurate to
  /// milliseconds. For example, the value 1516925490.087 represents Friday,
  /// January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// The date and time a job to back up resources is expected to be completed, in
  /// Unix format and Coordinated Universal Time (UTC). The value of
  /// <code>ExpectedCompletionDate</code> is accurate to milliseconds. For
  /// example, the value 1516925490.087 represents Friday, January 26, 2018
  /// 12:11:30.087 AM.
  final DateTime? expectedCompletionDate;

  /// Specifies the IAM role ARN used to create the target recovery point. IAM
  /// roles other than the default role must include either <code>AWSBackup</code>
  /// or <code>AwsBackup</code> in the role name. For example,
  /// <code>arn:aws:iam::123456789012:role/AWSBackupRDSAccess</code>. Role names
  /// without those strings lack permissions to perform backup jobs.
  final String? iamRoleArn;

  /// Contains an estimated percentage complete of a job at the time the job
  /// status was queried.
  final String? percentDone;

  /// An ARN that uniquely identifies a recovery point; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  final String? recoveryPointArn;

  /// An ARN that uniquely identifies a resource. The format of the ARN depends on
  /// the resource type.
  final String? resourceArn;

  /// The type of Amazon Web Services resource to be backed up; for example, an
  /// Amazon Elastic Block Store (Amazon EBS) volume or an Amazon Relational
  /// Database Service (Amazon RDS) database. For Windows Volume Shadow Copy
  /// Service (VSS) backups, the only supported resource type is Amazon EC2.
  final String? resourceType;

  /// Specifies the time in Unix format and Coordinated Universal Time (UTC) when
  /// a backup job must be started before it is canceled. The value is calculated
  /// by adding the start window to the scheduled time. So if the scheduled time
  /// were 6:00 PM and the start window is 2 hours, the <code>StartBy</code> time
  /// would be 8:00 PM on the date specified. The value of <code>StartBy</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? startBy;

  /// The current state of a resource recovery point.
  final BackupJobState? state;

  /// A detailed message explaining the status of the job to back up a resource.
  final String? statusMessage;

  BackupJob({
    this.accountId,
    this.backupJobId,
    this.backupOptions,
    this.backupSizeInBytes,
    this.backupType,
    this.backupVaultArn,
    this.backupVaultName,
    this.bytesTransferred,
    this.completionDate,
    this.createdBy,
    this.creationDate,
    this.expectedCompletionDate,
    this.iamRoleArn,
    this.percentDone,
    this.recoveryPointArn,
    this.resourceArn,
    this.resourceType,
    this.startBy,
    this.state,
    this.statusMessage,
  });
  factory BackupJob.fromJson(Map<String, dynamic> json) {
    return BackupJob(
      accountId: json['AccountId'] as String?,
      backupJobId: json['BackupJobId'] as String?,
      backupOptions: (json['BackupOptions'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      backupSizeInBytes: json['BackupSizeInBytes'] as int?,
      backupType: json['BackupType'] as String?,
      backupVaultArn: json['BackupVaultArn'] as String?,
      backupVaultName: json['BackupVaultName'] as String?,
      bytesTransferred: json['BytesTransferred'] as int?,
      completionDate: timeStampFromJson(json['CompletionDate']),
      createdBy: json['CreatedBy'] != null
          ? RecoveryPointCreator.fromJson(
              json['CreatedBy'] as Map<String, dynamic>)
          : null,
      creationDate: timeStampFromJson(json['CreationDate']),
      expectedCompletionDate: timeStampFromJson(json['ExpectedCompletionDate']),
      iamRoleArn: json['IamRoleArn'] as String?,
      percentDone: json['PercentDone'] as String?,
      recoveryPointArn: json['RecoveryPointArn'] as String?,
      resourceArn: json['ResourceArn'] as String?,
      resourceType: json['ResourceType'] as String?,
      startBy: timeStampFromJson(json['StartBy']),
      state: (json['State'] as String?)?.toBackupJobState(),
      statusMessage: json['StatusMessage'] as String?,
    );
  }
}

enum BackupJobState {
  created,
  pending,
  running,
  aborting,
  aborted,
  completed,
  failed,
  expired,
}

extension on BackupJobState {
  String toValue() {
    switch (this) {
      case BackupJobState.created:
        return 'CREATED';
      case BackupJobState.pending:
        return 'PENDING';
      case BackupJobState.running:
        return 'RUNNING';
      case BackupJobState.aborting:
        return 'ABORTING';
      case BackupJobState.aborted:
        return 'ABORTED';
      case BackupJobState.completed:
        return 'COMPLETED';
      case BackupJobState.failed:
        return 'FAILED';
      case BackupJobState.expired:
        return 'EXPIRED';
    }
  }
}

extension on String {
  BackupJobState toBackupJobState() {
    switch (this) {
      case 'CREATED':
        return BackupJobState.created;
      case 'PENDING':
        return BackupJobState.pending;
      case 'RUNNING':
        return BackupJobState.running;
      case 'ABORTING':
        return BackupJobState.aborting;
      case 'ABORTED':
        return BackupJobState.aborted;
      case 'COMPLETED':
        return BackupJobState.completed;
      case 'FAILED':
        return BackupJobState.failed;
      case 'EXPIRED':
        return BackupJobState.expired;
    }
    throw Exception('$this is not known in enum BackupJobState');
  }
}

/// Contains an optional backup plan display name and an array of
/// <code>BackupRule</code> objects, each of which specifies a backup rule. Each
/// rule in a backup plan is a separate scheduled task and can back up a
/// different selection of Amazon Web Services resources.
class BackupPlan {
  /// The display name of a backup plan. Must contain 1 to 50 alphanumeric or
  /// '-_.' characters.
  final String backupPlanName;

  /// An array of <code>BackupRule</code> objects, each of which specifies a
  /// scheduled task that is used to back up a selection of resources.
  final List<BackupRule> rules;

  /// Contains a list of <code>BackupOptions</code> for each resource type.
  final List<AdvancedBackupSetting>? advancedBackupSettings;

  BackupPlan({
    required this.backupPlanName,
    required this.rules,
    this.advancedBackupSettings,
  });
  factory BackupPlan.fromJson(Map<String, dynamic> json) {
    return BackupPlan(
      backupPlanName: json['BackupPlanName'] as String,
      rules: (json['Rules'] as List)
          .whereNotNull()
          .map((e) => BackupRule.fromJson(e as Map<String, dynamic>))
          .toList(),
      advancedBackupSettings: (json['AdvancedBackupSettings'] as List?)
          ?.whereNotNull()
          .map((e) => AdvancedBackupSetting.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Contains an optional backup plan display name and an array of
/// <code>BackupRule</code> objects, each of which specifies a backup rule. Each
/// rule in a backup plan is a separate scheduled task.
class BackupPlanInput {
  /// The display name of a backup plan. Must contain 1 to 50 alphanumeric or
  /// '-_.' characters.
  final String backupPlanName;

  /// An array of <code>BackupRule</code> objects, each of which specifies a
  /// scheduled task that is used to back up a selection of resources.
  final List<BackupRuleInput> rules;

  /// Specifies a list of <code>BackupOptions</code> for each resource type. These
  /// settings are only available for Windows Volume Shadow Copy Service (VSS)
  /// backup jobs.
  final List<AdvancedBackupSetting>? advancedBackupSettings;

  BackupPlanInput({
    required this.backupPlanName,
    required this.rules,
    this.advancedBackupSettings,
  });
  Map<String, dynamic> toJson() {
    final backupPlanName = this.backupPlanName;
    final rules = this.rules;
    final advancedBackupSettings = this.advancedBackupSettings;
    return {
      'BackupPlanName': backupPlanName,
      'Rules': rules,
      if (advancedBackupSettings != null)
        'AdvancedBackupSettings': advancedBackupSettings,
    };
  }
}

/// An object specifying metadata associated with a backup plan template.
class BackupPlanTemplatesListMember {
  /// Uniquely identifies a stored backup plan template.
  final String? backupPlanTemplateId;

  /// The optional display name of a backup plan template.
  final String? backupPlanTemplateName;

  BackupPlanTemplatesListMember({
    this.backupPlanTemplateId,
    this.backupPlanTemplateName,
  });
  factory BackupPlanTemplatesListMember.fromJson(Map<String, dynamic> json) {
    return BackupPlanTemplatesListMember(
      backupPlanTemplateId: json['BackupPlanTemplateId'] as String?,
      backupPlanTemplateName: json['BackupPlanTemplateName'] as String?,
    );
  }
}

/// Contains metadata about a backup plan.
class BackupPlansListMember {
  /// Contains a list of <code>BackupOptions</code> for a resource type.
  final List<AdvancedBackupSetting>? advancedBackupSettings;

  /// An Amazon Resource Name (ARN) that uniquely identifies a backup plan; for
  /// example,
  /// <code>arn:aws:backup:us-east-1:123456789012:plan:8F81F553-3A74-4A3F-B93D-B3360DC80C50</code>.
  final String? backupPlanArn;

  /// Uniquely identifies a backup plan.
  final String? backupPlanId;

  /// The display name of a saved backup plan.
  final String? backupPlanName;

  /// The date and time a resource backup plan is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationDate</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// A unique string that identifies the request and allows failed requests to be
  /// retried without the risk of running the operation twice. This parameter is
  /// optional.
  ///
  /// If used, this parameter must contain 1 to 50 alphanumeric or '-_.'
  /// characters.
  final String? creatorRequestId;

  /// The date and time a backup plan is deleted, in Unix format and Coordinated
  /// Universal Time (UTC). The value of <code>DeletionDate</code> is accurate to
  /// milliseconds. For example, the value 1516925490.087 represents Friday,
  /// January 26, 2018 12:11:30.087 AM.
  final DateTime? deletionDate;

  /// The last time a job to back up resources was run with this rule. A date and
  /// time, in Unix format and Coordinated Universal Time (UTC). The value of
  /// <code>LastExecutionDate</code> is accurate to milliseconds. For example, the
  /// value 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? lastExecutionDate;

  /// Unique, randomly generated, Unicode, UTF-8 encoded strings that are at most
  /// 1,024 bytes long. Version IDs cannot be edited.
  final String? versionId;

  BackupPlansListMember({
    this.advancedBackupSettings,
    this.backupPlanArn,
    this.backupPlanId,
    this.backupPlanName,
    this.creationDate,
    this.creatorRequestId,
    this.deletionDate,
    this.lastExecutionDate,
    this.versionId,
  });
  factory BackupPlansListMember.fromJson(Map<String, dynamic> json) {
    return BackupPlansListMember(
      advancedBackupSettings: (json['AdvancedBackupSettings'] as List?)
          ?.whereNotNull()
          .map((e) => AdvancedBackupSetting.fromJson(e as Map<String, dynamic>))
          .toList(),
      backupPlanArn: json['BackupPlanArn'] as String?,
      backupPlanId: json['BackupPlanId'] as String?,
      backupPlanName: json['BackupPlanName'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
      creatorRequestId: json['CreatorRequestId'] as String?,
      deletionDate: timeStampFromJson(json['DeletionDate']),
      lastExecutionDate: timeStampFromJson(json['LastExecutionDate']),
      versionId: json['VersionId'] as String?,
    );
  }
}

/// Specifies a scheduled task used to back up a selection of resources.
class BackupRule {
  /// A display name for a backup rule. Must contain 1 to 50 alphanumeric or '-_.'
  /// characters.
  final String ruleName;

  /// The name of a logical container where backups are stored. Backup vaults are
  /// identified by names that are unique to the account used to create them and
  /// the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  final String targetBackupVaultName;

  /// A value in minutes after a backup job is successfully started before it must
  /// be completed or it will be canceled by Backup. This value is optional.
  final int? completionWindowMinutes;

  /// An array of <code>CopyAction</code> objects, which contains the details of
  /// the copy operation.
  final List<CopyAction>? copyActions;

  /// Specifies whether Backup creates continuous backups. True causes Backup to
  /// create continuous backups capable of point-in-time restore (PITR). False (or
  /// not specified) causes Backup to create snapshot backups.
  final bool? enableContinuousBackup;

  /// The lifecycle defines when a protected resource is transitioned to cold
  /// storage and when it expires. Backup transitions and expires backups
  /// automatically according to the lifecycle that you define.
  ///
  /// Backups transitioned to cold storage must be stored in cold storage for a
  /// minimum of 90 days. Therefore, the “retention” setting must be 90 days
  /// greater than the “transition to cold after days” setting. The “transition to
  /// cold after days” setting cannot be changed after a backup has been
  /// transitioned to cold.
  ///
  /// Resource types that are able to be transitioned to cold storage are listed
  /// in the "Lifecycle to cold storage" section of the <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html#features-by-resource">
  /// Feature availability by resource</a> table. Backup ignores this expression
  /// for other resource types.
  final Lifecycle? lifecycle;

  /// An array of key-value pair strings that are assigned to resources that are
  /// associated with this rule when restored from backup.
  final Map<String, String>? recoveryPointTags;

  /// Uniquely identifies a rule that is used to schedule the backup of a
  /// selection of resources.
  final String? ruleId;

  /// A cron expression in UTC specifying when Backup initiates a backup job. For
  /// more information about Amazon Web Services cron expressions, see <a
  /// href="https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html">Schedule
  /// Expressions for Rules</a> in the <i>Amazon CloudWatch Events User
  /// Guide.</i>. Two examples of Amazon Web Services cron expressions are <code>
  /// 15 * ? * * *</code> (take a backup every hour at 15 minutes past the hour)
  /// and <code>0 12 * * ? *</code> (take a backup every day at 12 noon UTC). For
  /// a table of examples, click the preceding link and scroll down the page.
  final String? scheduleExpression;

  /// A value in minutes after a backup is scheduled before a job will be canceled
  /// if it doesn't start successfully. This value is optional.
  final int? startWindowMinutes;

  BackupRule({
    required this.ruleName,
    required this.targetBackupVaultName,
    this.completionWindowMinutes,
    this.copyActions,
    this.enableContinuousBackup,
    this.lifecycle,
    this.recoveryPointTags,
    this.ruleId,
    this.scheduleExpression,
    this.startWindowMinutes,
  });
  factory BackupRule.fromJson(Map<String, dynamic> json) {
    return BackupRule(
      ruleName: json['RuleName'] as String,
      targetBackupVaultName: json['TargetBackupVaultName'] as String,
      completionWindowMinutes: json['CompletionWindowMinutes'] as int?,
      copyActions: (json['CopyActions'] as List?)
          ?.whereNotNull()
          .map((e) => CopyAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      enableContinuousBackup: json['EnableContinuousBackup'] as bool?,
      lifecycle: json['Lifecycle'] != null
          ? Lifecycle.fromJson(json['Lifecycle'] as Map<String, dynamic>)
          : null,
      recoveryPointTags: (json['RecoveryPointTags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      ruleId: json['RuleId'] as String?,
      scheduleExpression: json['ScheduleExpression'] as String?,
      startWindowMinutes: json['StartWindowMinutes'] as int?,
    );
  }
}

/// Specifies a scheduled task used to back up a selection of resources.
class BackupRuleInput {
  /// A display name for a backup rule. Must contain 1 to 50 alphanumeric or '-_.'
  /// characters.
  final String ruleName;

  /// The name of a logical container where backups are stored. Backup vaults are
  /// identified by names that are unique to the account used to create them and
  /// the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  final String targetBackupVaultName;

  /// A value in minutes after a backup job is successfully started before it must
  /// be completed or it will be canceled by Backup. This value is optional.
  final int? completionWindowMinutes;

  /// An array of <code>CopyAction</code> objects, which contains the details of
  /// the copy operation.
  final List<CopyAction>? copyActions;

  /// Specifies whether Backup creates continuous backups. True causes Backup to
  /// create continuous backups capable of point-in-time restore (PITR). False (or
  /// not specified) causes Backup to create snapshot backups.
  final bool? enableContinuousBackup;

  /// The lifecycle defines when a protected resource is transitioned to cold
  /// storage and when it expires. Backup will transition and expire backups
  /// automatically according to the lifecycle that you define.
  ///
  /// Backups transitioned to cold storage must be stored in cold storage for a
  /// minimum of 90 days. Therefore, the “retention” setting must be 90 days
  /// greater than the “transition to cold after days” setting. The “transition to
  /// cold after days” setting cannot be changed after a backup has been
  /// transitioned to cold.
  ///
  /// Resource types that are able to be transitioned to cold storage are listed
  /// in the "Lifecycle to cold storage" section of the <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html#features-by-resource">
  /// Feature availability by resource</a> table. Backup ignores this expression
  /// for other resource types.
  final Lifecycle? lifecycle;

  /// To help organize your resources, you can assign your own metadata to the
  /// resources that you create. Each tag is a key-value pair.
  final Map<String, String>? recoveryPointTags;

  /// A CRON expression in UTC specifying when Backup initiates a backup job.
  final String? scheduleExpression;

  /// A value in minutes after a backup is scheduled before a job will be canceled
  /// if it doesn't start successfully. This value is optional.
  final int? startWindowMinutes;

  BackupRuleInput({
    required this.ruleName,
    required this.targetBackupVaultName,
    this.completionWindowMinutes,
    this.copyActions,
    this.enableContinuousBackup,
    this.lifecycle,
    this.recoveryPointTags,
    this.scheduleExpression,
    this.startWindowMinutes,
  });
  Map<String, dynamic> toJson() {
    final ruleName = this.ruleName;
    final targetBackupVaultName = this.targetBackupVaultName;
    final completionWindowMinutes = this.completionWindowMinutes;
    final copyActions = this.copyActions;
    final enableContinuousBackup = this.enableContinuousBackup;
    final lifecycle = this.lifecycle;
    final recoveryPointTags = this.recoveryPointTags;
    final scheduleExpression = this.scheduleExpression;
    final startWindowMinutes = this.startWindowMinutes;
    return {
      'RuleName': ruleName,
      'TargetBackupVaultName': targetBackupVaultName,
      if (completionWindowMinutes != null)
        'CompletionWindowMinutes': completionWindowMinutes,
      if (copyActions != null) 'CopyActions': copyActions,
      if (enableContinuousBackup != null)
        'EnableContinuousBackup': enableContinuousBackup,
      if (lifecycle != null) 'Lifecycle': lifecycle,
      if (recoveryPointTags != null) 'RecoveryPointTags': recoveryPointTags,
      if (scheduleExpression != null) 'ScheduleExpression': scheduleExpression,
      if (startWindowMinutes != null) 'StartWindowMinutes': startWindowMinutes,
    };
  }
}

/// Used to specify a set of resources to a backup plan.
///
/// Specifying your desired <code>Conditions</code>, <code>ListOfTags</code>,
/// <code>NotResources</code>, and/or <code>Resources</code> is recommended. If
/// none of these are specified, Backup will attempt to select all supported and
/// opted-in storage resources, which could have unintended cost implications.
class BackupSelection {
  /// The ARN of the IAM role that Backup uses to authenticate when backing up the
  /// target resource; for example,
  /// <code>arn:aws:iam::123456789012:role/S3Access</code>.
  final String iamRoleArn;

  /// The display name of a resource selection document. Must contain 1 to 50
  /// alphanumeric or '-_.' characters.
  final String selectionName;

  /// A list of conditions that you define to assign resources to your backup
  /// plans using tags. For example, <code>"StringEquals": { "ConditionKey":
  /// "aws:ResourceTag/CreatedByCryo", "ConditionValue": "true" },</code>.
  /// Condition operators are case sensitive.
  ///
  /// <code>Conditions</code> differs from <code>ListOfTags</code> as follows:
  ///
  /// <ul>
  /// <li>
  /// When you specify more than one condition, you only assign the resources that
  /// match ALL conditions (using AND logic).
  /// </li>
  /// <li>
  /// <code>Conditions</code> supports <code>StringEquals</code>,
  /// <code>StringLike</code>, <code>StringNotEquals</code>, and
  /// <code>StringNotLike</code>. <code>ListOfTags</code> only supports
  /// <code>StringEquals</code>.
  /// </li>
  /// </ul>
  final Conditions? conditions;

  /// A list of conditions that you define to assign resources to your backup
  /// plans using tags. For example, <code>"StringEquals": { "ConditionKey":
  /// "aws:ResourceTag/CreatedByCryo", "ConditionValue": "true" },</code>.
  /// Condition operators are case sensitive.
  ///
  /// <code>ListOfTags</code> differs from <code>Conditions</code> as follows:
  ///
  /// <ul>
  /// <li>
  /// When you specify more than one condition, you assign all resources that
  /// match AT LEAST ONE condition (using OR logic).
  /// </li>
  /// <li>
  /// <code>ListOfTags</code> only supports <code>StringEquals</code>.
  /// <code>Conditions</code> supports <code>StringEquals</code>,
  /// <code>StringLike</code>, <code>StringNotEquals</code>, and
  /// <code>StringNotLike</code>.
  /// </li>
  /// </ul>
  final List<Condition>? listOfTags;

  /// A list of Amazon Resource Names (ARNs) to exclude from a backup plan. The
  /// maximum number of ARNs is 500 without wildcards, or 30 ARNs with wildcards.
  ///
  /// If you need to exclude many resources from a backup plan, consider a
  /// different resource selection strategy, such as assigning only one or a few
  /// resource types or refining your resource selection using tags.
  final List<String>? notResources;

  /// A list of Amazon Resource Names (ARNs) to assign to a backup plan. The
  /// maximum number of ARNs is 500 without wildcards, or 30 ARNs with wildcards.
  ///
  /// If you need to assign many resources to a backup plan, consider a different
  /// resource selection strategy, such as assigning all resources of a resource
  /// type or refining your resource selection using tags.
  final List<String>? resources;

  BackupSelection({
    required this.iamRoleArn,
    required this.selectionName,
    this.conditions,
    this.listOfTags,
    this.notResources,
    this.resources,
  });
  factory BackupSelection.fromJson(Map<String, dynamic> json) {
    return BackupSelection(
      iamRoleArn: json['IamRoleArn'] as String,
      selectionName: json['SelectionName'] as String,
      conditions: json['Conditions'] != null
          ? Conditions.fromJson(json['Conditions'] as Map<String, dynamic>)
          : null,
      listOfTags: (json['ListOfTags'] as List?)
          ?.whereNotNull()
          .map((e) => Condition.fromJson(e as Map<String, dynamic>))
          .toList(),
      notResources: (json['NotResources'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      resources: (json['Resources'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final iamRoleArn = this.iamRoleArn;
    final selectionName = this.selectionName;
    final conditions = this.conditions;
    final listOfTags = this.listOfTags;
    final notResources = this.notResources;
    final resources = this.resources;
    return {
      'IamRoleArn': iamRoleArn,
      'SelectionName': selectionName,
      if (conditions != null) 'Conditions': conditions,
      if (listOfTags != null) 'ListOfTags': listOfTags,
      if (notResources != null) 'NotResources': notResources,
      if (resources != null) 'Resources': resources,
    };
  }
}

/// Contains metadata about a <code>BackupSelection</code> object.
class BackupSelectionsListMember {
  /// Uniquely identifies a backup plan.
  final String? backupPlanId;

  /// The date and time a backup plan is created, in Unix format and Coordinated
  /// Universal Time (UTC). The value of <code>CreationDate</code> is accurate to
  /// milliseconds. For example, the value 1516925490.087 represents Friday,
  /// January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// A unique string that identifies the request and allows failed requests to be
  /// retried without the risk of running the operation twice. This parameter is
  /// optional.
  ///
  /// If used, this parameter must contain 1 to 50 alphanumeric or '-_.'
  /// characters.
  final String? creatorRequestId;

  /// Specifies the IAM role Amazon Resource Name (ARN) to create the target
  /// recovery point; for example,
  /// <code>arn:aws:iam::123456789012:role/S3Access</code>.
  final String? iamRoleArn;

  /// Uniquely identifies a request to assign a set of resources to a backup plan.
  final String? selectionId;

  /// The display name of a resource selection document.
  final String? selectionName;

  BackupSelectionsListMember({
    this.backupPlanId,
    this.creationDate,
    this.creatorRequestId,
    this.iamRoleArn,
    this.selectionId,
    this.selectionName,
  });
  factory BackupSelectionsListMember.fromJson(Map<String, dynamic> json) {
    return BackupSelectionsListMember(
      backupPlanId: json['BackupPlanId'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
      creatorRequestId: json['CreatorRequestId'] as String?,
      iamRoleArn: json['IamRoleArn'] as String?,
      selectionId: json['SelectionId'] as String?,
      selectionName: json['SelectionName'] as String?,
    );
  }
}

enum BackupVaultEvent {
  backupJobStarted,
  backupJobCompleted,
  backupJobSuccessful,
  backupJobFailed,
  backupJobExpired,
  restoreJobStarted,
  restoreJobCompleted,
  restoreJobSuccessful,
  restoreJobFailed,
  copyJobStarted,
  copyJobSuccessful,
  copyJobFailed,
  recoveryPointModified,
  backupPlanCreated,
  backupPlanModified,
  s3BackupObjectFailed,
  s3RestoreObjectFailed,
}

extension on BackupVaultEvent {
  String toValue() {
    switch (this) {
      case BackupVaultEvent.backupJobStarted:
        return 'BACKUP_JOB_STARTED';
      case BackupVaultEvent.backupJobCompleted:
        return 'BACKUP_JOB_COMPLETED';
      case BackupVaultEvent.backupJobSuccessful:
        return 'BACKUP_JOB_SUCCESSFUL';
      case BackupVaultEvent.backupJobFailed:
        return 'BACKUP_JOB_FAILED';
      case BackupVaultEvent.backupJobExpired:
        return 'BACKUP_JOB_EXPIRED';
      case BackupVaultEvent.restoreJobStarted:
        return 'RESTORE_JOB_STARTED';
      case BackupVaultEvent.restoreJobCompleted:
        return 'RESTORE_JOB_COMPLETED';
      case BackupVaultEvent.restoreJobSuccessful:
        return 'RESTORE_JOB_SUCCESSFUL';
      case BackupVaultEvent.restoreJobFailed:
        return 'RESTORE_JOB_FAILED';
      case BackupVaultEvent.copyJobStarted:
        return 'COPY_JOB_STARTED';
      case BackupVaultEvent.copyJobSuccessful:
        return 'COPY_JOB_SUCCESSFUL';
      case BackupVaultEvent.copyJobFailed:
        return 'COPY_JOB_FAILED';
      case BackupVaultEvent.recoveryPointModified:
        return 'RECOVERY_POINT_MODIFIED';
      case BackupVaultEvent.backupPlanCreated:
        return 'BACKUP_PLAN_CREATED';
      case BackupVaultEvent.backupPlanModified:
        return 'BACKUP_PLAN_MODIFIED';
      case BackupVaultEvent.s3BackupObjectFailed:
        return 'S3_BACKUP_OBJECT_FAILED';
      case BackupVaultEvent.s3RestoreObjectFailed:
        return 'S3_RESTORE_OBJECT_FAILED';
    }
  }
}

extension on String {
  BackupVaultEvent toBackupVaultEvent() {
    switch (this) {
      case 'BACKUP_JOB_STARTED':
        return BackupVaultEvent.backupJobStarted;
      case 'BACKUP_JOB_COMPLETED':
        return BackupVaultEvent.backupJobCompleted;
      case 'BACKUP_JOB_SUCCESSFUL':
        return BackupVaultEvent.backupJobSuccessful;
      case 'BACKUP_JOB_FAILED':
        return BackupVaultEvent.backupJobFailed;
      case 'BACKUP_JOB_EXPIRED':
        return BackupVaultEvent.backupJobExpired;
      case 'RESTORE_JOB_STARTED':
        return BackupVaultEvent.restoreJobStarted;
      case 'RESTORE_JOB_COMPLETED':
        return BackupVaultEvent.restoreJobCompleted;
      case 'RESTORE_JOB_SUCCESSFUL':
        return BackupVaultEvent.restoreJobSuccessful;
      case 'RESTORE_JOB_FAILED':
        return BackupVaultEvent.restoreJobFailed;
      case 'COPY_JOB_STARTED':
        return BackupVaultEvent.copyJobStarted;
      case 'COPY_JOB_SUCCESSFUL':
        return BackupVaultEvent.copyJobSuccessful;
      case 'COPY_JOB_FAILED':
        return BackupVaultEvent.copyJobFailed;
      case 'RECOVERY_POINT_MODIFIED':
        return BackupVaultEvent.recoveryPointModified;
      case 'BACKUP_PLAN_CREATED':
        return BackupVaultEvent.backupPlanCreated;
      case 'BACKUP_PLAN_MODIFIED':
        return BackupVaultEvent.backupPlanModified;
      case 'S3_BACKUP_OBJECT_FAILED':
        return BackupVaultEvent.s3BackupObjectFailed;
      case 'S3_RESTORE_OBJECT_FAILED':
        return BackupVaultEvent.s3RestoreObjectFailed;
    }
    throw Exception('$this is not known in enum BackupVaultEvent');
  }
}

/// Contains metadata about a backup vault.
class BackupVaultListMember {
  /// An Amazon Resource Name (ARN) that uniquely identifies a backup vault; for
  /// example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:aBackupVault</code>.
  final String? backupVaultArn;

  /// The name of a logical container where backups are stored. Backup vaults are
  /// identified by names that are unique to the account used to create them and
  /// the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  final String? backupVaultName;

  /// The date and time a resource backup is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationDate</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// A unique string that identifies the request and allows failed requests to be
  /// retried without the risk of running the operation twice. This parameter is
  /// optional.
  ///
  /// If used, this parameter must contain 1 to 50 alphanumeric or '-_.'
  /// characters.
  final String? creatorRequestId;

  /// A server-side encryption key you can specify to encrypt your backups from
  /// services that support full Backup management; for example,
  /// <code>arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code>.
  /// If you specify a key, you must specify its ARN, not its alias. If you do not
  /// specify a key, Backup creates a KMS key for you by default.
  ///
  /// To learn which Backup services support full Backup management and how Backup
  /// handles encryption for backups from services that do not yet support full
  /// Backup, see <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/encryption.html">
  /// Encryption for backups in Backup</a>
  final String? encryptionKeyArn;

  /// The date and time when Backup Vault Lock configuration becomes immutable,
  /// meaning it cannot be changed or deleted.
  ///
  /// If you applied Vault Lock to your vault without specifying a lock date, you
  /// can change your Vault Lock settings, or delete Vault Lock from the vault
  /// entirely, at any time.
  ///
  /// This value is in Unix format, Coordinated Universal Time (UTC), and accurate
  /// to milliseconds. For example, the value 1516925490.087 represents Friday,
  /// January 26, 2018 12:11:30.087 AM.
  final DateTime? lockDate;

  /// A Boolean value that indicates whether Backup Vault Lock applies to the
  /// selected backup vault. If <code>true</code>, Vault Lock prevents delete and
  /// update operations on the recovery points in the selected vault.
  final bool? locked;

  /// The Backup Vault Lock setting that specifies the maximum retention period
  /// that the vault retains its recovery points. If this parameter is not
  /// specified, Vault Lock does not enforce a maximum retention period on the
  /// recovery points in the vault (allowing indefinite storage).
  ///
  /// If specified, any backup or copy job to the vault must have a lifecycle
  /// policy with a retention period equal to or shorter than the maximum
  /// retention period. If the job's retention period is longer than that maximum
  /// retention period, then the vault fails the backup or copy job, and you
  /// should either modify your lifecycle settings or use a different vault.
  /// Recovery points already stored in the vault prior to Vault Lock are not
  /// affected.
  final int? maxRetentionDays;

  /// The Backup Vault Lock setting that specifies the minimum retention period
  /// that the vault retains its recovery points. If this parameter is not
  /// specified, Vault Lock does not enforce a minimum retention period.
  ///
  /// If specified, any backup or copy job to the vault must have a lifecycle
  /// policy with a retention period equal to or longer than the minimum retention
  /// period. If the job's retention period is shorter than that minimum retention
  /// period, then the vault fails the backup or copy job, and you should either
  /// modify your lifecycle settings or use a different vault. Recovery points
  /// already stored in the vault prior to Vault Lock are not affected.
  final int? minRetentionDays;

  /// The number of recovery points that are stored in a backup vault.
  final int? numberOfRecoveryPoints;

  BackupVaultListMember({
    this.backupVaultArn,
    this.backupVaultName,
    this.creationDate,
    this.creatorRequestId,
    this.encryptionKeyArn,
    this.lockDate,
    this.locked,
    this.maxRetentionDays,
    this.minRetentionDays,
    this.numberOfRecoveryPoints,
  });
  factory BackupVaultListMember.fromJson(Map<String, dynamic> json) {
    return BackupVaultListMember(
      backupVaultArn: json['BackupVaultArn'] as String?,
      backupVaultName: json['BackupVaultName'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
      creatorRequestId: json['CreatorRequestId'] as String?,
      encryptionKeyArn: json['EncryptionKeyArn'] as String?,
      lockDate: timeStampFromJson(json['LockDate']),
      locked: json['Locked'] as bool?,
      maxRetentionDays: json['MaxRetentionDays'] as int?,
      minRetentionDays: json['MinRetentionDays'] as int?,
      numberOfRecoveryPoints: json['NumberOfRecoveryPoints'] as int?,
    );
  }
}

/// Contains <code>DeleteAt</code> and <code>MoveToColdStorageAt</code>
/// timestamps, which are used to specify a lifecycle for a recovery point.
///
/// The lifecycle defines when a protected resource is transitioned to cold
/// storage and when it expires. Backup transitions and expires backups
/// automatically according to the lifecycle that you define.
///
/// Backups transitioned to cold storage must be stored in cold storage for a
/// minimum of 90 days. Therefore, the “retention” setting must be 90 days
/// greater than the “transition to cold after days” setting. The “transition to
/// cold after days” setting cannot be changed after a backup has been
/// transitioned to cold.
///
/// Resource types that are able to be transitioned to cold storage are listed
/// in the "Lifecycle to cold storage" section of the <a
/// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html#features-by-resource">
/// Feature availability by resource</a> table. Backup ignores this expression
/// for other resource types.
class CalculatedLifecycle {
  /// A timestamp that specifies when to delete a recovery point.
  final DateTime? deleteAt;

  /// A timestamp that specifies when to transition a recovery point to cold
  /// storage.
  final DateTime? moveToColdStorageAt;

  CalculatedLifecycle({
    this.deleteAt,
    this.moveToColdStorageAt,
  });
  factory CalculatedLifecycle.fromJson(Map<String, dynamic> json) {
    return CalculatedLifecycle(
      deleteAt: timeStampFromJson(json['DeleteAt']),
      moveToColdStorageAt: timeStampFromJson(json['MoveToColdStorageAt']),
    );
  }
}

/// Contains an array of triplets made up of a condition type (such as
/// <code>StringEquals</code>), a key, and a value. Used to filter resources
/// using their tags and assign them to a backup plan. Case sensitive.
class Condition {
  /// The key in a key-value pair. For example, in the tag <code>Department:
  /// Accounting</code>, <code>Department</code> is the key.
  final String conditionKey;

  /// An operation applied to a key-value pair used to assign resources to your
  /// backup plan. Condition only supports <code>StringEquals</code>. For more
  /// flexible assignment options, including <code>StringLike</code> and the
  /// ability to exclude resources from your backup plan, use
  /// <code>Conditions</code> (with an "s" on the end) for your <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/API_BackupSelection.html">
  /// <code>BackupSelection</code> </a>.
  final ConditionType conditionType;

  /// The value in a key-value pair. For example, in the tag <code>Department:
  /// Accounting</code>, <code>Accounting</code> is the value.
  final String conditionValue;

  Condition({
    required this.conditionKey,
    required this.conditionType,
    required this.conditionValue,
  });
  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      conditionKey: json['ConditionKey'] as String,
      conditionType: (json['ConditionType'] as String).toConditionType(),
      conditionValue: json['ConditionValue'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final conditionKey = this.conditionKey;
    final conditionType = this.conditionType;
    final conditionValue = this.conditionValue;
    return {
      'ConditionKey': conditionKey,
      'ConditionType': conditionType.toValue(),
      'ConditionValue': conditionValue,
    };
  }
}

/// Includes information about tags you define to assign tagged resources to a
/// backup plan.
class ConditionParameter {
  /// The key in a key-value pair. For example, in the tag <code>Department:
  /// Accounting</code>, <code>Department</code> is the key.
  final String? conditionKey;

  /// The value in a key-value pair. For example, in the tag <code>Department:
  /// Accounting</code>, <code>Accounting</code> is the value.
  final String? conditionValue;

  ConditionParameter({
    this.conditionKey,
    this.conditionValue,
  });
  factory ConditionParameter.fromJson(Map<String, dynamic> json) {
    return ConditionParameter(
      conditionKey: json['ConditionKey'] as String?,
      conditionValue: json['ConditionValue'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final conditionKey = this.conditionKey;
    final conditionValue = this.conditionValue;
    return {
      if (conditionKey != null) 'ConditionKey': conditionKey,
      if (conditionValue != null) 'ConditionValue': conditionValue,
    };
  }
}

enum ConditionType {
  stringequals,
}

extension on ConditionType {
  String toValue() {
    switch (this) {
      case ConditionType.stringequals:
        return 'STRINGEQUALS';
    }
  }
}

extension on String {
  ConditionType toConditionType() {
    switch (this) {
      case 'STRINGEQUALS':
        return ConditionType.stringequals;
    }
    throw Exception('$this is not known in enum ConditionType');
  }
}

/// Contains information about which resources to include or exclude from a
/// backup plan using their tags. Conditions are case sensitive.
class Conditions {
  /// Filters the values of your tagged resources for only those resources that
  /// you tagged with the same value. Also called "exact matching."
  final List<ConditionParameter>? stringEquals;

  /// Filters the values of your tagged resources for matching tag values with the
  /// use of a wildcard character (*) anywhere in the string. For example, "prod*"
  /// or "*rod*" matches the tag value "production".
  final List<ConditionParameter>? stringLike;

  /// Filters the values of your tagged resources for only those resources that
  /// you tagged that do not have the same value. Also called "negated matching."
  final List<ConditionParameter>? stringNotEquals;

  /// Filters the values of your tagged resources for non-matching tag values with
  /// the use of a wildcard character (*) anywhere in the string.
  final List<ConditionParameter>? stringNotLike;

  Conditions({
    this.stringEquals,
    this.stringLike,
    this.stringNotEquals,
    this.stringNotLike,
  });
  factory Conditions.fromJson(Map<String, dynamic> json) {
    return Conditions(
      stringEquals: (json['StringEquals'] as List?)
          ?.whereNotNull()
          .map((e) => ConditionParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
      stringLike: (json['StringLike'] as List?)
          ?.whereNotNull()
          .map((e) => ConditionParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
      stringNotEquals: (json['StringNotEquals'] as List?)
          ?.whereNotNull()
          .map((e) => ConditionParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
      stringNotLike: (json['StringNotLike'] as List?)
          ?.whereNotNull()
          .map((e) => ConditionParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final stringEquals = this.stringEquals;
    final stringLike = this.stringLike;
    final stringNotEquals = this.stringNotEquals;
    final stringNotLike = this.stringNotLike;
    return {
      if (stringEquals != null) 'StringEquals': stringEquals,
      if (stringLike != null) 'StringLike': stringLike,
      if (stringNotEquals != null) 'StringNotEquals': stringNotEquals,
      if (stringNotLike != null) 'StringNotLike': stringNotLike,
    };
  }
}

/// A list of parameters for a control. A control can have zero, one, or more
/// than one parameter. An example of a control with two parameters is: "backup
/// plan frequency is at least <code>daily</code> and the retention period is at
/// least <code>1 year</code>". The first parameter is <code>daily</code>. The
/// second parameter is <code>1 year</code>.
class ControlInputParameter {
  /// The name of a parameter, for example, <code>BackupPlanFrequency</code>.
  final String? parameterName;

  /// The value of parameter, for example, <code>hourly</code>.
  final String? parameterValue;

  ControlInputParameter({
    this.parameterName,
    this.parameterValue,
  });
  factory ControlInputParameter.fromJson(Map<String, dynamic> json) {
    return ControlInputParameter(
      parameterName: json['ParameterName'] as String?,
      parameterValue: json['ParameterValue'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final parameterName = this.parameterName;
    final parameterValue = this.parameterValue;
    return {
      if (parameterName != null) 'ParameterName': parameterName,
      if (parameterValue != null) 'ParameterValue': parameterValue,
    };
  }
}

/// A framework consists of one or more controls. Each control has its own
/// control scope. The control scope can include one or more resource types, a
/// combination of a tag key and value, or a combination of one resource type
/// and one resource ID. If no scope is specified, evaluations for the rule are
/// triggered when any resource in your recording group changes in
/// configuration.
/// <note>
/// To set a control scope that includes all of a particular resource, leave the
/// <code>ControlScope</code> empty or do not pass it when calling
/// <code>CreateFramework</code>.
/// </note>
class ControlScope {
  /// The ID of the only Amazon Web Services resource that you want your control
  /// scope to contain.
  final List<String>? complianceResourceIds;

  /// Describes whether the control scope includes one or more types of resources,
  /// such as <code>EFS</code> or <code>RDS</code>.
  final List<String>? complianceResourceTypes;

  /// The tag key-value pair applied to those Amazon Web Services resources that
  /// you want to trigger an evaluation for a rule. A maximum of one key-value
  /// pair can be provided. The tag value is optional, but it cannot be an empty
  /// string. The structure to assign a tag is:
  /// <code>[{"Key":"string","Value":"string"}]</code>.
  final Map<String, String>? tags;

  ControlScope({
    this.complianceResourceIds,
    this.complianceResourceTypes,
    this.tags,
  });
  factory ControlScope.fromJson(Map<String, dynamic> json) {
    return ControlScope(
      complianceResourceIds: (json['ComplianceResourceIds'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      complianceResourceTypes: (json['ComplianceResourceTypes'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      tags: (json['Tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }

  Map<String, dynamic> toJson() {
    final complianceResourceIds = this.complianceResourceIds;
    final complianceResourceTypes = this.complianceResourceTypes;
    final tags = this.tags;
    return {
      if (complianceResourceIds != null)
        'ComplianceResourceIds': complianceResourceIds,
      if (complianceResourceTypes != null)
        'ComplianceResourceTypes': complianceResourceTypes,
      if (tags != null) 'Tags': tags,
    };
  }
}

/// The details of the copy operation.
class CopyAction {
  /// An Amazon Resource Name (ARN) that uniquely identifies the destination
  /// backup vault for the copied backup. For example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:aBackupVault</code>.
  final String destinationBackupVaultArn;
  final Lifecycle? lifecycle;

  CopyAction({
    required this.destinationBackupVaultArn,
    this.lifecycle,
  });
  factory CopyAction.fromJson(Map<String, dynamic> json) {
    return CopyAction(
      destinationBackupVaultArn: json['DestinationBackupVaultArn'] as String,
      lifecycle: json['Lifecycle'] != null
          ? Lifecycle.fromJson(json['Lifecycle'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final destinationBackupVaultArn = this.destinationBackupVaultArn;
    final lifecycle = this.lifecycle;
    return {
      'DestinationBackupVaultArn': destinationBackupVaultArn,
      if (lifecycle != null) 'Lifecycle': lifecycle,
    };
  }
}

/// Contains detailed information about a copy job.
class CopyJob {
  /// The account ID that owns the copy job.
  final String? accountId;

  /// The size, in bytes, of a copy job.
  final int? backupSizeInBytes;

  /// The date and time a copy job is completed, in Unix format and Coordinated
  /// Universal Time (UTC). The value of <code>CompletionDate</code> is accurate
  /// to milliseconds. For example, the value 1516925490.087 represents Friday,
  /// January 26, 2018 12:11:30.087 AM.
  final DateTime? completionDate;

  /// Uniquely identifies a copy job.
  final String? copyJobId;
  final RecoveryPointCreator? createdBy;

  /// The date and time a copy job is created, in Unix format and Coordinated
  /// Universal Time (UTC). The value of <code>CreationDate</code> is accurate to
  /// milliseconds. For example, the value 1516925490.087 represents Friday,
  /// January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// An Amazon Resource Name (ARN) that uniquely identifies a destination copy
  /// vault; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:aBackupVault</code>.
  final String? destinationBackupVaultArn;

  /// An ARN that uniquely identifies a destination recovery point; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  final String? destinationRecoveryPointArn;

  /// Specifies the IAM role ARN used to copy the target recovery point; for
  /// example, <code>arn:aws:iam::123456789012:role/S3Access</code>.
  final String? iamRoleArn;

  /// The Amazon Web Services resource to be copied; for example, an Amazon
  /// Elastic Block Store (Amazon EBS) volume or an Amazon Relational Database
  /// Service (Amazon RDS) database.
  final String? resourceArn;

  /// The type of Amazon Web Services resource to be copied; for example, an
  /// Amazon Elastic Block Store (Amazon EBS) volume or an Amazon Relational
  /// Database Service (Amazon RDS) database.
  final String? resourceType;

  /// An Amazon Resource Name (ARN) that uniquely identifies a source copy vault;
  /// for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:aBackupVault</code>.
  final String? sourceBackupVaultArn;

  /// An ARN that uniquely identifies a source recovery point; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  final String? sourceRecoveryPointArn;

  /// The current state of a copy job.
  final CopyJobState? state;

  /// A detailed message explaining the status of the job to copy a resource.
  final String? statusMessage;

  CopyJob({
    this.accountId,
    this.backupSizeInBytes,
    this.completionDate,
    this.copyJobId,
    this.createdBy,
    this.creationDate,
    this.destinationBackupVaultArn,
    this.destinationRecoveryPointArn,
    this.iamRoleArn,
    this.resourceArn,
    this.resourceType,
    this.sourceBackupVaultArn,
    this.sourceRecoveryPointArn,
    this.state,
    this.statusMessage,
  });
  factory CopyJob.fromJson(Map<String, dynamic> json) {
    return CopyJob(
      accountId: json['AccountId'] as String?,
      backupSizeInBytes: json['BackupSizeInBytes'] as int?,
      completionDate: timeStampFromJson(json['CompletionDate']),
      copyJobId: json['CopyJobId'] as String?,
      createdBy: json['CreatedBy'] != null
          ? RecoveryPointCreator.fromJson(
              json['CreatedBy'] as Map<String, dynamic>)
          : null,
      creationDate: timeStampFromJson(json['CreationDate']),
      destinationBackupVaultArn: json['DestinationBackupVaultArn'] as String?,
      destinationRecoveryPointArn:
          json['DestinationRecoveryPointArn'] as String?,
      iamRoleArn: json['IamRoleArn'] as String?,
      resourceArn: json['ResourceArn'] as String?,
      resourceType: json['ResourceType'] as String?,
      sourceBackupVaultArn: json['SourceBackupVaultArn'] as String?,
      sourceRecoveryPointArn: json['SourceRecoveryPointArn'] as String?,
      state: (json['State'] as String?)?.toCopyJobState(),
      statusMessage: json['StatusMessage'] as String?,
    );
  }
}

enum CopyJobState {
  created,
  running,
  completed,
  failed,
}

extension on CopyJobState {
  String toValue() {
    switch (this) {
      case CopyJobState.created:
        return 'CREATED';
      case CopyJobState.running:
        return 'RUNNING';
      case CopyJobState.completed:
        return 'COMPLETED';
      case CopyJobState.failed:
        return 'FAILED';
    }
  }
}

extension on String {
  CopyJobState toCopyJobState() {
    switch (this) {
      case 'CREATED':
        return CopyJobState.created;
      case 'RUNNING':
        return CopyJobState.running;
      case 'COMPLETED':
        return CopyJobState.completed;
      case 'FAILED':
        return CopyJobState.failed;
    }
    throw Exception('$this is not known in enum CopyJobState');
  }
}

class CreateBackupPlanOutput {
  /// A list of <code>BackupOptions</code> settings for a resource type. This
  /// option is only available for Windows Volume Shadow Copy Service (VSS) backup
  /// jobs.
  final List<AdvancedBackupSetting>? advancedBackupSettings;

  /// An Amazon Resource Name (ARN) that uniquely identifies a backup plan; for
  /// example,
  /// <code>arn:aws:backup:us-east-1:123456789012:plan:8F81F553-3A74-4A3F-B93D-B3360DC80C50</code>.
  final String? backupPlanArn;

  /// Uniquely identifies a backup plan.
  final String? backupPlanId;

  /// The date and time that a backup plan is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationDate</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// Unique, randomly generated, Unicode, UTF-8 encoded strings that are at most
  /// 1,024 bytes long. They cannot be edited.
  final String? versionId;

  CreateBackupPlanOutput({
    this.advancedBackupSettings,
    this.backupPlanArn,
    this.backupPlanId,
    this.creationDate,
    this.versionId,
  });
  factory CreateBackupPlanOutput.fromJson(Map<String, dynamic> json) {
    return CreateBackupPlanOutput(
      advancedBackupSettings: (json['AdvancedBackupSettings'] as List?)
          ?.whereNotNull()
          .map((e) => AdvancedBackupSetting.fromJson(e as Map<String, dynamic>))
          .toList(),
      backupPlanArn: json['BackupPlanArn'] as String?,
      backupPlanId: json['BackupPlanId'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
      versionId: json['VersionId'] as String?,
    );
  }
}

class CreateBackupSelectionOutput {
  /// Uniquely identifies a backup plan.
  final String? backupPlanId;

  /// The date and time a backup selection is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationDate</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// Uniquely identifies the body of a request to assign a set of resources to a
  /// backup plan.
  final String? selectionId;

  CreateBackupSelectionOutput({
    this.backupPlanId,
    this.creationDate,
    this.selectionId,
  });
  factory CreateBackupSelectionOutput.fromJson(Map<String, dynamic> json) {
    return CreateBackupSelectionOutput(
      backupPlanId: json['BackupPlanId'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
      selectionId: json['SelectionId'] as String?,
    );
  }
}

class CreateBackupVaultOutput {
  /// An Amazon Resource Name (ARN) that uniquely identifies a backup vault; for
  /// example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:aBackupVault</code>.
  final String? backupVaultArn;

  /// The name of a logical container where backups are stored. Backup vaults are
  /// identified by names that are unique to the account used to create them and
  /// the Region where they are created. They consist of lowercase letters,
  /// numbers, and hyphens.
  final String? backupVaultName;

  /// The date and time a backup vault is created, in Unix format and Coordinated
  /// Universal Time (UTC). The value of <code>CreationDate</code> is accurate to
  /// milliseconds. For example, the value 1516925490.087 represents Friday,
  /// January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  CreateBackupVaultOutput({
    this.backupVaultArn,
    this.backupVaultName,
    this.creationDate,
  });
  factory CreateBackupVaultOutput.fromJson(Map<String, dynamic> json) {
    return CreateBackupVaultOutput(
      backupVaultArn: json['BackupVaultArn'] as String?,
      backupVaultName: json['BackupVaultName'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
    );
  }
}

class CreateFrameworkOutput {
  /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
  /// format of the ARN depends on the resource type.
  final String? frameworkArn;

  /// The unique name of the framework. The name must be between 1 and 256
  /// characters, starting with a letter, and consisting of letters (a-z, A-Z),
  /// numbers (0-9), and underscores (_).
  final String? frameworkName;

  CreateFrameworkOutput({
    this.frameworkArn,
    this.frameworkName,
  });
  factory CreateFrameworkOutput.fromJson(Map<String, dynamic> json) {
    return CreateFrameworkOutput(
      frameworkArn: json['FrameworkArn'] as String?,
      frameworkName: json['FrameworkName'] as String?,
    );
  }
}

class CreateReportPlanOutput {
  /// The date and time a backup vault is created, in Unix format and Coordinated
  /// Universal Time (UTC). The value of <code>CreationTime</code> is accurate to
  /// milliseconds. For example, the value 1516925490.087 represents Friday,
  /// January 26, 2018 12:11:30.087 AM.
  final DateTime? creationTime;

  /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
  /// format of the ARN depends on the resource type.
  final String? reportPlanArn;

  /// The unique name of the report plan.
  final String? reportPlanName;

  CreateReportPlanOutput({
    this.creationTime,
    this.reportPlanArn,
    this.reportPlanName,
  });
  factory CreateReportPlanOutput.fromJson(Map<String, dynamic> json) {
    return CreateReportPlanOutput(
      creationTime: timeStampFromJson(json['CreationTime']),
      reportPlanArn: json['ReportPlanArn'] as String?,
      reportPlanName: json['ReportPlanName'] as String?,
    );
  }
}

class DeleteBackupPlanOutput {
  /// An Amazon Resource Name (ARN) that uniquely identifies a backup plan; for
  /// example,
  /// <code>arn:aws:backup:us-east-1:123456789012:plan:8F81F553-3A74-4A3F-B93D-B3360DC80C50</code>.
  final String? backupPlanArn;

  /// Uniquely identifies a backup plan.
  final String? backupPlanId;

  /// The date and time a backup plan is deleted, in Unix format and Coordinated
  /// Universal Time (UTC). The value of <code>DeletionDate</code> is accurate to
  /// milliseconds. For example, the value 1516925490.087 represents Friday,
  /// January 26, 2018 12:11:30.087 AM.
  final DateTime? deletionDate;

  /// Unique, randomly generated, Unicode, UTF-8 encoded strings that are at most
  /// 1,024 bytes long. Version IDs cannot be edited.
  final String? versionId;

  DeleteBackupPlanOutput({
    this.backupPlanArn,
    this.backupPlanId,
    this.deletionDate,
    this.versionId,
  });
  factory DeleteBackupPlanOutput.fromJson(Map<String, dynamic> json) {
    return DeleteBackupPlanOutput(
      backupPlanArn: json['BackupPlanArn'] as String?,
      backupPlanId: json['BackupPlanId'] as String?,
      deletionDate: timeStampFromJson(json['DeletionDate']),
      versionId: json['VersionId'] as String?,
    );
  }
}

class DescribeBackupJobOutput {
  /// Returns the account ID that owns the backup job.
  final String? accountId;

  /// Uniquely identifies a request to Backup to back up a resource.
  final String? backupJobId;

  /// Represents the options specified as part of backup plan or on-demand backup
  /// job.
  final Map<String, String>? backupOptions;

  /// The size, in bytes, of a backup.
  final int? backupSizeInBytes;

  /// Represents the actual backup type selected for a backup job. For example, if
  /// a successful Windows Volume Shadow Copy Service (VSS) backup was taken,
  /// <code>BackupType</code> returns <code>"WindowsVSS"</code>. If
  /// <code>BackupType</code> is empty, then the backup type was a regular backup.
  final String? backupType;

  /// An Amazon Resource Name (ARN) that uniquely identifies a backup vault; for
  /// example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:aBackupVault</code>.
  final String? backupVaultArn;

  /// The name of a logical container where backups are stored. Backup vaults are
  /// identified by names that are unique to the account used to create them and
  /// the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  final String? backupVaultName;

  /// The size in bytes transferred to a backup vault at the time that the job
  /// status was queried.
  final int? bytesTransferred;

  /// The date and time that a job to create a backup job is completed, in Unix
  /// format and Coordinated Universal Time (UTC). The value of
  /// <code>CompletionDate</code> is accurate to milliseconds. For example, the
  /// value 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? completionDate;

  /// Contains identifying information about the creation of a backup job,
  /// including the <code>BackupPlanArn</code>, <code>BackupPlanId</code>,
  /// <code>BackupPlanVersion</code>, and <code>BackupRuleId</code> of the backup
  /// plan that is used to create it.
  final RecoveryPointCreator? createdBy;

  /// The date and time that a backup job is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationDate</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// The date and time that a job to back up resources is expected to be
  /// completed, in Unix format and Coordinated Universal Time (UTC). The value of
  /// <code>ExpectedCompletionDate</code> is accurate to milliseconds. For
  /// example, the value 1516925490.087 represents Friday, January 26, 2018
  /// 12:11:30.087 AM.
  final DateTime? expectedCompletionDate;

  /// Specifies the IAM role ARN used to create the target recovery point; for
  /// example, <code>arn:aws:iam::123456789012:role/S3Access</code>.
  final String? iamRoleArn;

  /// Contains an estimated percentage that is complete of a job at the time the
  /// job status was queried.
  final String? percentDone;

  /// An ARN that uniquely identifies a recovery point; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  final String? recoveryPointArn;

  /// An ARN that uniquely identifies a saved resource. The format of the ARN
  /// depends on the resource type.
  final String? resourceArn;

  /// The type of Amazon Web Services resource to be backed up; for example, an
  /// Amazon Elastic Block Store (Amazon EBS) volume or an Amazon Relational
  /// Database Service (Amazon RDS) database.
  final String? resourceType;

  /// Specifies the time in Unix format and Coordinated Universal Time (UTC) when
  /// a backup job must be started before it is canceled. The value is calculated
  /// by adding the start window to the scheduled time. So if the scheduled time
  /// were 6:00 PM and the start window is 2 hours, the <code>StartBy</code> time
  /// would be 8:00 PM on the date specified. The value of <code>StartBy</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? startBy;

  /// The current state of a resource recovery point.
  final BackupJobState? state;

  /// A detailed message explaining the status of the job to back up a resource.
  final String? statusMessage;

  DescribeBackupJobOutput({
    this.accountId,
    this.backupJobId,
    this.backupOptions,
    this.backupSizeInBytes,
    this.backupType,
    this.backupVaultArn,
    this.backupVaultName,
    this.bytesTransferred,
    this.completionDate,
    this.createdBy,
    this.creationDate,
    this.expectedCompletionDate,
    this.iamRoleArn,
    this.percentDone,
    this.recoveryPointArn,
    this.resourceArn,
    this.resourceType,
    this.startBy,
    this.state,
    this.statusMessage,
  });
  factory DescribeBackupJobOutput.fromJson(Map<String, dynamic> json) {
    return DescribeBackupJobOutput(
      accountId: json['AccountId'] as String?,
      backupJobId: json['BackupJobId'] as String?,
      backupOptions: (json['BackupOptions'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      backupSizeInBytes: json['BackupSizeInBytes'] as int?,
      backupType: json['BackupType'] as String?,
      backupVaultArn: json['BackupVaultArn'] as String?,
      backupVaultName: json['BackupVaultName'] as String?,
      bytesTransferred: json['BytesTransferred'] as int?,
      completionDate: timeStampFromJson(json['CompletionDate']),
      createdBy: json['CreatedBy'] != null
          ? RecoveryPointCreator.fromJson(
              json['CreatedBy'] as Map<String, dynamic>)
          : null,
      creationDate: timeStampFromJson(json['CreationDate']),
      expectedCompletionDate: timeStampFromJson(json['ExpectedCompletionDate']),
      iamRoleArn: json['IamRoleArn'] as String?,
      percentDone: json['PercentDone'] as String?,
      recoveryPointArn: json['RecoveryPointArn'] as String?,
      resourceArn: json['ResourceArn'] as String?,
      resourceType: json['ResourceType'] as String?,
      startBy: timeStampFromJson(json['StartBy']),
      state: (json['State'] as String?)?.toBackupJobState(),
      statusMessage: json['StatusMessage'] as String?,
    );
  }
}

class DescribeBackupVaultOutput {
  /// An Amazon Resource Name (ARN) that uniquely identifies a backup vault; for
  /// example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:aBackupVault</code>.
  final String? backupVaultArn;

  /// The name of a logical container where backups are stored. Backup vaults are
  /// identified by names that are unique to the account used to create them and
  /// the Region where they are created. They consist of lowercase letters,
  /// numbers, and hyphens.
  final String? backupVaultName;

  /// The date and time that a backup vault is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationDate</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// A unique string that identifies the request and allows failed requests to be
  /// retried without the risk of running the operation twice.
  final String? creatorRequestId;

  /// The server-side encryption key that is used to protect your backups; for
  /// example,
  /// <code>arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code>.
  final String? encryptionKeyArn;

  /// The date and time when Backup Vault Lock configuration cannot be changed or
  /// deleted.
  ///
  /// If you applied Vault Lock to your vault without specifying a lock date, you
  /// can change any of your Vault Lock settings, or delete Vault Lock from the
  /// vault entirely, at any time.
  ///
  /// This value is in Unix format, Coordinated Universal Time (UTC), and accurate
  /// to milliseconds. For example, the value 1516925490.087 represents Friday,
  /// January 26, 2018 12:11:30.087 AM.
  final DateTime? lockDate;

  /// A Boolean that indicates whether Backup Vault Lock is currently protecting
  /// the backup vault. <code>True</code> means that Vault Lock causes delete or
  /// update operations on the recovery points stored in the vault to fail.
  final bool? locked;

  /// The Backup Vault Lock setting that specifies the maximum retention period
  /// that the vault retains its recovery points. If this parameter is not
  /// specified, Vault Lock does not enforce a maximum retention period on the
  /// recovery points in the vault (allowing indefinite storage).
  ///
  /// If specified, any backup or copy job to the vault must have a lifecycle
  /// policy with a retention period equal to or shorter than the maximum
  /// retention period. If the job's retention period is longer than that maximum
  /// retention period, then the vault fails the backup or copy job, and you
  /// should either modify your lifecycle settings or use a different vault.
  /// Recovery points already stored in the vault prior to Vault Lock are not
  /// affected.
  final int? maxRetentionDays;

  /// The Backup Vault Lock setting that specifies the minimum retention period
  /// that the vault retains its recovery points. If this parameter is not
  /// specified, Vault Lock does not enforce a minimum retention period.
  ///
  /// If specified, any backup or copy job to the vault must have a lifecycle
  /// policy with a retention period equal to or longer than the minimum retention
  /// period. If the job's retention period is shorter than that minimum retention
  /// period, then the vault fails the backup or copy job, and you should either
  /// modify your lifecycle settings or use a different vault. Recovery points
  /// already stored in the vault prior to Vault Lock are not affected.
  final int? minRetentionDays;

  /// The number of recovery points that are stored in a backup vault.
  final int? numberOfRecoveryPoints;

  DescribeBackupVaultOutput({
    this.backupVaultArn,
    this.backupVaultName,
    this.creationDate,
    this.creatorRequestId,
    this.encryptionKeyArn,
    this.lockDate,
    this.locked,
    this.maxRetentionDays,
    this.minRetentionDays,
    this.numberOfRecoveryPoints,
  });
  factory DescribeBackupVaultOutput.fromJson(Map<String, dynamic> json) {
    return DescribeBackupVaultOutput(
      backupVaultArn: json['BackupVaultArn'] as String?,
      backupVaultName: json['BackupVaultName'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
      creatorRequestId: json['CreatorRequestId'] as String?,
      encryptionKeyArn: json['EncryptionKeyArn'] as String?,
      lockDate: timeStampFromJson(json['LockDate']),
      locked: json['Locked'] as bool?,
      maxRetentionDays: json['MaxRetentionDays'] as int?,
      minRetentionDays: json['MinRetentionDays'] as int?,
      numberOfRecoveryPoints: json['NumberOfRecoveryPoints'] as int?,
    );
  }
}

class DescribeCopyJobOutput {
  /// Contains detailed information about a copy job.
  final CopyJob? copyJob;

  DescribeCopyJobOutput({
    this.copyJob,
  });
  factory DescribeCopyJobOutput.fromJson(Map<String, dynamic> json) {
    return DescribeCopyJobOutput(
      copyJob: json['CopyJob'] != null
          ? CopyJob.fromJson(json['CopyJob'] as Map<String, dynamic>)
          : null,
    );
  }
}

class DescribeFrameworkOutput {
  /// The date and time that a framework is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationTime</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationTime;

  /// The deployment status of a framework. The statuses are:
  ///
  /// <code>CREATE_IN_PROGRESS | UPDATE_IN_PROGRESS | DELETE_IN_PROGRESS |
  /// COMPLETED | FAILED</code>
  final String? deploymentStatus;

  /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
  /// format of the ARN depends on the resource type.
  final String? frameworkArn;

  /// A list of the controls that make up the framework. Each control in the list
  /// has a name, input parameters, and scope.
  final List<FrameworkControl>? frameworkControls;

  /// An optional description of the framework.
  final String? frameworkDescription;

  /// The unique name of a framework.
  final String? frameworkName;

  /// A framework consists of one or more controls. Each control governs a
  /// resource, such as backup plans, backup selections, backup vaults, or
  /// recovery points. You can also turn Config recording on or off for each
  /// resource. The statuses are:
  ///
  /// <ul>
  /// <li>
  /// <code>ACTIVE</code> when recording is turned on for all resources governed
  /// by the framework.
  /// </li>
  /// <li>
  /// <code>PARTIALLY_ACTIVE</code> when recording is turned off for at least one
  /// resource governed by the framework.
  /// </li>
  /// <li>
  /// <code>INACTIVE</code> when recording is turned off for all resources
  /// governed by the framework.
  /// </li>
  /// <li>
  /// <code>UNAVAILABLE</code> when Backup is unable to validate recording status
  /// at this time.
  /// </li>
  /// </ul>
  final String? frameworkStatus;

  /// A customer-chosen string that you can use to distinguish between otherwise
  /// identical calls to <code>DescribeFrameworkOutput</code>. Retrying a
  /// successful request with the same idempotency token results in a success
  /// message with no action taken.
  final String? idempotencyToken;

  DescribeFrameworkOutput({
    this.creationTime,
    this.deploymentStatus,
    this.frameworkArn,
    this.frameworkControls,
    this.frameworkDescription,
    this.frameworkName,
    this.frameworkStatus,
    this.idempotencyToken,
  });
  factory DescribeFrameworkOutput.fromJson(Map<String, dynamic> json) {
    return DescribeFrameworkOutput(
      creationTime: timeStampFromJson(json['CreationTime']),
      deploymentStatus: json['DeploymentStatus'] as String?,
      frameworkArn: json['FrameworkArn'] as String?,
      frameworkControls: (json['FrameworkControls'] as List?)
          ?.whereNotNull()
          .map((e) => FrameworkControl.fromJson(e as Map<String, dynamic>))
          .toList(),
      frameworkDescription: json['FrameworkDescription'] as String?,
      frameworkName: json['FrameworkName'] as String?,
      frameworkStatus: json['FrameworkStatus'] as String?,
      idempotencyToken: json['IdempotencyToken'] as String?,
    );
  }
}

class DescribeGlobalSettingsOutput {
  /// The status of the flag <code>isCrossAccountBackupEnabled</code>.
  final Map<String, String>? globalSettings;

  /// The date and time that the flag <code>isCrossAccountBackupEnabled</code> was
  /// last updated. This update is in Unix format and Coordinated Universal Time
  /// (UTC). The value of <code>LastUpdateTime</code> is accurate to milliseconds.
  /// For example, the value 1516925490.087 represents Friday, January 26, 2018
  /// 12:11:30.087 AM.
  final DateTime? lastUpdateTime;

  DescribeGlobalSettingsOutput({
    this.globalSettings,
    this.lastUpdateTime,
  });
  factory DescribeGlobalSettingsOutput.fromJson(Map<String, dynamic> json) {
    return DescribeGlobalSettingsOutput(
      globalSettings: (json['GlobalSettings'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      lastUpdateTime: timeStampFromJson(json['LastUpdateTime']),
    );
  }
}

class DescribeProtectedResourceOutput {
  /// The date and time that a resource was last backed up, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>LastBackupTime</code>
  /// is accurate to milliseconds. For example, the value 1516925490.087
  /// represents Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? lastBackupTime;

  /// An ARN that uniquely identifies a resource. The format of the ARN depends on
  /// the resource type.
  final String? resourceArn;

  /// The type of Amazon Web Services resource saved as a recovery point; for
  /// example, an Amazon EBS volume or an Amazon RDS database.
  final String? resourceType;

  DescribeProtectedResourceOutput({
    this.lastBackupTime,
    this.resourceArn,
    this.resourceType,
  });
  factory DescribeProtectedResourceOutput.fromJson(Map<String, dynamic> json) {
    return DescribeProtectedResourceOutput(
      lastBackupTime: timeStampFromJson(json['LastBackupTime']),
      resourceArn: json['ResourceArn'] as String?,
      resourceType: json['ResourceType'] as String?,
    );
  }
}

class DescribeRecoveryPointOutput {
  /// The size, in bytes, of a backup.
  final int? backupSizeInBytes;

  /// An ARN that uniquely identifies a backup vault; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:aBackupVault</code>.
  final String? backupVaultArn;

  /// The name of a logical container where backups are stored. Backup vaults are
  /// identified by names that are unique to the account used to create them and
  /// the Region where they are created. They consist of lowercase letters,
  /// numbers, and hyphens.
  final String? backupVaultName;

  /// A <code>CalculatedLifecycle</code> object containing <code>DeleteAt</code>
  /// and <code>MoveToColdStorageAt</code> timestamps.
  final CalculatedLifecycle? calculatedLifecycle;

  /// The date and time that a job to create a recovery point is completed, in
  /// Unix format and Coordinated Universal Time (UTC). The value of
  /// <code>CompletionDate</code> is accurate to milliseconds. For example, the
  /// value 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? completionDate;

  /// Contains identifying information about the creation of a recovery point,
  /// including the <code>BackupPlanArn</code>, <code>BackupPlanId</code>,
  /// <code>BackupPlanVersion</code>, and <code>BackupRuleId</code> of the backup
  /// plan used to create it.
  final RecoveryPointCreator? createdBy;

  /// The date and time that a recovery point is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationDate</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// The server-side encryption key used to protect your backups; for example,
  /// <code>arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code>.
  final String? encryptionKeyArn;

  /// Specifies the IAM role ARN used to create the target recovery point; for
  /// example, <code>arn:aws:iam::123456789012:role/S3Access</code>.
  final String? iamRoleArn;

  /// A Boolean value that is returned as <code>TRUE</code> if the specified
  /// recovery point is encrypted, or <code>FALSE</code> if the recovery point is
  /// not encrypted.
  final bool? isEncrypted;

  /// The date and time that a recovery point was last restored, in Unix format
  /// and Coordinated Universal Time (UTC). The value of
  /// <code>LastRestoreTime</code> is accurate to milliseconds. For example, the
  /// value 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? lastRestoreTime;

  /// The lifecycle defines when a protected resource is transitioned to cold
  /// storage and when it expires. Backup transitions and expires backups
  /// automatically according to the lifecycle that you define.
  ///
  /// Backups that are transitioned to cold storage must be stored in cold storage
  /// for a minimum of 90 days. Therefore, the “retention” setting must be 90 days
  /// greater than the “transition to cold after days” setting. The “transition to
  /// cold after days” setting cannot be changed after a backup has been
  /// transitioned to cold.
  ///
  /// Resource types that are able to be transitioned to cold storage are listed
  /// in the "Lifecycle to cold storage" section of the <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html#features-by-resource">
  /// Feature availability by resource</a> table. Backup ignores this expression
  /// for other resource types.
  final Lifecycle? lifecycle;

  /// An ARN that uniquely identifies a recovery point; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  final String? recoveryPointArn;

  /// An ARN that uniquely identifies a saved resource. The format of the ARN
  /// depends on the resource type.
  final String? resourceArn;

  /// The type of Amazon Web Services resource to save as a recovery point; for
  /// example, an Amazon Elastic Block Store (Amazon EBS) volume or an Amazon
  /// Relational Database Service (Amazon RDS) database.
  final String? resourceType;

  /// An Amazon Resource Name (ARN) that uniquely identifies the source vault
  /// where the resource was originally backed up in; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:BackupVault</code>. If the
  /// recovery is restored to the same Amazon Web Services account or Region, this
  /// value will be <code>null</code>.
  final String? sourceBackupVaultArn;

  /// A status code specifying the state of the recovery point.
  ///
  /// <code>PARTIAL</code> status indicates Backup could not create the recovery
  /// point before the backup window closed. To increase your backup plan window
  /// using the API, see <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/API_UpdateBackupPlan.html">UpdateBackupPlan</a>.
  /// You can also increase your backup plan window using the Console by choosing
  /// and editing your backup plan.
  ///
  /// <code>EXPIRED</code> status indicates that the recovery point has exceeded
  /// its retention period, but Backup lacks permission or is otherwise unable to
  /// delete it. To manually delete these recovery points, see <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/gs-cleanup-resources.html#cleanup-backups">
  /// Step 3: Delete the recovery points</a> in the <i>Clean up resources</i>
  /// section of <i>Getting started</i>.
  final RecoveryPointStatus? status;

  /// A status message explaining the reason for the recovery point deletion
  /// failure.
  final String? statusMessage;

  /// Specifies the storage class of the recovery point. Valid values are
  /// <code>WARM</code> or <code>COLD</code>.
  final StorageClass? storageClass;

  DescribeRecoveryPointOutput({
    this.backupSizeInBytes,
    this.backupVaultArn,
    this.backupVaultName,
    this.calculatedLifecycle,
    this.completionDate,
    this.createdBy,
    this.creationDate,
    this.encryptionKeyArn,
    this.iamRoleArn,
    this.isEncrypted,
    this.lastRestoreTime,
    this.lifecycle,
    this.recoveryPointArn,
    this.resourceArn,
    this.resourceType,
    this.sourceBackupVaultArn,
    this.status,
    this.statusMessage,
    this.storageClass,
  });
  factory DescribeRecoveryPointOutput.fromJson(Map<String, dynamic> json) {
    return DescribeRecoveryPointOutput(
      backupSizeInBytes: json['BackupSizeInBytes'] as int?,
      backupVaultArn: json['BackupVaultArn'] as String?,
      backupVaultName: json['BackupVaultName'] as String?,
      calculatedLifecycle: json['CalculatedLifecycle'] != null
          ? CalculatedLifecycle.fromJson(
              json['CalculatedLifecycle'] as Map<String, dynamic>)
          : null,
      completionDate: timeStampFromJson(json['CompletionDate']),
      createdBy: json['CreatedBy'] != null
          ? RecoveryPointCreator.fromJson(
              json['CreatedBy'] as Map<String, dynamic>)
          : null,
      creationDate: timeStampFromJson(json['CreationDate']),
      encryptionKeyArn: json['EncryptionKeyArn'] as String?,
      iamRoleArn: json['IamRoleArn'] as String?,
      isEncrypted: json['IsEncrypted'] as bool?,
      lastRestoreTime: timeStampFromJson(json['LastRestoreTime']),
      lifecycle: json['Lifecycle'] != null
          ? Lifecycle.fromJson(json['Lifecycle'] as Map<String, dynamic>)
          : null,
      recoveryPointArn: json['RecoveryPointArn'] as String?,
      resourceArn: json['ResourceArn'] as String?,
      resourceType: json['ResourceType'] as String?,
      sourceBackupVaultArn: json['SourceBackupVaultArn'] as String?,
      status: (json['Status'] as String?)?.toRecoveryPointStatus(),
      statusMessage: json['StatusMessage'] as String?,
      storageClass: (json['StorageClass'] as String?)?.toStorageClass(),
    );
  }
}

class DescribeRegionSettingsOutput {
  /// Returns whether Backup fully manages the backups for a resource type.
  ///
  /// For the benefits of full Backup management, see <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html#full-management">
  /// Full Backup management</a>.
  ///
  /// For a list of resource types and whether each supports full Backup
  /// management, see the <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html#features-by-resource">
  /// Feature availability by resource</a> table.
  ///
  /// If <code>"DynamoDB":false</code>, you can enable full Backup management for
  /// DynamoDB backup by enabling <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/advanced-ddb-backup.html#advanced-ddb-backup-enable-cli">
  /// Backup's advanced DynamoDB backup features</a>.
  final Map<String, bool>? resourceTypeManagementPreference;

  /// Returns a list of all services along with the opt-in preferences in the
  /// Region.
  final Map<String, bool>? resourceTypeOptInPreference;

  DescribeRegionSettingsOutput({
    this.resourceTypeManagementPreference,
    this.resourceTypeOptInPreference,
  });
  factory DescribeRegionSettingsOutput.fromJson(Map<String, dynamic> json) {
    return DescribeRegionSettingsOutput(
      resourceTypeManagementPreference:
          (json['ResourceTypeManagementPreference'] as Map<String, dynamic>?)
              ?.map((k, e) => MapEntry(k, e as bool)),
      resourceTypeOptInPreference:
          (json['ResourceTypeOptInPreference'] as Map<String, dynamic>?)
              ?.map((k, e) => MapEntry(k, e as bool)),
    );
  }
}

class DescribeReportJobOutput {
  /// A list of information about a report job, including its completion and
  /// creation times, report destination, unique report job ID, Amazon Resource
  /// Name (ARN), report template, status, and status message.
  final ReportJob? reportJob;

  DescribeReportJobOutput({
    this.reportJob,
  });
  factory DescribeReportJobOutput.fromJson(Map<String, dynamic> json) {
    return DescribeReportJobOutput(
      reportJob: json['ReportJob'] != null
          ? ReportJob.fromJson(json['ReportJob'] as Map<String, dynamic>)
          : null,
    );
  }
}

class DescribeReportPlanOutput {
  /// Returns details about the report plan that is specified by its name. These
  /// details include the report plan's Amazon Resource Name (ARN), description,
  /// settings, delivery channel, deployment status, creation time, and last
  /// attempted and successful run times.
  final ReportPlan? reportPlan;

  DescribeReportPlanOutput({
    this.reportPlan,
  });
  factory DescribeReportPlanOutput.fromJson(Map<String, dynamic> json) {
    return DescribeReportPlanOutput(
      reportPlan: json['ReportPlan'] != null
          ? ReportPlan.fromJson(json['ReportPlan'] as Map<String, dynamic>)
          : null,
    );
  }
}

class DescribeRestoreJobOutput {
  /// Returns the account ID that owns the restore job.
  final String? accountId;

  /// The size, in bytes, of the restored resource.
  final int? backupSizeInBytes;

  /// The date and time that a job to restore a recovery point is completed, in
  /// Unix format and Coordinated Universal Time (UTC). The value of
  /// <code>CompletionDate</code> is accurate to milliseconds. For example, the
  /// value 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? completionDate;

  /// An Amazon Resource Name (ARN) that uniquely identifies a resource whose
  /// recovery point is being restored. The format of the ARN depends on the
  /// resource type of the backed-up resource.
  final String? createdResourceArn;

  /// The date and time that a restore job is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationDate</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// The amount of time in minutes that a job restoring a recovery point is
  /// expected to take.
  final int? expectedCompletionTimeMinutes;

  /// Specifies the IAM role ARN used to create the target recovery point; for
  /// example, <code>arn:aws:iam::123456789012:role/S3Access</code>.
  final String? iamRoleArn;

  /// Contains an estimated percentage that is complete of a job at the time the
  /// job status was queried.
  final String? percentDone;

  /// An ARN that uniquely identifies a recovery point; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  final String? recoveryPointArn;

  /// Returns metadata associated with a restore job listed by resource type.
  final String? resourceType;

  /// Uniquely identifies the job that restores a recovery point.
  final String? restoreJobId;

  /// Status code specifying the state of the job that is initiated by Backup to
  /// restore a recovery point.
  final RestoreJobStatus? status;

  /// A message showing the status of a job to restore a recovery point.
  final String? statusMessage;

  DescribeRestoreJobOutput({
    this.accountId,
    this.backupSizeInBytes,
    this.completionDate,
    this.createdResourceArn,
    this.creationDate,
    this.expectedCompletionTimeMinutes,
    this.iamRoleArn,
    this.percentDone,
    this.recoveryPointArn,
    this.resourceType,
    this.restoreJobId,
    this.status,
    this.statusMessage,
  });
  factory DescribeRestoreJobOutput.fromJson(Map<String, dynamic> json) {
    return DescribeRestoreJobOutput(
      accountId: json['AccountId'] as String?,
      backupSizeInBytes: json['BackupSizeInBytes'] as int?,
      completionDate: timeStampFromJson(json['CompletionDate']),
      createdResourceArn: json['CreatedResourceArn'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
      expectedCompletionTimeMinutes:
          json['ExpectedCompletionTimeMinutes'] as int?,
      iamRoleArn: json['IamRoleArn'] as String?,
      percentDone: json['PercentDone'] as String?,
      recoveryPointArn: json['RecoveryPointArn'] as String?,
      resourceType: json['ResourceType'] as String?,
      restoreJobId: json['RestoreJobId'] as String?,
      status: (json['Status'] as String?)?.toRestoreJobStatus(),
      statusMessage: json['StatusMessage'] as String?,
    );
  }
}

class ExportBackupPlanTemplateOutput {
  /// The body of a backup plan template in JSON format.
  /// <note>
  /// This is a signed JSON document that cannot be modified before being passed
  /// to <code>GetBackupPlanFromJSON.</code>
  /// </note>
  final String? backupPlanTemplateJson;

  ExportBackupPlanTemplateOutput({
    this.backupPlanTemplateJson,
  });
  factory ExportBackupPlanTemplateOutput.fromJson(Map<String, dynamic> json) {
    return ExportBackupPlanTemplateOutput(
      backupPlanTemplateJson: json['BackupPlanTemplateJson'] as String?,
    );
  }
}

/// Contains detailed information about a framework. Frameworks contain
/// controls, which evaluate and report on your backup events and resources.
/// Frameworks generate daily compliance results.
class Framework {
  /// The date and time that a framework is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationTime</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationTime;

  /// The deployment status of a framework. The statuses are:
  ///
  /// <code>CREATE_IN_PROGRESS | UPDATE_IN_PROGRESS | DELETE_IN_PROGRESS |
  /// COMPLETED | FAILED</code>
  final String? deploymentStatus;

  /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
  /// format of the ARN depends on the resource type.
  final String? frameworkArn;

  /// An optional description of the framework with a maximum 1,024 characters.
  final String? frameworkDescription;

  /// The unique name of a framework. This name is between 1 and 256 characters,
  /// starting with a letter, and consisting of letters (a-z, A-Z), numbers (0-9),
  /// and underscores (_).
  final String? frameworkName;

  /// The number of controls contained by the framework.
  final int? numberOfControls;

  Framework({
    this.creationTime,
    this.deploymentStatus,
    this.frameworkArn,
    this.frameworkDescription,
    this.frameworkName,
    this.numberOfControls,
  });
  factory Framework.fromJson(Map<String, dynamic> json) {
    return Framework(
      creationTime: timeStampFromJson(json['CreationTime']),
      deploymentStatus: json['DeploymentStatus'] as String?,
      frameworkArn: json['FrameworkArn'] as String?,
      frameworkDescription: json['FrameworkDescription'] as String?,
      frameworkName: json['FrameworkName'] as String?,
      numberOfControls: json['NumberOfControls'] as int?,
    );
  }
}

/// Contains detailed information about all of the controls of a framework. Each
/// framework must contain at least one control.
class FrameworkControl {
  /// The name of a control. This name is between 1 and 256 characters.
  final String controlName;

  /// A list of <code>ParameterName</code> and <code>ParameterValue</code> pairs.
  final List<ControlInputParameter>? controlInputParameters;

  /// The scope of a control. The control scope defines what the control will
  /// evaluate. Three examples of control scopes are: a specific backup plan, all
  /// backup plans with a specific tag, or all backup plans. For more information,
  /// see <a href="aws-backup/latest/devguide/API_ControlScope.html">
  /// <code>ControlScope</code>.</a>
  final ControlScope? controlScope;

  FrameworkControl({
    required this.controlName,
    this.controlInputParameters,
    this.controlScope,
  });
  factory FrameworkControl.fromJson(Map<String, dynamic> json) {
    return FrameworkControl(
      controlName: json['ControlName'] as String,
      controlInputParameters: (json['ControlInputParameters'] as List?)
          ?.whereNotNull()
          .map((e) => ControlInputParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
      controlScope: json['ControlScope'] != null
          ? ControlScope.fromJson(json['ControlScope'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final controlName = this.controlName;
    final controlInputParameters = this.controlInputParameters;
    final controlScope = this.controlScope;
    return {
      'ControlName': controlName,
      if (controlInputParameters != null)
        'ControlInputParameters': controlInputParameters,
      if (controlScope != null) 'ControlScope': controlScope,
    };
  }
}

class GetBackupPlanFromJSONOutput {
  /// Specifies the body of a backup plan. Includes a <code>BackupPlanName</code>
  /// and one or more sets of <code>Rules</code>.
  final BackupPlan? backupPlan;

  GetBackupPlanFromJSONOutput({
    this.backupPlan,
  });
  factory GetBackupPlanFromJSONOutput.fromJson(Map<String, dynamic> json) {
    return GetBackupPlanFromJSONOutput(
      backupPlan: json['BackupPlan'] != null
          ? BackupPlan.fromJson(json['BackupPlan'] as Map<String, dynamic>)
          : null,
    );
  }
}

class GetBackupPlanFromTemplateOutput {
  /// Returns the body of a backup plan based on the target template, including
  /// the name, rules, and backup vault of the plan.
  final BackupPlan? backupPlanDocument;

  GetBackupPlanFromTemplateOutput({
    this.backupPlanDocument,
  });
  factory GetBackupPlanFromTemplateOutput.fromJson(Map<String, dynamic> json) {
    return GetBackupPlanFromTemplateOutput(
      backupPlanDocument: json['BackupPlanDocument'] != null
          ? BackupPlan.fromJson(
              json['BackupPlanDocument'] as Map<String, dynamic>)
          : null,
    );
  }
}

class GetBackupPlanOutput {
  /// Contains a list of <code>BackupOptions</code> for each resource type. The
  /// list is populated only if the advanced option is set for the backup plan.
  final List<AdvancedBackupSetting>? advancedBackupSettings;

  /// Specifies the body of a backup plan. Includes a <code>BackupPlanName</code>
  /// and one or more sets of <code>Rules</code>.
  final BackupPlan? backupPlan;

  /// An Amazon Resource Name (ARN) that uniquely identifies a backup plan; for
  /// example,
  /// <code>arn:aws:backup:us-east-1:123456789012:plan:8F81F553-3A74-4A3F-B93D-B3360DC80C50</code>.
  final String? backupPlanArn;

  /// Uniquely identifies a backup plan.
  final String? backupPlanId;

  /// The date and time that a backup plan is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationDate</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// A unique string that identifies the request and allows failed requests to be
  /// retried without the risk of running the operation twice.
  final String? creatorRequestId;

  /// The date and time that a backup plan is deleted, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>DeletionDate</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? deletionDate;

  /// The last time a job to back up resources was run with this backup plan. A
  /// date and time, in Unix format and Coordinated Universal Time (UTC). The
  /// value of <code>LastExecutionDate</code> is accurate to milliseconds. For
  /// example, the value 1516925490.087 represents Friday, January 26, 2018
  /// 12:11:30.087 AM.
  final DateTime? lastExecutionDate;

  /// Unique, randomly generated, Unicode, UTF-8 encoded strings that are at most
  /// 1,024 bytes long. Version IDs cannot be edited.
  final String? versionId;

  GetBackupPlanOutput({
    this.advancedBackupSettings,
    this.backupPlan,
    this.backupPlanArn,
    this.backupPlanId,
    this.creationDate,
    this.creatorRequestId,
    this.deletionDate,
    this.lastExecutionDate,
    this.versionId,
  });
  factory GetBackupPlanOutput.fromJson(Map<String, dynamic> json) {
    return GetBackupPlanOutput(
      advancedBackupSettings: (json['AdvancedBackupSettings'] as List?)
          ?.whereNotNull()
          .map((e) => AdvancedBackupSetting.fromJson(e as Map<String, dynamic>))
          .toList(),
      backupPlan: json['BackupPlan'] != null
          ? BackupPlan.fromJson(json['BackupPlan'] as Map<String, dynamic>)
          : null,
      backupPlanArn: json['BackupPlanArn'] as String?,
      backupPlanId: json['BackupPlanId'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
      creatorRequestId: json['CreatorRequestId'] as String?,
      deletionDate: timeStampFromJson(json['DeletionDate']),
      lastExecutionDate: timeStampFromJson(json['LastExecutionDate']),
      versionId: json['VersionId'] as String?,
    );
  }
}

class GetBackupSelectionOutput {
  /// Uniquely identifies a backup plan.
  final String? backupPlanId;

  /// Specifies the body of a request to assign a set of resources to a backup
  /// plan.
  final BackupSelection? backupSelection;

  /// The date and time a backup selection is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationDate</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// A unique string that identifies the request and allows failed requests to be
  /// retried without the risk of running the operation twice.
  final String? creatorRequestId;

  /// Uniquely identifies the body of a request to assign a set of resources to a
  /// backup plan.
  final String? selectionId;

  GetBackupSelectionOutput({
    this.backupPlanId,
    this.backupSelection,
    this.creationDate,
    this.creatorRequestId,
    this.selectionId,
  });
  factory GetBackupSelectionOutput.fromJson(Map<String, dynamic> json) {
    return GetBackupSelectionOutput(
      backupPlanId: json['BackupPlanId'] as String?,
      backupSelection: json['BackupSelection'] != null
          ? BackupSelection.fromJson(
              json['BackupSelection'] as Map<String, dynamic>)
          : null,
      creationDate: timeStampFromJson(json['CreationDate']),
      creatorRequestId: json['CreatorRequestId'] as String?,
      selectionId: json['SelectionId'] as String?,
    );
  }
}

class GetBackupVaultAccessPolicyOutput {
  /// An Amazon Resource Name (ARN) that uniquely identifies a backup vault; for
  /// example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:aBackupVault</code>.
  final String? backupVaultArn;

  /// The name of a logical container where backups are stored. Backup vaults are
  /// identified by names that are unique to the account used to create them and
  /// the Region where they are created. They consist of lowercase letters,
  /// numbers, and hyphens.
  final String? backupVaultName;

  /// The backup vault access policy document in JSON format.
  final String? policy;

  GetBackupVaultAccessPolicyOutput({
    this.backupVaultArn,
    this.backupVaultName,
    this.policy,
  });
  factory GetBackupVaultAccessPolicyOutput.fromJson(Map<String, dynamic> json) {
    return GetBackupVaultAccessPolicyOutput(
      backupVaultArn: json['BackupVaultArn'] as String?,
      backupVaultName: json['BackupVaultName'] as String?,
      policy: json['Policy'] as String?,
    );
  }
}

class GetBackupVaultNotificationsOutput {
  /// An Amazon Resource Name (ARN) that uniquely identifies a backup vault; for
  /// example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:aBackupVault</code>.
  final String? backupVaultArn;

  /// An array of events that indicate the status of jobs to back up resources to
  /// the backup vault.
  final List<BackupVaultEvent>? backupVaultEvents;

  /// The name of a logical container where backups are stored. Backup vaults are
  /// identified by names that are unique to the account used to create them and
  /// the Region where they are created. They consist of lowercase letters,
  /// numbers, and hyphens.
  final String? backupVaultName;

  /// An ARN that uniquely identifies an Amazon Simple Notification Service
  /// (Amazon SNS) topic; for example,
  /// <code>arn:aws:sns:us-west-2:111122223333:MyTopic</code>.
  final String? sNSTopicArn;

  GetBackupVaultNotificationsOutput({
    this.backupVaultArn,
    this.backupVaultEvents,
    this.backupVaultName,
    this.sNSTopicArn,
  });
  factory GetBackupVaultNotificationsOutput.fromJson(
      Map<String, dynamic> json) {
    return GetBackupVaultNotificationsOutput(
      backupVaultArn: json['BackupVaultArn'] as String?,
      backupVaultEvents: (json['BackupVaultEvents'] as List?)
          ?.whereNotNull()
          .map((e) => (e as String).toBackupVaultEvent())
          .toList(),
      backupVaultName: json['BackupVaultName'] as String?,
      sNSTopicArn: json['SNSTopicArn'] as String?,
    );
  }
}

class GetRecoveryPointRestoreMetadataOutput {
  /// An ARN that uniquely identifies a backup vault; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:aBackupVault</code>.
  final String? backupVaultArn;

  /// An ARN that uniquely identifies a recovery point; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  final String? recoveryPointArn;

  /// The set of metadata key-value pairs that describe the original configuration
  /// of the backed-up resource. These values vary depending on the service that
  /// is being restored.
  final Map<String, String>? restoreMetadata;

  GetRecoveryPointRestoreMetadataOutput({
    this.backupVaultArn,
    this.recoveryPointArn,
    this.restoreMetadata,
  });
  factory GetRecoveryPointRestoreMetadataOutput.fromJson(
      Map<String, dynamic> json) {
    return GetRecoveryPointRestoreMetadataOutput(
      backupVaultArn: json['BackupVaultArn'] as String?,
      recoveryPointArn: json['RecoveryPointArn'] as String?,
      restoreMetadata: (json['RestoreMetadata'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class GetSupportedResourceTypesOutput {
  /// Contains a string with the supported Amazon Web Services resource types:
  ///
  /// <ul>
  /// <li>
  /// <code>Aurora</code> for Amazon Aurora
  /// </li>
  /// <li>
  /// <code>DynamoDB</code> for Amazon DynamoDB
  /// </li>
  /// <li>
  /// <code>EBS</code> for Amazon Elastic Block Store
  /// </li>
  /// <li>
  /// <code>EC2</code> for Amazon Elastic Compute Cloud
  /// </li>
  /// <li>
  /// <code>EFS</code> for Amazon Elastic File System
  /// </li>
  /// <li>
  /// <code>FSX</code> for Amazon FSx
  /// </li>
  /// <li>
  /// <code>RDS</code> for Amazon Relational Database Service
  /// </li>
  /// <li>
  /// <code>Storage Gateway</code> for Storage Gateway
  /// </li>
  /// <li>
  /// <code>DocDB</code> for Amazon DocumentDB (with MongoDB compatibility)
  /// </li>
  /// <li>
  /// <code>Neptune</code> for Amazon Neptune
  /// </li>
  /// </ul>
  final List<String>? resourceTypes;

  GetSupportedResourceTypesOutput({
    this.resourceTypes,
  });
  factory GetSupportedResourceTypesOutput.fromJson(Map<String, dynamic> json) {
    return GetSupportedResourceTypesOutput(
      resourceTypes: (json['ResourceTypes'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }
}

/// Contains an array of <code>Transition</code> objects specifying how long in
/// days before a recovery point transitions to cold storage or is deleted.
///
/// Backups transitioned to cold storage must be stored in cold storage for a
/// minimum of 90 days. Therefore, on the console, the “retention” setting must
/// be 90 days greater than the “transition to cold after days” setting. The
/// “transition to cold after days” setting cannot be changed after a backup has
/// been transitioned to cold.
///
/// Resource types that are able to be transitioned to cold storage are listed
/// in the "Lifecycle to cold storage" section of the <a
/// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html#features-by-resource">
/// Feature availability by resource</a> table. Backup ignores this expression
/// for other resource types.
class Lifecycle {
  /// Specifies the number of days after creation that a recovery point is
  /// deleted. Must be greater than 90 days plus
  /// <code>MoveToColdStorageAfterDays</code>.
  final int? deleteAfterDays;

  /// Specifies the number of days after creation that a recovery point is moved
  /// to cold storage.
  final int? moveToColdStorageAfterDays;

  Lifecycle({
    this.deleteAfterDays,
    this.moveToColdStorageAfterDays,
  });
  factory Lifecycle.fromJson(Map<String, dynamic> json) {
    return Lifecycle(
      deleteAfterDays: json['DeleteAfterDays'] as int?,
      moveToColdStorageAfterDays: json['MoveToColdStorageAfterDays'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final deleteAfterDays = this.deleteAfterDays;
    final moveToColdStorageAfterDays = this.moveToColdStorageAfterDays;
    return {
      if (deleteAfterDays != null) 'DeleteAfterDays': deleteAfterDays,
      if (moveToColdStorageAfterDays != null)
        'MoveToColdStorageAfterDays': moveToColdStorageAfterDays,
    };
  }
}

class ListBackupJobsOutput {
  /// An array of structures containing metadata about your backup jobs returned
  /// in JSON format.
  final List<BackupJob>? backupJobs;

  /// The next item following a partial list of returned items. For example, if a
  /// request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list starting
  /// at the location pointed to by the next token.
  final String? nextToken;

  ListBackupJobsOutput({
    this.backupJobs,
    this.nextToken,
  });
  factory ListBackupJobsOutput.fromJson(Map<String, dynamic> json) {
    return ListBackupJobsOutput(
      backupJobs: (json['BackupJobs'] as List?)
          ?.whereNotNull()
          .map((e) => BackupJob.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListBackupPlanTemplatesOutput {
  /// An array of template list items containing metadata about your saved
  /// templates.
  final List<BackupPlanTemplatesListMember>? backupPlanTemplatesList;

  /// The next item following a partial list of returned items. For example, if a
  /// request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list starting
  /// at the location pointed to by the next token.
  final String? nextToken;

  ListBackupPlanTemplatesOutput({
    this.backupPlanTemplatesList,
    this.nextToken,
  });
  factory ListBackupPlanTemplatesOutput.fromJson(Map<String, dynamic> json) {
    return ListBackupPlanTemplatesOutput(
      backupPlanTemplatesList: (json['BackupPlanTemplatesList'] as List?)
          ?.whereNotNull()
          .map((e) =>
              BackupPlanTemplatesListMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListBackupPlanVersionsOutput {
  /// An array of version list items containing metadata about your backup plans.
  final List<BackupPlansListMember>? backupPlanVersionsList;

  /// The next item following a partial list of returned items. For example, if a
  /// request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list starting
  /// at the location pointed to by the next token.
  final String? nextToken;

  ListBackupPlanVersionsOutput({
    this.backupPlanVersionsList,
    this.nextToken,
  });
  factory ListBackupPlanVersionsOutput.fromJson(Map<String, dynamic> json) {
    return ListBackupPlanVersionsOutput(
      backupPlanVersionsList: (json['BackupPlanVersionsList'] as List?)
          ?.whereNotNull()
          .map((e) => BackupPlansListMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListBackupPlansOutput {
  /// An array of backup plan list items containing metadata about your saved
  /// backup plans.
  final List<BackupPlansListMember>? backupPlansList;

  /// The next item following a partial list of returned items. For example, if a
  /// request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list starting
  /// at the location pointed to by the next token.
  final String? nextToken;

  ListBackupPlansOutput({
    this.backupPlansList,
    this.nextToken,
  });
  factory ListBackupPlansOutput.fromJson(Map<String, dynamic> json) {
    return ListBackupPlansOutput(
      backupPlansList: (json['BackupPlansList'] as List?)
          ?.whereNotNull()
          .map((e) => BackupPlansListMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListBackupSelectionsOutput {
  /// An array of backup selection list items containing metadata about each
  /// resource in the list.
  final List<BackupSelectionsListMember>? backupSelectionsList;

  /// The next item following a partial list of returned items. For example, if a
  /// request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list starting
  /// at the location pointed to by the next token.
  final String? nextToken;

  ListBackupSelectionsOutput({
    this.backupSelectionsList,
    this.nextToken,
  });
  factory ListBackupSelectionsOutput.fromJson(Map<String, dynamic> json) {
    return ListBackupSelectionsOutput(
      backupSelectionsList: (json['BackupSelectionsList'] as List?)
          ?.whereNotNull()
          .map((e) =>
              BackupSelectionsListMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListBackupVaultsOutput {
  /// An array of backup vault list members containing vault metadata, including
  /// Amazon Resource Name (ARN), display name, creation date, number of saved
  /// recovery points, and encryption information if the resources saved in the
  /// backup vault are encrypted.
  final List<BackupVaultListMember>? backupVaultList;

  /// The next item following a partial list of returned items. For example, if a
  /// request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list starting
  /// at the location pointed to by the next token.
  final String? nextToken;

  ListBackupVaultsOutput({
    this.backupVaultList,
    this.nextToken,
  });
  factory ListBackupVaultsOutput.fromJson(Map<String, dynamic> json) {
    return ListBackupVaultsOutput(
      backupVaultList: (json['BackupVaultList'] as List?)
          ?.whereNotNull()
          .map((e) => BackupVaultListMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListCopyJobsOutput {
  /// An array of structures containing metadata about your copy jobs returned in
  /// JSON format.
  final List<CopyJob>? copyJobs;

  /// The next item following a partial list of returned items. For example, if a
  /// request is made to return maxResults number of items, NextToken allows you
  /// to return more items in your list starting at the location pointed to by the
  /// next token.
  final String? nextToken;

  ListCopyJobsOutput({
    this.copyJobs,
    this.nextToken,
  });
  factory ListCopyJobsOutput.fromJson(Map<String, dynamic> json) {
    return ListCopyJobsOutput(
      copyJobs: (json['CopyJobs'] as List?)
          ?.whereNotNull()
          .map((e) => CopyJob.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListFrameworksOutput {
  /// A list of frameworks with details for each framework, including the
  /// framework name, Amazon Resource Name (ARN), description, number of controls,
  /// creation time, and deployment status.
  final List<Framework>? frameworks;

  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  final String? nextToken;

  ListFrameworksOutput({
    this.frameworks,
    this.nextToken,
  });
  factory ListFrameworksOutput.fromJson(Map<String, dynamic> json) {
    return ListFrameworksOutput(
      frameworks: (json['Frameworks'] as List?)
          ?.whereNotNull()
          .map((e) => Framework.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListProtectedResourcesOutput {
  /// The next item following a partial list of returned items. For example, if a
  /// request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list starting
  /// at the location pointed to by the next token.
  final String? nextToken;

  /// An array of resources successfully backed up by Backup including the time
  /// the resource was saved, an Amazon Resource Name (ARN) of the resource, and a
  /// resource type.
  final List<ProtectedResource>? results;

  ListProtectedResourcesOutput({
    this.nextToken,
    this.results,
  });
  factory ListProtectedResourcesOutput.fromJson(Map<String, dynamic> json) {
    return ListProtectedResourcesOutput(
      nextToken: json['NextToken'] as String?,
      results: (json['Results'] as List?)
          ?.whereNotNull()
          .map((e) => ProtectedResource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListRecoveryPointsByBackupVaultOutput {
  /// The next item following a partial list of returned items. For example, if a
  /// request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list starting
  /// at the location pointed to by the next token.
  final String? nextToken;

  /// An array of objects that contain detailed information about recovery points
  /// saved in a backup vault.
  final List<RecoveryPointByBackupVault>? recoveryPoints;

  ListRecoveryPointsByBackupVaultOutput({
    this.nextToken,
    this.recoveryPoints,
  });
  factory ListRecoveryPointsByBackupVaultOutput.fromJson(
      Map<String, dynamic> json) {
    return ListRecoveryPointsByBackupVaultOutput(
      nextToken: json['NextToken'] as String?,
      recoveryPoints: (json['RecoveryPoints'] as List?)
          ?.whereNotNull()
          .map((e) =>
              RecoveryPointByBackupVault.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListRecoveryPointsByResourceOutput {
  /// The next item following a partial list of returned items. For example, if a
  /// request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list starting
  /// at the location pointed to by the next token.
  final String? nextToken;

  /// An array of objects that contain detailed information about recovery points
  /// of the specified resource type.
  /// <note>
  /// Only Amazon EFS and Amazon EC2 recovery points return BackupVaultName.
  /// </note>
  final List<RecoveryPointByResource>? recoveryPoints;

  ListRecoveryPointsByResourceOutput({
    this.nextToken,
    this.recoveryPoints,
  });
  factory ListRecoveryPointsByResourceOutput.fromJson(
      Map<String, dynamic> json) {
    return ListRecoveryPointsByResourceOutput(
      nextToken: json['NextToken'] as String?,
      recoveryPoints: (json['RecoveryPoints'] as List?)
          ?.whereNotNull()
          .map((e) =>
              RecoveryPointByResource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListReportJobsOutput {
  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  final String? nextToken;

  /// Details about your report jobs in JSON format.
  final List<ReportJob>? reportJobs;

  ListReportJobsOutput({
    this.nextToken,
    this.reportJobs,
  });
  factory ListReportJobsOutput.fromJson(Map<String, dynamic> json) {
    return ListReportJobsOutput(
      nextToken: json['NextToken'] as String?,
      reportJobs: (json['ReportJobs'] as List?)
          ?.whereNotNull()
          .map((e) => ReportJob.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListReportPlansOutput {
  /// An identifier that was returned from the previous call to this operation,
  /// which can be used to return the next set of items in the list.
  final String? nextToken;

  /// A list of your report plans with detailed information for each plan. This
  /// information includes the Amazon Resource Name (ARN), report plan name,
  /// description, settings, delivery channel, deployment status, creation time,
  /// and last times the report plan attempted to and successfully ran.
  final List<ReportPlan>? reportPlans;

  ListReportPlansOutput({
    this.nextToken,
    this.reportPlans,
  });
  factory ListReportPlansOutput.fromJson(Map<String, dynamic> json) {
    return ListReportPlansOutput(
      nextToken: json['NextToken'] as String?,
      reportPlans: (json['ReportPlans'] as List?)
          ?.whereNotNull()
          .map((e) => ReportPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListRestoreJobsOutput {
  /// The next item following a partial list of returned items. For example, if a
  /// request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list starting
  /// at the location pointed to by the next token.
  final String? nextToken;

  /// An array of objects that contain detailed information about jobs to restore
  /// saved resources.
  final List<RestoreJobsListMember>? restoreJobs;

  ListRestoreJobsOutput({
    this.nextToken,
    this.restoreJobs,
  });
  factory ListRestoreJobsOutput.fromJson(Map<String, dynamic> json) {
    return ListRestoreJobsOutput(
      nextToken: json['NextToken'] as String?,
      restoreJobs: (json['RestoreJobs'] as List?)
          ?.whereNotNull()
          .map((e) => RestoreJobsListMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListTagsOutput {
  /// The next item following a partial list of returned items. For example, if a
  /// request is made to return <code>maxResults</code> number of items,
  /// <code>NextToken</code> allows you to return more items in your list starting
  /// at the location pointed to by the next token.
  final String? nextToken;

  /// To help organize your resources, you can assign your own metadata to the
  /// resources you create. Each tag is a key-value pair.
  final Map<String, String>? tags;

  ListTagsOutput({
    this.nextToken,
    this.tags,
  });
  factory ListTagsOutput.fromJson(Map<String, dynamic> json) {
    return ListTagsOutput(
      nextToken: json['NextToken'] as String?,
      tags: (json['Tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

/// A structure that contains information about a backed-up resource.
class ProtectedResource {
  /// The date and time a resource was last backed up, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>LastBackupTime</code>
  /// is accurate to milliseconds. For example, the value 1516925490.087
  /// represents Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? lastBackupTime;

  /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
  /// format of the ARN depends on the resource type.
  final String? resourceArn;

  /// The type of Amazon Web Services resource; for example, an Amazon Elastic
  /// Block Store (Amazon EBS) volume or an Amazon Relational Database Service
  /// (Amazon RDS) database. For Windows Volume Shadow Copy Service (VSS) backups,
  /// the only supported resource type is Amazon EC2.
  final String? resourceType;

  ProtectedResource({
    this.lastBackupTime,
    this.resourceArn,
    this.resourceType,
  });
  factory ProtectedResource.fromJson(Map<String, dynamic> json) {
    return ProtectedResource(
      lastBackupTime: timeStampFromJson(json['LastBackupTime']),
      resourceArn: json['ResourceArn'] as String?,
      resourceType: json['ResourceType'] as String?,
    );
  }
}

/// Contains detailed information about the recovery points stored in a backup
/// vault.
class RecoveryPointByBackupVault {
  /// The size, in bytes, of a backup.
  final int? backupSizeInBytes;

  /// An ARN that uniquely identifies a backup vault; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:aBackupVault</code>.
  final String? backupVaultArn;

  /// The name of a logical container where backups are stored. Backup vaults are
  /// identified by names that are unique to the account used to create them and
  /// the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  final String? backupVaultName;

  /// A <code>CalculatedLifecycle</code> object containing <code>DeleteAt</code>
  /// and <code>MoveToColdStorageAt</code> timestamps.
  final CalculatedLifecycle? calculatedLifecycle;

  /// The date and time a job to restore a recovery point is completed, in Unix
  /// format and Coordinated Universal Time (UTC). The value of
  /// <code>CompletionDate</code> is accurate to milliseconds. For example, the
  /// value 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? completionDate;

  /// Contains identifying information about the creation of a recovery point,
  /// including the <code>BackupPlanArn</code>, <code>BackupPlanId</code>,
  /// <code>BackupPlanVersion</code>, and <code>BackupRuleId</code> of the backup
  /// plan that is used to create it.
  final RecoveryPointCreator? createdBy;

  /// The date and time a recovery point is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationDate</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// The server-side encryption key that is used to protect your backups; for
  /// example,
  /// <code>arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code>.
  final String? encryptionKeyArn;

  /// Specifies the IAM role ARN used to create the target recovery point; for
  /// example, <code>arn:aws:iam::123456789012:role/S3Access</code>.
  final String? iamRoleArn;

  /// A Boolean value that is returned as <code>TRUE</code> if the specified
  /// recovery point is encrypted, or <code>FALSE</code> if the recovery point is
  /// not encrypted.
  final bool? isEncrypted;

  /// The date and time a recovery point was last restored, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>LastRestoreTime</code>
  /// is accurate to milliseconds. For example, the value 1516925490.087
  /// represents Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? lastRestoreTime;

  /// The lifecycle defines when a protected resource is transitioned to cold
  /// storage and when it expires. Backup transitions and expires backups
  /// automatically according to the lifecycle that you define.
  ///
  /// Backups transitioned to cold storage must be stored in cold storage for a
  /// minimum of 90 days. Therefore, the “retention” setting must be 90 days
  /// greater than the “transition to cold after days” setting. The “transition to
  /// cold after days” setting cannot be changed after a backup has been
  /// transitioned to cold.
  ///
  /// Resource types that are able to be transitioned to cold storage are listed
  /// in the "Lifecycle to cold storage" section of the <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html#features-by-resource">
  /// Feature availability by resource</a> table. Backup ignores this expression
  /// for other resource types.
  final Lifecycle? lifecycle;

  /// An Amazon Resource Name (ARN) that uniquely identifies a recovery point; for
  /// example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  final String? recoveryPointArn;

  /// An ARN that uniquely identifies a resource. The format of the ARN depends on
  /// the resource type.
  final String? resourceArn;

  /// The type of Amazon Web Services resource saved as a recovery point; for
  /// example, an Amazon Elastic Block Store (Amazon EBS) volume or an Amazon
  /// Relational Database Service (Amazon RDS) database. For Windows Volume Shadow
  /// Copy Service (VSS) backups, the only supported resource type is Amazon EC2.
  final String? resourceType;

  /// The backup vault where the recovery point was originally copied from. If the
  /// recovery point is restored to the same account this value will be
  /// <code>null</code>.
  final String? sourceBackupVaultArn;

  /// A status code specifying the state of the recovery point.
  final RecoveryPointStatus? status;

  /// A message explaining the reason of the recovery point deletion failure.
  final String? statusMessage;

  RecoveryPointByBackupVault({
    this.backupSizeInBytes,
    this.backupVaultArn,
    this.backupVaultName,
    this.calculatedLifecycle,
    this.completionDate,
    this.createdBy,
    this.creationDate,
    this.encryptionKeyArn,
    this.iamRoleArn,
    this.isEncrypted,
    this.lastRestoreTime,
    this.lifecycle,
    this.recoveryPointArn,
    this.resourceArn,
    this.resourceType,
    this.sourceBackupVaultArn,
    this.status,
    this.statusMessage,
  });
  factory RecoveryPointByBackupVault.fromJson(Map<String, dynamic> json) {
    return RecoveryPointByBackupVault(
      backupSizeInBytes: json['BackupSizeInBytes'] as int?,
      backupVaultArn: json['BackupVaultArn'] as String?,
      backupVaultName: json['BackupVaultName'] as String?,
      calculatedLifecycle: json['CalculatedLifecycle'] != null
          ? CalculatedLifecycle.fromJson(
              json['CalculatedLifecycle'] as Map<String, dynamic>)
          : null,
      completionDate: timeStampFromJson(json['CompletionDate']),
      createdBy: json['CreatedBy'] != null
          ? RecoveryPointCreator.fromJson(
              json['CreatedBy'] as Map<String, dynamic>)
          : null,
      creationDate: timeStampFromJson(json['CreationDate']),
      encryptionKeyArn: json['EncryptionKeyArn'] as String?,
      iamRoleArn: json['IamRoleArn'] as String?,
      isEncrypted: json['IsEncrypted'] as bool?,
      lastRestoreTime: timeStampFromJson(json['LastRestoreTime']),
      lifecycle: json['Lifecycle'] != null
          ? Lifecycle.fromJson(json['Lifecycle'] as Map<String, dynamic>)
          : null,
      recoveryPointArn: json['RecoveryPointArn'] as String?,
      resourceArn: json['ResourceArn'] as String?,
      resourceType: json['ResourceType'] as String?,
      sourceBackupVaultArn: json['SourceBackupVaultArn'] as String?,
      status: (json['Status'] as String?)?.toRecoveryPointStatus(),
      statusMessage: json['StatusMessage'] as String?,
    );
  }
}

/// Contains detailed information about a saved recovery point.
class RecoveryPointByResource {
  /// The size, in bytes, of a backup.
  final int? backupSizeBytes;

  /// The name of a logical container where backups are stored. Backup vaults are
  /// identified by names that are unique to the account used to create them and
  /// the Amazon Web Services Region where they are created. They consist of
  /// lowercase letters, numbers, and hyphens.
  final String? backupVaultName;

  /// The date and time a recovery point is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationDate</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// The server-side encryption key that is used to protect your backups; for
  /// example,
  /// <code>arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code>.
  final String? encryptionKeyArn;

  /// An Amazon Resource Name (ARN) that uniquely identifies a recovery point; for
  /// example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  final String? recoveryPointArn;

  /// A status code specifying the state of the recovery point.
  final RecoveryPointStatus? status;

  /// A message explaining the reason of the recovery point deletion failure.
  final String? statusMessage;

  RecoveryPointByResource({
    this.backupSizeBytes,
    this.backupVaultName,
    this.creationDate,
    this.encryptionKeyArn,
    this.recoveryPointArn,
    this.status,
    this.statusMessage,
  });
  factory RecoveryPointByResource.fromJson(Map<String, dynamic> json) {
    return RecoveryPointByResource(
      backupSizeBytes: json['BackupSizeBytes'] as int?,
      backupVaultName: json['BackupVaultName'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
      encryptionKeyArn: json['EncryptionKeyArn'] as String?,
      recoveryPointArn: json['RecoveryPointArn'] as String?,
      status: (json['Status'] as String?)?.toRecoveryPointStatus(),
      statusMessage: json['StatusMessage'] as String?,
    );
  }
}

/// Contains information about the backup plan and rule that Backup used to
/// initiate the recovery point backup.
class RecoveryPointCreator {
  /// An Amazon Resource Name (ARN) that uniquely identifies a backup plan; for
  /// example,
  /// <code>arn:aws:backup:us-east-1:123456789012:plan:8F81F553-3A74-4A3F-B93D-B3360DC80C50</code>.
  final String? backupPlanArn;

  /// Uniquely identifies a backup plan.
  final String? backupPlanId;

  /// Version IDs are unique, randomly generated, Unicode, UTF-8 encoded strings
  /// that are at most 1,024 bytes long. They cannot be edited.
  final String? backupPlanVersion;

  /// Uniquely identifies a rule used to schedule the backup of a selection of
  /// resources.
  final String? backupRuleId;

  RecoveryPointCreator({
    this.backupPlanArn,
    this.backupPlanId,
    this.backupPlanVersion,
    this.backupRuleId,
  });
  factory RecoveryPointCreator.fromJson(Map<String, dynamic> json) {
    return RecoveryPointCreator(
      backupPlanArn: json['BackupPlanArn'] as String?,
      backupPlanId: json['BackupPlanId'] as String?,
      backupPlanVersion: json['BackupPlanVersion'] as String?,
      backupRuleId: json['BackupRuleId'] as String?,
    );
  }
}

enum RecoveryPointStatus {
  completed,
  partial,
  deleting,
  expired,
}

extension on RecoveryPointStatus {
  String toValue() {
    switch (this) {
      case RecoveryPointStatus.completed:
        return 'COMPLETED';
      case RecoveryPointStatus.partial:
        return 'PARTIAL';
      case RecoveryPointStatus.deleting:
        return 'DELETING';
      case RecoveryPointStatus.expired:
        return 'EXPIRED';
    }
  }
}

extension on String {
  RecoveryPointStatus toRecoveryPointStatus() {
    switch (this) {
      case 'COMPLETED':
        return RecoveryPointStatus.completed;
      case 'PARTIAL':
        return RecoveryPointStatus.partial;
      case 'DELETING':
        return RecoveryPointStatus.deleting;
      case 'EXPIRED':
        return RecoveryPointStatus.expired;
    }
    throw Exception('$this is not known in enum RecoveryPointStatus');
  }
}

/// Contains information from your report plan about where to deliver your
/// reports, specifically your Amazon S3 bucket name, S3 key prefix, and the
/// formats of your reports.
class ReportDeliveryChannel {
  /// The unique name of the S3 bucket that receives your reports.
  final String s3BucketName;

  /// A list of the format of your reports: <code>CSV</code>, <code>JSON</code>,
  /// or both. If not specified, the default format is <code>CSV</code>.
  final List<String>? formats;

  /// The prefix for where Backup Audit Manager delivers your reports to Amazon
  /// S3. The prefix is this part of the following path:
  /// s3://your-bucket-name/<code>prefix</code>/Backup/us-west-2/year/month/day/report-name.
  /// If not specified, there is no prefix.
  final String? s3KeyPrefix;

  ReportDeliveryChannel({
    required this.s3BucketName,
    this.formats,
    this.s3KeyPrefix,
  });
  factory ReportDeliveryChannel.fromJson(Map<String, dynamic> json) {
    return ReportDeliveryChannel(
      s3BucketName: json['S3BucketName'] as String,
      formats: (json['Formats'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      s3KeyPrefix: json['S3KeyPrefix'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final s3BucketName = this.s3BucketName;
    final formats = this.formats;
    final s3KeyPrefix = this.s3KeyPrefix;
    return {
      'S3BucketName': s3BucketName,
      if (formats != null) 'Formats': formats,
      if (s3KeyPrefix != null) 'S3KeyPrefix': s3KeyPrefix,
    };
  }
}

/// Contains information from your report job about your report destination.
class ReportDestination {
  /// The unique name of the Amazon S3 bucket that receives your reports.
  final String? s3BucketName;

  /// The object key that uniquely identifies your reports in your S3 bucket.
  final List<String>? s3Keys;

  ReportDestination({
    this.s3BucketName,
    this.s3Keys,
  });
  factory ReportDestination.fromJson(Map<String, dynamic> json) {
    return ReportDestination(
      s3BucketName: json['S3BucketName'] as String?,
      s3Keys: (json['S3Keys'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }
}

/// Contains detailed information about a report job. A report job compiles a
/// report based on a report plan and publishes it to Amazon S3.
class ReportJob {
  /// The date and time that a report job is completed, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CompletionTime</code>
  /// is accurate to milliseconds. For example, the value 1516925490.087
  /// represents Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? completionTime;

  /// The date and time that a report job is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationTime</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationTime;

  /// The S3 bucket name and S3 keys for the destination where the report job
  /// publishes the report.
  final ReportDestination? reportDestination;

  /// The identifier for a report job. A unique, randomly generated, Unicode,
  /// UTF-8 encoded string that is at most 1,024 bytes long. Report job IDs cannot
  /// be edited.
  final String? reportJobId;

  /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
  /// format of the ARN depends on the resource type.
  final String? reportPlanArn;

  /// Identifies the report template for the report. Reports are built using a
  /// report template. The report templates are:
  ///
  /// <code>RESOURCE_COMPLIANCE_REPORT | CONTROL_COMPLIANCE_REPORT |
  /// BACKUP_JOB_REPORT | COPY_JOB_REPORT | RESTORE_JOB_REPORT</code>
  final String? reportTemplate;

  /// The status of a report job. The statuses are:
  ///
  /// <code>CREATED | RUNNING | COMPLETED | FAILED</code>
  ///
  /// <code>COMPLETED</code> means that the report is available for your review at
  /// your designated destination. If the status is <code>FAILED</code>, review
  /// the <code>StatusMessage</code> for the reason.
  final String? status;

  /// A message explaining the status of the report job.
  final String? statusMessage;

  ReportJob({
    this.completionTime,
    this.creationTime,
    this.reportDestination,
    this.reportJobId,
    this.reportPlanArn,
    this.reportTemplate,
    this.status,
    this.statusMessage,
  });
  factory ReportJob.fromJson(Map<String, dynamic> json) {
    return ReportJob(
      completionTime: timeStampFromJson(json['CompletionTime']),
      creationTime: timeStampFromJson(json['CreationTime']),
      reportDestination: json['ReportDestination'] != null
          ? ReportDestination.fromJson(
              json['ReportDestination'] as Map<String, dynamic>)
          : null,
      reportJobId: json['ReportJobId'] as String?,
      reportPlanArn: json['ReportPlanArn'] as String?,
      reportTemplate: json['ReportTemplate'] as String?,
      status: json['Status'] as String?,
      statusMessage: json['StatusMessage'] as String?,
    );
  }
}

/// Contains detailed information about a report plan.
class ReportPlan {
  /// The date and time that a report plan is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationTime</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationTime;

  /// The deployment status of a report plan. The statuses are:
  ///
  /// <code>CREATE_IN_PROGRESS | UPDATE_IN_PROGRESS | DELETE_IN_PROGRESS |
  /// COMPLETED</code>
  final String? deploymentStatus;

  /// The date and time that a report job associated with this report plan last
  /// attempted to run, in Unix format and Coordinated Universal Time (UTC). The
  /// value of <code>LastAttemptedExecutionTime</code> is accurate to
  /// milliseconds. For example, the value 1516925490.087 represents Friday,
  /// January 26, 2018 12:11:30.087 AM.
  final DateTime? lastAttemptedExecutionTime;

  /// The date and time that a report job associated with this report plan last
  /// successfully ran, in Unix format and Coordinated Universal Time (UTC). The
  /// value of <code>LastSuccessfulExecutionTime</code> is accurate to
  /// milliseconds. For example, the value 1516925490.087 represents Friday,
  /// January 26, 2018 12:11:30.087 AM.
  final DateTime? lastSuccessfulExecutionTime;

  /// Contains information about where and how to deliver your reports,
  /// specifically your Amazon S3 bucket name, S3 key prefix, and the formats of
  /// your reports.
  final ReportDeliveryChannel? reportDeliveryChannel;

  /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
  /// format of the ARN depends on the resource type.
  final String? reportPlanArn;

  /// An optional description of the report plan with a maximum 1,024 characters.
  final String? reportPlanDescription;

  /// The unique name of the report plan. This name is between 1 and 256
  /// characters starting with a letter, and consisting of letters (a-z, A-Z),
  /// numbers (0-9), and underscores (_).
  final String? reportPlanName;

  /// Identifies the report template for the report. Reports are built using a
  /// report template. The report templates are:
  ///
  /// <code>RESOURCE_COMPLIANCE_REPORT | CONTROL_COMPLIANCE_REPORT |
  /// BACKUP_JOB_REPORT | COPY_JOB_REPORT | RESTORE_JOB_REPORT</code>
  ///
  /// If the report template is <code>RESOURCE_COMPLIANCE_REPORT</code> or
  /// <code>CONTROL_COMPLIANCE_REPORT</code>, this API resource also describes the
  /// report coverage by Amazon Web Services Regions and frameworks.
  final ReportSetting? reportSetting;

  ReportPlan({
    this.creationTime,
    this.deploymentStatus,
    this.lastAttemptedExecutionTime,
    this.lastSuccessfulExecutionTime,
    this.reportDeliveryChannel,
    this.reportPlanArn,
    this.reportPlanDescription,
    this.reportPlanName,
    this.reportSetting,
  });
  factory ReportPlan.fromJson(Map<String, dynamic> json) {
    return ReportPlan(
      creationTime: timeStampFromJson(json['CreationTime']),
      deploymentStatus: json['DeploymentStatus'] as String?,
      lastAttemptedExecutionTime:
          timeStampFromJson(json['LastAttemptedExecutionTime']),
      lastSuccessfulExecutionTime:
          timeStampFromJson(json['LastSuccessfulExecutionTime']),
      reportDeliveryChannel: json['ReportDeliveryChannel'] != null
          ? ReportDeliveryChannel.fromJson(
              json['ReportDeliveryChannel'] as Map<String, dynamic>)
          : null,
      reportPlanArn: json['ReportPlanArn'] as String?,
      reportPlanDescription: json['ReportPlanDescription'] as String?,
      reportPlanName: json['ReportPlanName'] as String?,
      reportSetting: json['ReportSetting'] != null
          ? ReportSetting.fromJson(
              json['ReportSetting'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Contains detailed information about a report setting.
class ReportSetting {
  /// Identifies the report template for the report. Reports are built using a
  /// report template. The report templates are:
  ///
  /// <code>RESOURCE_COMPLIANCE_REPORT | CONTROL_COMPLIANCE_REPORT |
  /// BACKUP_JOB_REPORT | COPY_JOB_REPORT | RESTORE_JOB_REPORT</code>
  final String reportTemplate;

  /// The Amazon Resource Names (ARNs) of the frameworks a report covers.
  final List<String>? frameworkArns;

  /// The number of frameworks a report covers.
  final int? numberOfFrameworks;

  ReportSetting({
    required this.reportTemplate,
    this.frameworkArns,
    this.numberOfFrameworks,
  });
  factory ReportSetting.fromJson(Map<String, dynamic> json) {
    return ReportSetting(
      reportTemplate: json['ReportTemplate'] as String,
      frameworkArns: (json['FrameworkArns'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      numberOfFrameworks: json['NumberOfFrameworks'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final reportTemplate = this.reportTemplate;
    final frameworkArns = this.frameworkArns;
    final numberOfFrameworks = this.numberOfFrameworks;
    return {
      'ReportTemplate': reportTemplate,
      if (frameworkArns != null) 'FrameworkArns': frameworkArns,
      if (numberOfFrameworks != null) 'NumberOfFrameworks': numberOfFrameworks,
    };
  }
}

enum RestoreJobStatus {
  pending,
  running,
  completed,
  aborted,
  failed,
}

extension on RestoreJobStatus {
  String toValue() {
    switch (this) {
      case RestoreJobStatus.pending:
        return 'PENDING';
      case RestoreJobStatus.running:
        return 'RUNNING';
      case RestoreJobStatus.completed:
        return 'COMPLETED';
      case RestoreJobStatus.aborted:
        return 'ABORTED';
      case RestoreJobStatus.failed:
        return 'FAILED';
    }
  }
}

extension on String {
  RestoreJobStatus toRestoreJobStatus() {
    switch (this) {
      case 'PENDING':
        return RestoreJobStatus.pending;
      case 'RUNNING':
        return RestoreJobStatus.running;
      case 'COMPLETED':
        return RestoreJobStatus.completed;
      case 'ABORTED':
        return RestoreJobStatus.aborted;
      case 'FAILED':
        return RestoreJobStatus.failed;
    }
    throw Exception('$this is not known in enum RestoreJobStatus');
  }
}

/// Contains metadata about a restore job.
class RestoreJobsListMember {
  /// The account ID that owns the restore job.
  final String? accountId;

  /// The size, in bytes, of the restored resource.
  final int? backupSizeInBytes;

  /// The date and time a job to restore a recovery point is completed, in Unix
  /// format and Coordinated Universal Time (UTC). The value of
  /// <code>CompletionDate</code> is accurate to milliseconds. For example, the
  /// value 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? completionDate;

  /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
  /// format of the ARN depends on the resource type.
  final String? createdResourceArn;

  /// The date and time a restore job is created, in Unix format and Coordinated
  /// Universal Time (UTC). The value of <code>CreationDate</code> is accurate to
  /// milliseconds. For example, the value 1516925490.087 represents Friday,
  /// January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// The amount of time in minutes that a job restoring a recovery point is
  /// expected to take.
  final int? expectedCompletionTimeMinutes;

  /// Specifies the IAM role ARN used to create the target recovery point; for
  /// example, <code>arn:aws:iam::123456789012:role/S3Access</code>.
  final String? iamRoleArn;

  /// Contains an estimated percentage complete of a job at the time the job
  /// status was queried.
  final String? percentDone;

  /// An ARN that uniquely identifies a recovery point; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  final String? recoveryPointArn;

  /// The resource type of the listed restore jobs; for example, an Amazon Elastic
  /// Block Store (Amazon EBS) volume or an Amazon Relational Database Service
  /// (Amazon RDS) database. For Windows Volume Shadow Copy Service (VSS) backups,
  /// the only supported resource type is Amazon EC2.
  final String? resourceType;

  /// Uniquely identifies the job that restores a recovery point.
  final String? restoreJobId;

  /// A status code specifying the state of the job initiated by Backup to restore
  /// a recovery point.
  final RestoreJobStatus? status;

  /// A detailed message explaining the status of the job to restore a recovery
  /// point.
  final String? statusMessage;

  RestoreJobsListMember({
    this.accountId,
    this.backupSizeInBytes,
    this.completionDate,
    this.createdResourceArn,
    this.creationDate,
    this.expectedCompletionTimeMinutes,
    this.iamRoleArn,
    this.percentDone,
    this.recoveryPointArn,
    this.resourceType,
    this.restoreJobId,
    this.status,
    this.statusMessage,
  });
  factory RestoreJobsListMember.fromJson(Map<String, dynamic> json) {
    return RestoreJobsListMember(
      accountId: json['AccountId'] as String?,
      backupSizeInBytes: json['BackupSizeInBytes'] as int?,
      completionDate: timeStampFromJson(json['CompletionDate']),
      createdResourceArn: json['CreatedResourceArn'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
      expectedCompletionTimeMinutes:
          json['ExpectedCompletionTimeMinutes'] as int?,
      iamRoleArn: json['IamRoleArn'] as String?,
      percentDone: json['PercentDone'] as String?,
      recoveryPointArn: json['RecoveryPointArn'] as String?,
      resourceType: json['ResourceType'] as String?,
      restoreJobId: json['RestoreJobId'] as String?,
      status: (json['Status'] as String?)?.toRestoreJobStatus(),
      statusMessage: json['StatusMessage'] as String?,
    );
  }
}

class StartBackupJobOutput {
  /// Uniquely identifies a request to Backup to back up a resource.
  final String? backupJobId;

  /// The date and time that a backup job is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationDate</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// An ARN that uniquely identifies a recovery point; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  final String? recoveryPointArn;

  StartBackupJobOutput({
    this.backupJobId,
    this.creationDate,
    this.recoveryPointArn,
  });
  factory StartBackupJobOutput.fromJson(Map<String, dynamic> json) {
    return StartBackupJobOutput(
      backupJobId: json['BackupJobId'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
      recoveryPointArn: json['RecoveryPointArn'] as String?,
    );
  }
}

class StartCopyJobOutput {
  /// Uniquely identifies a copy job.
  final String? copyJobId;

  /// The date and time that a copy job is created, in Unix format and Coordinated
  /// Universal Time (UTC). The value of <code>CreationDate</code> is accurate to
  /// milliseconds. For example, the value 1516925490.087 represents Friday,
  /// January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  StartCopyJobOutput({
    this.copyJobId,
    this.creationDate,
  });
  factory StartCopyJobOutput.fromJson(Map<String, dynamic> json) {
    return StartCopyJobOutput(
      copyJobId: json['CopyJobId'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
    );
  }
}

class StartReportJobOutput {
  /// The identifier of the report job. A unique, randomly generated, Unicode,
  /// UTF-8 encoded string that is at most 1,024 bytes long. The report job ID
  /// cannot be edited.
  final String? reportJobId;

  StartReportJobOutput({
    this.reportJobId,
  });
  factory StartReportJobOutput.fromJson(Map<String, dynamic> json) {
    return StartReportJobOutput(
      reportJobId: json['ReportJobId'] as String?,
    );
  }
}

class StartRestoreJobOutput {
  /// Uniquely identifies the job that restores a recovery point.
  final String? restoreJobId;

  StartRestoreJobOutput({
    this.restoreJobId,
  });
  factory StartRestoreJobOutput.fromJson(Map<String, dynamic> json) {
    return StartRestoreJobOutput(
      restoreJobId: json['RestoreJobId'] as String?,
    );
  }
}

enum StorageClass {
  warm,
  cold,
  deleted,
}

extension on StorageClass {
  String toValue() {
    switch (this) {
      case StorageClass.warm:
        return 'WARM';
      case StorageClass.cold:
        return 'COLD';
      case StorageClass.deleted:
        return 'DELETED';
    }
  }
}

extension on String {
  StorageClass toStorageClass() {
    switch (this) {
      case 'WARM':
        return StorageClass.warm;
      case 'COLD':
        return StorageClass.cold;
      case 'DELETED':
        return StorageClass.deleted;
    }
    throw Exception('$this is not known in enum StorageClass');
  }
}

class UpdateBackupPlanOutput {
  /// Contains a list of <code>BackupOptions</code> for each resource type.
  final List<AdvancedBackupSetting>? advancedBackupSettings;

  /// An Amazon Resource Name (ARN) that uniquely identifies a backup plan; for
  /// example,
  /// <code>arn:aws:backup:us-east-1:123456789012:plan:8F81F553-3A74-4A3F-B93D-B3360DC80C50</code>.
  final String? backupPlanArn;

  /// Uniquely identifies a backup plan.
  final String? backupPlanId;

  /// The date and time a backup plan is created, in Unix format and Coordinated
  /// Universal Time (UTC). The value of <code>CreationDate</code> is accurate to
  /// milliseconds. For example, the value 1516925490.087 represents Friday,
  /// January 26, 2018 12:11:30.087 AM.
  final DateTime? creationDate;

  /// Unique, randomly generated, Unicode, UTF-8 encoded strings that are at most
  /// 1,024 bytes long. Version Ids cannot be edited.
  final String? versionId;

  UpdateBackupPlanOutput({
    this.advancedBackupSettings,
    this.backupPlanArn,
    this.backupPlanId,
    this.creationDate,
    this.versionId,
  });
  factory UpdateBackupPlanOutput.fromJson(Map<String, dynamic> json) {
    return UpdateBackupPlanOutput(
      advancedBackupSettings: (json['AdvancedBackupSettings'] as List?)
          ?.whereNotNull()
          .map((e) => AdvancedBackupSetting.fromJson(e as Map<String, dynamic>))
          .toList(),
      backupPlanArn: json['BackupPlanArn'] as String?,
      backupPlanId: json['BackupPlanId'] as String?,
      creationDate: timeStampFromJson(json['CreationDate']),
      versionId: json['VersionId'] as String?,
    );
  }
}

class UpdateFrameworkOutput {
  /// The date and time that a framework is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationTime</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationTime;

  /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
  /// format of the ARN depends on the resource type.
  final String? frameworkArn;

  /// The unique name of a framework. This name is between 1 and 256 characters,
  /// starting with a letter, and consisting of letters (a-z, A-Z), numbers (0-9),
  /// and underscores (_).
  final String? frameworkName;

  UpdateFrameworkOutput({
    this.creationTime,
    this.frameworkArn,
    this.frameworkName,
  });
  factory UpdateFrameworkOutput.fromJson(Map<String, dynamic> json) {
    return UpdateFrameworkOutput(
      creationTime: timeStampFromJson(json['CreationTime']),
      frameworkArn: json['FrameworkArn'] as String?,
      frameworkName: json['FrameworkName'] as String?,
    );
  }
}

class UpdateRecoveryPointLifecycleOutput {
  /// An ARN that uniquely identifies a backup vault; for example,
  /// <code>arn:aws:backup:us-east-1:123456789012:vault:aBackupVault</code>.
  final String? backupVaultArn;

  /// A <code>CalculatedLifecycle</code> object containing <code>DeleteAt</code>
  /// and <code>MoveToColdStorageAt</code> timestamps.
  final CalculatedLifecycle? calculatedLifecycle;

  /// The lifecycle defines when a protected resource is transitioned to cold
  /// storage and when it expires. Backup transitions and expires backups
  /// automatically according to the lifecycle that you define.
  ///
  /// Backups transitioned to cold storage must be stored in cold storage for a
  /// minimum of 90 days. Therefore, the “retention” setting must be 90 days
  /// greater than the “transition to cold after days” setting. The “transition to
  /// cold after days” setting cannot be changed after a backup has been
  /// transitioned to cold.
  ///
  /// Resource types that are able to be transitioned to cold storage are listed
  /// in the "Lifecycle to cold storage" section of the <a
  /// href="https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html#features-by-resource">
  /// Feature availability by resource</a> table. Backup ignores this expression
  /// for other resource types.
  final Lifecycle? lifecycle;

  /// An Amazon Resource Name (ARN) that uniquely identifies a recovery point; for
  /// example,
  /// <code>arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45</code>.
  final String? recoveryPointArn;

  UpdateRecoveryPointLifecycleOutput({
    this.backupVaultArn,
    this.calculatedLifecycle,
    this.lifecycle,
    this.recoveryPointArn,
  });
  factory UpdateRecoveryPointLifecycleOutput.fromJson(
      Map<String, dynamic> json) {
    return UpdateRecoveryPointLifecycleOutput(
      backupVaultArn: json['BackupVaultArn'] as String?,
      calculatedLifecycle: json['CalculatedLifecycle'] != null
          ? CalculatedLifecycle.fromJson(
              json['CalculatedLifecycle'] as Map<String, dynamic>)
          : null,
      lifecycle: json['Lifecycle'] != null
          ? Lifecycle.fromJson(json['Lifecycle'] as Map<String, dynamic>)
          : null,
      recoveryPointArn: json['RecoveryPointArn'] as String?,
    );
  }
}

class UpdateReportPlanOutput {
  /// The date and time that a report plan is created, in Unix format and
  /// Coordinated Universal Time (UTC). The value of <code>CreationTime</code> is
  /// accurate to milliseconds. For example, the value 1516925490.087 represents
  /// Friday, January 26, 2018 12:11:30.087 AM.
  final DateTime? creationTime;

  /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
  /// format of the ARN depends on the resource type.
  final String? reportPlanArn;

  /// The unique name of the report plan.
  final String? reportPlanName;

  UpdateReportPlanOutput({
    this.creationTime,
    this.reportPlanArn,
    this.reportPlanName,
  });
  factory UpdateReportPlanOutput.fromJson(Map<String, dynamic> json) {
    return UpdateReportPlanOutput(
      creationTime: timeStampFromJson(json['CreationTime']),
      reportPlanArn: json['ReportPlanArn'] as String?,
      reportPlanName: json['ReportPlanName'] as String?,
    );
  }
}

class AlreadyExistsException extends _s.GenericAwsException {
  AlreadyExistsException({String? type, String? message})
      : super(type: type, code: 'AlreadyExistsException', message: message);
}

class ConflictException extends _s.GenericAwsException {
  ConflictException({String? type, String? message})
      : super(type: type, code: 'ConflictException', message: message);
}

class DependencyFailureException extends _s.GenericAwsException {
  DependencyFailureException({String? type, String? message})
      : super(type: type, code: 'DependencyFailureException', message: message);
}

class InvalidParameterValueException extends _s.GenericAwsException {
  InvalidParameterValueException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidParameterValueException',
            message: message);
}

class InvalidRequestException extends _s.GenericAwsException {
  InvalidRequestException({String? type, String? message})
      : super(type: type, code: 'InvalidRequestException', message: message);
}

class InvalidResourceStateException extends _s.GenericAwsException {
  InvalidResourceStateException({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidResourceStateException',
            message: message);
}

class LimitExceededException extends _s.GenericAwsException {
  LimitExceededException({String? type, String? message})
      : super(type: type, code: 'LimitExceededException', message: message);
}

class MissingParameterValueException extends _s.GenericAwsException {
  MissingParameterValueException({String? type, String? message})
      : super(
            type: type,
            code: 'MissingParameterValueException',
            message: message);
}

class ResourceNotFoundException extends _s.GenericAwsException {
  ResourceNotFoundException({String? type, String? message})
      : super(type: type, code: 'ResourceNotFoundException', message: message);
}

class ServiceUnavailableException extends _s.GenericAwsException {
  ServiceUnavailableException({String? type, String? message})
      : super(
            type: type, code: 'ServiceUnavailableException', message: message);
}

final _exceptionFns = <String, _s.AwsExceptionFn>{
  'AlreadyExistsException': (type, message) =>
      AlreadyExistsException(type: type, message: message),
  'ConflictException': (type, message) =>
      ConflictException(type: type, message: message),
  'DependencyFailureException': (type, message) =>
      DependencyFailureException(type: type, message: message),
  'InvalidParameterValueException': (type, message) =>
      InvalidParameterValueException(type: type, message: message),
  'InvalidRequestException': (type, message) =>
      InvalidRequestException(type: type, message: message),
  'InvalidResourceStateException': (type, message) =>
      InvalidResourceStateException(type: type, message: message),
  'LimitExceededException': (type, message) =>
      LimitExceededException(type: type, message: message),
  'MissingParameterValueException': (type, message) =>
      MissingParameterValueException(type: type, message: message),
  'ResourceNotFoundException': (type, message) =>
      ResourceNotFoundException(type: type, message: message),
  'ServiceUnavailableException': (type, message) =>
      ServiceUnavailableException(type: type, message: message),
};
