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

/// DataSync is a managed data transfer service that makes it simpler for you to
/// automate moving data between on-premises storage and Amazon Simple Storage
/// Service (Amazon S3) or Amazon Elastic File System (Amazon EFS).
class DataSync {
  final _s.JsonProtocol _protocol;
  DataSync({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.AwsClientCredentialsProvider? credentialsProvider,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.JsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'datasync',
            signingName: 'datasync',
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

  /// Cancels execution of a task.
  ///
  /// When you cancel a task execution, the transfer of some files is abruptly
  /// interrupted. The contents of files that are transferred to the destination
  /// might be incomplete or inconsistent with the source files. However, if you
  /// start a new task execution on the same task and you allow the task
  /// execution to complete, file content on the destination is complete and
  /// consistent. This applies to other unexpected failures that interrupt a
  /// task execution. In all of these cases, DataSync successfully complete the
  /// transfer when you start the next task execution.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [taskExecutionArn] :
  /// The Amazon Resource Name (ARN) of the task execution to cancel.
  Future<void> cancelTaskExecution({
    required String taskExecutionArn,
  }) async {
    ArgumentError.checkNotNull(taskExecutionArn, 'taskExecutionArn');
    _s.validateStringLength(
      'taskExecutionArn',
      taskExecutionArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.CancelTaskExecution'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'TaskExecutionArn': taskExecutionArn,
      },
    );
  }

  /// Activates an DataSync agent that you have deployed on your host. The
  /// activation process associates your agent with your account. In the
  /// activation process, you specify information such as the Amazon Web
  /// Services Region that you want to activate the agent in. You activate the
  /// agent in the Amazon Web Services Region where your target locations (in
  /// Amazon S3 or Amazon EFS) reside. Your tasks are created in this Amazon Web
  /// Services Region.
  ///
  /// You can activate the agent in a VPC (virtual private cloud) or provide the
  /// agent access to a VPC endpoint so you can run tasks without going over the
  /// public internet.
  ///
  /// You can use an agent for more than one location. If a task uses multiple
  /// agents, all of them need to have status AVAILABLE for the task to run. If
  /// you use multiple agents for a source location, the status of all the
  /// agents must be AVAILABLE for the task to run.
  ///
  /// Agents are automatically updated by Amazon Web Services on a regular
  /// basis, using a mechanism that ensures minimal interruption to your tasks.
  /// <p/>
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [activationKey] :
  /// Your agent activation key. You can get the activation key either by
  /// sending an HTTP GET request with redirects that enable you to get the
  /// agent IP address (port 80). Alternatively, you can get it from the
  /// DataSync console.
  ///
  /// The redirect URL returned in the response provides you the activation key
  /// for your agent in the query string parameter <code>activationKey</code>.
  /// It might also include other activation-related parameters; however, these
  /// are merely defaults. The arguments you pass to this API call determine the
  /// actual configuration of your agent.
  ///
  /// For more information, see Activating an Agent in the <i>DataSync User
  /// Guide.</i>
  ///
  /// Parameter [agentName] :
  /// The name you configured for your agent. This value is a text reference
  /// that is used to identify the agent in the console.
  ///
  /// Parameter [securityGroupArns] :
  /// The ARNs of the security groups used to protect your data transfer task
  /// subnets. See <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/API_Ec2Config.html#DataSync-Type-Ec2Config-SecurityGroupArns">SecurityGroupArns</a>.
  ///
  /// Parameter [subnetArns] :
  /// The Amazon Resource Names (ARNs) of the subnets in which DataSync will
  /// create elastic network interfaces for each data transfer task. The agent
  /// that runs a task must be private. When you start a task that is associated
  /// with an agent created in a VPC, or one that has access to an IP address in
  /// a VPC, then the task is also private. In this case, DataSync creates four
  /// network interfaces for each task in your subnet. For a data transfer to
  /// work, the agent must be able to route to all these four network
  /// interfaces.
  ///
  /// Parameter [tags] :
  /// The key-value pair that represents the tag that you want to associate with
  /// the agent. The value can be an empty string. This value helps you manage,
  /// filter, and search for your agents.
  /// <note>
  /// Valid characters for key and value are letters, spaces, and numbers
  /// representable in UTF-8 format, and the following special characters: + - =
  /// . _ : / @.
  /// </note>
  ///
  /// Parameter [vpcEndpointId] :
  /// The ID of the VPC (virtual private cloud) endpoint that the agent has
  /// access to. This is the client-side VPC endpoint, also called a
  /// PrivateLink. If you don't have a PrivateLink VPC endpoint, see <a
  /// href="https://docs.aws.amazon.com/vpc/latest/userguide/endpoint-service.html#create-endpoint-service">Creating
  /// a VPC Endpoint Service Configuration</a> in the Amazon VPC User Guide.
  ///
  /// VPC endpoint ID looks like this: <code>vpce-01234d5aff67890e1</code>.
  Future<CreateAgentResponse> createAgent({
    required String activationKey,
    String? agentName,
    List<String>? securityGroupArns,
    List<String>? subnetArns,
    List<TagListEntry>? tags,
    String? vpcEndpointId,
  }) async {
    ArgumentError.checkNotNull(activationKey, 'activationKey');
    _s.validateStringLength(
      'activationKey',
      activationKey,
      0,
      29,
      isRequired: true,
    );
    _s.validateStringLength(
      'agentName',
      agentName,
      1,
      256,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.CreateAgent'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ActivationKey': activationKey,
        if (agentName != null) 'AgentName': agentName,
        if (securityGroupArns != null) 'SecurityGroupArns': securityGroupArns,
        if (subnetArns != null) 'SubnetArns': subnetArns,
        if (tags != null) 'Tags': tags,
        if (vpcEndpointId != null) 'VpcEndpointId': vpcEndpointId,
      },
    );

    return CreateAgentResponse.fromJson(jsonResponse.body);
  }

  /// Creates an endpoint for an Amazon EFS file system that DataSync can access
  /// for a transfer. For more information, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-efs-location.html">Creating
  /// a location for Amazon EFS</a>.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [ec2Config] :
  /// Specifies the subnet and security groups DataSync uses to access your
  /// Amazon EFS file system.
  ///
  /// Parameter [efsFilesystemArn] :
  /// Specifies the ARN for the Amazon EFS file system.
  ///
  /// Parameter [accessPointArn] :
  /// Specifies the Amazon Resource Name (ARN) of the access point that DataSync
  /// uses to access the Amazon EFS file system.
  ///
  /// Parameter [fileSystemAccessRoleArn] :
  /// Specifies an Identity and Access Management (IAM) role that DataSync
  /// assumes when mounting the Amazon EFS file system.
  ///
  /// Parameter [inTransitEncryption] :
  /// Specifies whether you want DataSync to use Transport Layer Security (TLS)
  /// 1.2 encryption when it copies data to or from the Amazon EFS file system.
  ///
  /// If you specify an access point using <code>AccessPointArn</code> or an IAM
  /// role using <code>FileSystemAccessRoleArn</code>, you must set this
  /// parameter to <code>TLS1_2</code>.
  ///
  /// Parameter [subdirectory] :
  /// Specifies a mount path for your Amazon EFS file system. This is where
  /// DataSync reads or writes data (depending on if this is a source or
  /// destination location). By default, DataSync uses the root directory, but
  /// you can also include subdirectories.
  /// <note>
  /// You must specify a value with forward slashes (for example,
  /// <code>/path/to/folder</code>).
  /// </note>
  ///
  /// Parameter [tags] :
  /// Specifies the key-value pair that represents a tag that you want to add to
  /// the resource. The value can be an empty string. This value helps you
  /// manage, filter, and search for your resources. We recommend that you
  /// create a name tag for your location.
  Future<CreateLocationEfsResponse> createLocationEfs({
    required Ec2Config ec2Config,
    required String efsFilesystemArn,
    String? accessPointArn,
    String? fileSystemAccessRoleArn,
    EfsInTransitEncryption? inTransitEncryption,
    String? subdirectory,
    List<TagListEntry>? tags,
  }) async {
    ArgumentError.checkNotNull(ec2Config, 'ec2Config');
    ArgumentError.checkNotNull(efsFilesystemArn, 'efsFilesystemArn');
    _s.validateStringLength(
      'efsFilesystemArn',
      efsFilesystemArn,
      0,
      128,
      isRequired: true,
    );
    _s.validateStringLength(
      'accessPointArn',
      accessPointArn,
      0,
      128,
    );
    _s.validateStringLength(
      'fileSystemAccessRoleArn',
      fileSystemAccessRoleArn,
      0,
      2048,
    );
    _s.validateStringLength(
      'subdirectory',
      subdirectory,
      0,
      4096,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.CreateLocationEfs'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Ec2Config': ec2Config,
        'EfsFilesystemArn': efsFilesystemArn,
        if (accessPointArn != null) 'AccessPointArn': accessPointArn,
        if (fileSystemAccessRoleArn != null)
          'FileSystemAccessRoleArn': fileSystemAccessRoleArn,
        if (inTransitEncryption != null)
          'InTransitEncryption': inTransitEncryption.toValue(),
        if (subdirectory != null) 'Subdirectory': subdirectory,
        if (tags != null) 'Tags': tags,
      },
    );

    return CreateLocationEfsResponse.fromJson(jsonResponse.body);
  }

  /// Creates an endpoint for an Amazon FSx for Lustre file system.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [fsxFilesystemArn] :
  /// The Amazon Resource Name (ARN) for the FSx for Lustre file system.
  ///
  /// Parameter [securityGroupArns] :
  /// The Amazon Resource Names (ARNs) of the security groups that are used to
  /// configure the FSx for Lustre file system.
  ///
  /// Parameter [subdirectory] :
  /// A subdirectory in the location's path. This subdirectory in the FSx for
  /// Lustre file system is used to read data from the FSx for Lustre source
  /// location or write data to the FSx for Lustre destination.
  ///
  /// Parameter [tags] :
  /// The key-value pair that represents a tag that you want to add to the
  /// resource. The value can be an empty string. This value helps you manage,
  /// filter, and search for your resources. We recommend that you create a name
  /// tag for your location.
  Future<CreateLocationFsxLustreResponse> createLocationFsxLustre({
    required String fsxFilesystemArn,
    required List<String> securityGroupArns,
    String? subdirectory,
    List<TagListEntry>? tags,
  }) async {
    ArgumentError.checkNotNull(fsxFilesystemArn, 'fsxFilesystemArn');
    _s.validateStringLength(
      'fsxFilesystemArn',
      fsxFilesystemArn,
      0,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(securityGroupArns, 'securityGroupArns');
    _s.validateStringLength(
      'subdirectory',
      subdirectory,
      0,
      4096,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.CreateLocationFsxLustre'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'FsxFilesystemArn': fsxFilesystemArn,
        'SecurityGroupArns': securityGroupArns,
        if (subdirectory != null) 'Subdirectory': subdirectory,
        if (tags != null) 'Tags': tags,
      },
    );

    return CreateLocationFsxLustreResponse.fromJson(jsonResponse.body);
  }

  /// Creates an endpoint for an Amazon FSx for NetApp ONTAP file system that
  /// DataSync can access for a transfer. For more information, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-ontap-location.html">Creating
  /// a location for FSx for ONTAP</a>.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [securityGroupArns] :
  /// Specifies the Amazon EC2 security groups that provide access to your file
  /// system's preferred subnet.
  ///
  /// The security groups must allow outbound traffic on the following ports
  /// (depending on the protocol you use):
  ///
  /// <ul>
  /// <li>
  /// <b>Network File System (NFS)</b>: TCP ports 111, 635, and 2049
  /// </li>
  /// <li>
  /// <b>Server Message Block (SMB)</b>: TCP port 445
  /// </li>
  /// </ul>
  /// Your file system's security groups must also allow inbound traffic on the
  /// same ports.
  ///
  /// Parameter [storageVirtualMachineArn] :
  /// Specifies the ARN of the storage virtual machine (SVM) on your file system
  /// where you're copying data to or from.
  ///
  /// Parameter [subdirectory] :
  /// Specifies the junction path (also known as a mount point) in the SVM
  /// volume where you're copying data to or from (for example,
  /// <code>/vol1</code>).
  /// <note>
  /// Don't specify a junction path in the SVM's root volume. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/managing-svms.html">Managing
  /// FSx for ONTAP storage virtual machines</a> in the <i>Amazon FSx for NetApp
  /// ONTAP User Guide</i>.
  /// </note>
  ///
  /// Parameter [tags] :
  /// Specifies labels that help you categorize, filter, and search for your
  /// Amazon Web Services resources. We recommend creating at least a name tag
  /// for your location.
  Future<CreateLocationFsxOntapResponse> createLocationFsxOntap({
    required FsxProtocol protocol,
    required List<String> securityGroupArns,
    required String storageVirtualMachineArn,
    String? subdirectory,
    List<TagListEntry>? tags,
  }) async {
    ArgumentError.checkNotNull(protocol, 'protocol');
    ArgumentError.checkNotNull(securityGroupArns, 'securityGroupArns');
    ArgumentError.checkNotNull(
        storageVirtualMachineArn, 'storageVirtualMachineArn');
    _s.validateStringLength(
      'storageVirtualMachineArn',
      storageVirtualMachineArn,
      0,
      162,
      isRequired: true,
    );
    _s.validateStringLength(
      'subdirectory',
      subdirectory,
      0,
      255,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.CreateLocationFsxOntap'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Protocol': protocol,
        'SecurityGroupArns': securityGroupArns,
        'StorageVirtualMachineArn': storageVirtualMachineArn,
        if (subdirectory != null) 'Subdirectory': subdirectory,
        if (tags != null) 'Tags': tags,
      },
    );

    return CreateLocationFsxOntapResponse.fromJson(jsonResponse.body);
  }

  /// Creates an endpoint for an Amazon FSx for OpenZFS file system.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [fsxFilesystemArn] :
  /// The Amazon Resource Name (ARN) of the FSx for OpenZFS file system.
  ///
  /// Parameter [protocol] :
  /// The type of protocol that DataSync uses to access your file system.
  ///
  /// Parameter [securityGroupArns] :
  /// The ARNs of the security groups that are used to configure the FSx for
  /// OpenZFS file system.
  ///
  /// Parameter [subdirectory] :
  /// A subdirectory in the location's path that must begin with
  /// <code>/fsx</code>. DataSync uses this subdirectory to read or write data
  /// (depending on whether the file system is a source or destination
  /// location).
  ///
  /// Parameter [tags] :
  /// The key-value pair that represents a tag that you want to add to the
  /// resource. The value can be an empty string. This value helps you manage,
  /// filter, and search for your resources. We recommend that you create a name
  /// tag for your location.
  Future<CreateLocationFsxOpenZfsResponse> createLocationFsxOpenZfs({
    required String fsxFilesystemArn,
    required FsxProtocol protocol,
    required List<String> securityGroupArns,
    String? subdirectory,
    List<TagListEntry>? tags,
  }) async {
    ArgumentError.checkNotNull(fsxFilesystemArn, 'fsxFilesystemArn');
    _s.validateStringLength(
      'fsxFilesystemArn',
      fsxFilesystemArn,
      0,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(protocol, 'protocol');
    ArgumentError.checkNotNull(securityGroupArns, 'securityGroupArns');
    _s.validateStringLength(
      'subdirectory',
      subdirectory,
      0,
      4096,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.CreateLocationFsxOpenZfs'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'FsxFilesystemArn': fsxFilesystemArn,
        'Protocol': protocol,
        'SecurityGroupArns': securityGroupArns,
        if (subdirectory != null) 'Subdirectory': subdirectory,
        if (tags != null) 'Tags': tags,
      },
    );

    return CreateLocationFsxOpenZfsResponse.fromJson(jsonResponse.body);
  }

  /// Creates an endpoint for an Amazon FSx for Windows File Server file system.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [fsxFilesystemArn] :
  /// Specifies the Amazon Resource Name (ARN) for the FSx for Windows File
  /// Server file system.
  ///
  /// Parameter [password] :
  /// Specifies the password of the user who has the permissions to access files
  /// and folders in the file system.
  ///
  /// Parameter [securityGroupArns] :
  /// Specifies the ARNs of the security groups that provide access to your file
  /// system's preferred subnet.
  /// <note>
  /// If you choose a security group that doesn't allow connections from within
  /// itself, do one of the following:
  ///
  /// <ul>
  /// <li>
  /// Configure the security group to allow it to communicate within itself.
  /// </li>
  /// <li>
  /// Choose a different security group that can communicate with the mount
  /// target's security group.
  /// </li>
  /// </ul> </note>
  ///
  /// Parameter [user] :
  /// Specifies the user who has the permissions to access files and folders in
  /// the file system.
  ///
  /// For information about choosing a user name that ensures sufficient
  /// permissions to files, folders, and metadata, see <a
  /// href="create-fsx-location.html#FSxWuser">user</a>.
  ///
  /// Parameter [domain] :
  /// Specifies the name of the Windows domain that the FSx for Windows File
  /// Server belongs to.
  ///
  /// Parameter [subdirectory] :
  /// Specifies a mount path for your file system using forward slashes. This is
  /// where DataSync reads or writes data (depending on if this is a source or
  /// destination location).
  ///
  /// Parameter [tags] :
  /// Specifies labels that help you categorize, filter, and search for your
  /// Amazon Web Services resources. We recommend creating at least a name tag
  /// for your location.
  Future<CreateLocationFsxWindowsResponse> createLocationFsxWindows({
    required String fsxFilesystemArn,
    required String password,
    required List<String> securityGroupArns,
    required String user,
    String? domain,
    String? subdirectory,
    List<TagListEntry>? tags,
  }) async {
    ArgumentError.checkNotNull(fsxFilesystemArn, 'fsxFilesystemArn');
    _s.validateStringLength(
      'fsxFilesystemArn',
      fsxFilesystemArn,
      0,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(password, 'password');
    _s.validateStringLength(
      'password',
      password,
      0,
      104,
      isRequired: true,
    );
    ArgumentError.checkNotNull(securityGroupArns, 'securityGroupArns');
    ArgumentError.checkNotNull(user, 'user');
    _s.validateStringLength(
      'user',
      user,
      0,
      104,
      isRequired: true,
    );
    _s.validateStringLength(
      'domain',
      domain,
      0,
      253,
    );
    _s.validateStringLength(
      'subdirectory',
      subdirectory,
      0,
      4096,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.CreateLocationFsxWindows'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'FsxFilesystemArn': fsxFilesystemArn,
        'Password': password,
        'SecurityGroupArns': securityGroupArns,
        'User': user,
        if (domain != null) 'Domain': domain,
        if (subdirectory != null) 'Subdirectory': subdirectory,
        if (tags != null) 'Tags': tags,
      },
    );

    return CreateLocationFsxWindowsResponse.fromJson(jsonResponse.body);
  }

  /// Creates an endpoint for a Hadoop Distributed File System (HDFS).
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [agentArns] :
  /// The Amazon Resource Names (ARNs) of the agents that are used to connect to
  /// the HDFS cluster.
  ///
  /// Parameter [authenticationType] :
  /// The type of authentication used to determine the identity of the user.
  ///
  /// Parameter [nameNodes] :
  /// The NameNode that manages the HDFS namespace. The NameNode performs
  /// operations such as opening, closing, and renaming files and directories.
  /// The NameNode contains the information to map blocks of data to the
  /// DataNodes. You can use only one NameNode.
  ///
  /// Parameter [blockSize] :
  /// The size of data blocks to write into the HDFS cluster. The block size
  /// must be a multiple of 512 bytes. The default block size is 128 mebibytes
  /// (MiB).
  ///
  /// Parameter [kerberosKeytab] :
  /// The Kerberos key table (keytab) that contains mappings between the defined
  /// Kerberos principal and the encrypted keys. You can load the keytab from a
  /// file by providing the file's address. If you're using the CLI, it performs
  /// base64 encoding for you. Otherwise, provide the base64-encoded text.
  /// <note>
  /// If <code>KERBEROS</code> is specified for <code>AuthenticationType</code>,
  /// this parameter is required.
  /// </note>
  ///
  /// Parameter [kerberosKrb5Conf] :
  /// The <code>krb5.conf</code> file that contains the Kerberos configuration
  /// information. You can load the <code>krb5.conf</code> file by providing the
  /// file's address. If you're using the CLI, it performs the base64 encoding
  /// for you. Otherwise, provide the base64-encoded text.
  /// <note>
  /// If <code>KERBEROS</code> is specified for <code>AuthenticationType</code>,
  /// this parameter is required.
  /// </note>
  ///
  /// Parameter [kerberosPrincipal] :
  /// The Kerberos principal with access to the files and folders on the HDFS
  /// cluster.
  /// <note>
  /// If <code>KERBEROS</code> is specified for <code>AuthenticationType</code>,
  /// this parameter is required.
  /// </note>
  ///
  /// Parameter [kmsKeyProviderUri] :
  /// The URI of the HDFS cluster's Key Management Server (KMS).
  ///
  /// Parameter [qopConfiguration] :
  /// The Quality of Protection (QOP) configuration specifies the Remote
  /// Procedure Call (RPC) and data transfer protection settings configured on
  /// the Hadoop Distributed File System (HDFS) cluster. If
  /// <code>QopConfiguration</code> isn't specified, <code>RpcProtection</code>
  /// and <code>DataTransferProtection</code> default to <code>PRIVACY</code>.
  /// If you set <code>RpcProtection</code> or
  /// <code>DataTransferProtection</code>, the other parameter assumes the same
  /// value.
  ///
  /// Parameter [replicationFactor] :
  /// The number of DataNodes to replicate the data to when writing to the HDFS
  /// cluster. By default, data is replicated to three DataNodes.
  ///
  /// Parameter [simpleUser] :
  /// The user name used to identify the client on the host operating system.
  /// <note>
  /// If <code>SIMPLE</code> is specified for <code>AuthenticationType</code>,
  /// this parameter is required.
  /// </note>
  ///
  /// Parameter [subdirectory] :
  /// A subdirectory in the HDFS cluster. This subdirectory is used to read data
  /// from or write data to the HDFS cluster. If the subdirectory isn't
  /// specified, it will default to <code>/</code>.
  ///
  /// Parameter [tags] :
  /// The key-value pair that represents the tag that you want to add to the
  /// location. The value can be an empty string. We recommend using tags to
  /// name your resources.
  Future<CreateLocationHdfsResponse> createLocationHdfs({
    required List<String> agentArns,
    required HdfsAuthenticationType authenticationType,
    required List<HdfsNameNode> nameNodes,
    int? blockSize,
    Uint8List? kerberosKeytab,
    Uint8List? kerberosKrb5Conf,
    String? kerberosPrincipal,
    String? kmsKeyProviderUri,
    QopConfiguration? qopConfiguration,
    int? replicationFactor,
    String? simpleUser,
    String? subdirectory,
    List<TagListEntry>? tags,
  }) async {
    ArgumentError.checkNotNull(agentArns, 'agentArns');
    ArgumentError.checkNotNull(authenticationType, 'authenticationType');
    ArgumentError.checkNotNull(nameNodes, 'nameNodes');
    _s.validateNumRange(
      'blockSize',
      blockSize,
      1048576,
      1073741824,
    );
    _s.validateStringLength(
      'kerberosPrincipal',
      kerberosPrincipal,
      1,
      256,
    );
    _s.validateStringLength(
      'kmsKeyProviderUri',
      kmsKeyProviderUri,
      1,
      255,
    );
    _s.validateNumRange(
      'replicationFactor',
      replicationFactor,
      1,
      512,
    );
    _s.validateStringLength(
      'simpleUser',
      simpleUser,
      1,
      256,
    );
    _s.validateStringLength(
      'subdirectory',
      subdirectory,
      0,
      4096,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.CreateLocationHdfs'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AgentArns': agentArns,
        'AuthenticationType': authenticationType.toValue(),
        'NameNodes': nameNodes,
        if (blockSize != null) 'BlockSize': blockSize,
        if (kerberosKeytab != null)
          'KerberosKeytab': base64Encode(kerberosKeytab),
        if (kerberosKrb5Conf != null)
          'KerberosKrb5Conf': base64Encode(kerberosKrb5Conf),
        if (kerberosPrincipal != null) 'KerberosPrincipal': kerberosPrincipal,
        if (kmsKeyProviderUri != null) 'KmsKeyProviderUri': kmsKeyProviderUri,
        if (qopConfiguration != null) 'QopConfiguration': qopConfiguration,
        if (replicationFactor != null) 'ReplicationFactor': replicationFactor,
        if (simpleUser != null) 'SimpleUser': simpleUser,
        if (subdirectory != null) 'Subdirectory': subdirectory,
        if (tags != null) 'Tags': tags,
      },
    );

    return CreateLocationHdfsResponse.fromJson(jsonResponse.body);
  }

  /// Defines a file system on a Network File System (NFS) server that can be
  /// read from or written to.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [onPremConfig] :
  /// Contains a list of Amazon Resource Names (ARNs) of agents that are used to
  /// connect to an NFS server.
  ///
  /// If you are copying data to or from your Snowcone device, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-nfs-location.html#nfs-on-snowcone">NFS
  /// Server on Snowcone</a> for more information.
  ///
  /// Parameter [serverHostname] :
  /// The name of the NFS server. This value is the IP address or Domain Name
  /// Service (DNS) name of the NFS server. An agent that is installed
  /// on-premises uses this hostname to mount the NFS server in a network.
  ///
  /// If you are copying data to or from your Snowcone device, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-nfs-location.html#nfs-on-snowcone">NFS
  /// Server on Snowcone</a> for more information.
  /// <note>
  /// This name must either be DNS-compliant or must be an IP version 4 (IPv4)
  /// address.
  /// </note>
  ///
  /// Parameter [subdirectory] :
  /// The subdirectory in the NFS file system that is used to read data from the
  /// NFS source location or write data to the NFS destination. The NFS path
  /// should be a path that's exported by the NFS server, or a subdirectory of
  /// that path. The path should be such that it can be mounted by other NFS
  /// clients in your network.
  ///
  /// To see all the paths exported by your NFS server, run "<code>showmount -e
  /// nfs-server-name</code>" from an NFS client that has access to your server.
  /// You can specify any directory that appears in the results, and any
  /// subdirectory of that directory. Ensure that the NFS export is accessible
  /// without Kerberos authentication.
  ///
  /// To transfer all the data in the folder you specified, DataSync needs to
  /// have permissions to read all the data. To ensure this, either configure
  /// the NFS export with <code>no_root_squash,</code> or ensure that the
  /// permissions for all of the files that you want DataSync allow read access
  /// for all users. Doing either enables the agent to read the files. For the
  /// agent to access directories, you must additionally enable all execute
  /// access.
  ///
  /// If you are copying data to or from your Snowcone device, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-nfs-location.html#nfs-on-snowcone">NFS
  /// Server on Snowcone</a> for more information.
  ///
  /// For information about NFS export configuration, see 18.7. The /etc/exports
  /// Configuration File in the Red Hat Enterprise Linux documentation.
  ///
  /// Parameter [mountOptions] :
  /// The NFS mount options that DataSync can use to mount your NFS share.
  ///
  /// Parameter [tags] :
  /// The key-value pair that represents the tag that you want to add to the
  /// location. The value can be an empty string. We recommend using tags to
  /// name your resources.
  Future<CreateLocationNfsResponse> createLocationNfs({
    required OnPremConfig onPremConfig,
    required String serverHostname,
    required String subdirectory,
    NfsMountOptions? mountOptions,
    List<TagListEntry>? tags,
  }) async {
    ArgumentError.checkNotNull(onPremConfig, 'onPremConfig');
    ArgumentError.checkNotNull(serverHostname, 'serverHostname');
    _s.validateStringLength(
      'serverHostname',
      serverHostname,
      0,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(subdirectory, 'subdirectory');
    _s.validateStringLength(
      'subdirectory',
      subdirectory,
      0,
      4096,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.CreateLocationNfs'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'OnPremConfig': onPremConfig,
        'ServerHostname': serverHostname,
        'Subdirectory': subdirectory,
        if (mountOptions != null) 'MountOptions': mountOptions,
        if (tags != null) 'Tags': tags,
      },
    );

    return CreateLocationNfsResponse.fromJson(jsonResponse.body);
  }

  /// Creates an endpoint for an object storage system that DataSync can access
  /// for a transfer. For more information, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-object-location.html">Creating
  /// a location for object storage</a>.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [agentArns] :
  /// Specifies the Amazon Resource Names (ARNs) of the DataSync agents that can
  /// securely connect with your location.
  ///
  /// Parameter [bucketName] :
  /// Specifies the name of the object storage bucket involved in the transfer.
  ///
  /// Parameter [serverHostname] :
  /// Specifies the domain name or IP address of the object storage server. A
  /// DataSync agent uses this hostname to mount the object storage server in a
  /// network.
  ///
  /// Parameter [accessKey] :
  /// Specifies the access key (for example, a user name) if credentials are
  /// required to authenticate with the object storage server.
  ///
  /// Parameter [secretKey] :
  /// Specifies the secret key (for example, a password) if credentials are
  /// required to authenticate with the object storage server.
  ///
  /// Parameter [serverPort] :
  /// Specifies the port that your object storage server accepts inbound network
  /// traffic on (for example, port 443).
  ///
  /// Parameter [serverProtocol] :
  /// Specifies the protocol that your object storage server uses to
  /// communicate.
  ///
  /// Parameter [subdirectory] :
  /// Specifies the object prefix for your object storage server. If this is a
  /// source location, DataSync only copies objects with this prefix. If this is
  /// a destination location, DataSync writes all objects with this prefix.
  ///
  /// Parameter [tags] :
  /// Specifies the key-value pair that represents a tag that you want to add to
  /// the resource. Tags can help you manage, filter, and search for your
  /// resources. We recommend creating a name tag for your location.
  Future<CreateLocationObjectStorageResponse> createLocationObjectStorage({
    required List<String> agentArns,
    required String bucketName,
    required String serverHostname,
    String? accessKey,
    String? secretKey,
    int? serverPort,
    ObjectStorageServerProtocol? serverProtocol,
    String? subdirectory,
    List<TagListEntry>? tags,
  }) async {
    ArgumentError.checkNotNull(agentArns, 'agentArns');
    ArgumentError.checkNotNull(bucketName, 'bucketName');
    _s.validateStringLength(
      'bucketName',
      bucketName,
      3,
      63,
      isRequired: true,
    );
    ArgumentError.checkNotNull(serverHostname, 'serverHostname');
    _s.validateStringLength(
      'serverHostname',
      serverHostname,
      0,
      255,
      isRequired: true,
    );
    _s.validateStringLength(
      'accessKey',
      accessKey,
      8,
      200,
    );
    _s.validateStringLength(
      'secretKey',
      secretKey,
      8,
      200,
    );
    _s.validateNumRange(
      'serverPort',
      serverPort,
      1,
      65536,
    );
    _s.validateStringLength(
      'subdirectory',
      subdirectory,
      0,
      4096,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.CreateLocationObjectStorage'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AgentArns': agentArns,
        'BucketName': bucketName,
        'ServerHostname': serverHostname,
        if (accessKey != null) 'AccessKey': accessKey,
        if (secretKey != null) 'SecretKey': secretKey,
        if (serverPort != null) 'ServerPort': serverPort,
        if (serverProtocol != null) 'ServerProtocol': serverProtocol.toValue(),
        if (subdirectory != null) 'Subdirectory': subdirectory,
        if (tags != null) 'Tags': tags,
      },
    );

    return CreateLocationObjectStorageResponse.fromJson(jsonResponse.body);
  }

  /// Creates an endpoint for an Amazon S3 bucket.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-locations-cli.html#create-location-s3-cli">Create
  /// an Amazon S3 location</a> in the <i>DataSync User Guide</i>.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [s3BucketArn] :
  /// The ARN of the Amazon S3 bucket. If the bucket is on an Amazon Web
  /// Services Outpost, this must be an access point ARN.
  ///
  /// Parameter [agentArns] :
  /// If you're using DataSync on an Amazon Web Services Outpost, specify the
  /// Amazon Resource Names (ARNs) of the DataSync agents deployed on your
  /// Outpost. For more information about launching a DataSync agent on an
  /// Amazon Web Services Outpost, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/deploy-agents.html#outposts-agent">Deploy
  /// your DataSync agent on Outposts</a>.
  ///
  /// Parameter [s3StorageClass] :
  /// The Amazon S3 storage class that you want to store your files in when this
  /// location is used as a task destination. For buckets in Amazon Web Services
  /// Regions, the storage class defaults to Standard. For buckets on Outposts,
  /// the storage class defaults to Amazon Web Services S3 Outposts.
  ///
  /// For more information about S3 storage classes, see <a
  /// href="http://aws.amazon.com/s3/storage-classes/">Amazon S3 Storage
  /// Classes</a>. Some storage classes have behaviors that can affect your S3
  /// storage cost. For detailed information, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-s3-location.html#using-storage-classes">Considerations
  /// when working with S3 storage classes in DataSync</a>.
  ///
  /// Parameter [subdirectory] :
  /// A subdirectory in the Amazon S3 bucket. This subdirectory in Amazon S3 is
  /// used to read data from the S3 source location or write data to the S3
  /// destination.
  ///
  /// Parameter [tags] :
  /// The key-value pair that represents the tag that you want to add to the
  /// location. The value can be an empty string. We recommend using tags to
  /// name your resources.
  Future<CreateLocationS3Response> createLocationS3({
    required String s3BucketArn,
    required S3Config s3Config,
    List<String>? agentArns,
    S3StorageClass? s3StorageClass,
    String? subdirectory,
    List<TagListEntry>? tags,
  }) async {
    ArgumentError.checkNotNull(s3BucketArn, 's3BucketArn');
    _s.validateStringLength(
      's3BucketArn',
      s3BucketArn,
      0,
      156,
      isRequired: true,
    );
    ArgumentError.checkNotNull(s3Config, 's3Config');
    _s.validateStringLength(
      'subdirectory',
      subdirectory,
      0,
      4096,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.CreateLocationS3'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'S3BucketArn': s3BucketArn,
        'S3Config': s3Config,
        if (agentArns != null) 'AgentArns': agentArns,
        if (s3StorageClass != null) 'S3StorageClass': s3StorageClass.toValue(),
        if (subdirectory != null) 'Subdirectory': subdirectory,
        if (tags != null) 'Tags': tags,
      },
    );

    return CreateLocationS3Response.fromJson(jsonResponse.body);
  }

  /// Defines a file system on a Server Message Block (SMB) server that can be
  /// read from or written to.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [agentArns] :
  /// The Amazon Resource Names (ARNs) of agents to use for a Simple Message
  /// Block (SMB) location.
  ///
  /// Parameter [password] :
  /// The password of the user who can mount the share, has the permissions to
  /// access files and folders in the SMB share.
  ///
  /// Parameter [serverHostname] :
  /// The name of the SMB server. This value is the IP address or Domain Name
  /// Service (DNS) name of the SMB server. An agent that is installed
  /// on-premises uses this hostname to mount the SMB server in a network.
  /// <note>
  /// This name must either be DNS-compliant or must be an IP version 4 (IPv4)
  /// address.
  /// </note>
  ///
  /// Parameter [subdirectory] :
  /// The subdirectory in the SMB file system that is used to read data from the
  /// SMB source location or write data to the SMB destination. The SMB path
  /// should be a path that's exported by the SMB server, or a subdirectory of
  /// that path. The path should be such that it can be mounted by other SMB
  /// clients in your network.
  /// <note>
  /// <code>Subdirectory</code> must be specified with forward slashes. For
  /// example, <code>/path/to/folder</code>.
  /// </note>
  /// To transfer all the data in the folder you specified, DataSync needs to
  /// have permissions to mount the SMB share, as well as to access all the data
  /// in that share. To ensure this, either ensure that the user/password
  /// specified belongs to the user who can mount the share, and who has the
  /// appropriate permissions for all of the files and directories that you want
  /// DataSync to access, or use credentials of a member of the Backup Operators
  /// group to mount the share. Doing either enables the agent to access the
  /// data. For the agent to access directories, you must additionally enable
  /// all execute access.
  ///
  /// Parameter [user] :
  /// The user who can mount the share, has the permissions to access files and
  /// folders in the SMB share.
  ///
  /// For information about choosing a user name that ensures sufficient
  /// permissions to files, folders, and metadata, see the <a
  /// href="create-smb-location.html#SMBuser">User setting</a> for SMB
  /// locations.
  ///
  /// Parameter [domain] :
  /// The name of the Windows domain that the SMB server belongs to.
  ///
  /// Parameter [mountOptions] :
  /// The mount options used by DataSync to access the SMB server.
  ///
  /// Parameter [tags] :
  /// The key-value pair that represents the tag that you want to add to the
  /// location. The value can be an empty string. We recommend using tags to
  /// name your resources.
  Future<CreateLocationSmbResponse> createLocationSmb({
    required List<String> agentArns,
    required String password,
    required String serverHostname,
    required String subdirectory,
    required String user,
    String? domain,
    SmbMountOptions? mountOptions,
    List<TagListEntry>? tags,
  }) async {
    ArgumentError.checkNotNull(agentArns, 'agentArns');
    ArgumentError.checkNotNull(password, 'password');
    _s.validateStringLength(
      'password',
      password,
      0,
      104,
      isRequired: true,
    );
    ArgumentError.checkNotNull(serverHostname, 'serverHostname');
    _s.validateStringLength(
      'serverHostname',
      serverHostname,
      0,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(subdirectory, 'subdirectory');
    _s.validateStringLength(
      'subdirectory',
      subdirectory,
      0,
      4096,
      isRequired: true,
    );
    ArgumentError.checkNotNull(user, 'user');
    _s.validateStringLength(
      'user',
      user,
      0,
      104,
      isRequired: true,
    );
    _s.validateStringLength(
      'domain',
      domain,
      0,
      253,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.CreateLocationSmb'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AgentArns': agentArns,
        'Password': password,
        'ServerHostname': serverHostname,
        'Subdirectory': subdirectory,
        'User': user,
        if (domain != null) 'Domain': domain,
        if (mountOptions != null) 'MountOptions': mountOptions,
        if (tags != null) 'Tags': tags,
      },
    );

    return CreateLocationSmbResponse.fromJson(jsonResponse.body);
  }

  /// Configures a task, which defines where and how DataSync transfers your
  /// data.
  ///
  /// A task includes a source location, a destination location, and the
  /// preferences for how and when you want to transfer your data (such as
  /// bandwidth limits, scheduling, among other options).
  ///
  /// When you create a task that transfers data between Amazon Web Services
  /// services in different Amazon Web Services Regions, one of your locations
  /// must reside in the Region where you're using DataSync.
  ///
  /// For more information, see the following topics:
  ///
  /// <ul>
  /// <li>
  /// <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/working-with-locations.html">Working
  /// with DataSync locations</a>
  /// </li>
  /// <li>
  /// <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-task.html">Configure
  /// DataSync task settings</a>
  /// </li>
  /// </ul>
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [destinationLocationArn] :
  /// The Amazon Resource Name (ARN) of an Amazon Web Services storage
  /// resource's location.
  ///
  /// Parameter [sourceLocationArn] :
  /// The Amazon Resource Name (ARN) of the source location for the task.
  ///
  /// Parameter [cloudWatchLogGroupArn] :
  /// The Amazon Resource Name (ARN) of the Amazon CloudWatch log group that is
  /// used to monitor and log events in the task.
  ///
  /// Parameter [excludes] :
  /// A list of filter rules that determines which files to exclude from a task.
  /// The list should contain a single filter string that consists of the
  /// patterns to exclude. The patterns are delimited by "|" (that is, a pipe),
  /// for example, <code>"/folder1|/folder2"</code>.
  ///
  ///
  ///
  /// Parameter [includes] :
  /// A list of filter rules that determines which files to include when running
  /// a task. The pattern contains a single filter string that consists of the
  /// patterns to include. The patterns are delimited by "|" (that is, a pipe),
  /// for example, <code>"/folder1|/folder2"</code>.
  ///
  /// Parameter [name] :
  /// The name of a task. This value is a text reference that is used to
  /// identify the task in the console.
  ///
  /// Parameter [options] :
  /// The set of configuration options that control the behavior of a single
  /// execution of the task that occurs when you call
  /// <code>StartTaskExecution</code>. You can configure these options to
  /// preserve metadata such as user ID (UID) and group ID (GID), file
  /// permissions, data integrity verification, and so on.
  ///
  /// For each individual task execution, you can override these options by
  /// specifying the <code>OverrideOptions</code> before starting the task
  /// execution. For more information, see the <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/API_StartTaskExecution.html">StartTaskExecution</a>
  /// operation.
  ///
  /// Parameter [schedule] :
  /// Specifies a schedule used to periodically transfer files from a source to
  /// a destination location. The schedule should be specified in UTC time. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/task-scheduling.html">Scheduling
  /// your task</a>.
  ///
  /// Parameter [tags] :
  /// The key-value pair that represents the tag that you want to add to the
  /// resource. The value can be an empty string.
  Future<CreateTaskResponse> createTask({
    required String destinationLocationArn,
    required String sourceLocationArn,
    String? cloudWatchLogGroupArn,
    List<FilterRule>? excludes,
    List<FilterRule>? includes,
    String? name,
    Options? options,
    TaskSchedule? schedule,
    List<TagListEntry>? tags,
  }) async {
    ArgumentError.checkNotNull(
        destinationLocationArn, 'destinationLocationArn');
    _s.validateStringLength(
      'destinationLocationArn',
      destinationLocationArn,
      0,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(sourceLocationArn, 'sourceLocationArn');
    _s.validateStringLength(
      'sourceLocationArn',
      sourceLocationArn,
      0,
      128,
      isRequired: true,
    );
    _s.validateStringLength(
      'cloudWatchLogGroupArn',
      cloudWatchLogGroupArn,
      0,
      562,
    );
    _s.validateStringLength(
      'name',
      name,
      1,
      256,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.CreateTask'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'DestinationLocationArn': destinationLocationArn,
        'SourceLocationArn': sourceLocationArn,
        if (cloudWatchLogGroupArn != null)
          'CloudWatchLogGroupArn': cloudWatchLogGroupArn,
        if (excludes != null) 'Excludes': excludes,
        if (includes != null) 'Includes': includes,
        if (name != null) 'Name': name,
        if (options != null) 'Options': options,
        if (schedule != null) 'Schedule': schedule,
        if (tags != null) 'Tags': tags,
      },
    );

    return CreateTaskResponse.fromJson(jsonResponse.body);
  }

  /// Deletes an agent. To specify which agent to delete, use the Amazon
  /// Resource Name (ARN) of the agent in your request. The operation
  /// disassociates the agent from your Amazon Web Services account. However, it
  /// doesn't delete the agent virtual machine (VM) from your on-premises
  /// environment.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [agentArn] :
  /// The Amazon Resource Name (ARN) of the agent to delete. Use the
  /// <code>ListAgents</code> operation to return a list of agents for your
  /// account and Amazon Web Services Region.
  Future<void> deleteAgent({
    required String agentArn,
  }) async {
    ArgumentError.checkNotNull(agentArn, 'agentArn');
    _s.validateStringLength(
      'agentArn',
      agentArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.DeleteAgent'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AgentArn': agentArn,
      },
    );
  }

  /// Deletes the configuration of a location used by DataSync.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [locationArn] :
  /// The Amazon Resource Name (ARN) of the location to delete.
  Future<void> deleteLocation({
    required String locationArn,
  }) async {
    ArgumentError.checkNotNull(locationArn, 'locationArn');
    _s.validateStringLength(
      'locationArn',
      locationArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.DeleteLocation'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'LocationArn': locationArn,
      },
    );
  }

  /// Deletes a task.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [taskArn] :
  /// The Amazon Resource Name (ARN) of the task to delete.
  Future<void> deleteTask({
    required String taskArn,
  }) async {
    ArgumentError.checkNotNull(taskArn, 'taskArn');
    _s.validateStringLength(
      'taskArn',
      taskArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.DeleteTask'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'TaskArn': taskArn,
      },
    );
  }

  /// Returns metadata such as the name, the network interfaces, and the status
  /// (that is, whether the agent is running or not) for an agent. To specify
  /// which agent to describe, use the Amazon Resource Name (ARN) of the agent
  /// in your request.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [agentArn] :
  /// The Amazon Resource Name (ARN) of the agent to describe.
  Future<DescribeAgentResponse> describeAgent({
    required String agentArn,
  }) async {
    ArgumentError.checkNotNull(agentArn, 'agentArn');
    _s.validateStringLength(
      'agentArn',
      agentArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.DescribeAgent'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AgentArn': agentArn,
      },
    );

    return DescribeAgentResponse.fromJson(jsonResponse.body);
  }

  /// Returns metadata about your DataSync location for an Amazon EFS file
  /// system.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [locationArn] :
  /// The Amazon Resource Name (ARN) of the Amazon EFS file system location that
  /// you want information about.
  Future<DescribeLocationEfsResponse> describeLocationEfs({
    required String locationArn,
  }) async {
    ArgumentError.checkNotNull(locationArn, 'locationArn');
    _s.validateStringLength(
      'locationArn',
      locationArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.DescribeLocationEfs'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'LocationArn': locationArn,
      },
    );

    return DescribeLocationEfsResponse.fromJson(jsonResponse.body);
  }

  /// Returns metadata about an Amazon FSx for Lustre location, such as
  /// information about its path.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [locationArn] :
  /// The Amazon Resource Name (ARN) of the FSx for Lustre location to describe.
  Future<DescribeLocationFsxLustreResponse> describeLocationFsxLustre({
    required String locationArn,
  }) async {
    ArgumentError.checkNotNull(locationArn, 'locationArn');
    _s.validateStringLength(
      'locationArn',
      locationArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.DescribeLocationFsxLustre'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'LocationArn': locationArn,
      },
    );

    return DescribeLocationFsxLustreResponse.fromJson(jsonResponse.body);
  }

  /// Provides details about how an DataSync location for an Amazon FSx for
  /// NetApp ONTAP file system is configured.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [locationArn] :
  /// Specifies the Amazon Resource Name (ARN) of the FSx for ONTAP file system
  /// location that you want information about.
  Future<DescribeLocationFsxOntapResponse> describeLocationFsxOntap({
    required String locationArn,
  }) async {
    ArgumentError.checkNotNull(locationArn, 'locationArn');
    _s.validateStringLength(
      'locationArn',
      locationArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.DescribeLocationFsxOntap'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'LocationArn': locationArn,
      },
    );

    return DescribeLocationFsxOntapResponse.fromJson(jsonResponse.body);
  }

  /// Returns metadata about an Amazon FSx for OpenZFS location, such as
  /// information about its path.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [locationArn] :
  /// The Amazon Resource Name (ARN) of the FSx for OpenZFS location to
  /// describe.
  Future<DescribeLocationFsxOpenZfsResponse> describeLocationFsxOpenZfs({
    required String locationArn,
  }) async {
    ArgumentError.checkNotNull(locationArn, 'locationArn');
    _s.validateStringLength(
      'locationArn',
      locationArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.DescribeLocationFsxOpenZfs'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'LocationArn': locationArn,
      },
    );

    return DescribeLocationFsxOpenZfsResponse.fromJson(jsonResponse.body);
  }

  /// Returns metadata about an Amazon FSx for Windows File Server location,
  /// such as information about its path.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [locationArn] :
  /// The Amazon Resource Name (ARN) of the FSx for Windows File Server location
  /// to describe.
  Future<DescribeLocationFsxWindowsResponse> describeLocationFsxWindows({
    required String locationArn,
  }) async {
    ArgumentError.checkNotNull(locationArn, 'locationArn');
    _s.validateStringLength(
      'locationArn',
      locationArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.DescribeLocationFsxWindows'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'LocationArn': locationArn,
      },
    );

    return DescribeLocationFsxWindowsResponse.fromJson(jsonResponse.body);
  }

  /// Returns metadata, such as the authentication information about the Hadoop
  /// Distributed File System (HDFS) location.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [locationArn] :
  /// The Amazon Resource Name (ARN) of the HDFS cluster location to describe.
  Future<DescribeLocationHdfsResponse> describeLocationHdfs({
    required String locationArn,
  }) async {
    ArgumentError.checkNotNull(locationArn, 'locationArn');
    _s.validateStringLength(
      'locationArn',
      locationArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.DescribeLocationHdfs'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'LocationArn': locationArn,
      },
    );

    return DescribeLocationHdfsResponse.fromJson(jsonResponse.body);
  }

  /// Returns metadata, such as the path information, about an NFS location.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [locationArn] :
  /// The Amazon Resource Name (ARN) of the NFS location to describe.
  Future<DescribeLocationNfsResponse> describeLocationNfs({
    required String locationArn,
  }) async {
    ArgumentError.checkNotNull(locationArn, 'locationArn');
    _s.validateStringLength(
      'locationArn',
      locationArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.DescribeLocationNfs'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'LocationArn': locationArn,
      },
    );

    return DescribeLocationNfsResponse.fromJson(jsonResponse.body);
  }

  /// Returns metadata about your DataSync location for an object storage
  /// system.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [locationArn] :
  /// The Amazon Resource Name (ARN) of the object storage system location that
  /// you want information about.
  Future<DescribeLocationObjectStorageResponse> describeLocationObjectStorage({
    required String locationArn,
  }) async {
    ArgumentError.checkNotNull(locationArn, 'locationArn');
    _s.validateStringLength(
      'locationArn',
      locationArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.DescribeLocationObjectStorage'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'LocationArn': locationArn,
      },
    );

    return DescribeLocationObjectStorageResponse.fromJson(jsonResponse.body);
  }

  /// Returns metadata, such as bucket name, about an Amazon S3 bucket location.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [locationArn] :
  /// The Amazon Resource Name (ARN) of the Amazon S3 bucket location to
  /// describe.
  Future<DescribeLocationS3Response> describeLocationS3({
    required String locationArn,
  }) async {
    ArgumentError.checkNotNull(locationArn, 'locationArn');
    _s.validateStringLength(
      'locationArn',
      locationArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.DescribeLocationS3'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'LocationArn': locationArn,
      },
    );

    return DescribeLocationS3Response.fromJson(jsonResponse.body);
  }

  /// Returns metadata, such as the path and user information about an SMB
  /// location.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [locationArn] :
  /// The Amazon Resource Name (ARN) of the SMB location to describe.
  Future<DescribeLocationSmbResponse> describeLocationSmb({
    required String locationArn,
  }) async {
    ArgumentError.checkNotNull(locationArn, 'locationArn');
    _s.validateStringLength(
      'locationArn',
      locationArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.DescribeLocationSmb'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'LocationArn': locationArn,
      },
    );

    return DescribeLocationSmbResponse.fromJson(jsonResponse.body);
  }

  /// Returns metadata about a task.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [taskArn] :
  /// The Amazon Resource Name (ARN) of the task to describe.
  Future<DescribeTaskResponse> describeTask({
    required String taskArn,
  }) async {
    ArgumentError.checkNotNull(taskArn, 'taskArn');
    _s.validateStringLength(
      'taskArn',
      taskArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.DescribeTask'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'TaskArn': taskArn,
      },
    );

    return DescribeTaskResponse.fromJson(jsonResponse.body);
  }

  /// Returns detailed metadata about a task that is being executed.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [taskExecutionArn] :
  /// The Amazon Resource Name (ARN) of the task that is being executed.
  Future<DescribeTaskExecutionResponse> describeTaskExecution({
    required String taskExecutionArn,
  }) async {
    ArgumentError.checkNotNull(taskExecutionArn, 'taskExecutionArn');
    _s.validateStringLength(
      'taskExecutionArn',
      taskExecutionArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.DescribeTaskExecution'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'TaskExecutionArn': taskExecutionArn,
      },
    );

    return DescribeTaskExecutionResponse.fromJson(jsonResponse.body);
  }

  /// Returns a list of agents owned by an Amazon Web Services account in the
  /// Amazon Web Services Region specified in the request. The returned list is
  /// ordered by agent Amazon Resource Name (ARN).
  ///
  /// By default, this operation returns a maximum of 100 agents. This operation
  /// supports pagination that enables you to optionally reduce the number of
  /// agents returned in a response.
  ///
  /// If you have more agents than are returned in a response (that is, the
  /// response returns only a truncated list of your agents), the response
  /// contains a marker that you can specify in your next request to fetch the
  /// next page of agents.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [maxResults] :
  /// The maximum number of agents to list.
  ///
  /// Parameter [nextToken] :
  /// An opaque string that indicates the position at which to begin the next
  /// list of agents.
  Future<ListAgentsResponse> listAgents({
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      0,
      100,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      0,
      65535,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.ListAgents'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListAgentsResponse.fromJson(jsonResponse.body);
  }

  /// Returns a list of source and destination locations.
  ///
  /// If you have more locations than are returned in a response (that is, the
  /// response returns only a truncated list of your agents), the response
  /// contains a token that you can specify in your next request to fetch the
  /// next page of locations.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [filters] :
  /// You can use API filters to narrow down the list of resources returned by
  /// <code>ListLocations</code>. For example, to retrieve all tasks on a
  /// specific source location, you can use <code>ListLocations</code> with
  /// filter name <code>LocationType S3</code> and <code>Operator Equals</code>.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of locations to return.
  ///
  /// Parameter [nextToken] :
  /// An opaque string that indicates the position at which to begin the next
  /// list of locations.
  Future<ListLocationsResponse> listLocations({
    List<LocationFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      0,
      100,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      0,
      65535,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.ListLocations'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListLocationsResponse.fromJson(jsonResponse.body);
  }

  /// Returns all the tags associated with a specified resource.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [resourceArn] :
  /// The Amazon Resource Name (ARN) of the resource whose tags to list.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of locations to return.
  ///
  /// Parameter [nextToken] :
  /// An opaque string that indicates the position at which to begin the next
  /// list of locations.
  Future<ListTagsForResourceResponse> listTagsForResource({
    required String resourceArn,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateStringLength(
      'resourceArn',
      resourceArn,
      0,
      128,
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      0,
      100,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      0,
      65535,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.ListTagsForResource'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ResourceArn': resourceArn,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListTagsForResourceResponse.fromJson(jsonResponse.body);
  }

  /// Returns a list of executed tasks.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [maxResults] :
  /// The maximum number of executed tasks to list.
  ///
  /// Parameter [nextToken] :
  /// An opaque string that indicates the position at which to begin the next
  /// list of the executed tasks.
  ///
  /// Parameter [taskArn] :
  /// The Amazon Resource Name (ARN) of the task whose tasks you want to list.
  Future<ListTaskExecutionsResponse> listTaskExecutions({
    int? maxResults,
    String? nextToken,
    String? taskArn,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      0,
      100,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      0,
      65535,
    );
    _s.validateStringLength(
      'taskArn',
      taskArn,
      0,
      128,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.ListTaskExecutions'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
        if (taskArn != null) 'TaskArn': taskArn,
      },
    );

    return ListTaskExecutionsResponse.fromJson(jsonResponse.body);
  }

  /// Returns a list of the DataSync tasks you created.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [filters] :
  /// You can use API filters to narrow down the list of resources returned by
  /// <code>ListTasks</code>. For example, to retrieve all tasks on a specific
  /// source location, you can use <code>ListTasks</code> with filter name
  /// <code>LocationId</code> and <code>Operator Equals</code> with the ARN for
  /// the location.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of tasks to return.
  ///
  /// Parameter [nextToken] :
  /// An opaque string that indicates the position at which to begin the next
  /// list of tasks.
  Future<ListTasksResponse> listTasks({
    List<TaskFilter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      0,
      100,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      0,
      65535,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.ListTasks'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListTasksResponse.fromJson(jsonResponse.body);
  }

  /// Starts a specific invocation of a task. A <code>TaskExecution</code> value
  /// represents an individual run of a task. Each task can have at most one
  /// <code>TaskExecution</code> at a time.
  ///
  /// <code>TaskExecution</code> has the following transition phases:
  /// INITIALIZING | PREPARING | TRANSFERRING | VERIFYING | SUCCESS/FAILURE.
  ///
  /// For detailed information, see the Task Execution section in the Components
  /// and Terminology topic in the <i>DataSync User Guide</i>.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [taskArn] :
  /// The Amazon Resource Name (ARN) of the task to start.
  ///
  /// Parameter [excludes] :
  /// A list of filter rules that determines which files to exclude from a task.
  /// The list contains a single filter string that consists of the patterns to
  /// exclude. The patterns are delimited by "|" (that is, a pipe), for example,
  /// <code>"/folder1|/folder2"</code>.
  ///
  /// Parameter [includes] :
  /// A list of filter rules that determines which files to include when running
  /// a task. The pattern should contain a single filter string that consists of
  /// the patterns to include. The patterns are delimited by "|" (that is, a
  /// pipe), for example, <code>"/folder1|/folder2"</code>.
  ///
  ///
  Future<StartTaskExecutionResponse> startTaskExecution({
    required String taskArn,
    List<FilterRule>? excludes,
    List<FilterRule>? includes,
    Options? overrideOptions,
  }) async {
    ArgumentError.checkNotNull(taskArn, 'taskArn');
    _s.validateStringLength(
      'taskArn',
      taskArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.StartTaskExecution'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'TaskArn': taskArn,
        if (excludes != null) 'Excludes': excludes,
        if (includes != null) 'Includes': includes,
        if (overrideOptions != null) 'OverrideOptions': overrideOptions,
      },
    );

    return StartTaskExecutionResponse.fromJson(jsonResponse.body);
  }

  /// Applies a key-value pair to an Amazon Web Services resource.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [resourceArn] :
  /// The Amazon Resource Name (ARN) of the resource to apply the tag to.
  ///
  /// Parameter [tags] :
  /// The tags to apply.
  Future<void> tagResource({
    required String resourceArn,
    required List<TagListEntry> tags,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateStringLength(
      'resourceArn',
      resourceArn,
      0,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(tags, 'tags');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.TagResource'
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

  /// Removes a tag from an Amazon Web Services resource.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [keys] :
  /// The keys in the key-value pair in the tag to remove.
  ///
  /// Parameter [resourceArn] :
  /// The Amazon Resource Name (ARN) of the resource to remove the tag from.
  Future<void> untagResource({
    required List<String> keys,
    required String resourceArn,
  }) async {
    ArgumentError.checkNotNull(keys, 'keys');
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateStringLength(
      'resourceArn',
      resourceArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.UntagResource'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Keys': keys,
        'ResourceArn': resourceArn,
      },
    );
  }

  /// Updates the name of an agent.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [agentArn] :
  /// The Amazon Resource Name (ARN) of the agent to update.
  ///
  /// Parameter [name] :
  /// The name that you want to use to configure the agent.
  Future<void> updateAgent({
    required String agentArn,
    String? name,
  }) async {
    ArgumentError.checkNotNull(agentArn, 'agentArn');
    _s.validateStringLength(
      'agentArn',
      agentArn,
      0,
      128,
      isRequired: true,
    );
    _s.validateStringLength(
      'name',
      name,
      1,
      256,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.UpdateAgent'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'AgentArn': agentArn,
        if (name != null) 'Name': name,
      },
    );
  }

  /// Updates some parameters of a previously created location for a Hadoop
  /// Distributed File System cluster.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [locationArn] :
  /// The Amazon Resource Name (ARN) of the source HDFS cluster location.
  ///
  /// Parameter [agentArns] :
  /// The ARNs of the agents that are used to connect to the HDFS cluster.
  ///
  /// Parameter [authenticationType] :
  /// The type of authentication used to determine the identity of the user.
  ///
  /// Parameter [blockSize] :
  /// The size of the data blocks to write into the HDFS cluster.
  ///
  /// Parameter [kerberosKeytab] :
  /// The Kerberos key table (keytab) that contains mappings between the defined
  /// Kerberos principal and the encrypted keys. You can load the keytab from a
  /// file by providing the file's address. If you use the CLI, it performs
  /// base64 encoding for you. Otherwise, provide the base64-encoded text.
  ///
  /// Parameter [kerberosKrb5Conf] :
  /// The <code>krb5.conf</code> file that contains the Kerberos configuration
  /// information. You can load the <code>krb5.conf</code> file by providing the
  /// file's address. If you're using the CLI, it performs the base64 encoding
  /// for you. Otherwise, provide the base64-encoded text.
  ///
  /// Parameter [kerberosPrincipal] :
  /// The Kerberos principal with access to the files and folders on the HDFS
  /// cluster.
  ///
  /// Parameter [kmsKeyProviderUri] :
  /// The URI of the HDFS cluster's Key Management Server (KMS).
  ///
  /// Parameter [nameNodes] :
  /// The NameNode that manages the HDFS namespace. The NameNode performs
  /// operations such as opening, closing, and renaming files and directories.
  /// The NameNode contains the information to map blocks of data to the
  /// DataNodes. You can use only one NameNode.
  ///
  /// Parameter [qopConfiguration] :
  /// The Quality of Protection (QOP) configuration specifies the Remote
  /// Procedure Call (RPC) and data transfer privacy settings configured on the
  /// Hadoop Distributed File System (HDFS) cluster.
  ///
  /// Parameter [replicationFactor] :
  /// The number of DataNodes to replicate the data to when writing to the HDFS
  /// cluster.
  ///
  /// Parameter [simpleUser] :
  /// The user name used to identify the client on the host operating system.
  ///
  /// Parameter [subdirectory] :
  /// A subdirectory in the HDFS cluster. This subdirectory is used to read data
  /// from or write data to the HDFS cluster.
  Future<void> updateLocationHdfs({
    required String locationArn,
    List<String>? agentArns,
    HdfsAuthenticationType? authenticationType,
    int? blockSize,
    Uint8List? kerberosKeytab,
    Uint8List? kerberosKrb5Conf,
    String? kerberosPrincipal,
    String? kmsKeyProviderUri,
    List<HdfsNameNode>? nameNodes,
    QopConfiguration? qopConfiguration,
    int? replicationFactor,
    String? simpleUser,
    String? subdirectory,
  }) async {
    ArgumentError.checkNotNull(locationArn, 'locationArn');
    _s.validateStringLength(
      'locationArn',
      locationArn,
      0,
      128,
      isRequired: true,
    );
    _s.validateNumRange(
      'blockSize',
      blockSize,
      1048576,
      1073741824,
    );
    _s.validateStringLength(
      'kerberosPrincipal',
      kerberosPrincipal,
      1,
      256,
    );
    _s.validateStringLength(
      'kmsKeyProviderUri',
      kmsKeyProviderUri,
      1,
      255,
    );
    _s.validateNumRange(
      'replicationFactor',
      replicationFactor,
      1,
      512,
    );
    _s.validateStringLength(
      'simpleUser',
      simpleUser,
      1,
      256,
    );
    _s.validateStringLength(
      'subdirectory',
      subdirectory,
      0,
      4096,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.UpdateLocationHdfs'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'LocationArn': locationArn,
        if (agentArns != null) 'AgentArns': agentArns,
        if (authenticationType != null)
          'AuthenticationType': authenticationType.toValue(),
        if (blockSize != null) 'BlockSize': blockSize,
        if (kerberosKeytab != null)
          'KerberosKeytab': base64Encode(kerberosKeytab),
        if (kerberosKrb5Conf != null)
          'KerberosKrb5Conf': base64Encode(kerberosKrb5Conf),
        if (kerberosPrincipal != null) 'KerberosPrincipal': kerberosPrincipal,
        if (kmsKeyProviderUri != null) 'KmsKeyProviderUri': kmsKeyProviderUri,
        if (nameNodes != null) 'NameNodes': nameNodes,
        if (qopConfiguration != null) 'QopConfiguration': qopConfiguration,
        if (replicationFactor != null) 'ReplicationFactor': replicationFactor,
        if (simpleUser != null) 'SimpleUser': simpleUser,
        if (subdirectory != null) 'Subdirectory': subdirectory,
      },
    );
  }

  /// Updates some of the parameters of a previously created location for
  /// Network File System (NFS) access. For information about creating an NFS
  /// location, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-nfs-location.html">Creating
  /// a location for NFS</a>.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [locationArn] :
  /// The Amazon Resource Name (ARN) of the NFS location to update.
  ///
  /// Parameter [subdirectory] :
  /// The subdirectory in the NFS file system that is used to read data from the
  /// NFS source location or write data to the NFS destination. The NFS path
  /// should be a path that's exported by the NFS server, or a subdirectory of
  /// that path. The path should be such that it can be mounted by other NFS
  /// clients in your network.
  ///
  /// To see all the paths exported by your NFS server, run "<code>showmount -e
  /// nfs-server-name</code>" from an NFS client that has access to your server.
  /// You can specify any directory that appears in the results, and any
  /// subdirectory of that directory. Ensure that the NFS export is accessible
  /// without Kerberos authentication.
  ///
  /// To transfer all the data in the folder that you specified, DataSync must
  /// have permissions to read all the data. To ensure this, either configure
  /// the NFS export with <code>no_root_squash</code>, or ensure that the files
  /// you want DataSync to access have permissions that allow read access for
  /// all users. Doing either option enables the agent to read the files. For
  /// the agent to access directories, you must additionally enable all execute
  /// access.
  ///
  /// If you are copying data to or from your Snowcone device, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-nfs-location.html#nfs-on-snowcone">NFS
  /// Server on Snowcone</a> for more information.
  ///
  /// For information about NFS export configuration, see 18.7. The /etc/exports
  /// Configuration File in the Red Hat Enterprise Linux documentation.
  Future<void> updateLocationNfs({
    required String locationArn,
    NfsMountOptions? mountOptions,
    OnPremConfig? onPremConfig,
    String? subdirectory,
  }) async {
    ArgumentError.checkNotNull(locationArn, 'locationArn');
    _s.validateStringLength(
      'locationArn',
      locationArn,
      0,
      128,
      isRequired: true,
    );
    _s.validateStringLength(
      'subdirectory',
      subdirectory,
      0,
      4096,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.UpdateLocationNfs'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'LocationArn': locationArn,
        if (mountOptions != null) 'MountOptions': mountOptions,
        if (onPremConfig != null) 'OnPremConfig': onPremConfig,
        if (subdirectory != null) 'Subdirectory': subdirectory,
      },
    );
  }

  /// Updates some of the parameters of a previously created location for
  /// self-managed object storage server access. For information about creating
  /// a self-managed object storage location, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-object-location.html">Creating
  /// a location for object storage</a>.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [locationArn] :
  /// The Amazon Resource Name (ARN) of the self-managed object storage server
  /// location to be updated.
  ///
  /// Parameter [accessKey] :
  /// Optional. The access key is used if credentials are required to access the
  /// self-managed object storage server. If your object storage requires a user
  /// name and password to authenticate, use <code>AccessKey</code> and
  /// <code>SecretKey</code> to provide the user name and password,
  /// respectively.
  ///
  /// Parameter [agentArns] :
  /// The Amazon Resource Name (ARN) of the agents associated with the
  /// self-managed object storage server location.
  ///
  /// Parameter [secretKey] :
  /// Optional. The secret key is used if credentials are required to access the
  /// self-managed object storage server. If your object storage requires a user
  /// name and password to authenticate, use <code>AccessKey</code> and
  /// <code>SecretKey</code> to provide the user name and password,
  /// respectively.
  ///
  /// Parameter [serverPort] :
  /// The port that your self-managed object storage server accepts inbound
  /// network traffic on. The server port is set by default to TCP 80 (HTTP) or
  /// TCP 443 (HTTPS). You can specify a custom port if your self-managed object
  /// storage server requires one.
  ///
  /// Parameter [serverProtocol] :
  /// The protocol that the object storage server uses to communicate. Valid
  /// values are <code>HTTP</code> or <code>HTTPS</code>.
  ///
  /// Parameter [subdirectory] :
  /// The subdirectory in the self-managed object storage server that is used to
  /// read data from.
  Future<void> updateLocationObjectStorage({
    required String locationArn,
    String? accessKey,
    List<String>? agentArns,
    String? secretKey,
    int? serverPort,
    ObjectStorageServerProtocol? serverProtocol,
    String? subdirectory,
  }) async {
    ArgumentError.checkNotNull(locationArn, 'locationArn');
    _s.validateStringLength(
      'locationArn',
      locationArn,
      0,
      128,
      isRequired: true,
    );
    _s.validateStringLength(
      'accessKey',
      accessKey,
      8,
      200,
    );
    _s.validateStringLength(
      'secretKey',
      secretKey,
      8,
      200,
    );
    _s.validateNumRange(
      'serverPort',
      serverPort,
      1,
      65536,
    );
    _s.validateStringLength(
      'subdirectory',
      subdirectory,
      0,
      4096,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.UpdateLocationObjectStorage'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'LocationArn': locationArn,
        if (accessKey != null) 'AccessKey': accessKey,
        if (agentArns != null) 'AgentArns': agentArns,
        if (secretKey != null) 'SecretKey': secretKey,
        if (serverPort != null) 'ServerPort': serverPort,
        if (serverProtocol != null) 'ServerProtocol': serverProtocol.toValue(),
        if (subdirectory != null) 'Subdirectory': subdirectory,
      },
    );
  }

  /// Updates some of the parameters of a previously created location for Server
  /// Message Block (SMB) file system access. For information about creating an
  /// SMB location, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-smb-location.html">Creating
  /// a location for SMB</a>.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [locationArn] :
  /// The Amazon Resource Name (ARN) of the SMB location to update.
  ///
  /// Parameter [agentArns] :
  /// The Amazon Resource Names (ARNs) of agents to use for a Simple Message
  /// Block (SMB) location.
  ///
  /// Parameter [domain] :
  /// The name of the Windows domain that the SMB server belongs to.
  ///
  /// Parameter [password] :
  /// The password of the user who can mount the share has the permissions to
  /// access files and folders in the SMB share.
  ///
  /// Parameter [subdirectory] :
  /// The subdirectory in the SMB file system that is used to read data from the
  /// SMB source location or write data to the SMB destination. The SMB path
  /// should be a path that's exported by the SMB server, or a subdirectory of
  /// that path. The path should be such that it can be mounted by other SMB
  /// clients in your network.
  /// <note>
  /// <code>Subdirectory</code> must be specified with forward slashes. For
  /// example, <code>/path/to/folder</code>.
  /// </note>
  /// To transfer all the data in the folder that you specified, DataSync must
  /// have permissions to mount the SMB share and to access all the data in that
  /// share. To ensure this, do either of the following:
  ///
  /// <ul>
  /// <li>
  /// Ensure that the user/password specified belongs to the user who can mount
  /// the share and who has the appropriate permissions for all of the files and
  /// directories that you want DataSync to access.
  /// </li>
  /// <li>
  /// Use credentials of a member of the Backup Operators group to mount the
  /// share.
  /// </li>
  /// </ul>
  /// Doing either of these options enables the agent to access the data. For
  /// the agent to access directories, you must also enable all execute access.
  ///
  /// Parameter [user] :
  /// The user who can mount the share has the permissions to access files and
  /// folders in the SMB share.
  Future<void> updateLocationSmb({
    required String locationArn,
    List<String>? agentArns,
    String? domain,
    SmbMountOptions? mountOptions,
    String? password,
    String? subdirectory,
    String? user,
  }) async {
    ArgumentError.checkNotNull(locationArn, 'locationArn');
    _s.validateStringLength(
      'locationArn',
      locationArn,
      0,
      128,
      isRequired: true,
    );
    _s.validateStringLength(
      'domain',
      domain,
      0,
      253,
    );
    _s.validateStringLength(
      'password',
      password,
      0,
      104,
    );
    _s.validateStringLength(
      'subdirectory',
      subdirectory,
      0,
      4096,
    );
    _s.validateStringLength(
      'user',
      user,
      0,
      104,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.UpdateLocationSmb'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'LocationArn': locationArn,
        if (agentArns != null) 'AgentArns': agentArns,
        if (domain != null) 'Domain': domain,
        if (mountOptions != null) 'MountOptions': mountOptions,
        if (password != null) 'Password': password,
        if (subdirectory != null) 'Subdirectory': subdirectory,
        if (user != null) 'User': user,
      },
    );
  }

  /// Updates the metadata associated with a task.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [taskArn] :
  /// The Amazon Resource Name (ARN) of the resource name of the task to update.
  ///
  /// Parameter [cloudWatchLogGroupArn] :
  /// The Amazon Resource Name (ARN) of the resource name of the Amazon
  /// CloudWatch log group.
  ///
  /// Parameter [excludes] :
  /// A list of filter rules that determines which files to exclude from a task.
  /// The list should contain a single filter string that consists of the
  /// patterns to exclude. The patterns are delimited by "|" (that is, a pipe),
  /// for example, <code>"/folder1|/folder2"</code>.
  ///
  ///
  ///
  /// Parameter [includes] :
  /// A list of filter rules that determines which files to include when running
  /// a task. The pattern contains a single filter string that consists of the
  /// patterns to include. The patterns are delimited by "|" (that is, a pipe),
  /// for example, <code>"/folder1|/folder2"</code>.
  ///
  /// Parameter [name] :
  /// The name of the task to update.
  ///
  /// Parameter [schedule] :
  /// Specifies a schedule used to periodically transfer files from a source to
  /// a destination location. You can configure your task to execute hourly,
  /// daily, weekly or on specific days of the week. You control when in the day
  /// or hour you want the task to execute. The time you specify is UTC time.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/task-scheduling.html">Scheduling
  /// your task</a>.
  Future<void> updateTask({
    required String taskArn,
    String? cloudWatchLogGroupArn,
    List<FilterRule>? excludes,
    List<FilterRule>? includes,
    String? name,
    Options? options,
    TaskSchedule? schedule,
  }) async {
    ArgumentError.checkNotNull(taskArn, 'taskArn');
    _s.validateStringLength(
      'taskArn',
      taskArn,
      0,
      128,
      isRequired: true,
    );
    _s.validateStringLength(
      'cloudWatchLogGroupArn',
      cloudWatchLogGroupArn,
      0,
      562,
    );
    _s.validateStringLength(
      'name',
      name,
      1,
      256,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.UpdateTask'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'TaskArn': taskArn,
        if (cloudWatchLogGroupArn != null)
          'CloudWatchLogGroupArn': cloudWatchLogGroupArn,
        if (excludes != null) 'Excludes': excludes,
        if (includes != null) 'Includes': includes,
        if (name != null) 'Name': name,
        if (options != null) 'Options': options,
        if (schedule != null) 'Schedule': schedule,
      },
    );
  }

  /// Updates execution of a task.
  ///
  /// You can modify bandwidth throttling for a task execution that is running
  /// or queued. For more information, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/working-with-task-executions.html#adjust-bandwidth-throttling">Adjusting
  /// Bandwidth Throttling for a Task Execution</a>.
  /// <note>
  /// The only <code>Option</code> that can be modified by
  /// <code>UpdateTaskExecution</code> is <code> <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/API_Options.html#DataSync-Type-Options-BytesPerSecond">BytesPerSecond</a>
  /// </code>.
  /// </note>
  ///
  /// May throw [InvalidRequestException].
  /// May throw [InternalException].
  ///
  /// Parameter [taskExecutionArn] :
  /// The Amazon Resource Name (ARN) of the specific task execution that is
  /// being updated.
  Future<void> updateTaskExecution({
    required Options options,
    required String taskExecutionArn,
  }) async {
    ArgumentError.checkNotNull(options, 'options');
    ArgumentError.checkNotNull(taskExecutionArn, 'taskExecutionArn');
    _s.validateStringLength(
      'taskExecutionArn',
      taskExecutionArn,
      0,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'FmrsService.UpdateTaskExecution'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Options': options,
        'TaskExecutionArn': taskExecutionArn,
      },
    );
  }
}

/// Represents a single entry in a list of agents. <code>AgentListEntry</code>
/// returns an array that contains a list of agents when the <a
/// href="https://docs.aws.amazon.com/datasync/latest/userguide/API_ListAgents.html">ListAgents</a>
/// operation is called.
class AgentListEntry {
  /// The Amazon Resource Name (ARN) of the agent.
  final String? agentArn;

  /// The name of the agent.
  final String? name;

  /// The status of the agent.
  final AgentStatus? status;

  AgentListEntry({
    this.agentArn,
    this.name,
    this.status,
  });
  factory AgentListEntry.fromJson(Map<String, dynamic> json) {
    return AgentListEntry(
      agentArn: json['AgentArn'] as String?,
      name: json['Name'] as String?,
      status: (json['Status'] as String?)?.toAgentStatus(),
    );
  }
}

enum AgentStatus {
  online,
  offline,
}

extension on AgentStatus {
  String toValue() {
    switch (this) {
      case AgentStatus.online:
        return 'ONLINE';
      case AgentStatus.offline:
        return 'OFFLINE';
    }
  }
}

extension on String {
  AgentStatus toAgentStatus() {
    switch (this) {
      case 'ONLINE':
        return AgentStatus.online;
      case 'OFFLINE':
        return AgentStatus.offline;
    }
    throw Exception('$this is not known in enum AgentStatus');
  }
}

enum Atime {
  none,
  bestEffort,
}

extension on Atime {
  String toValue() {
    switch (this) {
      case Atime.none:
        return 'NONE';
      case Atime.bestEffort:
        return 'BEST_EFFORT';
    }
  }
}

extension on String {
  Atime toAtime() {
    switch (this) {
      case 'NONE':
        return Atime.none;
      case 'BEST_EFFORT':
        return Atime.bestEffort;
    }
    throw Exception('$this is not known in enum Atime');
  }
}

class CancelTaskExecutionResponse {
  CancelTaskExecutionResponse();
  factory CancelTaskExecutionResponse.fromJson(Map<String, dynamic> _) {
    return CancelTaskExecutionResponse();
  }
}

/// CreateAgentResponse
class CreateAgentResponse {
  /// The Amazon Resource Name (ARN) of the agent. Use the <code>ListAgents</code>
  /// operation to return a list of agents for your account and Amazon Web
  /// Services Region.
  final String? agentArn;

  CreateAgentResponse({
    this.agentArn,
  });
  factory CreateAgentResponse.fromJson(Map<String, dynamic> json) {
    return CreateAgentResponse(
      agentArn: json['AgentArn'] as String?,
    );
  }
}

/// CreateLocationEfs
class CreateLocationEfsResponse {
  /// The Amazon Resource Name (ARN) of the Amazon EFS file system location that
  /// you create.
  final String? locationArn;

  CreateLocationEfsResponse({
    this.locationArn,
  });
  factory CreateLocationEfsResponse.fromJson(Map<String, dynamic> json) {
    return CreateLocationEfsResponse(
      locationArn: json['LocationArn'] as String?,
    );
  }
}

class CreateLocationFsxLustreResponse {
  /// The Amazon Resource Name (ARN) of the FSx for Lustre file system location
  /// that's created.
  final String? locationArn;

  CreateLocationFsxLustreResponse({
    this.locationArn,
  });
  factory CreateLocationFsxLustreResponse.fromJson(Map<String, dynamic> json) {
    return CreateLocationFsxLustreResponse(
      locationArn: json['LocationArn'] as String?,
    );
  }
}

class CreateLocationFsxOntapResponse {
  /// Specifies the ARN of the FSx for ONTAP file system location that you create.
  final String? locationArn;

  CreateLocationFsxOntapResponse({
    this.locationArn,
  });
  factory CreateLocationFsxOntapResponse.fromJson(Map<String, dynamic> json) {
    return CreateLocationFsxOntapResponse(
      locationArn: json['LocationArn'] as String?,
    );
  }
}

class CreateLocationFsxOpenZfsResponse {
  /// The ARN of the FSx for OpenZFS file system location that you created.
  final String? locationArn;

  CreateLocationFsxOpenZfsResponse({
    this.locationArn,
  });
  factory CreateLocationFsxOpenZfsResponse.fromJson(Map<String, dynamic> json) {
    return CreateLocationFsxOpenZfsResponse(
      locationArn: json['LocationArn'] as String?,
    );
  }
}

class CreateLocationFsxWindowsResponse {
  /// The ARN of the FSx for Windows File Server file system location you created.
  final String? locationArn;

  CreateLocationFsxWindowsResponse({
    this.locationArn,
  });
  factory CreateLocationFsxWindowsResponse.fromJson(Map<String, dynamic> json) {
    return CreateLocationFsxWindowsResponse(
      locationArn: json['LocationArn'] as String?,
    );
  }
}

class CreateLocationHdfsResponse {
  /// The ARN of the source HDFS cluster location that's created.
  final String? locationArn;

  CreateLocationHdfsResponse({
    this.locationArn,
  });
  factory CreateLocationHdfsResponse.fromJson(Map<String, dynamic> json) {
    return CreateLocationHdfsResponse(
      locationArn: json['LocationArn'] as String?,
    );
  }
}

/// CreateLocationNfsResponse
class CreateLocationNfsResponse {
  /// The Amazon Resource Name (ARN) of the source NFS file system location that
  /// is created.
  final String? locationArn;

  CreateLocationNfsResponse({
    this.locationArn,
  });
  factory CreateLocationNfsResponse.fromJson(Map<String, dynamic> json) {
    return CreateLocationNfsResponse(
      locationArn: json['LocationArn'] as String?,
    );
  }
}

/// CreateLocationObjectStorageResponse
class CreateLocationObjectStorageResponse {
  /// Specifies the ARN of the object storage system location that you create.
  final String? locationArn;

  CreateLocationObjectStorageResponse({
    this.locationArn,
  });
  factory CreateLocationObjectStorageResponse.fromJson(
      Map<String, dynamic> json) {
    return CreateLocationObjectStorageResponse(
      locationArn: json['LocationArn'] as String?,
    );
  }
}

/// CreateLocationS3Response
class CreateLocationS3Response {
  /// The Amazon Resource Name (ARN) of the source Amazon S3 bucket location that
  /// is created.
  final String? locationArn;

  CreateLocationS3Response({
    this.locationArn,
  });
  factory CreateLocationS3Response.fromJson(Map<String, dynamic> json) {
    return CreateLocationS3Response(
      locationArn: json['LocationArn'] as String?,
    );
  }
}

/// CreateLocationSmbResponse
class CreateLocationSmbResponse {
  /// The Amazon Resource Name (ARN) of the source SMB file system location that
  /// is created.
  final String? locationArn;

  CreateLocationSmbResponse({
    this.locationArn,
  });
  factory CreateLocationSmbResponse.fromJson(Map<String, dynamic> json) {
    return CreateLocationSmbResponse(
      locationArn: json['LocationArn'] as String?,
    );
  }
}

/// CreateTaskResponse
class CreateTaskResponse {
  /// The Amazon Resource Name (ARN) of the task.
  final String? taskArn;

  CreateTaskResponse({
    this.taskArn,
  });
  factory CreateTaskResponse.fromJson(Map<String, dynamic> json) {
    return CreateTaskResponse(
      taskArn: json['TaskArn'] as String?,
    );
  }
}

class DeleteAgentResponse {
  DeleteAgentResponse();
  factory DeleteAgentResponse.fromJson(Map<String, dynamic> _) {
    return DeleteAgentResponse();
  }
}

class DeleteLocationResponse {
  DeleteLocationResponse();
  factory DeleteLocationResponse.fromJson(Map<String, dynamic> _) {
    return DeleteLocationResponse();
  }
}

class DeleteTaskResponse {
  DeleteTaskResponse();
  factory DeleteTaskResponse.fromJson(Map<String, dynamic> _) {
    return DeleteTaskResponse();
  }
}

/// DescribeAgentResponse
class DescribeAgentResponse {
  /// The Amazon Resource Name (ARN) of the agent.
  final String? agentArn;

  /// The time that the agent was activated (that is, created in your account).
  final DateTime? creationTime;

  /// The type of endpoint that your agent is connected to. If the endpoint is a
  /// VPC endpoint, the agent is not accessible over the public internet.
  final EndpointType? endpointType;

  /// The time that the agent last connected to DataSync.
  final DateTime? lastConnectionTime;

  /// The name of the agent.
  final String? name;

  /// The subnet and the security group that DataSync used to access a VPC
  /// endpoint.
  final PrivateLinkConfig? privateLinkConfig;

  /// The status of the agent. If the status is ONLINE, then the agent is
  /// configured properly and is available to use. The Running status is the
  /// normal running status for an agent. If the status is OFFLINE, the agent's VM
  /// is turned off or the agent is in an unhealthy state. When the issue that
  /// caused the unhealthy state is resolved, the agent returns to ONLINE status.
  final AgentStatus? status;

  DescribeAgentResponse({
    this.agentArn,
    this.creationTime,
    this.endpointType,
    this.lastConnectionTime,
    this.name,
    this.privateLinkConfig,
    this.status,
  });
  factory DescribeAgentResponse.fromJson(Map<String, dynamic> json) {
    return DescribeAgentResponse(
      agentArn: json['AgentArn'] as String?,
      creationTime: timeStampFromJson(json['CreationTime']),
      endpointType: (json['EndpointType'] as String?)?.toEndpointType(),
      lastConnectionTime: timeStampFromJson(json['LastConnectionTime']),
      name: json['Name'] as String?,
      privateLinkConfig: json['PrivateLinkConfig'] != null
          ? PrivateLinkConfig.fromJson(
              json['PrivateLinkConfig'] as Map<String, dynamic>)
          : null,
      status: (json['Status'] as String?)?.toAgentStatus(),
    );
  }
}

/// DescribeLocationEfsResponse
class DescribeLocationEfsResponse {
  /// The ARN of the access point that DataSync uses to access the Amazon EFS file
  /// system.
  final String? accessPointArn;

  /// The time that the location was created.
  final DateTime? creationTime;
  final Ec2Config? ec2Config;

  /// The Identity and Access Management (IAM) role that DataSync assumes when
  /// mounting the Amazon EFS file system.
  final String? fileSystemAccessRoleArn;

  /// Describes whether DataSync uses Transport Layer Security (TLS) encryption
  /// when copying data to or from the Amazon EFS file system.
  final EfsInTransitEncryption? inTransitEncryption;

  /// The ARN of the Amazon EFS file system location.
  final String? locationArn;

  /// The URL of the Amazon EFS file system location.
  final String? locationUri;

  DescribeLocationEfsResponse({
    this.accessPointArn,
    this.creationTime,
    this.ec2Config,
    this.fileSystemAccessRoleArn,
    this.inTransitEncryption,
    this.locationArn,
    this.locationUri,
  });
  factory DescribeLocationEfsResponse.fromJson(Map<String, dynamic> json) {
    return DescribeLocationEfsResponse(
      accessPointArn: json['AccessPointArn'] as String?,
      creationTime: timeStampFromJson(json['CreationTime']),
      ec2Config: json['Ec2Config'] != null
          ? Ec2Config.fromJson(json['Ec2Config'] as Map<String, dynamic>)
          : null,
      fileSystemAccessRoleArn: json['FileSystemAccessRoleArn'] as String?,
      inTransitEncryption:
          (json['InTransitEncryption'] as String?)?.toEfsInTransitEncryption(),
      locationArn: json['LocationArn'] as String?,
      locationUri: json['LocationUri'] as String?,
    );
  }
}

class DescribeLocationFsxLustreResponse {
  /// The time that the FSx for Lustre location was created.
  final DateTime? creationTime;

  /// The Amazon Resource Name (ARN) of the FSx for Lustre location that was
  /// described.
  final String? locationArn;

  /// The URI of the FSx for Lustre location that was described.
  final String? locationUri;

  /// The Amazon Resource Names (ARNs) of the security groups that are configured
  /// for the FSx for Lustre file system.
  final List<String>? securityGroupArns;

  DescribeLocationFsxLustreResponse({
    this.creationTime,
    this.locationArn,
    this.locationUri,
    this.securityGroupArns,
  });
  factory DescribeLocationFsxLustreResponse.fromJson(
      Map<String, dynamic> json) {
    return DescribeLocationFsxLustreResponse(
      creationTime: timeStampFromJson(json['CreationTime']),
      locationArn: json['LocationArn'] as String?,
      locationUri: json['LocationUri'] as String?,
      securityGroupArns: (json['SecurityGroupArns'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }
}

class DescribeLocationFsxOntapResponse {
  /// The time that the location was created.
  final DateTime? creationTime;

  /// The ARN of the FSx for ONTAP file system.
  final String? fsxFilesystemArn;

  /// The ARN of the FSx for ONTAP file system location.
  final String? locationArn;

  /// The uniform resource identifier (URI) of the FSx for ONTAP file system
  /// location.
  final String? locationUri;
  final FsxProtocol? protocol;

  /// The security groups that DataSync uses to access your FSx for ONTAP file
  /// system.
  final List<String>? securityGroupArns;

  /// The ARN of the storage virtual machine (SVM) on your FSx for ONTAP file
  /// system where you're copying data to or from.
  final String? storageVirtualMachineArn;

  DescribeLocationFsxOntapResponse({
    this.creationTime,
    this.fsxFilesystemArn,
    this.locationArn,
    this.locationUri,
    this.protocol,
    this.securityGroupArns,
    this.storageVirtualMachineArn,
  });
  factory DescribeLocationFsxOntapResponse.fromJson(Map<String, dynamic> json) {
    return DescribeLocationFsxOntapResponse(
      creationTime: timeStampFromJson(json['CreationTime']),
      fsxFilesystemArn: json['FsxFilesystemArn'] as String?,
      locationArn: json['LocationArn'] as String?,
      locationUri: json['LocationUri'] as String?,
      protocol: json['Protocol'] != null
          ? FsxProtocol.fromJson(json['Protocol'] as Map<String, dynamic>)
          : null,
      securityGroupArns: (json['SecurityGroupArns'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      storageVirtualMachineArn: json['StorageVirtualMachineArn'] as String?,
    );
  }
}

class DescribeLocationFsxOpenZfsResponse {
  /// The time that the FSx for OpenZFS location was created.
  final DateTime? creationTime;

  /// The ARN of the FSx for OpenZFS location that was described.
  final String? locationArn;

  /// The uniform resource identifier (URI) of the FSx for OpenZFS location that
  /// was described.
  ///
  /// Example:
  /// <code>fsxz://us-west-2.fs-1234567890abcdef02/fsx/folderA/folder</code>
  final String? locationUri;

  /// The type of protocol that DataSync uses to access your file system.
  final FsxProtocol? protocol;

  /// The ARNs of the security groups that are configured for the FSx for OpenZFS
  /// file system.
  final List<String>? securityGroupArns;

  DescribeLocationFsxOpenZfsResponse({
    this.creationTime,
    this.locationArn,
    this.locationUri,
    this.protocol,
    this.securityGroupArns,
  });
  factory DescribeLocationFsxOpenZfsResponse.fromJson(
      Map<String, dynamic> json) {
    return DescribeLocationFsxOpenZfsResponse(
      creationTime: timeStampFromJson(json['CreationTime']),
      locationArn: json['LocationArn'] as String?,
      locationUri: json['LocationUri'] as String?,
      protocol: json['Protocol'] != null
          ? FsxProtocol.fromJson(json['Protocol'] as Map<String, dynamic>)
          : null,
      securityGroupArns: (json['SecurityGroupArns'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }
}

class DescribeLocationFsxWindowsResponse {
  /// The time that the FSx for Windows File Server location was created.
  final DateTime? creationTime;

  /// The name of the Windows domain that the FSx for Windows File Server belongs
  /// to.
  final String? domain;

  /// The Amazon Resource Name (ARN) of the FSx for Windows File Server location
  /// that was described.
  final String? locationArn;

  /// The URL of the FSx for Windows File Server location that was described.
  final String? locationUri;

  /// The Amazon Resource Names (ARNs) of the security groups that are configured
  /// for the FSx for Windows File Server file system.
  final List<String>? securityGroupArns;

  /// The user who has the permissions to access files and folders in the FSx for
  /// Windows File Server file system.
  final String? user;

  DescribeLocationFsxWindowsResponse({
    this.creationTime,
    this.domain,
    this.locationArn,
    this.locationUri,
    this.securityGroupArns,
    this.user,
  });
  factory DescribeLocationFsxWindowsResponse.fromJson(
      Map<String, dynamic> json) {
    return DescribeLocationFsxWindowsResponse(
      creationTime: timeStampFromJson(json['CreationTime']),
      domain: json['Domain'] as String?,
      locationArn: json['LocationArn'] as String?,
      locationUri: json['LocationUri'] as String?,
      securityGroupArns: (json['SecurityGroupArns'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      user: json['User'] as String?,
    );
  }
}

class DescribeLocationHdfsResponse {
  /// The ARNs of the agents that are used to connect to the HDFS cluster.
  final List<String>? agentArns;

  /// The type of authentication used to determine the identity of the user.
  final HdfsAuthenticationType? authenticationType;

  /// The size of the data blocks to write into the HDFS cluster.
  final int? blockSize;

  /// The time that the HDFS location was created.
  final DateTime? creationTime;

  /// The Kerberos principal with access to the files and folders on the HDFS
  /// cluster. This parameter is used if the <code>AuthenticationType</code> is
  /// defined as <code>KERBEROS</code>.
  final String? kerberosPrincipal;

  /// The URI of the HDFS cluster's Key Management Server (KMS).
  final String? kmsKeyProviderUri;

  /// The ARN of the HDFS cluster location.
  final String? locationArn;

  /// The URI of the HDFS cluster location.
  final String? locationUri;

  /// The NameNode that manage the HDFS namespace.
  final List<HdfsNameNode>? nameNodes;

  /// The Quality of Protection (QOP) configuration specifies the Remote Procedure
  /// Call (RPC) and data transfer protection settings configured on the Hadoop
  /// Distributed File System (HDFS) cluster.
  final QopConfiguration? qopConfiguration;

  /// The number of DataNodes to replicate the data to when writing to the HDFS
  /// cluster.
  final int? replicationFactor;

  /// The user name used to identify the client on the host operating system. This
  /// parameter is used if the <code>AuthenticationType</code> is defined as
  /// <code>SIMPLE</code>.
  final String? simpleUser;

  DescribeLocationHdfsResponse({
    this.agentArns,
    this.authenticationType,
    this.blockSize,
    this.creationTime,
    this.kerberosPrincipal,
    this.kmsKeyProviderUri,
    this.locationArn,
    this.locationUri,
    this.nameNodes,
    this.qopConfiguration,
    this.replicationFactor,
    this.simpleUser,
  });
  factory DescribeLocationHdfsResponse.fromJson(Map<String, dynamic> json) {
    return DescribeLocationHdfsResponse(
      agentArns: (json['AgentArns'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      authenticationType:
          (json['AuthenticationType'] as String?)?.toHdfsAuthenticationType(),
      blockSize: json['BlockSize'] as int?,
      creationTime: timeStampFromJson(json['CreationTime']),
      kerberosPrincipal: json['KerberosPrincipal'] as String?,
      kmsKeyProviderUri: json['KmsKeyProviderUri'] as String?,
      locationArn: json['LocationArn'] as String?,
      locationUri: json['LocationUri'] as String?,
      nameNodes: (json['NameNodes'] as List?)
          ?.whereNotNull()
          .map((e) => HdfsNameNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      qopConfiguration: json['QopConfiguration'] != null
          ? QopConfiguration.fromJson(
              json['QopConfiguration'] as Map<String, dynamic>)
          : null,
      replicationFactor: json['ReplicationFactor'] as int?,
      simpleUser: json['SimpleUser'] as String?,
    );
  }
}

/// DescribeLocationNfsResponse
class DescribeLocationNfsResponse {
  /// The time that the NFS location was created.
  final DateTime? creationTime;

  /// The Amazon Resource Name (ARN) of the NFS location that was described.
  final String? locationArn;

  /// The URL of the source NFS location that was described.
  final String? locationUri;

  /// The NFS mount options that DataSync used to mount your NFS share.
  final NfsMountOptions? mountOptions;
  final OnPremConfig? onPremConfig;

  DescribeLocationNfsResponse({
    this.creationTime,
    this.locationArn,
    this.locationUri,
    this.mountOptions,
    this.onPremConfig,
  });
  factory DescribeLocationNfsResponse.fromJson(Map<String, dynamic> json) {
    return DescribeLocationNfsResponse(
      creationTime: timeStampFromJson(json['CreationTime']),
      locationArn: json['LocationArn'] as String?,
      locationUri: json['LocationUri'] as String?,
      mountOptions: json['MountOptions'] != null
          ? NfsMountOptions.fromJson(
              json['MountOptions'] as Map<String, dynamic>)
          : null,
      onPremConfig: json['OnPremConfig'] != null
          ? OnPremConfig.fromJson(json['OnPremConfig'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// DescribeLocationObjectStorageResponse
class DescribeLocationObjectStorageResponse {
  /// The access key (for example, a user name) required to authenticate with the
  /// object storage server.
  final String? accessKey;

  /// The ARNs of the DataSync agents that can securely connect with your
  /// location.
  final List<String>? agentArns;

  /// The time that the location was created.
  final DateTime? creationTime;

  /// The ARN of the object storage system location.
  final String? locationArn;

  /// The URL of the object storage system location.
  final String? locationUri;

  /// The port that your object storage server accepts inbound network traffic on
  /// (for example, port 443).
  final int? serverPort;

  /// The protocol that your object storage server uses to communicate.
  final ObjectStorageServerProtocol? serverProtocol;

  DescribeLocationObjectStorageResponse({
    this.accessKey,
    this.agentArns,
    this.creationTime,
    this.locationArn,
    this.locationUri,
    this.serverPort,
    this.serverProtocol,
  });
  factory DescribeLocationObjectStorageResponse.fromJson(
      Map<String, dynamic> json) {
    return DescribeLocationObjectStorageResponse(
      accessKey: json['AccessKey'] as String?,
      agentArns: (json['AgentArns'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      creationTime: timeStampFromJson(json['CreationTime']),
      locationArn: json['LocationArn'] as String?,
      locationUri: json['LocationUri'] as String?,
      serverPort: json['ServerPort'] as int?,
      serverProtocol:
          (json['ServerProtocol'] as String?)?.toObjectStorageServerProtocol(),
    );
  }
}

/// DescribeLocationS3Response
class DescribeLocationS3Response {
  /// If you are using DataSync on an Amazon Web Services Outpost, the Amazon
  /// Resource Name (ARNs) of the EC2 agents deployed on your Outpost. For more
  /// information about launching a DataSync agent on an Amazon Web Services
  /// Outpost, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/deploy-agents.html#outposts-agent">Deploy
  /// your DataSync agent on Outposts</a>.
  final List<String>? agentArns;

  /// The time that the Amazon S3 bucket location was created.
  final DateTime? creationTime;

  /// The Amazon Resource Name (ARN) of the Amazon S3 bucket or access point.
  final String? locationArn;

  /// The URL of the Amazon S3 location that was described.
  final String? locationUri;
  final S3Config? s3Config;

  /// The Amazon S3 storage class that you chose to store your files in when this
  /// location is used as a task destination. For more information about S3
  /// storage classes, see <a
  /// href="http://aws.amazon.com/s3/storage-classes/">Amazon S3 Storage
  /// Classes</a>. Some storage classes have behaviors that can affect your S3
  /// storage cost. For detailed information, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-s3-location.html#using-storage-classes">Considerations
  /// when working with S3 storage classes in DataSync</a>.
  final S3StorageClass? s3StorageClass;

  DescribeLocationS3Response({
    this.agentArns,
    this.creationTime,
    this.locationArn,
    this.locationUri,
    this.s3Config,
    this.s3StorageClass,
  });
  factory DescribeLocationS3Response.fromJson(Map<String, dynamic> json) {
    return DescribeLocationS3Response(
      agentArns: (json['AgentArns'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      creationTime: timeStampFromJson(json['CreationTime']),
      locationArn: json['LocationArn'] as String?,
      locationUri: json['LocationUri'] as String?,
      s3Config: json['S3Config'] != null
          ? S3Config.fromJson(json['S3Config'] as Map<String, dynamic>)
          : null,
      s3StorageClass: (json['S3StorageClass'] as String?)?.toS3StorageClass(),
    );
  }
}

/// DescribeLocationSmbResponse
class DescribeLocationSmbResponse {
  /// The Amazon Resource Name (ARN) of the source SMB file system location that
  /// is created.
  final List<String>? agentArns;

  /// The time that the SMB location was created.
  final DateTime? creationTime;

  /// The name of the Windows domain that the SMB server belongs to.
  final String? domain;

  /// The Amazon Resource Name (ARN) of the SMB location that was described.
  final String? locationArn;

  /// The URL of the source SMB location that was described.
  final String? locationUri;

  /// The mount options that are available for DataSync to use to access an SMB
  /// location.
  final SmbMountOptions? mountOptions;

  /// The user who can mount the share, has the permissions to access files and
  /// folders in the SMB share.
  final String? user;

  DescribeLocationSmbResponse({
    this.agentArns,
    this.creationTime,
    this.domain,
    this.locationArn,
    this.locationUri,
    this.mountOptions,
    this.user,
  });
  factory DescribeLocationSmbResponse.fromJson(Map<String, dynamic> json) {
    return DescribeLocationSmbResponse(
      agentArns: (json['AgentArns'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      creationTime: timeStampFromJson(json['CreationTime']),
      domain: json['Domain'] as String?,
      locationArn: json['LocationArn'] as String?,
      locationUri: json['LocationUri'] as String?,
      mountOptions: json['MountOptions'] != null
          ? SmbMountOptions.fromJson(
              json['MountOptions'] as Map<String, dynamic>)
          : null,
      user: json['User'] as String?,
    );
  }
}

/// DescribeTaskExecutionResponse
class DescribeTaskExecutionResponse {
  /// The physical number of bytes transferred over the network.
  final int? bytesTransferred;

  /// The number of logical bytes written to the destination Amazon Web Services
  /// storage resource.
  final int? bytesWritten;

  /// The estimated physical number of bytes that is to be transferred over the
  /// network.
  final int? estimatedBytesToTransfer;

  /// The expected number of files that is to be transferred over the network.
  /// This value is calculated during the PREPARING phase, before the TRANSFERRING
  /// phase. This value is the expected number of files to be transferred. It's
  /// calculated based on comparing the content of the source and destination
  /// locations and finding the delta that needs to be transferred.
  final int? estimatedFilesToTransfer;

  /// A list of filter rules that determines which files to exclude from a task.
  /// The list should contain a single filter string that consists of the patterns
  /// to exclude. The patterns are delimited by "|" (that is, a pipe), for
  /// example: <code>"/folder1|/folder2"</code>
  ///
  ///
  final List<FilterRule>? excludes;

  /// The actual number of files that was transferred over the network. This value
  /// is calculated and updated on an ongoing basis during the TRANSFERRING phase.
  /// It's updated periodically when each file is read from the source and sent
  /// over the network.
  ///
  /// If failures occur during a transfer, this value can be less than
  /// <code>EstimatedFilesToTransfer</code>. This value can also be greater than
  /// <code>EstimatedFilesTransferred</code> in some cases. This element is
  /// implementation-specific for some location types, so don't use it as an
  /// indicator for a correct file number or to monitor your task execution.
  final int? filesTransferred;

  /// A list of filter rules that determines which files to include when running a
  /// task. The list should contain a single filter string that consists of the
  /// patterns to include. The patterns are delimited by "|" (that is, a pipe),
  /// for example: <code>"/folder1|/folder2"</code>
  ///
  ///
  final List<FilterRule>? includes;
  final Options? options;

  /// The result of the task execution.
  final TaskExecutionResultDetail? result;

  /// The time that the task execution was started.
  final DateTime? startTime;

  /// The status of the task execution.
  ///
  /// For detailed information about task execution statuses, see Understanding
  /// Task Statuses in the <i>DataSync User Guide.</i>
  final TaskExecutionStatus? status;

  /// The Amazon Resource Name (ARN) of the task execution that was described.
  /// <code>TaskExecutionArn</code> is hierarchical and includes
  /// <code>TaskArn</code> for the task that was executed.
  ///
  /// For example, a <code>TaskExecution</code> value with the ARN
  /// <code>arn:aws:datasync:us-east-1:111222333444:task/task-0208075f79cedf4a2/execution/exec-08ef1e88ec491019b</code>
  /// executed the task with the ARN
  /// <code>arn:aws:datasync:us-east-1:111222333444:task/task-0208075f79cedf4a2</code>.
  final String? taskExecutionArn;

  DescribeTaskExecutionResponse({
    this.bytesTransferred,
    this.bytesWritten,
    this.estimatedBytesToTransfer,
    this.estimatedFilesToTransfer,
    this.excludes,
    this.filesTransferred,
    this.includes,
    this.options,
    this.result,
    this.startTime,
    this.status,
    this.taskExecutionArn,
  });
  factory DescribeTaskExecutionResponse.fromJson(Map<String, dynamic> json) {
    return DescribeTaskExecutionResponse(
      bytesTransferred: json['BytesTransferred'] as int?,
      bytesWritten: json['BytesWritten'] as int?,
      estimatedBytesToTransfer: json['EstimatedBytesToTransfer'] as int?,
      estimatedFilesToTransfer: json['EstimatedFilesToTransfer'] as int?,
      excludes: (json['Excludes'] as List?)
          ?.whereNotNull()
          .map((e) => FilterRule.fromJson(e as Map<String, dynamic>))
          .toList(),
      filesTransferred: json['FilesTransferred'] as int?,
      includes: (json['Includes'] as List?)
          ?.whereNotNull()
          .map((e) => FilterRule.fromJson(e as Map<String, dynamic>))
          .toList(),
      options: json['Options'] != null
          ? Options.fromJson(json['Options'] as Map<String, dynamic>)
          : null,
      result: json['Result'] != null
          ? TaskExecutionResultDetail.fromJson(
              json['Result'] as Map<String, dynamic>)
          : null,
      startTime: timeStampFromJson(json['StartTime']),
      status: (json['Status'] as String?)?.toTaskExecutionStatus(),
      taskExecutionArn: json['TaskExecutionArn'] as String?,
    );
  }
}

/// DescribeTaskResponse
class DescribeTaskResponse {
  /// The Amazon Resource Name (ARN) of the Amazon CloudWatch log group that was
  /// used to monitor and log events in the task.
  ///
  /// For more information on these groups, see Working with Log Groups and Log
  /// Streams in the <i>Amazon CloudWatch User Guide</i>.
  final String? cloudWatchLogGroupArn;

  /// The time that the task was created.
  final DateTime? creationTime;

  /// The Amazon Resource Name (ARN) of the task execution that is syncing files.
  final String? currentTaskExecutionArn;

  /// The Amazon Resource Name (ARN) of the Amazon Web Services storage resource's
  /// location.
  final String? destinationLocationArn;

  /// The Amazon Resource Names (ARNs) of the destination elastic network
  /// interfaces (ENIs) that were created for your subnet.
  final List<String>? destinationNetworkInterfaceArns;

  /// Errors that DataSync encountered during execution of the task. You can use
  /// this error code to help troubleshoot issues.
  final String? errorCode;

  /// Detailed description of an error that was encountered during the task
  /// execution. You can use this information to help troubleshoot issues.
  final String? errorDetail;

  /// A list of filter rules that determines which files to exclude from a task.
  /// The list should contain a single filter string that consists of the patterns
  /// to exclude. The patterns are delimited by "|" (that is, a pipe), for
  /// example, <code>"/folder1|/folder2"</code>.
  ///
  ///
  final List<FilterRule>? excludes;

  /// A list of filter rules that determines which files to include when running a
  /// task. The pattern contains a single filter string that consists of the
  /// patterns to include. The patterns are delimited by "|" (that is, a pipe),
  /// for example, <code>"/folder1|/folder2</code>".
  final List<FilterRule>? includes;

  /// The name of the task that was described.
  final String? name;

  /// The set of configuration options that control the behavior of a single
  /// execution of the task that occurs when you call
  /// <code>StartTaskExecution</code>. You can configure these options to preserve
  /// metadata such as user ID (UID) and group (GID), file permissions, data
  /// integrity verification, and so on.
  ///
  /// For each individual task execution, you can override these options by
  /// specifying the overriding <code>OverrideOptions</code> value to <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/API_StartTaskExecution.html">StartTaskExecution</a>
  /// operation.
  final Options? options;

  /// The schedule used to periodically transfer files from a source to a
  /// destination location.
  final TaskSchedule? schedule;

  /// The Amazon Resource Name (ARN) of the source file system's location.
  final String? sourceLocationArn;

  /// The Amazon Resource Names (ARNs) of the source elastic network interfaces
  /// (ENIs) that were created for your subnet.
  final List<String>? sourceNetworkInterfaceArns;

  /// The status of the task that was described.
  ///
  /// For detailed information about task execution statuses, see Understanding
  /// Task Statuses in the <i>DataSync User Guide</i>.
  final TaskStatus? status;

  /// The Amazon Resource Name (ARN) of the task that was described.
  final String? taskArn;

  DescribeTaskResponse({
    this.cloudWatchLogGroupArn,
    this.creationTime,
    this.currentTaskExecutionArn,
    this.destinationLocationArn,
    this.destinationNetworkInterfaceArns,
    this.errorCode,
    this.errorDetail,
    this.excludes,
    this.includes,
    this.name,
    this.options,
    this.schedule,
    this.sourceLocationArn,
    this.sourceNetworkInterfaceArns,
    this.status,
    this.taskArn,
  });
  factory DescribeTaskResponse.fromJson(Map<String, dynamic> json) {
    return DescribeTaskResponse(
      cloudWatchLogGroupArn: json['CloudWatchLogGroupArn'] as String?,
      creationTime: timeStampFromJson(json['CreationTime']),
      currentTaskExecutionArn: json['CurrentTaskExecutionArn'] as String?,
      destinationLocationArn: json['DestinationLocationArn'] as String?,
      destinationNetworkInterfaceArns:
          (json['DestinationNetworkInterfaceArns'] as List?)
              ?.whereNotNull()
              .map((e) => e as String)
              .toList(),
      errorCode: json['ErrorCode'] as String?,
      errorDetail: json['ErrorDetail'] as String?,
      excludes: (json['Excludes'] as List?)
          ?.whereNotNull()
          .map((e) => FilterRule.fromJson(e as Map<String, dynamic>))
          .toList(),
      includes: (json['Includes'] as List?)
          ?.whereNotNull()
          .map((e) => FilterRule.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['Name'] as String?,
      options: json['Options'] != null
          ? Options.fromJson(json['Options'] as Map<String, dynamic>)
          : null,
      schedule: json['Schedule'] != null
          ? TaskSchedule.fromJson(json['Schedule'] as Map<String, dynamic>)
          : null,
      sourceLocationArn: json['SourceLocationArn'] as String?,
      sourceNetworkInterfaceArns: (json['SourceNetworkInterfaceArns'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      status: (json['Status'] as String?)?.toTaskStatus(),
      taskArn: json['TaskArn'] as String?,
    );
  }
}

/// The subnet and security groups that DataSync uses to access your Amazon EFS
/// file system.
class Ec2Config {
  /// Specifies the Amazon Resource Names (ARNs) of the security groups associated
  /// with an Amazon EFS file system's mount target.
  final List<String> securityGroupArns;

  /// Specifies the ARN of a subnet where DataSync creates the <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/datasync-network.html#required-network-interfaces">network
  /// interfaces</a> for managing traffic during your transfer.
  ///
  /// The subnet must be located:
  ///
  /// <ul>
  /// <li>
  /// In the same virtual private cloud (VPC) as the Amazon EFS file system.
  /// </li>
  /// <li>
  /// In the same Availability Zone as at least one mount target for the Amazon
  /// EFS file system.
  /// </li>
  /// </ul> <note>
  /// You don't need to specify a subnet that includes a file system mount target.
  /// </note>
  final String subnetArn;

  Ec2Config({
    required this.securityGroupArns,
    required this.subnetArn,
  });
  factory Ec2Config.fromJson(Map<String, dynamic> json) {
    return Ec2Config(
      securityGroupArns: (json['SecurityGroupArns'] as List)
          .whereNotNull()
          .map((e) => e as String)
          .toList(),
      subnetArn: json['SubnetArn'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final securityGroupArns = this.securityGroupArns;
    final subnetArn = this.subnetArn;
    return {
      'SecurityGroupArns': securityGroupArns,
      'SubnetArn': subnetArn,
    };
  }
}

enum EfsInTransitEncryption {
  none,
  tls1_2,
}

extension on EfsInTransitEncryption {
  String toValue() {
    switch (this) {
      case EfsInTransitEncryption.none:
        return 'NONE';
      case EfsInTransitEncryption.tls1_2:
        return 'TLS1_2';
    }
  }
}

extension on String {
  EfsInTransitEncryption toEfsInTransitEncryption() {
    switch (this) {
      case 'NONE':
        return EfsInTransitEncryption.none;
      case 'TLS1_2':
        return EfsInTransitEncryption.tls1_2;
    }
    throw Exception('$this is not known in enum EfsInTransitEncryption');
  }
}

enum EndpointType {
  public,
  privateLink,
  fips,
}

extension on EndpointType {
  String toValue() {
    switch (this) {
      case EndpointType.public:
        return 'PUBLIC';
      case EndpointType.privateLink:
        return 'PRIVATE_LINK';
      case EndpointType.fips:
        return 'FIPS';
    }
  }
}

extension on String {
  EndpointType toEndpointType() {
    switch (this) {
      case 'PUBLIC':
        return EndpointType.public;
      case 'PRIVATE_LINK':
        return EndpointType.privateLink;
      case 'FIPS':
        return EndpointType.fips;
    }
    throw Exception('$this is not known in enum EndpointType');
  }
}

/// Specifies which files, folders, and objects to include or exclude when
/// transferring files from source to destination.
class FilterRule {
  /// The type of filter rule to apply. DataSync only supports the SIMPLE_PATTERN
  /// rule type.
  final FilterType? filterType;

  /// A single filter string that consists of the patterns to include or exclude.
  /// The patterns are delimited by "|" (that is, a pipe), for example:
  /// <code>/folder1|/folder2</code>
  ///
  ///
  final String? value;

  FilterRule({
    this.filterType,
    this.value,
  });
  factory FilterRule.fromJson(Map<String, dynamic> json) {
    return FilterRule(
      filterType: (json['FilterType'] as String?)?.toFilterType(),
      value: json['Value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final filterType = this.filterType;
    final value = this.value;
    return {
      if (filterType != null) 'FilterType': filterType.toValue(),
      if (value != null) 'Value': value,
    };
  }
}

enum FilterType {
  simplePattern,
}

extension on FilterType {
  String toValue() {
    switch (this) {
      case FilterType.simplePattern:
        return 'SIMPLE_PATTERN';
    }
  }
}

extension on String {
  FilterType toFilterType() {
    switch (this) {
      case 'SIMPLE_PATTERN':
        return FilterType.simplePattern;
    }
    throw Exception('$this is not known in enum FilterType');
  }
}

/// Specifies the data transfer protocol that DataSync uses to access your
/// Amazon FSx file system.
class FsxProtocol {
  /// Specifies the Network File System (NFS) protocol configuration that DataSync
  /// uses to access your FSx for OpenZFS file system or FSx for ONTAP file
  /// system's storage virtual machine (SVM).
  final FsxProtocolNfs? nfs;

  /// Specifies the Server Message Block (SMB) protocol configuration that
  /// DataSync uses to access your FSx for ONTAP file system's SVM.
  final FsxProtocolSmb? smb;

  FsxProtocol({
    this.nfs,
    this.smb,
  });
  factory FsxProtocol.fromJson(Map<String, dynamic> json) {
    return FsxProtocol(
      nfs: json['NFS'] != null
          ? FsxProtocolNfs.fromJson(json['NFS'] as Map<String, dynamic>)
          : null,
      smb: json['SMB'] != null
          ? FsxProtocolSmb.fromJson(json['SMB'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final nfs = this.nfs;
    final smb = this.smb;
    return {
      if (nfs != null) 'NFS': nfs,
      if (smb != null) 'SMB': smb,
    };
  }
}

/// Specifies the Network File System (NFS) protocol configuration that DataSync
/// uses to access your Amazon FSx for OpenZFS or Amazon FSx for NetApp ONTAP
/// file system.
class FsxProtocolNfs {
  final NfsMountOptions? mountOptions;

  FsxProtocolNfs({
    this.mountOptions,
  });
  factory FsxProtocolNfs.fromJson(Map<String, dynamic> json) {
    return FsxProtocolNfs(
      mountOptions: json['MountOptions'] != null
          ? NfsMountOptions.fromJson(
              json['MountOptions'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final mountOptions = this.mountOptions;
    return {
      if (mountOptions != null) 'MountOptions': mountOptions,
    };
  }
}

/// Specifies the Server Message Block (SMB) protocol configuration that
/// DataSync uses to access your Amazon FSx for NetApp ONTAP file system. For
/// more information, see <a
/// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-ontap-location.html#create-ontap-location-access">Accessing
/// FSx for ONTAP file systems</a>.
class FsxProtocolSmb {
  /// Specifies the password of a user who has permission to access your SVM.
  final String password;

  /// Specifies a user name that can mount the location and access the files,
  /// folders, and metadata that you need in the SVM.
  ///
  /// If you provide a user in your Active Directory, note the following:
  ///
  /// <ul>
  /// <li>
  /// If you're using Directory Service for Microsoft Active Directory, the user
  /// must be a member of the Amazon Web Services Delegated FSx Administrators
  /// group.
  /// </li>
  /// <li>
  /// If you're using a self-managed Active Directory, the user must be a member
  /// of either the Domain Admins group or a custom group that you specified for
  /// file system administration when you created your file system.
  /// </li>
  /// </ul>
  /// Make sure that the user has the permissions it needs to copy the data you
  /// want:
  ///
  /// <ul>
  /// <li>
  /// <code>SE_TCB_NAME</code>: Required to set object ownership and file
  /// metadata. With this privilege, you also can copy NTFS discretionary access
  /// lists (DACLs).
  /// </li>
  /// <li>
  /// <code>SE_SECURITY_NAME</code>: May be needed to copy NTFS system access
  /// control lists (SACLs). This operation specifically requires the Windows
  /// privilege, which is granted to members of the Domain Admins group. If you
  /// configure your task to copy SACLs, make sure that the user has the required
  /// privileges. For information about copying SACLs, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-task.html#configure-ownership-and-permissions">Ownership
  /// and permissions-related options</a>.
  /// </li>
  /// </ul>
  final String user;

  /// Specifies the fully qualified domain name (FQDN) of the Microsoft Active
  /// Directory that your storage virtual machine (SVM) belongs to.
  final String? domain;
  final SmbMountOptions? mountOptions;

  FsxProtocolSmb({
    required this.password,
    required this.user,
    this.domain,
    this.mountOptions,
  });
  factory FsxProtocolSmb.fromJson(Map<String, dynamic> json) {
    return FsxProtocolSmb(
      password: json['Password'] as String,
      user: json['User'] as String,
      domain: json['Domain'] as String?,
      mountOptions: json['MountOptions'] != null
          ? SmbMountOptions.fromJson(
              json['MountOptions'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final password = this.password;
    final user = this.user;
    final domain = this.domain;
    final mountOptions = this.mountOptions;
    return {
      'Password': password,
      'User': user,
      if (domain != null) 'Domain': domain,
      if (mountOptions != null) 'MountOptions': mountOptions,
    };
  }
}

enum Gid {
  none,
  intValue,
  name,
  both,
}

extension on Gid {
  String toValue() {
    switch (this) {
      case Gid.none:
        return 'NONE';
      case Gid.intValue:
        return 'INT_VALUE';
      case Gid.name:
        return 'NAME';
      case Gid.both:
        return 'BOTH';
    }
  }
}

extension on String {
  Gid toGid() {
    switch (this) {
      case 'NONE':
        return Gid.none;
      case 'INT_VALUE':
        return Gid.intValue;
      case 'NAME':
        return Gid.name;
      case 'BOTH':
        return Gid.both;
    }
    throw Exception('$this is not known in enum Gid');
  }
}

enum HdfsAuthenticationType {
  simple,
  kerberos,
}

extension on HdfsAuthenticationType {
  String toValue() {
    switch (this) {
      case HdfsAuthenticationType.simple:
        return 'SIMPLE';
      case HdfsAuthenticationType.kerberos:
        return 'KERBEROS';
    }
  }
}

extension on String {
  HdfsAuthenticationType toHdfsAuthenticationType() {
    switch (this) {
      case 'SIMPLE':
        return HdfsAuthenticationType.simple;
      case 'KERBEROS':
        return HdfsAuthenticationType.kerberos;
    }
    throw Exception('$this is not known in enum HdfsAuthenticationType');
  }
}

enum HdfsDataTransferProtection {
  disabled,
  authentication,
  integrity,
  privacy,
}

extension on HdfsDataTransferProtection {
  String toValue() {
    switch (this) {
      case HdfsDataTransferProtection.disabled:
        return 'DISABLED';
      case HdfsDataTransferProtection.authentication:
        return 'AUTHENTICATION';
      case HdfsDataTransferProtection.integrity:
        return 'INTEGRITY';
      case HdfsDataTransferProtection.privacy:
        return 'PRIVACY';
    }
  }
}

extension on String {
  HdfsDataTransferProtection toHdfsDataTransferProtection() {
    switch (this) {
      case 'DISABLED':
        return HdfsDataTransferProtection.disabled;
      case 'AUTHENTICATION':
        return HdfsDataTransferProtection.authentication;
      case 'INTEGRITY':
        return HdfsDataTransferProtection.integrity;
      case 'PRIVACY':
        return HdfsDataTransferProtection.privacy;
    }
    throw Exception('$this is not known in enum HdfsDataTransferProtection');
  }
}

/// The NameNode of the Hadoop Distributed File System (HDFS). The NameNode
/// manages the file system's namespace. The NameNode performs operations such
/// as opening, closing, and renaming files and directories. The NameNode
/// contains the information to map blocks of data to the DataNodes.
class HdfsNameNode {
  /// The hostname of the NameNode in the HDFS cluster. This value is the IP
  /// address or Domain Name Service (DNS) name of the NameNode. An agent that's
  /// installed on-premises uses this hostname to communicate with the NameNode in
  /// the network.
  final String hostname;

  /// The port that the NameNode uses to listen to client requests.
  final int port;

  HdfsNameNode({
    required this.hostname,
    required this.port,
  });
  factory HdfsNameNode.fromJson(Map<String, dynamic> json) {
    return HdfsNameNode(
      hostname: json['Hostname'] as String,
      port: json['Port'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final hostname = this.hostname;
    final port = this.port;
    return {
      'Hostname': hostname,
      'Port': port,
    };
  }
}

enum HdfsRpcProtection {
  disabled,
  authentication,
  integrity,
  privacy,
}

extension on HdfsRpcProtection {
  String toValue() {
    switch (this) {
      case HdfsRpcProtection.disabled:
        return 'DISABLED';
      case HdfsRpcProtection.authentication:
        return 'AUTHENTICATION';
      case HdfsRpcProtection.integrity:
        return 'INTEGRITY';
      case HdfsRpcProtection.privacy:
        return 'PRIVACY';
    }
  }
}

extension on String {
  HdfsRpcProtection toHdfsRpcProtection() {
    switch (this) {
      case 'DISABLED':
        return HdfsRpcProtection.disabled;
      case 'AUTHENTICATION':
        return HdfsRpcProtection.authentication;
      case 'INTEGRITY':
        return HdfsRpcProtection.integrity;
      case 'PRIVACY':
        return HdfsRpcProtection.privacy;
    }
    throw Exception('$this is not known in enum HdfsRpcProtection');
  }
}

/// ListAgentsResponse
class ListAgentsResponse {
  /// A list of agents in your account.
  final List<AgentListEntry>? agents;

  /// An opaque string that indicates the position at which to begin returning the
  /// next list of agents.
  final String? nextToken;

  ListAgentsResponse({
    this.agents,
    this.nextToken,
  });
  factory ListAgentsResponse.fromJson(Map<String, dynamic> json) {
    return ListAgentsResponse(
      agents: (json['Agents'] as List?)
          ?.whereNotNull()
          .map((e) => AgentListEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

/// ListLocationsResponse
class ListLocationsResponse {
  /// An array that contains a list of locations.
  final List<LocationListEntry>? locations;

  /// An opaque string that indicates the position at which to begin returning the
  /// next list of locations.
  final String? nextToken;

  ListLocationsResponse({
    this.locations,
    this.nextToken,
  });
  factory ListLocationsResponse.fromJson(Map<String, dynamic> json) {
    return ListLocationsResponse(
      locations: (json['Locations'] as List?)
          ?.whereNotNull()
          .map((e) => LocationListEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

/// ListTagsForResourceResponse
class ListTagsForResourceResponse {
  /// An opaque string that indicates the position at which to begin returning the
  /// next list of resource tags.
  final String? nextToken;

  /// Array of resource tags.
  final List<TagListEntry>? tags;

  ListTagsForResourceResponse({
    this.nextToken,
    this.tags,
  });
  factory ListTagsForResourceResponse.fromJson(Map<String, dynamic> json) {
    return ListTagsForResourceResponse(
      nextToken: json['NextToken'] as String?,
      tags: (json['Tags'] as List?)
          ?.whereNotNull()
          .map((e) => TagListEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// ListTaskExecutionsResponse
class ListTaskExecutionsResponse {
  /// An opaque string that indicates the position at which to begin returning the
  /// next list of executed tasks.
  final String? nextToken;

  /// A list of executed tasks.
  final List<TaskExecutionListEntry>? taskExecutions;

  ListTaskExecutionsResponse({
    this.nextToken,
    this.taskExecutions,
  });
  factory ListTaskExecutionsResponse.fromJson(Map<String, dynamic> json) {
    return ListTaskExecutionsResponse(
      nextToken: json['NextToken'] as String?,
      taskExecutions: (json['TaskExecutions'] as List?)
          ?.whereNotNull()
          .map(
              (e) => TaskExecutionListEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// ListTasksResponse
class ListTasksResponse {
  /// An opaque string that indicates the position at which to begin returning the
  /// next list of tasks.
  final String? nextToken;

  /// A list of all the tasks that are returned.
  final List<TaskListEntry>? tasks;

  ListTasksResponse({
    this.nextToken,
    this.tasks,
  });
  factory ListTasksResponse.fromJson(Map<String, dynamic> json) {
    return ListTasksResponse(
      nextToken: json['NextToken'] as String?,
      tasks: (json['Tasks'] as List?)
          ?.whereNotNull()
          .map((e) => TaskListEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Narrow down the list of resources returned by <code>ListLocations</code>.
/// For example, to see all your Amazon S3 locations, create a filter using
/// <code>"Name": "LocationType"</code>, <code>"Operator": "Equals"</code>, and
/// <code>"Values": "S3"</code>.
///
/// For more information, see <a
/// href="https://docs.aws.amazon.com/datasync/latest/userguide/query-resources.html">filtering
/// resources</a>.
class LocationFilter {
  /// The name of the filter being used. Each API call supports a list of filters
  /// that are available for it (for example, <code>LocationType</code> for
  /// <code>ListLocations</code>).
  final LocationFilterName name;

  /// The operator that is used to compare filter values (for example,
  /// <code>Equals</code> or <code>Contains</code>).
  final Operator operator;

  /// The values that you want to filter for. For example, you might want to
  /// display only Amazon S3 locations.
  final List<String> values;

  LocationFilter({
    required this.name,
    required this.operator,
    required this.values,
  });
  Map<String, dynamic> toJson() {
    final name = this.name;
    final operator = this.operator;
    final values = this.values;
    return {
      'Name': name.toValue(),
      'Operator': operator.toValue(),
      'Values': values,
    };
  }
}

enum LocationFilterName {
  locationUri,
  locationType,
  creationTime,
}

extension on LocationFilterName {
  String toValue() {
    switch (this) {
      case LocationFilterName.locationUri:
        return 'LocationUri';
      case LocationFilterName.locationType:
        return 'LocationType';
      case LocationFilterName.creationTime:
        return 'CreationTime';
    }
  }
}

extension on String {
  LocationFilterName toLocationFilterName() {
    switch (this) {
      case 'LocationUri':
        return LocationFilterName.locationUri;
      case 'LocationType':
        return LocationFilterName.locationType;
      case 'CreationTime':
        return LocationFilterName.creationTime;
    }
    throw Exception('$this is not known in enum LocationFilterName');
  }
}

/// Represents a single entry in a list of locations.
/// <code>LocationListEntry</code> returns an array that contains a list of
/// locations when the <a
/// href="https://docs.aws.amazon.com/datasync/latest/userguide/API_ListLocations.html">ListLocations</a>
/// operation is called.
class LocationListEntry {
  /// The Amazon Resource Name (ARN) of the location. For Network File System
  /// (NFS) or Amazon EFS, the location is the export path. For Amazon S3, the
  /// location is the prefix path that you want to mount and use as the root of
  /// the location.
  final String? locationArn;

  /// Represents a list of URIs of a location. <code>LocationUri</code> returns an
  /// array that contains a list of locations when the <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/API_ListLocations.html">ListLocations</a>
  /// operation is called.
  ///
  /// Format: <code>TYPE://GLOBAL_ID/SUBDIR</code>.
  ///
  /// TYPE designates the type of location (for example, <code>nfs</code> or
  /// <code>s3</code>).
  ///
  /// GLOBAL_ID is the globally unique identifier of the resource that backs the
  /// location. An example for EFS is <code>us-east-2.fs-abcd1234</code>. An
  /// example for Amazon S3 is the bucket name, such as <code>myBucket</code>. An
  /// example for NFS is a valid IPv4 address or a hostname that is compliant with
  /// Domain Name Service (DNS).
  ///
  /// SUBDIR is a valid file system path, delimited by forward slashes as is the
  /// *nix convention. For NFS and Amazon EFS, it's the export path to mount the
  /// location. For Amazon S3, it's the prefix path that you mount to and treat as
  /// the root of the location.
  /// <p/>
  final String? locationUri;

  LocationListEntry({
    this.locationArn,
    this.locationUri,
  });
  factory LocationListEntry.fromJson(Map<String, dynamic> json) {
    return LocationListEntry(
      locationArn: json['LocationArn'] as String?,
      locationUri: json['LocationUri'] as String?,
    );
  }
}

enum LogLevel {
  off,
  basic,
  transfer,
}

extension on LogLevel {
  String toValue() {
    switch (this) {
      case LogLevel.off:
        return 'OFF';
      case LogLevel.basic:
        return 'BASIC';
      case LogLevel.transfer:
        return 'TRANSFER';
    }
  }
}

extension on String {
  LogLevel toLogLevel() {
    switch (this) {
      case 'OFF':
        return LogLevel.off;
      case 'BASIC':
        return LogLevel.basic;
      case 'TRANSFER':
        return LogLevel.transfer;
    }
    throw Exception('$this is not known in enum LogLevel');
  }
}

enum Mtime {
  none,
  preserve,
}

extension on Mtime {
  String toValue() {
    switch (this) {
      case Mtime.none:
        return 'NONE';
      case Mtime.preserve:
        return 'PRESERVE';
    }
  }
}

extension on String {
  Mtime toMtime() {
    switch (this) {
      case 'NONE':
        return Mtime.none;
      case 'PRESERVE':
        return Mtime.preserve;
    }
    throw Exception('$this is not known in enum Mtime');
  }
}

/// Specifies how DataSync can access a location using the NFS protocol.
class NfsMountOptions {
  /// Specifies the NFS version that you want DataSync to use when mounting your
  /// NFS share. If the server refuses to use the version specified, the task
  /// fails.
  ///
  /// You can specify the following options:
  ///
  /// <ul>
  /// <li>
  /// <code>AUTOMATIC</code> (default): DataSync chooses NFS version 4.1.
  /// </li>
  /// <li>
  /// <code>NFS3</code>: Stateless protocol version that allows for asynchronous
  /// writes on the server.
  /// </li>
  /// <li>
  /// <code>NFSv4_0</code>: Stateful, firewall-friendly protocol version that
  /// supports delegations and pseudo file systems.
  /// </li>
  /// <li>
  /// <code>NFSv4_1</code>: Stateful protocol version that supports sessions,
  /// directory delegations, and parallel data processing. NFS version 4.1 also
  /// includes all features available in version 4.0.
  /// </li>
  /// </ul> <note>
  /// DataSync currently only supports NFS version 3 with Amazon FSx for NetApp
  /// ONTAP locations.
  /// </note>
  final NfsVersion? version;

  NfsMountOptions({
    this.version,
  });
  factory NfsMountOptions.fromJson(Map<String, dynamic> json) {
    return NfsMountOptions(
      version: (json['Version'] as String?)?.toNfsVersion(),
    );
  }

  Map<String, dynamic> toJson() {
    final version = this.version;
    return {
      if (version != null) 'Version': version.toValue(),
    };
  }
}

enum NfsVersion {
  automatic,
  nfs3,
  nfs4_0,
  nfs4_1,
}

extension on NfsVersion {
  String toValue() {
    switch (this) {
      case NfsVersion.automatic:
        return 'AUTOMATIC';
      case NfsVersion.nfs3:
        return 'NFS3';
      case NfsVersion.nfs4_0:
        return 'NFS4_0';
      case NfsVersion.nfs4_1:
        return 'NFS4_1';
    }
  }
}

extension on String {
  NfsVersion toNfsVersion() {
    switch (this) {
      case 'AUTOMATIC':
        return NfsVersion.automatic;
      case 'NFS3':
        return NfsVersion.nfs3;
      case 'NFS4_0':
        return NfsVersion.nfs4_0;
      case 'NFS4_1':
        return NfsVersion.nfs4_1;
    }
    throw Exception('$this is not known in enum NfsVersion');
  }
}

enum ObjectStorageServerProtocol {
  https,
  http,
}

extension on ObjectStorageServerProtocol {
  String toValue() {
    switch (this) {
      case ObjectStorageServerProtocol.https:
        return 'HTTPS';
      case ObjectStorageServerProtocol.http:
        return 'HTTP';
    }
  }
}

extension on String {
  ObjectStorageServerProtocol toObjectStorageServerProtocol() {
    switch (this) {
      case 'HTTPS':
        return ObjectStorageServerProtocol.https;
      case 'HTTP':
        return ObjectStorageServerProtocol.http;
    }
    throw Exception('$this is not known in enum ObjectStorageServerProtocol');
  }
}

enum ObjectTags {
  preserve,
  none,
}

extension on ObjectTags {
  String toValue() {
    switch (this) {
      case ObjectTags.preserve:
        return 'PRESERVE';
      case ObjectTags.none:
        return 'NONE';
    }
  }
}

extension on String {
  ObjectTags toObjectTags() {
    switch (this) {
      case 'PRESERVE':
        return ObjectTags.preserve;
      case 'NONE':
        return ObjectTags.none;
    }
    throw Exception('$this is not known in enum ObjectTags');
  }
}

/// A list of Amazon Resource Names (ARNs) of agents to use for a Network File
/// System (NFS) location.
class OnPremConfig {
  /// ARNs of the agents to use for an NFS location.
  final List<String> agentArns;

  OnPremConfig({
    required this.agentArns,
  });
  factory OnPremConfig.fromJson(Map<String, dynamic> json) {
    return OnPremConfig(
      agentArns: (json['AgentArns'] as List)
          .whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final agentArns = this.agentArns;
    return {
      'AgentArns': agentArns,
    };
  }
}

enum Operator {
  equals,
  notEquals,
  $in,
  lessThanOrEqual,
  lessThan,
  greaterThanOrEqual,
  greaterThan,
  contains,
  notContains,
  beginsWith,
}

extension on Operator {
  String toValue() {
    switch (this) {
      case Operator.equals:
        return 'Equals';
      case Operator.notEquals:
        return 'NotEquals';
      case Operator.$in:
        return 'In';
      case Operator.lessThanOrEqual:
        return 'LessThanOrEqual';
      case Operator.lessThan:
        return 'LessThan';
      case Operator.greaterThanOrEqual:
        return 'GreaterThanOrEqual';
      case Operator.greaterThan:
        return 'GreaterThan';
      case Operator.contains:
        return 'Contains';
      case Operator.notContains:
        return 'NotContains';
      case Operator.beginsWith:
        return 'BeginsWith';
    }
  }
}

extension on String {
  Operator toOperator() {
    switch (this) {
      case 'Equals':
        return Operator.equals;
      case 'NotEquals':
        return Operator.notEquals;
      case 'In':
        return Operator.$in;
      case 'LessThanOrEqual':
        return Operator.lessThanOrEqual;
      case 'LessThan':
        return Operator.lessThan;
      case 'GreaterThanOrEqual':
        return Operator.greaterThanOrEqual;
      case 'GreaterThan':
        return Operator.greaterThan;
      case 'Contains':
        return Operator.contains;
      case 'NotContains':
        return Operator.notContains;
      case 'BeginsWith':
        return Operator.beginsWith;
    }
    throw Exception('$this is not known in enum Operator');
  }
}

/// Represents the options that are available to control the behavior of a <a
/// href="https://docs.aws.amazon.com/datasync/latest/userguide/API_StartTaskExecution.html">StartTaskExecution</a>
/// operation. Behavior includes preserving metadata such as user ID (UID),
/// group ID (GID), and file permissions, and also overwriting files in the
/// destination, data integrity verification, and so on.
///
/// A task has a set of default options associated with it. If you don't specify
/// an option in <a
/// href="https://docs.aws.amazon.com/datasync/latest/userguide/API_StartTaskExecution.html">StartTaskExecution</a>,
/// the default value is used. You can override the defaults options on each
/// task execution by specifying an overriding <code>Options</code> value to <a
/// href="https://docs.aws.amazon.com/datasync/latest/userguide/API_StartTaskExecution.html">StartTaskExecution</a>.
class Options {
  /// A file metadata value that shows the last time a file was accessed (that is,
  /// when the file was read or written to). If you set <code>Atime</code> to
  /// <code>BEST_EFFORT</code>, DataSync attempts to preserve the original
  /// <code>Atime</code> attribute on all source files (that is, the version
  /// before the <code>PREPARING</code> phase). However, <code>Atime</code>'s
  /// behavior is not fully standard across platforms, so DataSync can only do
  /// this on a best-effort basis.
  ///
  /// Default value: <code>BEST_EFFORT</code>
  ///
  /// <code>BEST_EFFORT</code>: Attempt to preserve the per-file
  /// <code>Atime</code> value (recommended).
  ///
  /// <code>NONE</code>: Ignore <code>Atime</code>.
  /// <note>
  /// If <code>Atime</code> is set to <code>BEST_EFFORT</code>, <code>Mtime</code>
  /// must be set to <code>PRESERVE</code>.
  ///
  /// If <code>Atime</code> is set to <code>NONE</code>, <code>Mtime</code> must
  /// also be <code>NONE</code>.
  /// </note>
  final Atime? atime;

  /// A value that limits the bandwidth used by DataSync. For example, if you want
  /// DataSync to use a maximum of 1 MB, set this value to <code>1048576</code>
  /// (<code>=1024*1024</code>).
  final int? bytesPerSecond;

  /// The POSIX group ID (GID) of the file's owners.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/special-files.html#metadata-copied">Metadata
  /// copied by DataSync</a>.
  ///
  /// Default value: <code>INT_VALUE</code>. This preserves the integer value of
  /// the ID.
  ///
  /// <code>INT_VALUE</code>: Preserve the integer value of user ID (UID) and GID
  /// (recommended).
  ///
  /// <code>NONE</code>: Ignore UID and GID.
  final Gid? gid;

  /// A value that determines the type of logs that DataSync publishes to a log
  /// stream in the Amazon CloudWatch log group that you provide. For more
  /// information about providing a log group for DataSync, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/API_CreateTask.html#DataSync-CreateTask-request-CloudWatchLogGroupArn">CloudWatchLogGroupArn</a>.
  /// If set to <code>OFF</code>, no logs are published. <code>BASIC</code>
  /// publishes logs on errors for individual files transferred, and
  /// <code>TRANSFER</code> publishes logs for every file or object that is
  /// transferred and integrity checked.
  final LogLevel? logLevel;

  /// A value that indicates the last time that a file was modified (that is, a
  /// file was written to) before the <code>PREPARING</code> phase. This option is
  /// required for cases when you need to run the same task more than one time.
  ///
  /// Default Value: <code>PRESERVE</code>
  ///
  /// <code>PRESERVE</code>: Preserve original <code>Mtime</code> (recommended)
  ///
  /// <code>NONE</code>: Ignore <code>Mtime</code>.
  /// <note>
  /// If <code>Mtime</code> is set to <code>PRESERVE</code>, <code>Atime</code>
  /// must be set to <code>BEST_EFFORT</code>.
  ///
  /// If <code>Mtime</code> is set to <code>NONE</code>, <code>Atime</code> must
  /// also be set to <code>NONE</code>.
  /// </note>
  final Mtime? mtime;

  /// Specifies whether object tags are maintained when transferring between
  /// object storage systems. If you want your DataSync task to ignore object
  /// tags, specify the <code>NONE</code> value.
  ///
  /// Default Value: <code>PRESERVE</code>
  final ObjectTags? objectTags;

  /// A value that determines whether files at the destination should be
  /// overwritten or preserved when copying files. If set to <code>NEVER</code> a
  /// destination file will not be replaced by a source file, even if the
  /// destination file differs from the source file. If you modify files in the
  /// destination and you sync the files, you can use this value to protect
  /// against overwriting those changes.
  ///
  /// Some storage classes have specific behaviors that can affect your S3 storage
  /// cost. For detailed information, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-s3-location.html#using-storage-classes">Considerations
  /// when working with Amazon S3 storage classes in DataSync </a> in the
  /// <i>DataSync User Guide</i>.
  final OverwriteMode? overwriteMode;

  /// A value that determines which users or groups can access a file for a
  /// specific purpose such as reading, writing, or execution of the file.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/special-files.html#metadata-copied">Metadata
  /// copied by DataSync</a>.
  ///
  /// Default value: <code>PRESERVE</code>
  ///
  /// <code>PRESERVE</code>: Preserve POSIX-style permissions (recommended).
  ///
  /// <code>NONE</code>: Ignore permissions.
  /// <note>
  /// DataSync can preserve extant permissions of a source location.
  /// </note>
  final PosixPermissions? posixPermissions;

  /// A value that specifies whether files in the destination that don't exist in
  /// the source file system should be preserved. This option can affect your
  /// storage cost. If your task deletes objects, you might incur minimum storage
  /// duration charges for certain storage classes. For detailed information, see
  /// <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-s3-location.html#using-storage-classes">Considerations
  /// when working with Amazon S3 storage classes in DataSync </a> in the
  /// <i>DataSync User Guide</i>.
  ///
  /// Default value: <code>PRESERVE</code>
  ///
  /// <code>PRESERVE</code>: Ignore such destination files (recommended).
  ///
  /// <code>REMOVE</code>: Delete destination files that aren’t present in the
  /// source.
  final PreserveDeletedFiles? preserveDeletedFiles;

  /// A value that determines whether DataSync should preserve the metadata of
  /// block and character devices in the source file system, and re-create the
  /// files with that device name and metadata on the destination. DataSync does
  /// not copy the contents of such devices, only the name and metadata.
  /// <note>
  /// DataSync can't sync the actual contents of such devices, because they are
  /// nonterminal and don't return an end-of-file (EOF) marker.
  /// </note>
  /// Default value: <code>NONE</code>
  ///
  /// <code>NONE</code>: Ignore special devices (recommended).
  ///
  /// <code>PRESERVE</code>: Preserve character and block device metadata. This
  /// option isn't currently supported for Amazon EFS.
  final PreserveDevices? preserveDevices;

  /// A value that determines which components of the SMB security descriptor are
  /// copied from source to destination objects.
  ///
  /// This value is only used for transfers between SMB and Amazon FSx for Windows
  /// File Server locations, or between two Amazon FSx for Windows File Server
  /// locations. For more information about how DataSync handles metadata, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/special-files.html">How
  /// DataSync Handles Metadata and Special Files</a>.
  ///
  /// Default value: <code>OWNER_DACL</code>
  ///
  /// <code>OWNER_DACL</code>: For each copied object, DataSync copies the
  /// following metadata:
  ///
  /// <ul>
  /// <li>
  /// Object owner.
  /// </li>
  /// <li>
  /// NTFS discretionary access control lists (DACLs), which determine whether to
  /// grant access to an object.
  /// </li>
  /// </ul>
  /// When choosing this option, DataSync does NOT copy the NTFS system access
  /// control lists (SACLs), which are used by administrators to log attempts to
  /// access a secured object.
  ///
  /// <code>OWNER_DACL_SACL</code>: For each copied object, DataSync copies the
  /// following metadata:
  ///
  /// <ul>
  /// <li>
  /// Object owner.
  /// </li>
  /// <li>
  /// NTFS discretionary access control lists (DACLs), which determine whether to
  /// grant access to an object.
  /// </li>
  /// <li>
  /// NTFS system access control lists (SACLs), which are used by administrators
  /// to log attempts to access a secured object.
  /// </li>
  /// </ul>
  /// Copying SACLs requires granting additional permissions to the Windows user
  /// that DataSync uses to access your SMB location. For information about
  /// choosing a user that ensures sufficient permissions to files, folders, and
  /// metadata, see <a href="create-smb-location.html#SMBuser">user</a>.
  ///
  /// <code>NONE</code>: None of the SMB security descriptor components are
  /// copied. Destination objects are owned by the user that was provided for
  /// accessing the destination location. DACLs and SACLs are set based on the
  /// destination server’s configuration.
  final SmbSecurityDescriptorCopyFlags? securityDescriptorCopyFlags;

  /// A value that determines whether tasks should be queued before executing the
  /// tasks. If set to <code>ENABLED</code>, the tasks will be queued. The default
  /// is <code>ENABLED</code>.
  ///
  /// If you use the same agent to run multiple tasks, you can enable the tasks to
  /// run in series. For more information, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/run-task.html#queue-task-execution">Queueing
  /// task executions</a>.
  final TaskQueueing? taskQueueing;

  /// A value that determines whether DataSync transfers only the data and
  /// metadata that differ between the source and the destination location, or
  /// whether DataSync transfers all the content from the source, without
  /// comparing to the destination location.
  ///
  /// <code>CHANGED</code>: DataSync copies only data or metadata that is new or
  /// different content from the source location to the destination location.
  ///
  /// <code>ALL</code>: DataSync copies all source location content to the
  /// destination, without comparing to existing content on the destination.
  final TransferMode? transferMode;

  /// The POSIX user ID (UID) of the file's owner.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/special-files.html#metadata-copied">Metadata
  /// copied by DataSync</a>.
  ///
  /// Default value: <code>INT_VALUE</code>. This preserves the integer value of
  /// the ID.
  ///
  /// <code>INT_VALUE</code>: Preserve the integer value of UID and group ID (GID)
  /// (recommended).
  ///
  /// <code>NONE</code>: Ignore UID and GID.
  final Uid? uid;

  /// A value that determines whether a data integrity verification should be
  /// performed at the end of a task execution after all data and metadata have
  /// been transferred. For more information, see <a
  /// href="https://docs.aws.amazon.com/datasync/latest/userguide/create-task.html">Configure
  /// task settings</a>.
  ///
  /// Default value: <code>POINT_IN_TIME_CONSISTENT</code>
  ///
  /// <code>ONLY_FILES_TRANSFERRED</code> (recommended): Perform verification only
  /// on files that were transferred.
  ///
  /// <code>POINT_IN_TIME_CONSISTENT</code>: Scan the entire source and entire
  /// destination at the end of the transfer to verify that source and destination
  /// are fully synchronized. This option isn't supported when transferring to S3
  /// Glacier Flexible Retrieval or S3 Glacier Deep Archive storage classes.
  ///
  /// <code>NONE</code>: No additional verification is done at the end of the
  /// transfer, but all data transmissions are integrity-checked with checksum
  /// verification during the transfer.
  final VerifyMode? verifyMode;

  Options({
    this.atime,
    this.bytesPerSecond,
    this.gid,
    this.logLevel,
    this.mtime,
    this.objectTags,
    this.overwriteMode,
    this.posixPermissions,
    this.preserveDeletedFiles,
    this.preserveDevices,
    this.securityDescriptorCopyFlags,
    this.taskQueueing,
    this.transferMode,
    this.uid,
    this.verifyMode,
  });
  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      atime: (json['Atime'] as String?)?.toAtime(),
      bytesPerSecond: json['BytesPerSecond'] as int?,
      gid: (json['Gid'] as String?)?.toGid(),
      logLevel: (json['LogLevel'] as String?)?.toLogLevel(),
      mtime: (json['Mtime'] as String?)?.toMtime(),
      objectTags: (json['ObjectTags'] as String?)?.toObjectTags(),
      overwriteMode: (json['OverwriteMode'] as String?)?.toOverwriteMode(),
      posixPermissions:
          (json['PosixPermissions'] as String?)?.toPosixPermissions(),
      preserveDeletedFiles:
          (json['PreserveDeletedFiles'] as String?)?.toPreserveDeletedFiles(),
      preserveDevices:
          (json['PreserveDevices'] as String?)?.toPreserveDevices(),
      securityDescriptorCopyFlags:
          (json['SecurityDescriptorCopyFlags'] as String?)
              ?.toSmbSecurityDescriptorCopyFlags(),
      taskQueueing: (json['TaskQueueing'] as String?)?.toTaskQueueing(),
      transferMode: (json['TransferMode'] as String?)?.toTransferMode(),
      uid: (json['Uid'] as String?)?.toUid(),
      verifyMode: (json['VerifyMode'] as String?)?.toVerifyMode(),
    );
  }

  Map<String, dynamic> toJson() {
    final atime = this.atime;
    final bytesPerSecond = this.bytesPerSecond;
    final gid = this.gid;
    final logLevel = this.logLevel;
    final mtime = this.mtime;
    final objectTags = this.objectTags;
    final overwriteMode = this.overwriteMode;
    final posixPermissions = this.posixPermissions;
    final preserveDeletedFiles = this.preserveDeletedFiles;
    final preserveDevices = this.preserveDevices;
    final securityDescriptorCopyFlags = this.securityDescriptorCopyFlags;
    final taskQueueing = this.taskQueueing;
    final transferMode = this.transferMode;
    final uid = this.uid;
    final verifyMode = this.verifyMode;
    return {
      if (atime != null) 'Atime': atime.toValue(),
      if (bytesPerSecond != null) 'BytesPerSecond': bytesPerSecond,
      if (gid != null) 'Gid': gid.toValue(),
      if (logLevel != null) 'LogLevel': logLevel.toValue(),
      if (mtime != null) 'Mtime': mtime.toValue(),
      if (objectTags != null) 'ObjectTags': objectTags.toValue(),
      if (overwriteMode != null) 'OverwriteMode': overwriteMode.toValue(),
      if (posixPermissions != null)
        'PosixPermissions': posixPermissions.toValue(),
      if (preserveDeletedFiles != null)
        'PreserveDeletedFiles': preserveDeletedFiles.toValue(),
      if (preserveDevices != null) 'PreserveDevices': preserveDevices.toValue(),
      if (securityDescriptorCopyFlags != null)
        'SecurityDescriptorCopyFlags': securityDescriptorCopyFlags.toValue(),
      if (taskQueueing != null) 'TaskQueueing': taskQueueing.toValue(),
      if (transferMode != null) 'TransferMode': transferMode.toValue(),
      if (uid != null) 'Uid': uid.toValue(),
      if (verifyMode != null) 'VerifyMode': verifyMode.toValue(),
    };
  }
}

enum OverwriteMode {
  always,
  never,
}

extension on OverwriteMode {
  String toValue() {
    switch (this) {
      case OverwriteMode.always:
        return 'ALWAYS';
      case OverwriteMode.never:
        return 'NEVER';
    }
  }
}

extension on String {
  OverwriteMode toOverwriteMode() {
    switch (this) {
      case 'ALWAYS':
        return OverwriteMode.always;
      case 'NEVER':
        return OverwriteMode.never;
    }
    throw Exception('$this is not known in enum OverwriteMode');
  }
}

enum PhaseStatus {
  pending,
  success,
  error,
}

extension on PhaseStatus {
  String toValue() {
    switch (this) {
      case PhaseStatus.pending:
        return 'PENDING';
      case PhaseStatus.success:
        return 'SUCCESS';
      case PhaseStatus.error:
        return 'ERROR';
    }
  }
}

extension on String {
  PhaseStatus toPhaseStatus() {
    switch (this) {
      case 'PENDING':
        return PhaseStatus.pending;
      case 'SUCCESS':
        return PhaseStatus.success;
      case 'ERROR':
        return PhaseStatus.error;
    }
    throw Exception('$this is not known in enum PhaseStatus');
  }
}

enum PosixPermissions {
  none,
  preserve,
}

extension on PosixPermissions {
  String toValue() {
    switch (this) {
      case PosixPermissions.none:
        return 'NONE';
      case PosixPermissions.preserve:
        return 'PRESERVE';
    }
  }
}

extension on String {
  PosixPermissions toPosixPermissions() {
    switch (this) {
      case 'NONE':
        return PosixPermissions.none;
      case 'PRESERVE':
        return PosixPermissions.preserve;
    }
    throw Exception('$this is not known in enum PosixPermissions');
  }
}

enum PreserveDeletedFiles {
  preserve,
  remove,
}

extension on PreserveDeletedFiles {
  String toValue() {
    switch (this) {
      case PreserveDeletedFiles.preserve:
        return 'PRESERVE';
      case PreserveDeletedFiles.remove:
        return 'REMOVE';
    }
  }
}

extension on String {
  PreserveDeletedFiles toPreserveDeletedFiles() {
    switch (this) {
      case 'PRESERVE':
        return PreserveDeletedFiles.preserve;
      case 'REMOVE':
        return PreserveDeletedFiles.remove;
    }
    throw Exception('$this is not known in enum PreserveDeletedFiles');
  }
}

enum PreserveDevices {
  none,
  preserve,
}

extension on PreserveDevices {
  String toValue() {
    switch (this) {
      case PreserveDevices.none:
        return 'NONE';
      case PreserveDevices.preserve:
        return 'PRESERVE';
    }
  }
}

extension on String {
  PreserveDevices toPreserveDevices() {
    switch (this) {
      case 'NONE':
        return PreserveDevices.none;
      case 'PRESERVE':
        return PreserveDevices.preserve;
    }
    throw Exception('$this is not known in enum PreserveDevices');
  }
}

/// The VPC endpoint, subnet, and security group that an agent uses to access IP
/// addresses in a VPC (Virtual Private Cloud).
class PrivateLinkConfig {
  /// The private endpoint that is configured for an agent that has access to IP
  /// addresses in a <a
  /// href="https://docs.aws.amazon.com/vpc/latest/userguide/endpoint-service.html">PrivateLink</a>.
  /// An agent that is configured with this endpoint will not be accessible over
  /// the public internet.
  final String? privateLinkEndpoint;

  /// The Amazon Resource Names (ARNs) of the security groups that are configured
  /// for the EC2 resource that hosts an agent activated in a VPC or an agent that
  /// has access to a VPC endpoint.
  final List<String>? securityGroupArns;

  /// The Amazon Resource Names (ARNs) of the subnets that are configured for an
  /// agent activated in a VPC or an agent that has access to a VPC endpoint.
  final List<String>? subnetArns;

  /// The ID of the VPC endpoint that is configured for an agent. An agent that is
  /// configured with a VPC endpoint will not be accessible over the public
  /// internet.
  final String? vpcEndpointId;

  PrivateLinkConfig({
    this.privateLinkEndpoint,
    this.securityGroupArns,
    this.subnetArns,
    this.vpcEndpointId,
  });
  factory PrivateLinkConfig.fromJson(Map<String, dynamic> json) {
    return PrivateLinkConfig(
      privateLinkEndpoint: json['PrivateLinkEndpoint'] as String?,
      securityGroupArns: (json['SecurityGroupArns'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      subnetArns: (json['SubnetArns'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      vpcEndpointId: json['VpcEndpointId'] as String?,
    );
  }
}

/// The Quality of Protection (QOP) configuration specifies the Remote Procedure
/// Call (RPC) and data transfer privacy settings configured on the Hadoop
/// Distributed File System (HDFS) cluster.
class QopConfiguration {
  /// The data transfer protection setting configured on the HDFS cluster. This
  /// setting corresponds to your <code>dfs.data.transfer.protection</code>
  /// setting in the <code>hdfs-site.xml</code> file on your Hadoop cluster.
  final HdfsDataTransferProtection? dataTransferProtection;

  /// The RPC protection setting configured on the HDFS cluster. This setting
  /// corresponds to your <code>hadoop.rpc.protection</code> setting in your
  /// <code>core-site.xml</code> file on your Hadoop cluster.
  final HdfsRpcProtection? rpcProtection;

  QopConfiguration({
    this.dataTransferProtection,
    this.rpcProtection,
  });
  factory QopConfiguration.fromJson(Map<String, dynamic> json) {
    return QopConfiguration(
      dataTransferProtection: (json['DataTransferProtection'] as String?)
          ?.toHdfsDataTransferProtection(),
      rpcProtection: (json['RpcProtection'] as String?)?.toHdfsRpcProtection(),
    );
  }

  Map<String, dynamic> toJson() {
    final dataTransferProtection = this.dataTransferProtection;
    final rpcProtection = this.rpcProtection;
    return {
      if (dataTransferProtection != null)
        'DataTransferProtection': dataTransferProtection.toValue(),
      if (rpcProtection != null) 'RpcProtection': rpcProtection.toValue(),
    };
  }
}

/// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
/// role used to access an Amazon S3 bucket.
///
/// For detailed information about using such a role, see Creating a Location
/// for Amazon S3 in the <i>DataSync User Guide</i>.
class S3Config {
  /// The ARN of the IAM role for accessing the S3 bucket.
  final String bucketAccessRoleArn;

  S3Config({
    required this.bucketAccessRoleArn,
  });
  factory S3Config.fromJson(Map<String, dynamic> json) {
    return S3Config(
      bucketAccessRoleArn: json['BucketAccessRoleArn'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final bucketAccessRoleArn = this.bucketAccessRoleArn;
    return {
      'BucketAccessRoleArn': bucketAccessRoleArn,
    };
  }
}

enum S3StorageClass {
  standard,
  standardIa,
  onezoneIa,
  intelligentTiering,
  glacier,
  deepArchive,
  outposts,
}

extension on S3StorageClass {
  String toValue() {
    switch (this) {
      case S3StorageClass.standard:
        return 'STANDARD';
      case S3StorageClass.standardIa:
        return 'STANDARD_IA';
      case S3StorageClass.onezoneIa:
        return 'ONEZONE_IA';
      case S3StorageClass.intelligentTiering:
        return 'INTELLIGENT_TIERING';
      case S3StorageClass.glacier:
        return 'GLACIER';
      case S3StorageClass.deepArchive:
        return 'DEEP_ARCHIVE';
      case S3StorageClass.outposts:
        return 'OUTPOSTS';
    }
  }
}

extension on String {
  S3StorageClass toS3StorageClass() {
    switch (this) {
      case 'STANDARD':
        return S3StorageClass.standard;
      case 'STANDARD_IA':
        return S3StorageClass.standardIa;
      case 'ONEZONE_IA':
        return S3StorageClass.onezoneIa;
      case 'INTELLIGENT_TIERING':
        return S3StorageClass.intelligentTiering;
      case 'GLACIER':
        return S3StorageClass.glacier;
      case 'DEEP_ARCHIVE':
        return S3StorageClass.deepArchive;
      case 'OUTPOSTS':
        return S3StorageClass.outposts;
    }
    throw Exception('$this is not known in enum S3StorageClass');
  }
}

/// Specifies how DataSync can access a location using the SMB protocol.
class SmbMountOptions {
  /// Specifies the SMB version that you want DataSync to use when mounting your
  /// SMB share. If you don't specify a version, DataSync defaults to
  /// <code>AUTOMATIC</code> and chooses a version based on negotiation with the
  /// SMB server.
  final SmbVersion? version;

  SmbMountOptions({
    this.version,
  });
  factory SmbMountOptions.fromJson(Map<String, dynamic> json) {
    return SmbMountOptions(
      version: (json['Version'] as String?)?.toSmbVersion(),
    );
  }

  Map<String, dynamic> toJson() {
    final version = this.version;
    return {
      if (version != null) 'Version': version.toValue(),
    };
  }
}

enum SmbSecurityDescriptorCopyFlags {
  none,
  ownerDacl,
  ownerDaclSacl,
}

extension on SmbSecurityDescriptorCopyFlags {
  String toValue() {
    switch (this) {
      case SmbSecurityDescriptorCopyFlags.none:
        return 'NONE';
      case SmbSecurityDescriptorCopyFlags.ownerDacl:
        return 'OWNER_DACL';
      case SmbSecurityDescriptorCopyFlags.ownerDaclSacl:
        return 'OWNER_DACL_SACL';
    }
  }
}

extension on String {
  SmbSecurityDescriptorCopyFlags toSmbSecurityDescriptorCopyFlags() {
    switch (this) {
      case 'NONE':
        return SmbSecurityDescriptorCopyFlags.none;
      case 'OWNER_DACL':
        return SmbSecurityDescriptorCopyFlags.ownerDacl;
      case 'OWNER_DACL_SACL':
        return SmbSecurityDescriptorCopyFlags.ownerDaclSacl;
    }
    throw Exception(
        '$this is not known in enum SmbSecurityDescriptorCopyFlags');
  }
}

enum SmbVersion {
  automatic,
  smb2,
  smb3,
}

extension on SmbVersion {
  String toValue() {
    switch (this) {
      case SmbVersion.automatic:
        return 'AUTOMATIC';
      case SmbVersion.smb2:
        return 'SMB2';
      case SmbVersion.smb3:
        return 'SMB3';
    }
  }
}

extension on String {
  SmbVersion toSmbVersion() {
    switch (this) {
      case 'AUTOMATIC':
        return SmbVersion.automatic;
      case 'SMB2':
        return SmbVersion.smb2;
      case 'SMB3':
        return SmbVersion.smb3;
    }
    throw Exception('$this is not known in enum SmbVersion');
  }
}

/// StartTaskExecutionResponse
class StartTaskExecutionResponse {
  /// The Amazon Resource Name (ARN) of the specific task execution that was
  /// started.
  final String? taskExecutionArn;

  StartTaskExecutionResponse({
    this.taskExecutionArn,
  });
  factory StartTaskExecutionResponse.fromJson(Map<String, dynamic> json) {
    return StartTaskExecutionResponse(
      taskExecutionArn: json['TaskExecutionArn'] as String?,
    );
  }
}

/// Represents a single entry in a list of Amazon Web Services resource tags.
/// <code>TagListEntry</code> returns an array that contains a list of tasks
/// when the <a
/// href="https://docs.aws.amazon.com/datasync/latest/userguide/API_ListTagsForResource.html">ListTagsForResource</a>
/// operation is called.
class TagListEntry {
  /// The key for an Amazon Web Services resource tag.
  final String key;

  /// The value for an Amazon Web Services resource tag.
  final String? value;

  TagListEntry({
    required this.key,
    this.value,
  });
  factory TagListEntry.fromJson(Map<String, dynamic> json) {
    return TagListEntry(
      key: json['Key'] as String,
      value: json['Value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final key = this.key;
    final value = this.value;
    return {
      'Key': key,
      if (value != null) 'Value': value,
    };
  }
}

class TagResourceResponse {
  TagResourceResponse();
  factory TagResourceResponse.fromJson(Map<String, dynamic> _) {
    return TagResourceResponse();
  }
}

/// Represents a single entry in a list of task executions.
/// <code>TaskExecutionListEntry</code> returns an array that contains a list of
/// specific invocations of a task when the <a
/// href="https://docs.aws.amazon.com/datasync/latest/userguide/API_ListTaskExecutions.html">ListTaskExecutions</a>
/// operation is called.
class TaskExecutionListEntry {
  /// The status of a task execution.
  final TaskExecutionStatus? status;

  /// The Amazon Resource Name (ARN) of the task that was executed.
  final String? taskExecutionArn;

  TaskExecutionListEntry({
    this.status,
    this.taskExecutionArn,
  });
  factory TaskExecutionListEntry.fromJson(Map<String, dynamic> json) {
    return TaskExecutionListEntry(
      status: (json['Status'] as String?)?.toTaskExecutionStatus(),
      taskExecutionArn: json['TaskExecutionArn'] as String?,
    );
  }
}

/// Describes the detailed result of a <code>TaskExecution</code> operation.
/// This result includes the time in milliseconds spent in each phase, the
/// status of the task execution, and the errors encountered.
class TaskExecutionResultDetail {
  /// Errors that DataSync encountered during execution of the task. You can use
  /// this error code to help troubleshoot issues.
  final String? errorCode;

  /// Detailed description of an error that was encountered during the task
  /// execution. You can use this information to help troubleshoot issues.
  final String? errorDetail;

  /// The total time in milliseconds that DataSync spent in the PREPARING phase.
  final int? prepareDuration;

  /// The status of the PREPARING phase.
  final PhaseStatus? prepareStatus;

  /// The total time in milliseconds that DataSync took to transfer the file from
  /// the source to the destination location.
  final int? totalDuration;

  /// The total time in milliseconds that DataSync spent in the TRANSFERRING
  /// phase.
  final int? transferDuration;

  /// The status of the TRANSFERRING phase.
  final PhaseStatus? transferStatus;

  /// The total time in milliseconds that DataSync spent in the VERIFYING phase.
  final int? verifyDuration;

  /// The status of the VERIFYING phase.
  final PhaseStatus? verifyStatus;

  TaskExecutionResultDetail({
    this.errorCode,
    this.errorDetail,
    this.prepareDuration,
    this.prepareStatus,
    this.totalDuration,
    this.transferDuration,
    this.transferStatus,
    this.verifyDuration,
    this.verifyStatus,
  });
  factory TaskExecutionResultDetail.fromJson(Map<String, dynamic> json) {
    return TaskExecutionResultDetail(
      errorCode: json['ErrorCode'] as String?,
      errorDetail: json['ErrorDetail'] as String?,
      prepareDuration: json['PrepareDuration'] as int?,
      prepareStatus: (json['PrepareStatus'] as String?)?.toPhaseStatus(),
      totalDuration: json['TotalDuration'] as int?,
      transferDuration: json['TransferDuration'] as int?,
      transferStatus: (json['TransferStatus'] as String?)?.toPhaseStatus(),
      verifyDuration: json['VerifyDuration'] as int?,
      verifyStatus: (json['VerifyStatus'] as String?)?.toPhaseStatus(),
    );
  }
}

enum TaskExecutionStatus {
  queued,
  launching,
  preparing,
  transferring,
  verifying,
  success,
  error,
}

extension on TaskExecutionStatus {
  String toValue() {
    switch (this) {
      case TaskExecutionStatus.queued:
        return 'QUEUED';
      case TaskExecutionStatus.launching:
        return 'LAUNCHING';
      case TaskExecutionStatus.preparing:
        return 'PREPARING';
      case TaskExecutionStatus.transferring:
        return 'TRANSFERRING';
      case TaskExecutionStatus.verifying:
        return 'VERIFYING';
      case TaskExecutionStatus.success:
        return 'SUCCESS';
      case TaskExecutionStatus.error:
        return 'ERROR';
    }
  }
}

extension on String {
  TaskExecutionStatus toTaskExecutionStatus() {
    switch (this) {
      case 'QUEUED':
        return TaskExecutionStatus.queued;
      case 'LAUNCHING':
        return TaskExecutionStatus.launching;
      case 'PREPARING':
        return TaskExecutionStatus.preparing;
      case 'TRANSFERRING':
        return TaskExecutionStatus.transferring;
      case 'VERIFYING':
        return TaskExecutionStatus.verifying;
      case 'SUCCESS':
        return TaskExecutionStatus.success;
      case 'ERROR':
        return TaskExecutionStatus.error;
    }
    throw Exception('$this is not known in enum TaskExecutionStatus');
  }
}

/// You can use API filters to narrow down the list of resources returned by
/// <code>ListTasks</code>. For example, to retrieve all tasks on a source
/// location, you can use <code>ListTasks</code> with filter name
/// <code>LocationId</code> and <code>Operator Equals</code> with the ARN for
/// the location.
///
/// For more information, see <a
/// href="https://docs.aws.amazon.com/datasync/latest/userguide/query-resources.html">filtering
/// DataSync resources</a>.
class TaskFilter {
  /// The name of the filter being used. Each API call supports a list of filters
  /// that are available for it. For example, <code>LocationId</code> for
  /// <code>ListTasks</code>.
  final TaskFilterName name;

  /// The operator that is used to compare filter values (for example,
  /// <code>Equals</code> or <code>Contains</code>).
  final Operator operator;

  /// The values that you want to filter for. For example, you might want to
  /// display only tasks for a specific destination location.
  final List<String> values;

  TaskFilter({
    required this.name,
    required this.operator,
    required this.values,
  });
  Map<String, dynamic> toJson() {
    final name = this.name;
    final operator = this.operator;
    final values = this.values;
    return {
      'Name': name.toValue(),
      'Operator': operator.toValue(),
      'Values': values,
    };
  }
}

enum TaskFilterName {
  locationId,
  creationTime,
}

extension on TaskFilterName {
  String toValue() {
    switch (this) {
      case TaskFilterName.locationId:
        return 'LocationId';
      case TaskFilterName.creationTime:
        return 'CreationTime';
    }
  }
}

extension on String {
  TaskFilterName toTaskFilterName() {
    switch (this) {
      case 'LocationId':
        return TaskFilterName.locationId;
      case 'CreationTime':
        return TaskFilterName.creationTime;
    }
    throw Exception('$this is not known in enum TaskFilterName');
  }
}

/// Represents a single entry in a list of tasks. <code>TaskListEntry</code>
/// returns an array that contains a list of tasks when the <a
/// href="https://docs.aws.amazon.com/datasync/latest/userguide/API_ListTasks.html">ListTasks</a>
/// operation is called. A task includes the source and destination file systems
/// to sync and the options to use for the tasks.
class TaskListEntry {
  /// The name of the task.
  final String? name;

  /// The status of the task.
  final TaskStatus? status;

  /// The Amazon Resource Name (ARN) of the task.
  final String? taskArn;

  TaskListEntry({
    this.name,
    this.status,
    this.taskArn,
  });
  factory TaskListEntry.fromJson(Map<String, dynamic> json) {
    return TaskListEntry(
      name: json['Name'] as String?,
      status: (json['Status'] as String?)?.toTaskStatus(),
      taskArn: json['TaskArn'] as String?,
    );
  }
}

enum TaskQueueing {
  enabled,
  disabled,
}

extension on TaskQueueing {
  String toValue() {
    switch (this) {
      case TaskQueueing.enabled:
        return 'ENABLED';
      case TaskQueueing.disabled:
        return 'DISABLED';
    }
  }
}

extension on String {
  TaskQueueing toTaskQueueing() {
    switch (this) {
      case 'ENABLED':
        return TaskQueueing.enabled;
      case 'DISABLED':
        return TaskQueueing.disabled;
    }
    throw Exception('$this is not known in enum TaskQueueing');
  }
}

/// Specifies the schedule you want your task to use for repeated executions.
/// For more information, see <a
/// href="https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html">Schedule
/// Expressions for Rules</a>.
class TaskSchedule {
  /// A cron expression that specifies when DataSync initiates a scheduled
  /// transfer from a source to a destination location.
  final String scheduleExpression;

  TaskSchedule({
    required this.scheduleExpression,
  });
  factory TaskSchedule.fromJson(Map<String, dynamic> json) {
    return TaskSchedule(
      scheduleExpression: json['ScheduleExpression'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final scheduleExpression = this.scheduleExpression;
    return {
      'ScheduleExpression': scheduleExpression,
    };
  }
}

enum TaskStatus {
  available,
  creating,
  queued,
  running,
  unavailable,
}

extension on TaskStatus {
  String toValue() {
    switch (this) {
      case TaskStatus.available:
        return 'AVAILABLE';
      case TaskStatus.creating:
        return 'CREATING';
      case TaskStatus.queued:
        return 'QUEUED';
      case TaskStatus.running:
        return 'RUNNING';
      case TaskStatus.unavailable:
        return 'UNAVAILABLE';
    }
  }
}

extension on String {
  TaskStatus toTaskStatus() {
    switch (this) {
      case 'AVAILABLE':
        return TaskStatus.available;
      case 'CREATING':
        return TaskStatus.creating;
      case 'QUEUED':
        return TaskStatus.queued;
      case 'RUNNING':
        return TaskStatus.running;
      case 'UNAVAILABLE':
        return TaskStatus.unavailable;
    }
    throw Exception('$this is not known in enum TaskStatus');
  }
}

enum TransferMode {
  changed,
  all,
}

extension on TransferMode {
  String toValue() {
    switch (this) {
      case TransferMode.changed:
        return 'CHANGED';
      case TransferMode.all:
        return 'ALL';
    }
  }
}

extension on String {
  TransferMode toTransferMode() {
    switch (this) {
      case 'CHANGED':
        return TransferMode.changed;
      case 'ALL':
        return TransferMode.all;
    }
    throw Exception('$this is not known in enum TransferMode');
  }
}

enum Uid {
  none,
  intValue,
  name,
  both,
}

extension on Uid {
  String toValue() {
    switch (this) {
      case Uid.none:
        return 'NONE';
      case Uid.intValue:
        return 'INT_VALUE';
      case Uid.name:
        return 'NAME';
      case Uid.both:
        return 'BOTH';
    }
  }
}

extension on String {
  Uid toUid() {
    switch (this) {
      case 'NONE':
        return Uid.none;
      case 'INT_VALUE':
        return Uid.intValue;
      case 'NAME':
        return Uid.name;
      case 'BOTH':
        return Uid.both;
    }
    throw Exception('$this is not known in enum Uid');
  }
}

class UntagResourceResponse {
  UntagResourceResponse();
  factory UntagResourceResponse.fromJson(Map<String, dynamic> _) {
    return UntagResourceResponse();
  }
}

class UpdateAgentResponse {
  UpdateAgentResponse();
  factory UpdateAgentResponse.fromJson(Map<String, dynamic> _) {
    return UpdateAgentResponse();
  }
}

class UpdateLocationHdfsResponse {
  UpdateLocationHdfsResponse();
  factory UpdateLocationHdfsResponse.fromJson(Map<String, dynamic> _) {
    return UpdateLocationHdfsResponse();
  }
}

class UpdateLocationNfsResponse {
  UpdateLocationNfsResponse();
  factory UpdateLocationNfsResponse.fromJson(Map<String, dynamic> _) {
    return UpdateLocationNfsResponse();
  }
}

class UpdateLocationObjectStorageResponse {
  UpdateLocationObjectStorageResponse();
  factory UpdateLocationObjectStorageResponse.fromJson(Map<String, dynamic> _) {
    return UpdateLocationObjectStorageResponse();
  }
}

class UpdateLocationSmbResponse {
  UpdateLocationSmbResponse();
  factory UpdateLocationSmbResponse.fromJson(Map<String, dynamic> _) {
    return UpdateLocationSmbResponse();
  }
}

class UpdateTaskExecutionResponse {
  UpdateTaskExecutionResponse();
  factory UpdateTaskExecutionResponse.fromJson(Map<String, dynamic> _) {
    return UpdateTaskExecutionResponse();
  }
}

class UpdateTaskResponse {
  UpdateTaskResponse();
  factory UpdateTaskResponse.fromJson(Map<String, dynamic> _) {
    return UpdateTaskResponse();
  }
}

enum VerifyMode {
  pointInTimeConsistent,
  onlyFilesTransferred,
  none,
}

extension on VerifyMode {
  String toValue() {
    switch (this) {
      case VerifyMode.pointInTimeConsistent:
        return 'POINT_IN_TIME_CONSISTENT';
      case VerifyMode.onlyFilesTransferred:
        return 'ONLY_FILES_TRANSFERRED';
      case VerifyMode.none:
        return 'NONE';
    }
  }
}

extension on String {
  VerifyMode toVerifyMode() {
    switch (this) {
      case 'POINT_IN_TIME_CONSISTENT':
        return VerifyMode.pointInTimeConsistent;
      case 'ONLY_FILES_TRANSFERRED':
        return VerifyMode.onlyFilesTransferred;
      case 'NONE':
        return VerifyMode.none;
    }
    throw Exception('$this is not known in enum VerifyMode');
  }
}

class InternalException extends _s.GenericAwsException {
  InternalException({String? type, String? message})
      : super(type: type, code: 'InternalException', message: message);
}

class InvalidRequestException extends _s.GenericAwsException {
  InvalidRequestException({String? type, String? message})
      : super(type: type, code: 'InvalidRequestException', message: message);
}

final _exceptionFns = <String, _s.AwsExceptionFn>{
  'InternalException': (type, message) =>
      InternalException(type: type, message: message),
  'InvalidRequestException': (type, message) =>
      InvalidRequestException(type: type, message: message),
};
