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

/// Using Batch, you can run batch computing workloads on the Amazon Web
/// Services Cloud. Batch computing is a common means for developers,
/// scientists, and engineers to access large amounts of compute resources.
/// Batch uses the advantages of this computing workload to remove the
/// undifferentiated heavy lifting of configuring and managing required
/// infrastructure. At the same time, it also adopts a familiar batch computing
/// software approach. Given these advantages, Batch can help you to efficiently
/// provision resources in response to jobs submitted, thus effectively helping
/// you to eliminate capacity constraints, reduce compute costs, and deliver
/// your results more quickly.
class Batch {
  final _s.RestJsonProtocol _protocol;
  Batch({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.AwsClientCredentialsProvider? credentialsProvider,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.RestJsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'batch',
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

  /// Cancels a job in an Batch job queue. Jobs that are in the
  /// <code>SUBMITTED</code>, <code>PENDING</code>, or <code>RUNNABLE</code>
  /// state are canceled. Jobs that have progressed to <code>STARTING</code> or
  /// <code>RUNNING</code> aren't canceled, but the API operation still
  /// succeeds, even if no job is canceled. These jobs must be terminated with
  /// the <a>TerminateJob</a> operation.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [jobId] :
  /// The Batch job ID of the job to cancel.
  ///
  /// Parameter [reason] :
  /// A message to attach to the job that explains the reason for canceling it.
  /// This message is returned by future <a>DescribeJobs</a> operations on the
  /// job. This message is also recorded in the Batch activity logs.
  Future<void> cancelJob({
    required String jobId,
    required String reason,
  }) async {
    ArgumentError.checkNotNull(jobId, 'jobId');
    ArgumentError.checkNotNull(reason, 'reason');
    final $payload = <String, dynamic>{
      'jobId': jobId,
      'reason': reason,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/canceljob',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Creates an Batch compute environment. You can create <code>MANAGED</code>
  /// or <code>UNMANAGED</code> compute environments. <code>MANAGED</code>
  /// compute environments can use Amazon EC2 or Fargate resources.
  /// <code>UNMANAGED</code> compute environments can only use EC2 resources.
  ///
  /// In a managed compute environment, Batch manages the capacity and instance
  /// types of the compute resources within the environment. This is based on
  /// the compute resource specification that you define or the <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html">launch
  /// template</a> that you specify when you create the compute environment.
  /// Either, you can choose to use EC2 On-Demand Instances and EC2 Spot
  /// Instances. Or, you can use Fargate and Fargate Spot capacity in your
  /// managed compute environment. You can optionally set a maximum price so
  /// that Spot Instances only launch when the Spot Instance price is less than
  /// a specified percentage of the On-Demand price.
  /// <note>
  /// Multi-node parallel jobs aren't supported on Spot Instances.
  /// </note>
  /// In an unmanaged compute environment, you can manage your own EC2 compute
  /// resources and have a lot of flexibility with how you configure your
  /// compute resources. For example, you can use custom AMIs. However, you must
  /// verify that each of your AMIs meet the Amazon ECS container instance AMI
  /// specification. For more information, see <a
  /// href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/container_instance_AMIs.html">container
  /// instance AMIs</a> in the <i>Amazon Elastic Container Service Developer
  /// Guide</i>. After you created your unmanaged compute environment, you can
  /// use the <a>DescribeComputeEnvironments</a> operation to find the Amazon
  /// ECS cluster that's associated with it. Then, launch your container
  /// instances into that Amazon ECS cluster. For more information, see <a
  /// href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_container_instance.html">Launching
  /// an Amazon ECS container instance</a> in the <i>Amazon Elastic Container
  /// Service Developer Guide</i>.
  /// <note>
  /// Batch doesn't automatically upgrade the AMIs in a compute environment
  /// after it's created. For example, it also doesn't update the AMIs in your
  /// compute environment when a newer version of the Amazon ECS optimized AMI
  /// is available. You're responsible for the management of the guest operating
  /// system. This includes any updates and security patches. You're also
  /// responsible for any additional application software or utilities that you
  /// install on the compute resources. There are two ways to use a new AMI for
  /// your Batch jobs. The original method is to complete these steps:
  /// <ol>
  /// <li>
  /// Create a new compute environment with the new AMI.
  /// </li>
  /// <li>
  /// Add the compute environment to an existing job queue.
  /// </li>
  /// <li>
  /// Remove the earlier compute environment from your job queue.
  /// </li>
  /// <li>
  /// Delete the earlier compute environment.
  /// </li> </ol>
  /// In April 2022, Batch added enhanced support for updating compute
  /// environments. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a>. To use the enhanced updating of compute
  /// environments to update AMIs, follow these rules:
  ///
  /// <ul>
  /// <li>
  /// Either do not set the service role (<code>serviceRole</code>) parameter or
  /// set it to the <b>AWSBatchServiceRole</b> service-linked role.
  /// </li>
  /// <li>
  /// Set the allocation strategy (<code>allocationStrategy</code>) parameter to
  /// <code>BEST_FIT_PROGRESSIVE</code> or <code>SPOT_CAPACITY_OPTIMIZED</code>.
  /// </li>
  /// <li>
  /// Set the update to latest image version
  /// (<code>updateToLatestImageVersion</code>) parameter to <code>true</code>.
  /// </li>
  /// <li>
  /// Do not specify an AMI ID in <code>imageId</code>,
  /// <code>imageIdOverride</code> (in <a
  /// href="https://docs.aws.amazon.com/batch/latest/APIReference/API_Ec2Configuration.html">
  /// <code>ec2Configuration</code> </a>), or in the launch template
  /// (<code>launchTemplate</code>). In that case Batch will select the latest
  /// Amazon ECS optimized AMI supported by Batch at the time the infrastructure
  /// update is initiated. Alternatively you can specify the AMI ID in the
  /// <code>imageId</code> or <code>imageIdOverride</code> parameters, or the
  /// launch template identified by the <code>LaunchTemplate</code> properties.
  /// Changing any of these properties will trigger an infrastructure update. If
  /// the AMI ID is specified in the launch template, it can not be replaced by
  /// specifying an AMI ID in either the <code>imageId</code> or
  /// <code>imageIdOverride</code> parameters. It can only be replaced by
  /// specifying a different launch template, or if the launch template version
  /// is set to <code>$Default</code> or <code>$Latest</code>, by setting either
  /// a new default version for the launch template (if <code>$Default</code>)or
  /// by adding a new version to the launch template (if <code>$Latest</code>).
  /// </li>
  /// </ul>
  /// If these rules are followed, any update that triggers an infrastructure
  /// update will cause the AMI ID to be re-selected. If the
  /// <code>version</code> setting in the launch template
  /// (<code>launchTemplate</code>) is set to <code>$Latest</code> or
  /// <code>$Default</code>, the latest or default version of the launch
  /// template will be evaluated up at the time of the infrastructure update,
  /// even if the <code>launchTemplate</code> was not updated.
  /// </note>
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [computeEnvironmentName] :
  /// The name for your compute environment. It can be up to 128 letters long.
  /// It can contain uppercase and lowercase letters, numbers, hyphens (-), and
  /// underscores (_).
  ///
  /// Parameter [type] :
  /// The type of the compute environment: <code>MANAGED</code> or
  /// <code>UNMANAGED</code>. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/compute_environments.html">Compute
  /// Environments</a> in the <i>Batch User Guide</i>.
  ///
  /// Parameter [computeResources] :
  /// Details about the compute resources managed by the compute environment.
  /// This parameter is required for managed compute environments. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/compute_environments.html">Compute
  /// Environments</a> in the <i>Batch User Guide</i>.
  ///
  /// Parameter [serviceRole] :
  /// The full Amazon Resource Name (ARN) of the IAM role that allows Batch to
  /// make calls to other Amazon Web Services services on your behalf. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/service_IAM_role.html">Batch
  /// service IAM role</a> in the <i>Batch User Guide</i>.
  /// <important>
  /// If your account already created the Batch service-linked role, that role
  /// is used by default for your compute environment unless you specify a
  /// different role here. If the Batch service-linked role doesn't exist in
  /// your account, and no role is specified here, the service attempts to
  /// create the Batch service-linked role in your account.
  /// </important>
  /// If your specified role has a path other than <code>/</code>, then you must
  /// specify either the full role ARN (recommended) or prefix the role name
  /// with the path. For example, if a role with the name <code>bar</code> has a
  /// path of <code>/foo/</code> then you would specify <code>/foo/bar</code> as
  /// the role name. For more information, see <a
  /// href="https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-friendly-names">Friendly
  /// names and paths</a> in the <i>IAM User Guide</i>.
  /// <note>
  /// Depending on how you created your Batch service role, its ARN might
  /// contain the <code>service-role</code> path prefix. When you only specify
  /// the name of the service role, Batch assumes that your ARN doesn't use the
  /// <code>service-role</code> path prefix. Because of this, we recommend that
  /// you specify the full ARN of your service role when you create compute
  /// environments.
  /// </note>
  ///
  /// Parameter [state] :
  /// The state of the compute environment. If the state is
  /// <code>ENABLED</code>, then the compute environment accepts jobs from a
  /// queue and can scale out automatically based on queues.
  ///
  /// If the state is <code>ENABLED</code>, then the Batch scheduler can attempt
  /// to place jobs from an associated job queue on the compute resources within
  /// the environment. If the compute environment is managed, then it can scale
  /// its instances out or in automatically, based on the job queue demand.
  ///
  /// If the state is <code>DISABLED</code>, then the Batch scheduler doesn't
  /// attempt to place jobs within the environment. Jobs in a
  /// <code>STARTING</code> or <code>RUNNING</code> state continue to progress
  /// normally. Managed compute environments in the <code>DISABLED</code> state
  /// don't scale out. However, they scale in to <code>minvCpus</code> value
  /// after instances become idle.
  ///
  /// Parameter [tags] :
  /// The tags that you apply to the compute environment to help you categorize
  /// and organize your resources. Each tag consists of a key and an optional
  /// value. For more information, see <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html">Tagging
  /// Amazon Web Services Resources</a> in <i>Amazon Web Services General
  /// Reference</i>.
  ///
  /// These tags can be updated or removed using the <a
  /// href="https://docs.aws.amazon.com/batch/latest/APIReference/API_TagResource.html">TagResource</a>
  /// and <a
  /// href="https://docs.aws.amazon.com/batch/latest/APIReference/API_UntagResource.html">UntagResource</a>
  /// API operations. These tags don't propagate to the underlying compute
  /// resources.
  ///
  /// Parameter [unmanagedvCpus] :
  /// The maximum number of vCPUs for an unmanaged compute environment. This
  /// parameter is only used for fair share scheduling to reserve vCPU capacity
  /// for new share identifiers. If this parameter isn't provided for a fair
  /// share job queue, no vCPU capacity is reserved.
  /// <note>
  /// This parameter is only supported when the <code>type</code> parameter is
  /// set to <code>UNMANAGED</code>.
  /// </note>
  Future<CreateComputeEnvironmentResponse> createComputeEnvironment({
    required String computeEnvironmentName,
    required CEType type,
    ComputeResource? computeResources,
    String? serviceRole,
    CEState? state,
    Map<String, String>? tags,
    int? unmanagedvCpus,
  }) async {
    ArgumentError.checkNotNull(
        computeEnvironmentName, 'computeEnvironmentName');
    ArgumentError.checkNotNull(type, 'type');
    final $payload = <String, dynamic>{
      'computeEnvironmentName': computeEnvironmentName,
      'type': type.toValue(),
      if (computeResources != null) 'computeResources': computeResources,
      if (serviceRole != null) 'serviceRole': serviceRole,
      if (state != null) 'state': state.toValue(),
      if (tags != null) 'tags': tags,
      if (unmanagedvCpus != null) 'unmanagedvCpus': unmanagedvCpus,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/createcomputeenvironment',
      exceptionFnMap: _exceptionFns,
    );
    return CreateComputeEnvironmentResponse.fromJson(response);
  }

  /// Creates an Batch job queue. When you create a job queue, you associate one
  /// or more compute environments to the queue and assign an order of
  /// preference for the compute environments.
  ///
  /// You also set a priority to the job queue that determines the order that
  /// the Batch scheduler places jobs onto its associated compute environments.
  /// For example, if a compute environment is associated with more than one job
  /// queue, the job queue with a higher priority is given preference for
  /// scheduling jobs to that compute environment.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [computeEnvironmentOrder] :
  /// The set of compute environments mapped to a job queue and their order
  /// relative to each other. The job scheduler uses this parameter to determine
  /// which compute environment runs a specific job. Compute environments must
  /// be in the <code>VALID</code> state before you can associate them with a
  /// job queue. You can associate up to three compute environments with a job
  /// queue. All of the compute environments must be either EC2
  /// (<code>EC2</code> or <code>SPOT</code>) or Fargate (<code>FARGATE</code>
  /// or <code>FARGATE_SPOT</code>); EC2 and Fargate compute environments can't
  /// be mixed.
  /// <note>
  /// All compute environments that are associated with a job queue must share
  /// the same architecture. Batch doesn't support mixing compute environment
  /// architecture types in a single job queue.
  /// </note>
  ///
  /// Parameter [jobQueueName] :
  /// The name of the job queue. It can be up to 128 letters long. It can
  /// contain uppercase and lowercase letters, numbers, hyphens (-), and
  /// underscores (_).
  ///
  /// Parameter [priority] :
  /// The priority of the job queue. Job queues with a higher priority (or a
  /// higher integer value for the <code>priority</code> parameter) are
  /// evaluated first when associated with the same compute environment.
  /// Priority is determined in descending order. For example, a job queue with
  /// a priority value of <code>10</code> is given scheduling preference over a
  /// job queue with a priority value of <code>1</code>. All of the compute
  /// environments must be either EC2 (<code>EC2</code> or <code>SPOT</code>) or
  /// Fargate (<code>FARGATE</code> or <code>FARGATE_SPOT</code>); EC2 and
  /// Fargate compute environments can't be mixed.
  ///
  /// Parameter [schedulingPolicyArn] :
  /// The Amazon Resource Name (ARN) of the fair share scheduling policy. If
  /// this parameter is specified, the job queue uses a fair share scheduling
  /// policy. If this parameter isn't specified, the job queue uses a first in,
  /// first out (FIFO) scheduling policy. After a job queue is created, you can
  /// replace but can't remove the fair share scheduling policy. The format is
  /// <code>aws:<i>Partition</i>:batch:<i>Region</i>:<i>Account</i>:scheduling-policy/<i>Name</i>
  /// </code>. An example is
  /// <code>aws:aws:batch:us-west-2:012345678910:scheduling-policy/MySchedulingPolicy</code>.
  ///
  /// Parameter [state] :
  /// The state of the job queue. If the job queue state is
  /// <code>ENABLED</code>, it is able to accept jobs. If the job queue state is
  /// <code>DISABLED</code>, new jobs can't be added to the queue, but jobs
  /// already in the queue can finish.
  ///
  /// Parameter [tags] :
  /// The tags that you apply to the job queue to help you categorize and
  /// organize your resources. Each tag consists of a key and an optional value.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/using-tags.html">Tagging
  /// your Batch resources</a> in <i>Batch User Guide</i>.
  Future<CreateJobQueueResponse> createJobQueue({
    required List<ComputeEnvironmentOrder> computeEnvironmentOrder,
    required String jobQueueName,
    required int priority,
    String? schedulingPolicyArn,
    JQState? state,
    Map<String, String>? tags,
  }) async {
    ArgumentError.checkNotNull(
        computeEnvironmentOrder, 'computeEnvironmentOrder');
    ArgumentError.checkNotNull(jobQueueName, 'jobQueueName');
    ArgumentError.checkNotNull(priority, 'priority');
    final $payload = <String, dynamic>{
      'computeEnvironmentOrder': computeEnvironmentOrder,
      'jobQueueName': jobQueueName,
      'priority': priority,
      if (schedulingPolicyArn != null)
        'schedulingPolicyArn': schedulingPolicyArn,
      if (state != null) 'state': state.toValue(),
      if (tags != null) 'tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/createjobqueue',
      exceptionFnMap: _exceptionFns,
    );
    return CreateJobQueueResponse.fromJson(response);
  }

  /// Creates an Batch scheduling policy.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [name] :
  /// The name of the scheduling policy. It can be up to 128 letters long. It
  /// can contain uppercase and lowercase letters, numbers, hyphens (-), and
  /// underscores (_).
  ///
  /// Parameter [fairsharePolicy] :
  /// The fair share policy of the scheduling policy.
  ///
  /// Parameter [tags] :
  /// The tags that you apply to the scheduling policy to help you categorize
  /// and organize your resources. Each tag consists of a key and an optional
  /// value. For more information, see <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html">Tagging
  /// Amazon Web Services Resources</a> in <i>Amazon Web Services General
  /// Reference</i>.
  ///
  /// These tags can be updated or removed using the <a
  /// href="https://docs.aws.amazon.com/batch/latest/APIReference/API_TagResource.html">TagResource</a>
  /// and <a
  /// href="https://docs.aws.amazon.com/batch/latest/APIReference/API_UntagResource.html">UntagResource</a>
  /// API operations.
  Future<CreateSchedulingPolicyResponse> createSchedulingPolicy({
    required String name,
    FairsharePolicy? fairsharePolicy,
    Map<String, String>? tags,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    final $payload = <String, dynamic>{
      'name': name,
      if (fairsharePolicy != null) 'fairsharePolicy': fairsharePolicy,
      if (tags != null) 'tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/createschedulingpolicy',
      exceptionFnMap: _exceptionFns,
    );
    return CreateSchedulingPolicyResponse.fromJson(response);
  }

  /// Deletes an Batch compute environment.
  ///
  /// Before you can delete a compute environment, you must set its state to
  /// <code>DISABLED</code> with the <a>UpdateComputeEnvironment</a> API
  /// operation and disassociate it from any job queues with the
  /// <a>UpdateJobQueue</a> API operation. Compute environments that use Fargate
  /// resources must terminate all active jobs on that compute environment
  /// before deleting the compute environment. If this isn't done, the compute
  /// environment enters an invalid state.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [computeEnvironment] :
  /// The name or Amazon Resource Name (ARN) of the compute environment to
  /// delete.
  Future<void> deleteComputeEnvironment({
    required String computeEnvironment,
  }) async {
    ArgumentError.checkNotNull(computeEnvironment, 'computeEnvironment');
    final $payload = <String, dynamic>{
      'computeEnvironment': computeEnvironment,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/deletecomputeenvironment',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes the specified job queue. You must first disable submissions for a
  /// queue with the <a>UpdateJobQueue</a> operation. All jobs in the queue are
  /// eventually terminated when you delete a job queue. The jobs are terminated
  /// at a rate of about 16 jobs each second.
  ///
  /// It's not necessary to disassociate compute environments from a queue
  /// before submitting a <code>DeleteJobQueue</code> request.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [jobQueue] :
  /// The short name or full Amazon Resource Name (ARN) of the queue to delete.
  Future<void> deleteJobQueue({
    required String jobQueue,
  }) async {
    ArgumentError.checkNotNull(jobQueue, 'jobQueue');
    final $payload = <String, dynamic>{
      'jobQueue': jobQueue,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/deletejobqueue',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes the specified scheduling policy.
  ///
  /// You can't delete a scheduling policy that's used in any job queues.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [arn] :
  /// The Amazon Resource Name (ARN) of the scheduling policy to delete.
  Future<void> deleteSchedulingPolicy({
    required String arn,
  }) async {
    ArgumentError.checkNotNull(arn, 'arn');
    final $payload = <String, dynamic>{
      'arn': arn,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/deleteschedulingpolicy',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deregisters an Batch job definition. Job definitions are permanently
  /// deleted after 180 days.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [jobDefinition] :
  /// The name and revision (<code>name:revision</code>) or full Amazon Resource
  /// Name (ARN) of the job definition to deregister.
  Future<void> deregisterJobDefinition({
    required String jobDefinition,
  }) async {
    ArgumentError.checkNotNull(jobDefinition, 'jobDefinition');
    final $payload = <String, dynamic>{
      'jobDefinition': jobDefinition,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/deregisterjobdefinition',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Describes one or more of your compute environments.
  ///
  /// If you're using an unmanaged compute environment, you can use the
  /// <code>DescribeComputeEnvironment</code> operation to determine the
  /// <code>ecsClusterArn</code> that you launch your Amazon ECS container
  /// instances into.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [computeEnvironments] :
  /// A list of up to 100 compute environment names or full Amazon Resource Name
  /// (ARN) entries.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of cluster results returned by
  /// <code>DescribeComputeEnvironments</code> in paginated output. When this
  /// parameter is used, <code>DescribeComputeEnvironments</code> only returns
  /// <code>maxResults</code> results in a single page along with a
  /// <code>nextToken</code> response element. The remaining results of the
  /// initial request can be seen by sending another
  /// <code>DescribeComputeEnvironments</code> request with the returned
  /// <code>nextToken</code> value. This value can be between 1 and 100. If this
  /// parameter isn't used, then <code>DescribeComputeEnvironments</code>
  /// returns up to 100 results and a <code>nextToken</code> value if
  /// applicable.
  ///
  /// Parameter [nextToken] :
  /// The <code>nextToken</code> value returned from a previous paginated
  /// <code>DescribeComputeEnvironments</code> request where
  /// <code>maxResults</code> was used and the results exceeded the value of
  /// that parameter. Pagination continues from the end of the previous results
  /// that returned the <code>nextToken</code> value. This value is
  /// <code>null</code> when there are no more results to return.
  /// <note>
  /// This token should be treated as an opaque identifier that's only used to
  /// retrieve the next items in a list and not for other programmatic purposes.
  /// </note>
  Future<DescribeComputeEnvironmentsResponse> describeComputeEnvironments({
    List<String>? computeEnvironments,
    int? maxResults,
    String? nextToken,
  }) async {
    final $payload = <String, dynamic>{
      if (computeEnvironments != null)
        'computeEnvironments': computeEnvironments,
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/describecomputeenvironments',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeComputeEnvironmentsResponse.fromJson(response);
  }

  /// Describes a list of job definitions. You can specify a <code>status</code>
  /// (such as <code>ACTIVE</code>) to only return job definitions that match
  /// that status.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [jobDefinitionName] :
  /// The name of the job definition to describe.
  ///
  /// Parameter [jobDefinitions] :
  /// A list of up to 100 job definitions. Each entry in the list can either be
  /// an ARN in the format
  /// <code>arn:aws:batch:${Region}:${Account}:job-definition/${JobDefinitionName}:${Revision}</code>
  /// or a short version using the form
  /// <code>${JobDefinitionName}:${Revision}</code>.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of results returned by
  /// <code>DescribeJobDefinitions</code> in paginated output. When this
  /// parameter is used, <code>DescribeJobDefinitions</code> only returns
  /// <code>maxResults</code> results in a single page and a
  /// <code>nextToken</code> response element. The remaining results of the
  /// initial request can be seen by sending another
  /// <code>DescribeJobDefinitions</code> request with the returned
  /// <code>nextToken</code> value. This value can be between 1 and 100. If this
  /// parameter isn't used, then <code>DescribeJobDefinitions</code> returns up
  /// to 100 results and a <code>nextToken</code> value if applicable.
  ///
  /// Parameter [nextToken] :
  /// The <code>nextToken</code> value returned from a previous paginated
  /// <code>DescribeJobDefinitions</code> request where <code>maxResults</code>
  /// was used and the results exceeded the value of that parameter. Pagination
  /// continues from the end of the previous results that returned the
  /// <code>nextToken</code> value. This value is <code>null</code> when there
  /// are no more results to return.
  /// <note>
  /// This token should be treated as an opaque identifier that's only used to
  /// retrieve the next items in a list and not for other programmatic purposes.
  /// </note>
  ///
  /// Parameter [status] :
  /// The status used to filter job definitions.
  Future<DescribeJobDefinitionsResponse> describeJobDefinitions({
    String? jobDefinitionName,
    List<String>? jobDefinitions,
    int? maxResults,
    String? nextToken,
    String? status,
  }) async {
    final $payload = <String, dynamic>{
      if (jobDefinitionName != null) 'jobDefinitionName': jobDefinitionName,
      if (jobDefinitions != null) 'jobDefinitions': jobDefinitions,
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
      if (status != null) 'status': status,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/describejobdefinitions',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeJobDefinitionsResponse.fromJson(response);
  }

  /// Describes one or more of your job queues.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [jobQueues] :
  /// A list of up to 100 queue names or full queue Amazon Resource Name (ARN)
  /// entries.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of results returned by <code>DescribeJobQueues</code>
  /// in paginated output. When this parameter is used,
  /// <code>DescribeJobQueues</code> only returns <code>maxResults</code>
  /// results in a single page and a <code>nextToken</code> response element.
  /// The remaining results of the initial request can be seen by sending
  /// another <code>DescribeJobQueues</code> request with the returned
  /// <code>nextToken</code> value. This value can be between 1 and 100. If this
  /// parameter isn't used, then <code>DescribeJobQueues</code> returns up to
  /// 100 results and a <code>nextToken</code> value if applicable.
  ///
  /// Parameter [nextToken] :
  /// The <code>nextToken</code> value returned from a previous paginated
  /// <code>DescribeJobQueues</code> request where <code>maxResults</code> was
  /// used and the results exceeded the value of that parameter. Pagination
  /// continues from the end of the previous results that returned the
  /// <code>nextToken</code> value. This value is <code>null</code> when there
  /// are no more results to return.
  /// <note>
  /// This token should be treated as an opaque identifier that's only used to
  /// retrieve the next items in a list and not for other programmatic purposes.
  /// </note>
  Future<DescribeJobQueuesResponse> describeJobQueues({
    List<String>? jobQueues,
    int? maxResults,
    String? nextToken,
  }) async {
    final $payload = <String, dynamic>{
      if (jobQueues != null) 'jobQueues': jobQueues,
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/describejobqueues',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeJobQueuesResponse.fromJson(response);
  }

  /// Describes a list of Batch jobs.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [jobs] :
  /// A list of up to 100 job IDs.
  Future<DescribeJobsResponse> describeJobs({
    required List<String> jobs,
  }) async {
    ArgumentError.checkNotNull(jobs, 'jobs');
    final $payload = <String, dynamic>{
      'jobs': jobs,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/describejobs',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeJobsResponse.fromJson(response);
  }

  /// Describes one or more of your scheduling policies.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [arns] :
  /// A list of up to 100 scheduling policy Amazon Resource Name (ARN) entries.
  Future<DescribeSchedulingPoliciesResponse> describeSchedulingPolicies({
    required List<String> arns,
  }) async {
    ArgumentError.checkNotNull(arns, 'arns');
    final $payload = <String, dynamic>{
      'arns': arns,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/describeschedulingpolicies',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeSchedulingPoliciesResponse.fromJson(response);
  }

  /// Returns a list of Batch jobs.
  ///
  /// You must specify only one of the following items:
  ///
  /// <ul>
  /// <li>
  /// A job queue ID to return a list of jobs in that job queue
  /// </li>
  /// <li>
  /// A multi-node parallel job ID to return a list of nodes for that job
  /// </li>
  /// <li>
  /// An array job ID to return a list of the children for that job
  /// </li>
  /// </ul>
  /// You can filter the results by job status with the <code>jobStatus</code>
  /// parameter. If you don't specify a status, only <code>RUNNING</code> jobs
  /// are returned.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [arrayJobId] :
  /// The job ID for an array job. Specifying an array job ID with this
  /// parameter lists all child jobs from within the specified array.
  ///
  /// Parameter [filters] :
  /// The filter to apply to the query. Only one filter can be used at a time.
  /// When the filter is used, <code>jobStatus</code> is ignored. The filter
  /// doesn't apply to child jobs in an array or multi-node parallel (MNP) jobs.
  /// The results are sorted by the <code>createdAt</code> field, with the most
  /// recent jobs being first.
  /// <dl> <dt>JOB_NAME</dt> <dd>
  /// The value of the filter is a case-insensitive match for the job name. If
  /// the value ends with an asterisk (*), the filter will match any job name
  /// that begins with the string before the '*'. This corresponds to the
  /// <code>jobName</code> value. For example, <code>test1</code> matches both
  /// <code>Test1</code> and <code>test1</code>, and <code>test1*</code> matches
  /// both <code>test1</code> and <code>Test10</code>. When the
  /// <code>JOB_NAME</code> filter is used, the results are grouped by the job
  /// name and version.
  /// </dd> <dt>JOB_DEFINITION</dt> <dd>
  /// The value for the filter is the name or Amazon Resource Name (ARN) of the
  /// job definition. This corresponds to the <code>jobDefinition</code> value.
  /// The value is case sensitive. When the value for the filter is the job
  /// definition name, the results include all the jobs that used any revision
  /// of that job definition name. If the value ends with an asterisk (*), the
  /// filter will match any job definition name that begins with the string
  /// before the '*'. For example, <code>jd1</code> matches only
  /// <code>jd1</code>, and <code>jd1*</code> matches both <code>jd1</code> and
  /// <code>jd1A</code>. The version of the job definition that's used doesn't
  /// affect the sort order. When the <code>JOB_DEFINITION</code> filter is used
  /// and the ARN is used (which is in the form
  /// <code>arn:${Partition}:batch:${Region}:${Account}:job-definition/${JobDefinitionName}:${Revision}</code>),
  /// the results include jobs that used the specified revision of the job
  /// definition. Asterisk (*) is not supported when the ARN is used.
  /// </dd> <dt>BEFORE_CREATED_AT</dt> <dd>
  /// The value for the filter is the time that's before the job was created.
  /// This corresponds to the <code>createdAt</code> value. The value is a
  /// string representation of the number of milliseconds since 00:00:00 UTC
  /// (midnight) on January 1, 1970.
  /// </dd> <dt>AFTER_CREATED_AT</dt> <dd>
  /// The value for the filter is the time that's after the job was created.
  /// This corresponds to the <code>createdAt</code> value. The value is a
  /// string representation of the number of milliseconds since 00:00:00 UTC
  /// (midnight) on January 1, 1970.
  /// </dd> </dl>
  ///
  /// Parameter [jobQueue] :
  /// The name or full Amazon Resource Name (ARN) of the job queue used to list
  /// jobs.
  ///
  /// Parameter [jobStatus] :
  /// The job status used to filter jobs in the specified queue. If the
  /// <code>filters</code> parameter is specified, the <code>jobStatus</code>
  /// parameter is ignored and jobs with any status are returned. If you don't
  /// specify a status, only <code>RUNNING</code> jobs are returned.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of results returned by <code>ListJobs</code> in
  /// paginated output. When this parameter is used, <code>ListJobs</code> only
  /// returns <code>maxResults</code> results in a single page and a
  /// <code>nextToken</code> response element. The remaining results of the
  /// initial request can be seen by sending another <code>ListJobs</code>
  /// request with the returned <code>nextToken</code> value. This value can be
  /// between 1 and 100. If this parameter isn't used, then
  /// <code>ListJobs</code> returns up to 100 results and a
  /// <code>nextToken</code> value if applicable.
  ///
  /// Parameter [multiNodeJobId] :
  /// The job ID for a multi-node parallel job. Specifying a multi-node parallel
  /// job ID with this parameter lists all nodes that are associated with the
  /// specified job.
  ///
  /// Parameter [nextToken] :
  /// The <code>nextToken</code> value returned from a previous paginated
  /// <code>ListJobs</code> request where <code>maxResults</code> was used and
  /// the results exceeded the value of that parameter. Pagination continues
  /// from the end of the previous results that returned the
  /// <code>nextToken</code> value. This value is <code>null</code> when there
  /// are no more results to return.
  /// <note>
  /// This token should be treated as an opaque identifier that's only used to
  /// retrieve the next items in a list and not for other programmatic purposes.
  /// </note>
  Future<ListJobsResponse> listJobs({
    String? arrayJobId,
    List<KeyValuesPair>? filters,
    String? jobQueue,
    JobStatus? jobStatus,
    int? maxResults,
    String? multiNodeJobId,
    String? nextToken,
  }) async {
    final $payload = <String, dynamic>{
      if (arrayJobId != null) 'arrayJobId': arrayJobId,
      if (filters != null) 'filters': filters,
      if (jobQueue != null) 'jobQueue': jobQueue,
      if (jobStatus != null) 'jobStatus': jobStatus.toValue(),
      if (maxResults != null) 'maxResults': maxResults,
      if (multiNodeJobId != null) 'multiNodeJobId': multiNodeJobId,
      if (nextToken != null) 'nextToken': nextToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/listjobs',
      exceptionFnMap: _exceptionFns,
    );
    return ListJobsResponse.fromJson(response);
  }

  /// Returns a list of Batch scheduling policies.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [maxResults] :
  /// The maximum number of results that's returned by
  /// <code>ListSchedulingPolicies</code> in paginated output. When this
  /// parameter is used, <code>ListSchedulingPolicies</code> only returns
  /// <code>maxResults</code> results in a single page and a
  /// <code>nextToken</code> response element. You can see the remaining results
  /// of the initial request by sending another
  /// <code>ListSchedulingPolicies</code> request with the returned
  /// <code>nextToken</code> value. This value can be between 1 and 100. If this
  /// parameter isn't used, <code>ListSchedulingPolicies</code> returns up to
  /// 100 results and a <code>nextToken</code> value if applicable.
  ///
  /// Parameter [nextToken] :
  /// The <code>nextToken</code> value that's returned from a previous paginated
  /// <code>ListSchedulingPolicies</code> request where <code>maxResults</code>
  /// was used and the results exceeded the value of that parameter. Pagination
  /// continues from the end of the previous results that returned the
  /// <code>nextToken</code> value. This value is <code>null</code> when there
  /// are no more results to return.
  /// <note>
  /// This token should be treated as an opaque identifier that's only used to
  /// retrieve the next items in a list and not for other programmatic purposes.
  /// </note>
  Future<ListSchedulingPoliciesResponse> listSchedulingPolicies({
    int? maxResults,
    String? nextToken,
  }) async {
    final $payload = <String, dynamic>{
      if (maxResults != null) 'maxResults': maxResults,
      if (nextToken != null) 'nextToken': nextToken,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/listschedulingpolicies',
      exceptionFnMap: _exceptionFns,
    );
    return ListSchedulingPoliciesResponse.fromJson(response);
  }

  /// Lists the tags for an Batch resource. Batch resources that support tags
  /// are compute environments, jobs, job definitions, job queues, and
  /// scheduling policies. ARNs for child jobs of array and multi-node parallel
  /// (MNP) jobs are not supported.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [resourceArn] :
  /// The Amazon Resource Name (ARN) that identifies the resource that tags are
  /// listed for. Batch resources that support tags are compute environments,
  /// jobs, job definitions, job queues, and scheduling policies. ARNs for child
  /// jobs of array and multi-node parallel (MNP) jobs are not supported.
  Future<ListTagsForResourceResponse> listTagsForResource({
    required String resourceArn,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/v1/tags/${Uri.encodeComponent(resourceArn)}',
      exceptionFnMap: _exceptionFns,
    );
    return ListTagsForResourceResponse.fromJson(response);
  }

  /// Registers an Batch job definition.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [jobDefinitionName] :
  /// The name of the job definition to register. It can be up to 128 letters
  /// long. It can contain uppercase and lowercase letters, numbers, hyphens
  /// (-), and underscores (_).
  ///
  /// Parameter [type] :
  /// The type of job definition. For more information about multi-node parallel
  /// jobs, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/multi-node-job-def.html">Creating
  /// a multi-node parallel job definition</a> in the <i>Batch User Guide</i>.
  /// <note>
  /// If the job is run on Fargate resources, then <code>multinode</code> isn't
  /// supported.
  /// </note>
  ///
  /// Parameter [containerProperties] :
  /// An object with various properties specific to single-node container-based
  /// jobs. If the job definition's <code>type</code> parameter is
  /// <code>container</code>, then you must specify either
  /// <code>containerProperties</code> or <code>nodeProperties</code>.
  /// <note>
  /// If the job runs on Fargate resources, then you must not specify
  /// <code>nodeProperties</code>; use only <code>containerProperties</code>.
  /// </note>
  ///
  /// Parameter [nodeProperties] :
  /// An object with various properties specific to multi-node parallel jobs. If
  /// you specify node properties for a job, it becomes a multi-node parallel
  /// job. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/multi-node-parallel-jobs.html">Multi-node
  /// Parallel Jobs</a> in the <i>Batch User Guide</i>. If the job definition's
  /// <code>type</code> parameter is <code>container</code>, then you must
  /// specify either <code>containerProperties</code> or
  /// <code>nodeProperties</code>.
  /// <note>
  /// If the job runs on Fargate resources, then you must not specify
  /// <code>nodeProperties</code>; use <code>containerProperties</code> instead.
  /// </note>
  ///
  /// Parameter [parameters] :
  /// Default parameter substitution placeholders to set in the job definition.
  /// Parameters are specified as a key-value pair mapping. Parameters in a
  /// <code>SubmitJob</code> request override any corresponding parameter
  /// defaults from the job definition.
  ///
  /// Parameter [platformCapabilities] :
  /// The platform capabilities required by the job definition. If no value is
  /// specified, it defaults to <code>EC2</code>. To run the job on Fargate
  /// resources, specify <code>FARGATE</code>.
  ///
  /// Parameter [propagateTags] :
  /// Specifies whether to propagate the tags from the job or job definition to
  /// the corresponding Amazon ECS task. If no value is specified, the tags are
  /// not propagated. Tags can only be propagated to the tasks during task
  /// creation. For tags with the same name, job tags are given priority over
  /// job definitions tags. If the total number of combined tags from the job
  /// and job definition is over 50, the job is moved to the <code>FAILED</code>
  /// state.
  ///
  /// Parameter [retryStrategy] :
  /// The retry strategy to use for failed jobs that are submitted with this job
  /// definition. Any retry strategy that's specified during a <a>SubmitJob</a>
  /// operation overrides the retry strategy defined here. If a job is
  /// terminated due to a timeout, it isn't retried.
  ///
  /// Parameter [schedulingPriority] :
  /// The scheduling priority for jobs that are submitted with this job
  /// definition. This will only affect jobs in job queues with a fair share
  /// policy. Jobs with a higher scheduling priority will be scheduled before
  /// jobs with a lower scheduling priority.
  ///
  /// The minimum supported value is 0 and the maximum supported value is 9999.
  ///
  /// Parameter [tags] :
  /// The tags that you apply to the job definition to help you categorize and
  /// organize your resources. Each tag consists of a key and an optional value.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/using-tags.html">Tagging
  /// Amazon Web Services Resources</a> in <i>Batch User Guide</i>.
  ///
  /// Parameter [timeout] :
  /// The timeout configuration for jobs that are submitted with this job
  /// definition, after which Batch terminates your jobs if they have not
  /// finished. If a job is terminated due to a timeout, it isn't retried. The
  /// minimum value for the timeout is 60 seconds. Any timeout configuration
  /// that's specified during a <a>SubmitJob</a> operation overrides the timeout
  /// configuration defined here. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/job_timeouts.html">Job
  /// Timeouts</a> in the <i>Batch User Guide</i>.
  Future<RegisterJobDefinitionResponse> registerJobDefinition({
    required String jobDefinitionName,
    required JobDefinitionType type,
    ContainerProperties? containerProperties,
    NodeProperties? nodeProperties,
    Map<String, String>? parameters,
    List<PlatformCapability>? platformCapabilities,
    bool? propagateTags,
    RetryStrategy? retryStrategy,
    int? schedulingPriority,
    Map<String, String>? tags,
    JobTimeout? timeout,
  }) async {
    ArgumentError.checkNotNull(jobDefinitionName, 'jobDefinitionName');
    ArgumentError.checkNotNull(type, 'type');
    final $payload = <String, dynamic>{
      'jobDefinitionName': jobDefinitionName,
      'type': type.toValue(),
      if (containerProperties != null)
        'containerProperties': containerProperties,
      if (nodeProperties != null) 'nodeProperties': nodeProperties,
      if (parameters != null) 'parameters': parameters,
      if (platformCapabilities != null)
        'platformCapabilities':
            platformCapabilities.map((e) => e.toValue()).toList(),
      if (propagateTags != null) 'propagateTags': propagateTags,
      if (retryStrategy != null) 'retryStrategy': retryStrategy,
      if (schedulingPriority != null) 'schedulingPriority': schedulingPriority,
      if (tags != null) 'tags': tags,
      if (timeout != null) 'timeout': timeout,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/registerjobdefinition',
      exceptionFnMap: _exceptionFns,
    );
    return RegisterJobDefinitionResponse.fromJson(response);
  }

  /// Submits an Batch job from a job definition. Parameters that are specified
  /// during <a>SubmitJob</a> override parameters defined in the job definition.
  /// vCPU and memory requirements that are specified in the
  /// <code>resourceRequirements</code> objects in the job definition are the
  /// exception. They can't be overridden this way using the <code>memory</code>
  /// and <code>vcpus</code> parameters. Rather, you must specify updates to job
  /// definition parameters in a <code>resourceRequirements</code> object that's
  /// included in the <code>containerOverrides</code> parameter.
  /// <note>
  /// Job queues with a scheduling policy are limited to 500 active fair share
  /// identifiers at a time.
  /// </note> <important>
  /// Jobs that run on Fargate resources can't be guaranteed to run for more
  /// than 14 days. This is because, after 14 days, Fargate resources might
  /// become unavailable and job might be terminated.
  /// </important>
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [jobDefinition] :
  /// The job definition used by this job. This value can be one of
  /// <code>name</code>, <code>name:revision</code>, or the Amazon Resource Name
  /// (ARN) for the job definition. If <code>name</code> is specified without a
  /// revision then the latest active revision is used.
  ///
  /// Parameter [jobName] :
  /// The name of the job. It can be up to 128 letters long. The first character
  /// must be alphanumeric, can contain uppercase and lowercase letters,
  /// numbers, hyphens (-), and underscores (_).
  ///
  /// Parameter [jobQueue] :
  /// The job queue where the job is submitted. You can specify either the name
  /// or the Amazon Resource Name (ARN) of the queue.
  ///
  /// Parameter [arrayProperties] :
  /// The array properties for the submitted job, such as the size of the array.
  /// The array size can be between 2 and 10,000. If you specify array
  /// properties for a job, it becomes an array job. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/array_jobs.html">Array
  /// Jobs</a> in the <i>Batch User Guide</i>.
  ///
  /// Parameter [containerOverrides] :
  /// A list of container overrides in the JSON format that specify the name of
  /// a container in the specified job definition and the overrides it receives.
  /// You can override the default command for a container, which is specified
  /// in the job definition or the Docker image, with a <code>command</code>
  /// override. You can also override existing environment variables on a
  /// container or add new environment variables to it with an
  /// <code>environment</code> override.
  ///
  /// Parameter [dependsOn] :
  /// A list of dependencies for the job. A job can depend upon a maximum of 20
  /// jobs. You can specify a <code>SEQUENTIAL</code> type dependency without
  /// specifying a job ID for array jobs so that each child array job completes
  /// sequentially, starting at index 0. You can also specify an
  /// <code>N_TO_N</code> type dependency with a job ID for array jobs. In that
  /// case, each index child of this job must wait for the corresponding index
  /// child of each dependency to complete before it can begin.
  ///
  /// Parameter [nodeOverrides] :
  /// A list of node overrides in JSON format that specify the node range to
  /// target and the container overrides for that node range.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources; use <code>containerOverrides</code> instead.
  /// </note>
  ///
  /// Parameter [parameters] :
  /// Additional parameters passed to the job that replace parameter
  /// substitution placeholders that are set in the job definition. Parameters
  /// are specified as a key and value pair mapping. Parameters in a
  /// <code>SubmitJob</code> request override any corresponding parameter
  /// defaults from the job definition.
  ///
  /// Parameter [propagateTags] :
  /// Specifies whether to propagate the tags from the job or job definition to
  /// the corresponding Amazon ECS task. If no value is specified, the tags
  /// aren't propagated. Tags can only be propagated to the tasks during task
  /// creation. For tags with the same name, job tags are given priority over
  /// job definitions tags. If the total number of combined tags from the job
  /// and job definition is over 50, the job is moved to the <code>FAILED</code>
  /// state. When specified, this overrides the tag propagation setting in the
  /// job definition.
  ///
  /// Parameter [retryStrategy] :
  /// The retry strategy to use for failed jobs from this <a>SubmitJob</a>
  /// operation. When a retry strategy is specified here, it overrides the retry
  /// strategy defined in the job definition.
  ///
  /// Parameter [schedulingPriorityOverride] :
  /// The scheduling priority for the job. This will only affect jobs in job
  /// queues with a fair share policy. Jobs with a higher scheduling priority
  /// will be scheduled before jobs with a lower scheduling priority. This will
  /// override any scheduling priority in the job definition.
  ///
  /// The minimum supported value is 0 and the maximum supported value is 9999.
  ///
  /// Parameter [shareIdentifier] :
  /// The share identifier for the job. If the job queue does not have a
  /// scheduling policy, then this parameter must not be specified. If the job
  /// queue has a scheduling policy, then this parameter must be specified.
  ///
  /// Parameter [tags] :
  /// The tags that you apply to the job request to help you categorize and
  /// organize your resources. Each tag consists of a key and an optional value.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html">Tagging
  /// Amazon Web Services Resources</a> in <i>Amazon Web Services General
  /// Reference</i>.
  ///
  /// Parameter [timeout] :
  /// The timeout configuration for this <a>SubmitJob</a> operation. You can
  /// specify a timeout duration after which Batch terminates your jobs if they
  /// haven't finished. If a job is terminated due to a timeout, it isn't
  /// retried. The minimum value for the timeout is 60 seconds. This
  /// configuration overrides any timeout configuration specified in the job
  /// definition. For array jobs, child jobs have the same timeout configuration
  /// as the parent job. For more information, see <a
  /// href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/job_timeouts.html">Job
  /// Timeouts</a> in the <i>Amazon Elastic Container Service Developer
  /// Guide</i>.
  Future<SubmitJobResponse> submitJob({
    required String jobDefinition,
    required String jobName,
    required String jobQueue,
    ArrayProperties? arrayProperties,
    ContainerOverrides? containerOverrides,
    List<JobDependency>? dependsOn,
    NodeOverrides? nodeOverrides,
    Map<String, String>? parameters,
    bool? propagateTags,
    RetryStrategy? retryStrategy,
    int? schedulingPriorityOverride,
    String? shareIdentifier,
    Map<String, String>? tags,
    JobTimeout? timeout,
  }) async {
    ArgumentError.checkNotNull(jobDefinition, 'jobDefinition');
    ArgumentError.checkNotNull(jobName, 'jobName');
    ArgumentError.checkNotNull(jobQueue, 'jobQueue');
    final $payload = <String, dynamic>{
      'jobDefinition': jobDefinition,
      'jobName': jobName,
      'jobQueue': jobQueue,
      if (arrayProperties != null) 'arrayProperties': arrayProperties,
      if (containerOverrides != null) 'containerOverrides': containerOverrides,
      if (dependsOn != null) 'dependsOn': dependsOn,
      if (nodeOverrides != null) 'nodeOverrides': nodeOverrides,
      if (parameters != null) 'parameters': parameters,
      if (propagateTags != null) 'propagateTags': propagateTags,
      if (retryStrategy != null) 'retryStrategy': retryStrategy,
      if (schedulingPriorityOverride != null)
        'schedulingPriorityOverride': schedulingPriorityOverride,
      if (shareIdentifier != null) 'shareIdentifier': shareIdentifier,
      if (tags != null) 'tags': tags,
      if (timeout != null) 'timeout': timeout,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/submitjob',
      exceptionFnMap: _exceptionFns,
    );
    return SubmitJobResponse.fromJson(response);
  }

  /// Associates the specified tags to a resource with the specified
  /// <code>resourceArn</code>. If existing tags on a resource aren't specified
  /// in the request parameters, they aren't changed. When a resource is
  /// deleted, the tags that are associated with that resource are deleted as
  /// well. Batch resources that support tags are compute environments, jobs,
  /// job definitions, job queues, and scheduling policies. ARNs for child jobs
  /// of array and multi-node parallel (MNP) jobs are not supported.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [resourceArn] :
  /// The Amazon Resource Name (ARN) of the resource that tags are added to.
  /// Batch resources that support tags are compute environments, jobs, job
  /// definitions, job queues, and scheduling policies. ARNs for child jobs of
  /// array and multi-node parallel (MNP) jobs are not supported.
  ///
  /// Parameter [tags] :
  /// The tags that you apply to the resource to help you categorize and
  /// organize your resources. Each tag consists of a key and an optional value.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html">Tagging
  /// Amazon Web Services Resources</a> in <i>Amazon Web Services General
  /// Reference</i>.
  Future<void> tagResource({
    required String resourceArn,
    required Map<String, String> tags,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    ArgumentError.checkNotNull(tags, 'tags');
    final $payload = <String, dynamic>{
      'tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/tags/${Uri.encodeComponent(resourceArn)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Terminates a job in a job queue. Jobs that are in the
  /// <code>STARTING</code> or <code>RUNNING</code> state are terminated, which
  /// causes them to transition to <code>FAILED</code>. Jobs that have not
  /// progressed to the <code>STARTING</code> state are cancelled.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [jobId] :
  /// The Batch job ID of the job to terminate.
  ///
  /// Parameter [reason] :
  /// A message to attach to the job that explains the reason for canceling it.
  /// This message is returned by future <a>DescribeJobs</a> operations on the
  /// job. This message is also recorded in the Batch activity logs.
  Future<void> terminateJob({
    required String jobId,
    required String reason,
  }) async {
    ArgumentError.checkNotNull(jobId, 'jobId');
    ArgumentError.checkNotNull(reason, 'reason');
    final $payload = <String, dynamic>{
      'jobId': jobId,
      'reason': reason,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/terminatejob',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes specified tags from an Batch resource.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [resourceArn] :
  /// The Amazon Resource Name (ARN) of the resource from which to delete tags.
  /// Batch resources that support tags are compute environments, jobs, job
  /// definitions, job queues, and scheduling policies. ARNs for child jobs of
  /// array and multi-node parallel (MNP) jobs are not supported.
  ///
  /// Parameter [tagKeys] :
  /// The keys of the tags to be removed.
  Future<void> untagResource({
    required String resourceArn,
    required List<String> tagKeys,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    ArgumentError.checkNotNull(tagKeys, 'tagKeys');
    final $query = <String, List<String>>{
      'tagKeys': tagKeys,
    };
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/v1/tags/${Uri.encodeComponent(resourceArn)}',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Updates an Batch compute environment.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [computeEnvironment] :
  /// The name or full Amazon Resource Name (ARN) of the compute environment to
  /// update.
  ///
  /// Parameter [computeResources] :
  /// Details of the compute resources managed by the compute environment.
  /// Required for a managed compute environment. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/compute_environments.html">Compute
  /// Environments</a> in the <i>Batch User Guide</i>.
  ///
  /// Parameter [serviceRole] :
  /// The full Amazon Resource Name (ARN) of the IAM role that allows Batch to
  /// make calls to other Amazon Web Services services on your behalf. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/service_IAM_role.html">Batch
  /// service IAM role</a> in the <i>Batch User Guide</i>.
  /// <important>
  /// If the compute environment has a service-linked role, it can't be changed
  /// to use a regular IAM role. Likewise, if the compute environment has a
  /// regular IAM role, it can't be changed to use a service-linked role. To
  /// update the parameters for the compute environment that require an
  /// infrastructure update to change, the <b>AWSServiceRoleForBatch</b>
  /// service-linked role must be used. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  /// </important>
  /// If your specified role has a path other than <code>/</code>, then you must
  /// either specify the full role ARN (recommended) or prefix the role name
  /// with the path.
  /// <note>
  /// Depending on how you created your Batch service role, its ARN might
  /// contain the <code>service-role</code> path prefix. When you only specify
  /// the name of the service role, Batch assumes that your ARN doesn't use the
  /// <code>service-role</code> path prefix. Because of this, we recommend that
  /// you specify the full ARN of your service role when you create compute
  /// environments.
  /// </note>
  ///
  /// Parameter [state] :
  /// The state of the compute environment. Compute environments in the
  /// <code>ENABLED</code> state can accept jobs from a queue and scale in or
  /// out automatically based on the workload demand of its associated queues.
  ///
  /// If the state is <code>ENABLED</code>, then the Batch scheduler can attempt
  /// to place jobs from an associated job queue on the compute resources within
  /// the environment. If the compute environment is managed, then it can scale
  /// its instances out or in automatically, based on the job queue demand.
  ///
  /// If the state is <code>DISABLED</code>, then the Batch scheduler doesn't
  /// attempt to place jobs within the environment. Jobs in a
  /// <code>STARTING</code> or <code>RUNNING</code> state continue to progress
  /// normally. Managed compute environments in the <code>DISABLED</code> state
  /// don't scale out. However, they scale in to <code>minvCpus</code> value
  /// after instances become idle.
  ///
  /// Parameter [unmanagedvCpus] :
  /// The maximum number of vCPUs expected to be used for an unmanaged compute
  /// environment. Do not specify this parameter for a managed compute
  /// environment. This parameter is only used for fair share scheduling to
  /// reserve vCPU capacity for new share identifiers. If this parameter is not
  /// provided for a fair share job queue, no vCPU capacity will be reserved.
  ///
  /// Parameter [updatePolicy] :
  /// Specifies the updated infrastructure update policy for the compute
  /// environment. For more information about infrastructure updates, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  Future<UpdateComputeEnvironmentResponse> updateComputeEnvironment({
    required String computeEnvironment,
    ComputeResourceUpdate? computeResources,
    String? serviceRole,
    CEState? state,
    int? unmanagedvCpus,
    UpdatePolicy? updatePolicy,
  }) async {
    ArgumentError.checkNotNull(computeEnvironment, 'computeEnvironment');
    final $payload = <String, dynamic>{
      'computeEnvironment': computeEnvironment,
      if (computeResources != null) 'computeResources': computeResources,
      if (serviceRole != null) 'serviceRole': serviceRole,
      if (state != null) 'state': state.toValue(),
      if (unmanagedvCpus != null) 'unmanagedvCpus': unmanagedvCpus,
      if (updatePolicy != null) 'updatePolicy': updatePolicy,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/updatecomputeenvironment',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateComputeEnvironmentResponse.fromJson(response);
  }

  /// Updates a job queue.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [jobQueue] :
  /// The name or the Amazon Resource Name (ARN) of the job queue.
  ///
  /// Parameter [computeEnvironmentOrder] :
  /// Details the set of compute environments mapped to a job queue and their
  /// order relative to each other. This is one of the parameters used by the
  /// job scheduler to determine which compute environment runs a given job.
  /// Compute environments must be in the <code>VALID</code> state before you
  /// can associate them with a job queue. All of the compute environments must
  /// be either EC2 (<code>EC2</code> or <code>SPOT</code>) or Fargate
  /// (<code>FARGATE</code> or <code>FARGATE_SPOT</code>). EC2 and Fargate
  /// compute environments can't be mixed.
  /// <note>
  /// All compute environments that are associated with a job queue must share
  /// the same architecture. Batch doesn't support mixing compute environment
  /// architecture types in a single job queue.
  /// </note>
  ///
  /// Parameter [priority] :
  /// The priority of the job queue. Job queues with a higher priority (or a
  /// higher integer value for the <code>priority</code> parameter) are
  /// evaluated first when associated with the same compute environment.
  /// Priority is determined in descending order. For example, a job queue with
  /// a priority value of <code>10</code> is given scheduling preference over a
  /// job queue with a priority value of <code>1</code>. All of the compute
  /// environments must be either EC2 (<code>EC2</code> or <code>SPOT</code>) or
  /// Fargate (<code>FARGATE</code> or <code>FARGATE_SPOT</code>). EC2 and
  /// Fargate compute environments can't be mixed.
  ///
  /// Parameter [schedulingPolicyArn] :
  /// Amazon Resource Name (ARN) of the fair share scheduling policy. Once a job
  /// queue is created, the fair share scheduling policy can be replaced but not
  /// removed. The format is
  /// <code>aws:<i>Partition</i>:batch:<i>Region</i>:<i>Account</i>:scheduling-policy/<i>Name</i>
  /// </code>. For example,
  /// <code>aws:aws:batch:us-west-2:012345678910:scheduling-policy/MySchedulingPolicy</code>.
  ///
  /// Parameter [state] :
  /// Describes the queue's ability to accept new jobs. If the job queue state
  /// is <code>ENABLED</code>, it can accept jobs. If the job queue state is
  /// <code>DISABLED</code>, new jobs can't be added to the queue, but jobs
  /// already in the queue can finish.
  Future<UpdateJobQueueResponse> updateJobQueue({
    required String jobQueue,
    List<ComputeEnvironmentOrder>? computeEnvironmentOrder,
    int? priority,
    String? schedulingPolicyArn,
    JQState? state,
  }) async {
    ArgumentError.checkNotNull(jobQueue, 'jobQueue');
    final $payload = <String, dynamic>{
      'jobQueue': jobQueue,
      if (computeEnvironmentOrder != null)
        'computeEnvironmentOrder': computeEnvironmentOrder,
      if (priority != null) 'priority': priority,
      if (schedulingPolicyArn != null)
        'schedulingPolicyArn': schedulingPolicyArn,
      if (state != null) 'state': state.toValue(),
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/updatejobqueue',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateJobQueueResponse.fromJson(response);
  }

  /// Updates a scheduling policy.
  ///
  /// May throw [ClientException].
  /// May throw [ServerException].
  ///
  /// Parameter [arn] :
  /// The Amazon Resource Name (ARN) of the scheduling policy to update.
  ///
  /// Parameter [fairsharePolicy] :
  /// The fair share policy.
  Future<void> updateSchedulingPolicy({
    required String arn,
    FairsharePolicy? fairsharePolicy,
  }) async {
    ArgumentError.checkNotNull(arn, 'arn');
    final $payload = <String, dynamic>{
      'arn': arn,
      if (fairsharePolicy != null) 'fairsharePolicy': fairsharePolicy,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/v1/updateschedulingpolicy',
      exceptionFnMap: _exceptionFns,
    );
  }
}

enum ArrayJobDependency {
  nToN,
  sequential,
}

extension on ArrayJobDependency {
  String toValue() {
    switch (this) {
      case ArrayJobDependency.nToN:
        return 'N_TO_N';
      case ArrayJobDependency.sequential:
        return 'SEQUENTIAL';
    }
  }
}

extension on String {
  ArrayJobDependency toArrayJobDependency() {
    switch (this) {
      case 'N_TO_N':
        return ArrayJobDependency.nToN;
      case 'SEQUENTIAL':
        return ArrayJobDependency.sequential;
    }
    throw Exception('$this is not known in enum ArrayJobDependency');
  }
}

/// An object representing an Batch array job.
class ArrayProperties {
  /// The size of the array job.
  final int? size;

  ArrayProperties({
    this.size,
  });
  Map<String, dynamic> toJson() {
    final size = this.size;
    return {
      if (size != null) 'size': size,
    };
  }
}

/// An object representing the array properties of a job.
class ArrayPropertiesDetail {
  /// The job index within the array that's associated with this job. This
  /// parameter is returned for array job children.
  final int? index;

  /// The size of the array job. This parameter is returned for parent array jobs.
  final int? size;

  /// A summary of the number of array job children in each available job status.
  /// This parameter is returned for parent array jobs.
  final Map<String, int>? statusSummary;

  ArrayPropertiesDetail({
    this.index,
    this.size,
    this.statusSummary,
  });
  factory ArrayPropertiesDetail.fromJson(Map<String, dynamic> json) {
    return ArrayPropertiesDetail(
      index: json['index'] as int?,
      size: json['size'] as int?,
      statusSummary: (json['statusSummary'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as int)),
    );
  }
}

/// An object representing the array properties of a job.
class ArrayPropertiesSummary {
  /// The job index within the array that's associated with this job. This
  /// parameter is returned for children of array jobs.
  final int? index;

  /// The size of the array job. This parameter is returned for parent array jobs.
  final int? size;

  ArrayPropertiesSummary({
    this.index,
    this.size,
  });
  factory ArrayPropertiesSummary.fromJson(Map<String, dynamic> json) {
    return ArrayPropertiesSummary(
      index: json['index'] as int?,
      size: json['size'] as int?,
    );
  }
}

enum AssignPublicIp {
  enabled,
  disabled,
}

extension on AssignPublicIp {
  String toValue() {
    switch (this) {
      case AssignPublicIp.enabled:
        return 'ENABLED';
      case AssignPublicIp.disabled:
        return 'DISABLED';
    }
  }
}

extension on String {
  AssignPublicIp toAssignPublicIp() {
    switch (this) {
      case 'ENABLED':
        return AssignPublicIp.enabled;
      case 'DISABLED':
        return AssignPublicIp.disabled;
    }
    throw Exception('$this is not known in enum AssignPublicIp');
  }
}

/// An object representing the details of a container that's part of a job
/// attempt.
class AttemptContainerDetail {
  /// The Amazon Resource Name (ARN) of the Amazon ECS container instance that
  /// hosts the job attempt.
  final String? containerInstanceArn;

  /// The exit code for the job attempt. A non-zero exit code is considered a
  /// failure.
  final int? exitCode;

  /// The name of the CloudWatch Logs log stream associated with the container.
  /// The log group for Batch jobs is <code>/aws/batch/job</code>. Each container
  /// attempt receives a log stream name when they reach the <code>RUNNING</code>
  /// status.
  final String? logStreamName;

  /// The network interfaces associated with the job attempt.
  final List<NetworkInterface>? networkInterfaces;

  /// A short (255 max characters) human-readable string to provide additional
  /// details about a running or stopped container.
  final String? reason;

  /// The Amazon Resource Name (ARN) of the Amazon ECS task that's associated with
  /// the job attempt. Each container attempt receives a task ARN when they reach
  /// the <code>STARTING</code> status.
  final String? taskArn;

  AttemptContainerDetail({
    this.containerInstanceArn,
    this.exitCode,
    this.logStreamName,
    this.networkInterfaces,
    this.reason,
    this.taskArn,
  });
  factory AttemptContainerDetail.fromJson(Map<String, dynamic> json) {
    return AttemptContainerDetail(
      containerInstanceArn: json['containerInstanceArn'] as String?,
      exitCode: json['exitCode'] as int?,
      logStreamName: json['logStreamName'] as String?,
      networkInterfaces: (json['networkInterfaces'] as List?)
          ?.whereNotNull()
          .map((e) => NetworkInterface.fromJson(e as Map<String, dynamic>))
          .toList(),
      reason: json['reason'] as String?,
      taskArn: json['taskArn'] as String?,
    );
  }
}

/// An object representing a job attempt.
class AttemptDetail {
  /// Details about the container in this job attempt.
  final AttemptContainerDetail? container;

  /// The Unix timestamp (in milliseconds) for when the attempt was started (when
  /// the attempt transitioned from the <code>STARTING</code> state to the
  /// <code>RUNNING</code> state).
  final int? startedAt;

  /// A short, human-readable string to provide additional details about the
  /// current status of the job attempt.
  final String? statusReason;

  /// The Unix timestamp (in milliseconds) for when the attempt was stopped (when
  /// the attempt transitioned from the <code>RUNNING</code> state to a terminal
  /// state, such as <code>SUCCEEDED</code> or <code>FAILED</code>).
  final int? stoppedAt;

  AttemptDetail({
    this.container,
    this.startedAt,
    this.statusReason,
    this.stoppedAt,
  });
  factory AttemptDetail.fromJson(Map<String, dynamic> json) {
    return AttemptDetail(
      container: json['container'] != null
          ? AttemptContainerDetail.fromJson(
              json['container'] as Map<String, dynamic>)
          : null,
      startedAt: json['startedAt'] as int?,
      statusReason: json['statusReason'] as String?,
      stoppedAt: json['stoppedAt'] as int?,
    );
  }
}

enum CEState {
  enabled,
  disabled,
}

extension on CEState {
  String toValue() {
    switch (this) {
      case CEState.enabled:
        return 'ENABLED';
      case CEState.disabled:
        return 'DISABLED';
    }
  }
}

extension on String {
  CEState toCEState() {
    switch (this) {
      case 'ENABLED':
        return CEState.enabled;
      case 'DISABLED':
        return CEState.disabled;
    }
    throw Exception('$this is not known in enum CEState');
  }
}

enum CEStatus {
  creating,
  updating,
  deleting,
  deleted,
  valid,
  invalid,
}

extension on CEStatus {
  String toValue() {
    switch (this) {
      case CEStatus.creating:
        return 'CREATING';
      case CEStatus.updating:
        return 'UPDATING';
      case CEStatus.deleting:
        return 'DELETING';
      case CEStatus.deleted:
        return 'DELETED';
      case CEStatus.valid:
        return 'VALID';
      case CEStatus.invalid:
        return 'INVALID';
    }
  }
}

extension on String {
  CEStatus toCEStatus() {
    switch (this) {
      case 'CREATING':
        return CEStatus.creating;
      case 'UPDATING':
        return CEStatus.updating;
      case 'DELETING':
        return CEStatus.deleting;
      case 'DELETED':
        return CEStatus.deleted;
      case 'VALID':
        return CEStatus.valid;
      case 'INVALID':
        return CEStatus.invalid;
    }
    throw Exception('$this is not known in enum CEStatus');
  }
}

enum CEType {
  managed,
  unmanaged,
}

extension on CEType {
  String toValue() {
    switch (this) {
      case CEType.managed:
        return 'MANAGED';
      case CEType.unmanaged:
        return 'UNMANAGED';
    }
  }
}

extension on String {
  CEType toCEType() {
    switch (this) {
      case 'MANAGED':
        return CEType.managed;
      case 'UNMANAGED':
        return CEType.unmanaged;
    }
    throw Exception('$this is not known in enum CEType');
  }
}

enum CRAllocationStrategy {
  bestFit,
  bestFitProgressive,
  spotCapacityOptimized,
}

extension on CRAllocationStrategy {
  String toValue() {
    switch (this) {
      case CRAllocationStrategy.bestFit:
        return 'BEST_FIT';
      case CRAllocationStrategy.bestFitProgressive:
        return 'BEST_FIT_PROGRESSIVE';
      case CRAllocationStrategy.spotCapacityOptimized:
        return 'SPOT_CAPACITY_OPTIMIZED';
    }
  }
}

extension on String {
  CRAllocationStrategy toCRAllocationStrategy() {
    switch (this) {
      case 'BEST_FIT':
        return CRAllocationStrategy.bestFit;
      case 'BEST_FIT_PROGRESSIVE':
        return CRAllocationStrategy.bestFitProgressive;
      case 'SPOT_CAPACITY_OPTIMIZED':
        return CRAllocationStrategy.spotCapacityOptimized;
    }
    throw Exception('$this is not known in enum CRAllocationStrategy');
  }
}

enum CRType {
  ec2,
  spot,
  fargate,
  fargateSpot,
}

extension on CRType {
  String toValue() {
    switch (this) {
      case CRType.ec2:
        return 'EC2';
      case CRType.spot:
        return 'SPOT';
      case CRType.fargate:
        return 'FARGATE';
      case CRType.fargateSpot:
        return 'FARGATE_SPOT';
    }
  }
}

extension on String {
  CRType toCRType() {
    switch (this) {
      case 'EC2':
        return CRType.ec2;
      case 'SPOT':
        return CRType.spot;
      case 'FARGATE':
        return CRType.fargate;
      case 'FARGATE_SPOT':
        return CRType.fargateSpot;
    }
    throw Exception('$this is not known in enum CRType');
  }
}

enum CRUpdateAllocationStrategy {
  bestFitProgressive,
  spotCapacityOptimized,
}

extension on CRUpdateAllocationStrategy {
  String toValue() {
    switch (this) {
      case CRUpdateAllocationStrategy.bestFitProgressive:
        return 'BEST_FIT_PROGRESSIVE';
      case CRUpdateAllocationStrategy.spotCapacityOptimized:
        return 'SPOT_CAPACITY_OPTIMIZED';
    }
  }
}

extension on String {
  CRUpdateAllocationStrategy toCRUpdateAllocationStrategy() {
    switch (this) {
      case 'BEST_FIT_PROGRESSIVE':
        return CRUpdateAllocationStrategy.bestFitProgressive;
      case 'SPOT_CAPACITY_OPTIMIZED':
        return CRUpdateAllocationStrategy.spotCapacityOptimized;
    }
    throw Exception('$this is not known in enum CRUpdateAllocationStrategy');
  }
}

class CancelJobResponse {
  CancelJobResponse();
  factory CancelJobResponse.fromJson(Map<String, dynamic> _) {
    return CancelJobResponse();
  }
}

/// An object representing an Batch compute environment.
class ComputeEnvironmentDetail {
  /// The Amazon Resource Name (ARN) of the compute environment.
  final String computeEnvironmentArn;

  /// The name of the compute environment. It can be up to 128 letters long. It
  /// can contain uppercase and lowercase letters, numbers, hyphens (-), and
  /// underscores (_).
  final String computeEnvironmentName;

  /// The compute resources defined for the compute environment. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/compute_environments.html">Compute
  /// environments</a> in the <i>Batch User Guide</i>.
  final ComputeResource? computeResources;

  /// The Amazon Resource Name (ARN) of the underlying Amazon ECS cluster used by
  /// the compute environment.
  final String? ecsClusterArn;

  /// The service role associated with the compute environment that allows Batch
  /// to make calls to Amazon Web Services API operations on your behalf. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/service_IAM_role.html">Batch
  /// service IAM role</a> in the <i>Batch User Guide</i>.
  final String? serviceRole;

  /// The state of the compute environment. The valid values are
  /// <code>ENABLED</code> or <code>DISABLED</code>.
  ///
  /// If the state is <code>ENABLED</code>, then the Batch scheduler can attempt
  /// to place jobs from an associated job queue on the compute resources within
  /// the environment. If the compute environment is managed, then it can scale
  /// its instances out or in automatically, based on the job queue demand.
  ///
  /// If the state is <code>DISABLED</code>, then the Batch scheduler doesn't
  /// attempt to place jobs within the environment. Jobs in a
  /// <code>STARTING</code> or <code>RUNNING</code> state continue to progress
  /// normally. Managed compute environments in the <code>DISABLED</code> state
  /// don't scale out. However, they scale in to <code>minvCpus</code> value after
  /// instances become idle.
  final CEState? state;

  /// The current status of the compute environment (for example,
  /// <code>CREATING</code> or <code>VALID</code>).
  final CEStatus? status;

  /// A short, human-readable string to provide additional details about the
  /// current status of the compute environment.
  final String? statusReason;

  /// The tags applied to the compute environment.
  final Map<String, String>? tags;

  /// The type of the compute environment: <code>MANAGED</code> or
  /// <code>UNMANAGED</code>. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/compute_environments.html">Compute
  /// environments</a> in the <i>Batch User Guide</i>.
  final CEType? type;

  /// The maximum number of VCPUs expected to be used for an unmanaged compute
  /// environment.
  final int? unmanagedvCpus;

  /// Specifies the infrastructure update policy for the compute environment. For
  /// more information about infrastructure updates, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  final UpdatePolicy? updatePolicy;

  ComputeEnvironmentDetail({
    required this.computeEnvironmentArn,
    required this.computeEnvironmentName,
    this.computeResources,
    this.ecsClusterArn,
    this.serviceRole,
    this.state,
    this.status,
    this.statusReason,
    this.tags,
    this.type,
    this.unmanagedvCpus,
    this.updatePolicy,
  });
  factory ComputeEnvironmentDetail.fromJson(Map<String, dynamic> json) {
    return ComputeEnvironmentDetail(
      computeEnvironmentArn: json['computeEnvironmentArn'] as String,
      computeEnvironmentName: json['computeEnvironmentName'] as String,
      computeResources: json['computeResources'] != null
          ? ComputeResource.fromJson(
              json['computeResources'] as Map<String, dynamic>)
          : null,
      ecsClusterArn: json['ecsClusterArn'] as String?,
      serviceRole: json['serviceRole'] as String?,
      state: (json['state'] as String?)?.toCEState(),
      status: (json['status'] as String?)?.toCEStatus(),
      statusReason: json['statusReason'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      type: (json['type'] as String?)?.toCEType(),
      unmanagedvCpus: json['unmanagedvCpus'] as int?,
      updatePolicy: json['updatePolicy'] != null
          ? UpdatePolicy.fromJson(json['updatePolicy'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// The order in which compute environments are tried for job placement within a
/// queue. Compute environments are tried in ascending order. For example, if
/// two compute environments are associated with a job queue, the compute
/// environment with a lower order integer value is tried for job placement
/// first. Compute environments must be in the <code>VALID</code> state before
/// you can associate them with a job queue. All of the compute environments
/// must be either EC2 (<code>EC2</code> or <code>SPOT</code>) or Fargate
/// (<code>FARGATE</code> or <code>FARGATE_SPOT</code>); EC2 and Fargate compute
/// environments can't be mixed.
/// <note>
/// All compute environments that are associated with a job queue must share the
/// same architecture. Batch doesn't support mixing compute environment
/// architecture types in a single job queue.
/// </note>
class ComputeEnvironmentOrder {
  /// The Amazon Resource Name (ARN) of the compute environment.
  final String computeEnvironment;

  /// The order of the compute environment. Compute environments are tried in
  /// ascending order. For example, if two compute environments are associated
  /// with a job queue, the compute environment with a lower <code>order</code>
  /// integer value is tried for job placement first.
  final int order;

  ComputeEnvironmentOrder({
    required this.computeEnvironment,
    required this.order,
  });
  factory ComputeEnvironmentOrder.fromJson(Map<String, dynamic> json) {
    return ComputeEnvironmentOrder(
      computeEnvironment: json['computeEnvironment'] as String,
      order: json['order'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final computeEnvironment = this.computeEnvironment;
    final order = this.order;
    return {
      'computeEnvironment': computeEnvironment,
      'order': order,
    };
  }
}

/// An object representing an Batch compute resource. For more information, see
/// <a
/// href="https://docs.aws.amazon.com/batch/latest/userguide/compute_environments.html">Compute
/// environments</a> in the <i>Batch User Guide</i>.
class ComputeResource {
  /// The maximum number of Amazon EC2 vCPUs that a compute environment can reach.
  /// <note>
  /// With both <code>BEST_FIT_PROGRESSIVE</code> and
  /// <code>SPOT_CAPACITY_OPTIMIZED</code> allocation strategies, Batch might need
  /// to exceed <code>maxvCpus</code> to meet your capacity requirements. In this
  /// event, Batch never exceeds <code>maxvCpus</code> by more than a single
  /// instance. For example, no more than a single instance from among those
  /// specified in your compute environment is allocated.
  /// </note>
  final int maxvCpus;

  /// The VPC subnets where the compute resources are launched. These subnets must
  /// be within the same VPC. Fargate compute resources can contain up to 16
  /// subnets. For more information, see <a
  /// href="https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html">VPCs
  /// and subnets</a> in the <i>Amazon VPC User Guide</i>.
  final List<String> subnets;

  /// The type of compute environment: <code>EC2</code>, <code>SPOT</code>,
  /// <code>FARGATE</code>, or <code>FARGATE_SPOT</code>. For more information,
  /// see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/compute_environments.html">Compute
  /// environments</a> in the <i>Batch User Guide</i>.
  ///
  /// If you choose <code>SPOT</code>, you must also specify an Amazon EC2 Spot
  /// Fleet role with the <code>spotIamFleetRole</code> parameter. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/spot_fleet_IAM_role.html">Amazon
  /// EC2 spot fleet role</a> in the <i>Batch User Guide</i>.
  final CRType type;

  /// The allocation strategy to use for the compute resource if not enough
  /// instances of the best fitting instance type can be allocated. This might be
  /// because of availability of the instance type in the Region or <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-resource-limits.html">Amazon
  /// EC2 service limits</a>. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/allocation-strategies.html">Allocation
  /// strategies</a> in the <i>Batch User Guide</i>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note> <dl> <dt>BEST_FIT (default)</dt> <dd>
  /// Batch selects an instance type that best fits the needs of the jobs with a
  /// preference for the lowest-cost instance type. If additional instances of the
  /// selected instance type aren't available, Batch waits for the additional
  /// instances to be available. If there aren't enough instances available, or if
  /// the user is reaching <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-resource-limits.html">Amazon
  /// EC2 service limits</a> then additional jobs aren't run until the currently
  /// running jobs have completed. This allocation strategy keeps costs lower but
  /// can limit scaling. If you are using Spot Fleets with <code>BEST_FIT</code>
  /// then the Spot Fleet IAM Role must be specified. Compute resources that use a
  /// <code>BEST_FIT</code> allocation strategy don't support infrastructure
  /// updates and can't update some parameters. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  /// </dd> <dt>BEST_FIT_PROGRESSIVE</dt> <dd>
  /// Batch will select additional instance types that are large enough to meet
  /// the requirements of the jobs in the queue, with a preference for instance
  /// types with a lower cost per unit vCPU. If additional instances of the
  /// previously selected instance types aren't available, Batch will select new
  /// instance types.
  /// </dd> <dt>SPOT_CAPACITY_OPTIMIZED</dt> <dd>
  /// Batch will select one or more instance types that are large enough to meet
  /// the requirements of the jobs in the queue, with a preference for instance
  /// types that are less likely to be interrupted. This allocation strategy is
  /// only available for Spot Instance compute resources.
  /// </dd> </dl>
  /// With both <code>BEST_FIT_PROGRESSIVE</code> and
  /// <code>SPOT_CAPACITY_OPTIMIZED</code> strategies, Batch might need to go
  /// above <code>maxvCpus</code> to meet your capacity requirements. In this
  /// event, Batch never exceeds <code>maxvCpus</code> by more than a single
  /// instance.
  final CRAllocationStrategy? allocationStrategy;

  /// The maximum percentage that a Spot Instance price can be when compared with
  /// the On-Demand price for that instance type before instances are launched.
  /// For example, if your maximum percentage is 20%, then the Spot price must be
  /// less than 20% of the current On-Demand price for that Amazon EC2 instance.
  /// You always pay the lowest (market) price and never more than your maximum
  /// percentage. If you leave this field empty, the default value is 100% of the
  /// On-Demand price.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final int? bidPercentage;

  /// The desired number of Amazon EC2 vCPUS in the compute environment. Batch
  /// modifies this value between the minimum and maximum values, based on job
  /// queue demand.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final int? desiredvCpus;

  /// Provides information used to select Amazon Machine Images (AMIs) for EC2
  /// instances in the compute environment. If <code>Ec2Configuration</code> isn't
  /// specified, the default is <code>ECS_AL2</code>.
  ///
  /// One or two values can be provided.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final List<Ec2Configuration>? ec2Configuration;

  /// The Amazon EC2 key pair that's used for instances launched in the compute
  /// environment. You can use this key pair to log in to your instances with SSH.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final String? ec2KeyPair;

  /// The Amazon Machine Image (AMI) ID used for instances launched in the compute
  /// environment. This parameter is overridden by the
  /// <code>imageIdOverride</code> member of the <code>Ec2Configuration</code>
  /// structure.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note> <note>
  /// The AMI that you choose for a compute environment must match the
  /// architecture of the instance types that you intend to use for that compute
  /// environment. For example, if your compute environment uses A1 instance
  /// types, the compute resource AMI that you choose must support ARM instances.
  /// Amazon ECS vends both x86 and ARM versions of the Amazon ECS-optimized
  /// Amazon Linux 2 AMI. For more information, see <a
  /// href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html#ecs-optimized-ami-linux-variants.html">Amazon
  /// ECS-optimized Amazon Linux 2 AMI</a> in the <i>Amazon Elastic Container
  /// Service Developer Guide</i>.
  /// </note>
  final String? imageId;

  /// The Amazon ECS instance profile applied to Amazon EC2 instances in a compute
  /// environment. You can specify the short name or full Amazon Resource Name
  /// (ARN) of an instance profile. For example, <code> <i>ecsInstanceRole</i>
  /// </code> or
  /// <code>arn:aws:iam::<i>&lt;aws_account_id&gt;</i>:instance-profile/<i>ecsInstanceRole</i>
  /// </code>. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/instance_IAM_role.html">Amazon
  /// ECS instance role</a> in the <i>Batch User Guide</i>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final String? instanceRole;

  /// The instances types that can be launched. You can specify instance families
  /// to launch any instance type within those families (for example,
  /// <code>c5</code> or <code>p3</code>), or you can specify specific sizes
  /// within a family (such as <code>c5.8xlarge</code>). You can also choose
  /// <code>optimal</code> to select instance types (from the C4, M4, and R4
  /// instance families) that match the demand of your job queues.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note> <note>
  /// When you create a compute environment, the instance types that you select
  /// for the compute environment must share the same architecture. For example,
  /// you can't mix x86 and ARM instances in the same compute environment.
  /// </note> <note>
  /// Currently, <code>optimal</code> uses instance types from the C4, M4, and R4
  /// instance families. In Regions that don't have instance types from those
  /// instance families, instance types from the C5, M5. and R5 instance families
  /// are used.
  /// </note>
  final List<String>? instanceTypes;

  /// The launch template to use for your compute resources. Any other compute
  /// resource parameters that you specify in a <a>CreateComputeEnvironment</a>
  /// API operation override the same parameters in the launch template. You must
  /// specify either the launch template ID or launch template name in the
  /// request, but not both. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/launch-templates.html">Launch
  /// template support</a> in the <i>Batch User Guide</i>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final LaunchTemplateSpecification? launchTemplate;

  /// The minimum number of Amazon EC2 vCPUs that an environment should maintain
  /// (even if the compute environment is <code>DISABLED</code>).
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final int? minvCpus;

  /// The Amazon EC2 placement group to associate with your compute resources. If
  /// you intend to submit multi-node parallel jobs to your compute environment,
  /// you should consider creating a cluster placement group and associate it with
  /// your compute resources. This keeps your multi-node parallel job on a logical
  /// grouping of instances within a single Availability Zone with high network
  /// flow potential. For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html">Placement
  /// groups</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final String? placementGroup;

  /// The Amazon EC2 security groups associated with instances launched in the
  /// compute environment. One or more security groups must be specified, either
  /// in <code>securityGroupIds</code> or using a launch template referenced in
  /// <code>launchTemplate</code>. This parameter is required for jobs that are
  /// running on Fargate resources and must contain at least one security group.
  /// Fargate doesn't support launch templates. If security groups are specified
  /// using both <code>securityGroupIds</code> and <code>launchTemplate</code>,
  /// the values in <code>securityGroupIds</code> are used.
  final List<String>? securityGroupIds;

  /// The Amazon Resource Name (ARN) of the Amazon EC2 Spot Fleet IAM role applied
  /// to a <code>SPOT</code> compute environment. This role is required if the
  /// allocation strategy set to <code>BEST_FIT</code> or if the allocation
  /// strategy isn't specified. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/spot_fleet_IAM_role.html">Amazon
  /// EC2 spot fleet role</a> in the <i>Batch User Guide</i>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note> <important>
  /// To tag your Spot Instances on creation, the Spot Fleet IAM role specified
  /// here must use the newer <b>AmazonEC2SpotFleetTaggingRole</b> managed policy.
  /// The previously recommended <b>AmazonEC2SpotFleetRole</b> managed policy
  /// doesn't have the required permissions to tag Spot Instances. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/troubleshooting.html#spot-instance-no-tag">Spot
  /// instances not tagged on creation</a> in the <i>Batch User Guide</i>.
  /// </important>
  final String? spotIamFleetRole;

  /// Key-value pair tags to be applied to EC2 resources that are launched in the
  /// compute environment. For Batch, these take the form of "String1": "String2",
  /// where String1 is the tag key and String2 is the tag value−for example,
  /// <code>{ "Name": "Batch Instance - C4OnDemand" }</code>. This is helpful for
  /// recognizing your Batch instances in the Amazon EC2 console. Updating these
  /// tags requires an infrastructure update to the compute environment. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>. These tags aren't
  /// seen when using the Batch <code>ListTagsForResource</code> API operation.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final Map<String, String>? tags;

  ComputeResource({
    required this.maxvCpus,
    required this.subnets,
    required this.type,
    this.allocationStrategy,
    this.bidPercentage,
    this.desiredvCpus,
    this.ec2Configuration,
    this.ec2KeyPair,
    this.imageId,
    this.instanceRole,
    this.instanceTypes,
    this.launchTemplate,
    this.minvCpus,
    this.placementGroup,
    this.securityGroupIds,
    this.spotIamFleetRole,
    this.tags,
  });
  factory ComputeResource.fromJson(Map<String, dynamic> json) {
    return ComputeResource(
      maxvCpus: json['maxvCpus'] as int,
      subnets: (json['subnets'] as List)
          .whereNotNull()
          .map((e) => e as String)
          .toList(),
      type: (json['type'] as String).toCRType(),
      allocationStrategy:
          (json['allocationStrategy'] as String?)?.toCRAllocationStrategy(),
      bidPercentage: json['bidPercentage'] as int?,
      desiredvCpus: json['desiredvCpus'] as int?,
      ec2Configuration: (json['ec2Configuration'] as List?)
          ?.whereNotNull()
          .map((e) => Ec2Configuration.fromJson(e as Map<String, dynamic>))
          .toList(),
      ec2KeyPair: json['ec2KeyPair'] as String?,
      imageId: json['imageId'] as String?,
      instanceRole: json['instanceRole'] as String?,
      instanceTypes: (json['instanceTypes'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      launchTemplate: json['launchTemplate'] != null
          ? LaunchTemplateSpecification.fromJson(
              json['launchTemplate'] as Map<String, dynamic>)
          : null,
      minvCpus: json['minvCpus'] as int?,
      placementGroup: json['placementGroup'] as String?,
      securityGroupIds: (json['securityGroupIds'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      spotIamFleetRole: json['spotIamFleetRole'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }

  Map<String, dynamic> toJson() {
    final maxvCpus = this.maxvCpus;
    final subnets = this.subnets;
    final type = this.type;
    final allocationStrategy = this.allocationStrategy;
    final bidPercentage = this.bidPercentage;
    final desiredvCpus = this.desiredvCpus;
    final ec2Configuration = this.ec2Configuration;
    final ec2KeyPair = this.ec2KeyPair;
    final imageId = this.imageId;
    final instanceRole = this.instanceRole;
    final instanceTypes = this.instanceTypes;
    final launchTemplate = this.launchTemplate;
    final minvCpus = this.minvCpus;
    final placementGroup = this.placementGroup;
    final securityGroupIds = this.securityGroupIds;
    final spotIamFleetRole = this.spotIamFleetRole;
    final tags = this.tags;
    return {
      'maxvCpus': maxvCpus,
      'subnets': subnets,
      'type': type.toValue(),
      if (allocationStrategy != null)
        'allocationStrategy': allocationStrategy.toValue(),
      if (bidPercentage != null) 'bidPercentage': bidPercentage,
      if (desiredvCpus != null) 'desiredvCpus': desiredvCpus,
      if (ec2Configuration != null) 'ec2Configuration': ec2Configuration,
      if (ec2KeyPair != null) 'ec2KeyPair': ec2KeyPair,
      if (imageId != null) 'imageId': imageId,
      if (instanceRole != null) 'instanceRole': instanceRole,
      if (instanceTypes != null) 'instanceTypes': instanceTypes,
      if (launchTemplate != null) 'launchTemplate': launchTemplate,
      if (minvCpus != null) 'minvCpus': minvCpus,
      if (placementGroup != null) 'placementGroup': placementGroup,
      if (securityGroupIds != null) 'securityGroupIds': securityGroupIds,
      if (spotIamFleetRole != null) 'spotIamFleetRole': spotIamFleetRole,
      if (tags != null) 'tags': tags,
    };
  }
}

/// An object representing the attributes of a compute environment that can be
/// updated. For more information, see <a
/// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
/// compute environments</a> in the <i>Batch User Guide</i>.
class ComputeResourceUpdate {
  /// The allocation strategy to use for the compute resource if not enough
  /// instances of the best fitting instance type can be allocated. This might be
  /// because of availability of the instance type in the Region or <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-resource-limits.html">Amazon
  /// EC2 service limits</a>. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/allocation-strategies.html">Allocation
  /// strategies</a> in the <i>Batch User Guide</i>.
  ///
  /// When updating a compute environment, changing the allocation strategy
  /// requires an infrastructure update of the compute environment. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  /// <code>BEST_FIT</code> isn't supported when updating a compute environment.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note> <dl> <dt>BEST_FIT_PROGRESSIVE</dt> <dd>
  /// Batch will select additional instance types that are large enough to meet
  /// the requirements of the jobs in the queue, with a preference for instance
  /// types with a lower cost per unit vCPU. If additional instances of the
  /// previously selected instance types aren't available, Batch will select new
  /// instance types.
  /// </dd> <dt>SPOT_CAPACITY_OPTIMIZED</dt> <dd>
  /// Batch will select one or more instance types that are large enough to meet
  /// the requirements of the jobs in the queue, with a preference for instance
  /// types that are less likely to be interrupted. This allocation strategy is
  /// only available for Spot Instance compute resources.
  /// </dd> </dl>
  /// With both <code>BEST_FIT_PROGRESSIVE</code> and
  /// <code>SPOT_CAPACITY_OPTIMIZED</code> strategies, Batch might need to go
  /// above <code>maxvCpus</code> to meet your capacity requirements. In this
  /// event, Batch never exceeds <code>maxvCpus</code> by more than a single
  /// instance.
  final CRUpdateAllocationStrategy? allocationStrategy;

  /// The maximum percentage that a Spot Instance price can be when compared with
  /// the On-Demand price for that instance type before instances are launched.
  /// For example, if your maximum percentage is 20%, then the Spot price must be
  /// less than 20% of the current On-Demand price for that Amazon EC2 instance.
  /// You always pay the lowest (market) price and never more than your maximum
  /// percentage.
  ///
  /// When updating a compute environment, changing the bid percentage requires an
  /// infrastructure update of the compute environment. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final int? bidPercentage;

  /// The desired number of Amazon EC2 vCPUS in the compute environment. Batch
  /// modifies this value between the minimum and maximum values based on job
  /// queue demand.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final int? desiredvCpus;

  /// Provides information used to select Amazon Machine Images (AMIs) for EC2
  /// instances in the compute environment. If <code>Ec2Configuration</code> isn't
  /// specified, the default is <code>ECS_AL2</code>.
  ///
  /// When updating a compute environment, changing this setting requires an
  /// infrastructure update of the compute environment. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>. To remove the EC2
  /// configuration and any custom AMI ID specified in
  /// <code>imageIdOverride</code>, set this value to an empty string.
  ///
  /// One or two values can be provided.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final List<Ec2Configuration>? ec2Configuration;

  /// The Amazon EC2 key pair that's used for instances launched in the compute
  /// environment. You can use this key pair to log in to your instances with SSH.
  /// To remove the Amazon EC2 key pair, set this value to an empty string.
  ///
  /// When updating a compute environment, changing the EC2 key pair requires an
  /// infrastructure update of the compute environment. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final String? ec2KeyPair;

  /// The Amazon Machine Image (AMI) ID used for instances launched in the compute
  /// environment. This parameter is overridden by the
  /// <code>imageIdOverride</code> member of the <code>Ec2Configuration</code>
  /// structure. To remove the custom AMI ID and use the default AMI ID, set this
  /// value to an empty string.
  ///
  /// When updating a compute environment, changing the AMI ID requires an
  /// infrastructure update of the compute environment. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note> <note>
  /// The AMI that you choose for a compute environment must match the
  /// architecture of the instance types that you intend to use for that compute
  /// environment. For example, if your compute environment uses A1 instance
  /// types, the compute resource AMI that you choose must support ARM instances.
  /// Amazon ECS vends both x86 and ARM versions of the Amazon ECS-optimized
  /// Amazon Linux 2 AMI. For more information, see <a
  /// href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html#ecs-optimized-ami-linux-variants.html">Amazon
  /// ECS-optimized Amazon Linux 2 AMI</a> in the <i>Amazon Elastic Container
  /// Service Developer Guide</i>.
  /// </note>
  final String? imageId;

  /// The Amazon ECS instance profile applied to Amazon EC2 instances in a compute
  /// environment. You can specify the short name or full Amazon Resource Name
  /// (ARN) of an instance profile. For example, <code> <i>ecsInstanceRole</i>
  /// </code> or
  /// <code>arn:aws:iam::<i>&lt;aws_account_id&gt;</i>:instance-profile/<i>ecsInstanceRole</i>
  /// </code>. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/instance_IAM_role.html">Amazon
  /// ECS instance role</a> in the <i>Batch User Guide</i>.
  ///
  /// When updating a compute environment, changing this setting requires an
  /// infrastructure update of the compute environment. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final String? instanceRole;

  /// The instances types that can be launched. You can specify instance families
  /// to launch any instance type within those families (for example,
  /// <code>c5</code> or <code>p3</code>), or you can specify specific sizes
  /// within a family (such as <code>c5.8xlarge</code>). You can also choose
  /// <code>optimal</code> to select instance types (from the C4, M4, and R4
  /// instance families) that match the demand of your job queues.
  ///
  /// When updating a compute environment, changing this setting requires an
  /// infrastructure update of the compute environment. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note> <note>
  /// When you create a compute environment, the instance types that you select
  /// for the compute environment must share the same architecture. For example,
  /// you can't mix x86 and ARM instances in the same compute environment.
  /// </note> <note>
  /// Currently, <code>optimal</code> uses instance types from the C4, M4, and R4
  /// instance families. In Regions that don't have instance types from those
  /// instance families, instance types from the C5, M5. and R5 instance families
  /// are used.
  /// </note>
  final List<String>? instanceTypes;

  /// The updated launch template to use for your compute resources. You must
  /// specify either the launch template ID or launch template name in the
  /// request, but not both. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/launch-templates.html">Launch
  /// template support</a> in the <i>Batch User Guide</i>. To remove the custom
  /// launch template and use the default launch template, set
  /// <code>launchTemplateId</code> or <code>launchTemplateName</code> member of
  /// the launch template specification to an empty string. Removing the launch
  /// template from a compute environment will not remove the AMI specified in the
  /// launch template. In order to update the AMI specified in a launch template,
  /// the <code>updateToLatestImageVersion</code> parameter must be set to
  /// <code>true</code>.
  ///
  /// When updating a compute environment, changing the launch template requires
  /// an infrastructure update of the compute environment. For more information,
  /// see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final LaunchTemplateSpecification? launchTemplate;

  /// The maximum number of Amazon EC2 vCPUs that an environment can reach.
  /// <note>
  /// With both <code>BEST_FIT_PROGRESSIVE</code> and
  /// <code>SPOT_CAPACITY_OPTIMIZED</code> allocation strategies, Batch might need
  /// to exceed <code>maxvCpus</code> to meet your capacity requirements. In this
  /// event, Batch never exceeds <code>maxvCpus</code> by more than a single
  /// instance. That is, no more than a single instance from among those specified
  /// in your compute environment.
  /// </note>
  final int? maxvCpus;

  /// The minimum number of Amazon EC2 vCPUs that an environment should maintain
  /// (even if the compute environment is <code>DISABLED</code>).
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final int? minvCpus;

  /// The Amazon EC2 placement group to associate with your compute resources. If
  /// you intend to submit multi-node parallel jobs to your compute environment,
  /// you should consider creating a cluster placement group and associate it with
  /// your compute resources. This keeps your multi-node parallel job on a logical
  /// grouping of instances within a single Availability Zone with high network
  /// flow potential. For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html">Placement
  /// groups</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.
  ///
  /// When updating a compute environment, changing the placement group requires
  /// an infrastructure update of the compute environment. For more information,
  /// see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final String? placementGroup;

  /// The Amazon EC2 security groups associated with instances launched in the
  /// compute environment. This parameter is required for Fargate compute
  /// resources, where it can contain up to 5 security groups. For Fargate compute
  /// resources, providing an empty list is handled as if this parameter wasn't
  /// specified and no change is made. For EC2 compute resources, providing an
  /// empty list removes the security groups from the compute resource.
  ///
  /// When updating a compute environment, changing the EC2 security groups
  /// requires an infrastructure update of the compute environment. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  final List<String>? securityGroupIds;

  /// The VPC subnets where the compute resources are launched. Fargate compute
  /// resources can contain up to 16 subnets. For Fargate compute resources,
  /// providing an empty list will be handled as if this parameter wasn't
  /// specified and no change is made. For EC2 compute resources, providing an
  /// empty list removes the VPC subnets from the compute resource. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html">VPCs
  /// and subnets</a> in the <i>Amazon VPC User Guide</i>.
  ///
  /// When updating a compute environment, changing the VPC subnets requires an
  /// infrastructure update of the compute environment. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  final List<String>? subnets;

  /// Key-value pair tags to be applied to EC2 resources that are launched in the
  /// compute environment. For Batch, these take the form of "String1": "String2",
  /// where String1 is the tag key and String2 is the tag value−for example,
  /// <code>{ "Name": "Batch Instance - C4OnDemand" }</code>. This is helpful for
  /// recognizing your Batch instances in the Amazon EC2 console. These tags
  /// aren't seen when using the Batch <code>ListTagsForResource</code> API
  /// operation.
  ///
  /// When updating a compute environment, changing this setting requires an
  /// infrastructure update of the compute environment. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources, and shouldn't be specified.
  /// </note>
  final Map<String, String>? tags;

  /// The type of compute environment: <code>EC2</code>, <code>SPOT</code>,
  /// <code>FARGATE</code>, or <code>FARGATE_SPOT</code>. For more information,
  /// see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/compute_environments.html">Compute
  /// environments</a> in the <i>Batch User Guide</i>.
  ///
  /// If you choose <code>SPOT</code>, you must also specify an Amazon EC2 Spot
  /// Fleet role with the <code>spotIamFleetRole</code> parameter. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/spot_fleet_IAM_role.html">Amazon
  /// EC2 spot fleet role</a> in the <i>Batch User Guide</i>.
  ///
  /// When updating a compute environment, changing the type of a compute
  /// environment requires an infrastructure update of the compute environment.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  final CRType? type;

  /// Specifies whether the AMI ID is updated to the latest one that's supported
  /// by Batch when the compute environment has an infrastructure update. The
  /// default value is <code>false</code>.
  /// <note>
  /// If an AMI ID is specified in the <code>imageId</code> or
  /// <code>imageIdOverride</code> parameters or by the launch template specified
  /// in the <code>launchTemplate</code> parameter, this parameter is ignored. For
  /// more information on updating AMI IDs during an infrastructure update, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html#updating-compute-environments-ami">Updating
  /// the AMI ID</a> in the <i>Batch User Guide</i>.
  /// </note>
  /// When updating a compute environment, changing this setting requires an
  /// infrastructure update of the compute environment. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  final bool? updateToLatestImageVersion;

  ComputeResourceUpdate({
    this.allocationStrategy,
    this.bidPercentage,
    this.desiredvCpus,
    this.ec2Configuration,
    this.ec2KeyPair,
    this.imageId,
    this.instanceRole,
    this.instanceTypes,
    this.launchTemplate,
    this.maxvCpus,
    this.minvCpus,
    this.placementGroup,
    this.securityGroupIds,
    this.subnets,
    this.tags,
    this.type,
    this.updateToLatestImageVersion,
  });
  Map<String, dynamic> toJson() {
    final allocationStrategy = this.allocationStrategy;
    final bidPercentage = this.bidPercentage;
    final desiredvCpus = this.desiredvCpus;
    final ec2Configuration = this.ec2Configuration;
    final ec2KeyPair = this.ec2KeyPair;
    final imageId = this.imageId;
    final instanceRole = this.instanceRole;
    final instanceTypes = this.instanceTypes;
    final launchTemplate = this.launchTemplate;
    final maxvCpus = this.maxvCpus;
    final minvCpus = this.minvCpus;
    final placementGroup = this.placementGroup;
    final securityGroupIds = this.securityGroupIds;
    final subnets = this.subnets;
    final tags = this.tags;
    final type = this.type;
    final updateToLatestImageVersion = this.updateToLatestImageVersion;
    return {
      if (allocationStrategy != null)
        'allocationStrategy': allocationStrategy.toValue(),
      if (bidPercentage != null) 'bidPercentage': bidPercentage,
      if (desiredvCpus != null) 'desiredvCpus': desiredvCpus,
      if (ec2Configuration != null) 'ec2Configuration': ec2Configuration,
      if (ec2KeyPair != null) 'ec2KeyPair': ec2KeyPair,
      if (imageId != null) 'imageId': imageId,
      if (instanceRole != null) 'instanceRole': instanceRole,
      if (instanceTypes != null) 'instanceTypes': instanceTypes,
      if (launchTemplate != null) 'launchTemplate': launchTemplate,
      if (maxvCpus != null) 'maxvCpus': maxvCpus,
      if (minvCpus != null) 'minvCpus': minvCpus,
      if (placementGroup != null) 'placementGroup': placementGroup,
      if (securityGroupIds != null) 'securityGroupIds': securityGroupIds,
      if (subnets != null) 'subnets': subnets,
      if (tags != null) 'tags': tags,
      if (type != null) 'type': type.toValue(),
      if (updateToLatestImageVersion != null)
        'updateToLatestImageVersion': updateToLatestImageVersion,
    };
  }
}

/// An object representing the details of a container that's part of a job.
class ContainerDetail {
  /// The command that's passed to the container.
  final List<String>? command;

  /// The Amazon Resource Name (ARN) of the container instance that the container
  /// is running on.
  final String? containerInstanceArn;

  /// The environment variables to pass to a container.
  /// <note>
  /// Environment variables must not start with <code>AWS_BATCH</code>; this
  /// naming convention is reserved for variables that are set by the Batch
  /// service.
  /// </note>
  final List<KeyValuePair>? environment;

  /// The Amazon Resource Name (ARN) of the execution role that Batch can assume.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/execution-IAM-role.html">Batch
  /// execution IAM role</a> in the <i>Batch User Guide</i>.
  final String? executionRoleArn;

  /// The exit code to return upon completion.
  final int? exitCode;

  /// The platform configuration for jobs that are running on Fargate resources.
  /// Jobs that are running on EC2 resources must not specify this parameter.
  final FargatePlatformConfiguration? fargatePlatformConfiguration;

  /// The image used to start the container.
  final String? image;

  /// The instance type of the underlying host infrastructure of a multi-node
  /// parallel job.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources.
  /// </note>
  final String? instanceType;

  /// The Amazon Resource Name (ARN) associated with the job upon execution.
  final String? jobRoleArn;

  /// Linux-specific modifications that are applied to the container, such as
  /// details for device mappings.
  final LinuxParameters? linuxParameters;

  /// The log configuration specification for the container.
  ///
  /// This parameter maps to <code>LogConfig</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--log-driver</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>. By
  /// default, containers use the same logging driver that the Docker daemon uses.
  /// However, the container might use a different logging driver than the Docker
  /// daemon by specifying a log driver with this parameter in the container
  /// definition. To use a different logging driver for a container, the log
  /// system must be configured properly on the container instance. Or,
  /// alternatively, it must be configured on a different log server for remote
  /// logging options. For more information on the options for different supported
  /// log drivers, see <a
  /// href="https://docs.docker.com/engine/admin/logging/overview/">Configure
  /// logging drivers</a> in the Docker documentation.
  /// <note>
  /// Batch currently supports a subset of the logging drivers available to the
  /// Docker daemon (shown in the <a>LogConfiguration</a> data type). Additional
  /// log drivers might be available in future releases of the Amazon ECS
  /// container agent.
  /// </note>
  /// This parameter requires version 1.18 of the Docker Remote API or greater on
  /// your container instance. To check the Docker Remote API version on your
  /// container instance, log into your container instance and run the following
  /// command: <code>sudo docker version | grep "Server API version"</code>
  /// <note>
  /// The Amazon ECS container agent running on a container instance must register
  /// the logging drivers available on that instance with the
  /// <code>ECS_AVAILABLE_LOGGING_DRIVERS</code> environment variable before
  /// containers placed on that instance can use these log configuration options.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html">Amazon
  /// ECS container agent configuration</a> in the <i>Amazon Elastic Container
  /// Service Developer Guide</i>.
  /// </note>
  final LogConfiguration? logConfiguration;

  /// The name of the CloudWatch Logs log stream associated with the container.
  /// The log group for Batch jobs is <code>/aws/batch/job</code>. Each container
  /// attempt receives a log stream name when they reach the <code>RUNNING</code>
  /// status.
  final String? logStreamName;

  /// For jobs running on EC2 resources that didn't specify memory requirements
  /// using <code>resourceRequirements</code>, the number of MiB of memory
  /// reserved for the job. For other jobs, including all run on Fargate
  /// resources, see <code>resourceRequirements</code>.
  final int? memory;

  /// The mount points for data volumes in your container.
  final List<MountPoint>? mountPoints;

  /// The network configuration for jobs that are running on Fargate resources.
  /// Jobs that are running on EC2 resources must not specify this parameter.
  final NetworkConfiguration? networkConfiguration;

  /// The network interfaces associated with the job.
  final List<NetworkInterface>? networkInterfaces;

  /// When this parameter is true, the container is given elevated permissions on
  /// the host container instance (similar to the <code>root</code> user). The
  /// default value is false.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources and shouldn't be provided, or specified as false.
  /// </note>
  final bool? privileged;

  /// When this parameter is true, the container is given read-only access to its
  /// root file system. This parameter maps to <code>ReadonlyRootfs</code> in the
  /// <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--read-only</code> option to <a
  /// href="https://docs.docker.com/engine/reference/commandline/run/">
  /// <code>docker run</code> </a>.
  final bool? readonlyRootFilesystem;

  /// A short (255 max characters) human-readable string to provide additional
  /// details about a running or stopped container.
  final String? reason;

  /// The type and amount of resources to assign to a container. The supported
  /// resources include <code>GPU</code>, <code>MEMORY</code>, and
  /// <code>VCPU</code>.
  final List<ResourceRequirement>? resourceRequirements;

  /// The secrets to pass to the container. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/specifying-sensitive-data.html">Specifying
  /// sensitive data</a> in the <i>Batch User Guide</i>.
  final List<Secret>? secrets;

  /// The Amazon Resource Name (ARN) of the Amazon ECS task that's associated with
  /// the container job. Each container attempt receives a task ARN when they
  /// reach the <code>STARTING</code> status.
  final String? taskArn;

  /// A list of <code>ulimit</code> values to set in the container. This parameter
  /// maps to <code>Ulimits</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--ulimit</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources.
  /// </note>
  final List<Ulimit>? ulimits;

  /// The user name to use inside the container. This parameter maps to
  /// <code>User</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--user</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>.
  final String? user;

  /// The number of vCPUs reserved for the container. For jobs that run on EC2
  /// resources, you can specify the vCPU requirement for the job using
  /// <code>resourceRequirements</code>, but you can't specify the vCPU
  /// requirements in both the <code>vcpus</code> and
  /// <code>resourceRequirements</code> object. This parameter maps to
  /// <code>CpuShares</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--cpu-shares</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>. Each
  /// vCPU is equivalent to 1,024 CPU shares. You must specify at least one vCPU.
  /// This is required but can be specified in several places. It must be
  /// specified for each node at least once.
  /// <note>
  /// This parameter isn't applicable to jobs that run on Fargate resources. For
  /// jobs that run on Fargate resources, you must specify the vCPU requirement
  /// for the job using <code>resourceRequirements</code>.
  /// </note>
  final int? vcpus;

  /// A list of volumes associated with the job.
  final List<Volume>? volumes;

  ContainerDetail({
    this.command,
    this.containerInstanceArn,
    this.environment,
    this.executionRoleArn,
    this.exitCode,
    this.fargatePlatformConfiguration,
    this.image,
    this.instanceType,
    this.jobRoleArn,
    this.linuxParameters,
    this.logConfiguration,
    this.logStreamName,
    this.memory,
    this.mountPoints,
    this.networkConfiguration,
    this.networkInterfaces,
    this.privileged,
    this.readonlyRootFilesystem,
    this.reason,
    this.resourceRequirements,
    this.secrets,
    this.taskArn,
    this.ulimits,
    this.user,
    this.vcpus,
    this.volumes,
  });
  factory ContainerDetail.fromJson(Map<String, dynamic> json) {
    return ContainerDetail(
      command: (json['command'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      containerInstanceArn: json['containerInstanceArn'] as String?,
      environment: (json['environment'] as List?)
          ?.whereNotNull()
          .map((e) => KeyValuePair.fromJson(e as Map<String, dynamic>))
          .toList(),
      executionRoleArn: json['executionRoleArn'] as String?,
      exitCode: json['exitCode'] as int?,
      fargatePlatformConfiguration: json['fargatePlatformConfiguration'] != null
          ? FargatePlatformConfiguration.fromJson(
              json['fargatePlatformConfiguration'] as Map<String, dynamic>)
          : null,
      image: json['image'] as String?,
      instanceType: json['instanceType'] as String?,
      jobRoleArn: json['jobRoleArn'] as String?,
      linuxParameters: json['linuxParameters'] != null
          ? LinuxParameters.fromJson(
              json['linuxParameters'] as Map<String, dynamic>)
          : null,
      logConfiguration: json['logConfiguration'] != null
          ? LogConfiguration.fromJson(
              json['logConfiguration'] as Map<String, dynamic>)
          : null,
      logStreamName: json['logStreamName'] as String?,
      memory: json['memory'] as int?,
      mountPoints: (json['mountPoints'] as List?)
          ?.whereNotNull()
          .map((e) => MountPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      networkConfiguration: json['networkConfiguration'] != null
          ? NetworkConfiguration.fromJson(
              json['networkConfiguration'] as Map<String, dynamic>)
          : null,
      networkInterfaces: (json['networkInterfaces'] as List?)
          ?.whereNotNull()
          .map((e) => NetworkInterface.fromJson(e as Map<String, dynamic>))
          .toList(),
      privileged: json['privileged'] as bool?,
      readonlyRootFilesystem: json['readonlyRootFilesystem'] as bool?,
      reason: json['reason'] as String?,
      resourceRequirements: (json['resourceRequirements'] as List?)
          ?.whereNotNull()
          .map((e) => ResourceRequirement.fromJson(e as Map<String, dynamic>))
          .toList(),
      secrets: (json['secrets'] as List?)
          ?.whereNotNull()
          .map((e) => Secret.fromJson(e as Map<String, dynamic>))
          .toList(),
      taskArn: json['taskArn'] as String?,
      ulimits: (json['ulimits'] as List?)
          ?.whereNotNull()
          .map((e) => Ulimit.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: json['user'] as String?,
      vcpus: json['vcpus'] as int?,
      volumes: (json['volumes'] as List?)
          ?.whereNotNull()
          .map((e) => Volume.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// The overrides that should be sent to a container.
class ContainerOverrides {
  /// The command to send to the container that overrides the default command from
  /// the Docker image or the job definition.
  final List<String>? command;

  /// The environment variables to send to the container. You can add new
  /// environment variables, which are added to the container at launch, or you
  /// can override the existing environment variables from the Docker image or the
  /// job definition.
  /// <note>
  /// Environment variables must not start with <code>AWS_BATCH</code>; this
  /// naming convention is reserved for variables that are set by the Batch
  /// service.
  /// </note>
  final List<KeyValuePair>? environment;

  /// The instance type to use for a multi-node parallel job.
  /// <note>
  /// This parameter isn't applicable to single-node container jobs or jobs that
  /// run on Fargate resources, and shouldn't be provided.
  /// </note>
  final String? instanceType;

  /// This parameter is deprecated, use <code>resourceRequirements</code> to
  /// override the memory requirements specified in the job definition. It's not
  /// supported for jobs running on Fargate resources. For jobs running on EC2
  /// resources, it overrides the <code>memory</code> parameter set in the job
  /// definition, but doesn't override any memory requirement specified in the
  /// <code>resourceRequirements</code> structure in the job definition. To
  /// override memory requirements that are specified in the
  /// <code>resourceRequirements</code> structure in the job definition,
  /// <code>resourceRequirements</code> must be specified in the
  /// <code>SubmitJob</code> request, with <code>type</code> set to
  /// <code>MEMORY</code> and <code>value</code> set to the new value. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/troubleshooting.html#override-resource-requirements">Can't
  /// override job definition resource requirements</a> in the <i>Batch User
  /// Guide</i>.
  final int? memory;

  /// The type and amount of resources to assign to a container. This overrides
  /// the settings in the job definition. The supported resources include
  /// <code>GPU</code>, <code>MEMORY</code>, and <code>VCPU</code>.
  final List<ResourceRequirement>? resourceRequirements;

  /// This parameter is deprecated, use <code>resourceRequirements</code> to
  /// override the <code>vcpus</code> parameter that's set in the job definition.
  /// It's not supported for jobs running on Fargate resources. For jobs running
  /// on EC2 resources, it overrides the <code>vcpus</code> parameter set in the
  /// job definition, but doesn't override any vCPU requirement specified in the
  /// <code>resourceRequirements</code> structure in the job definition. To
  /// override vCPU requirements that are specified in the
  /// <code>resourceRequirements</code> structure in the job definition,
  /// <code>resourceRequirements</code> must be specified in the
  /// <code>SubmitJob</code> request, with <code>type</code> set to
  /// <code>VCPU</code> and <code>value</code> set to the new value. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/troubleshooting.html#override-resource-requirements">Can't
  /// override job definition resource requirements</a> in the <i>Batch User
  /// Guide</i>.
  final int? vcpus;

  ContainerOverrides({
    this.command,
    this.environment,
    this.instanceType,
    this.memory,
    this.resourceRequirements,
    this.vcpus,
  });
  Map<String, dynamic> toJson() {
    final command = this.command;
    final environment = this.environment;
    final instanceType = this.instanceType;
    final memory = this.memory;
    final resourceRequirements = this.resourceRequirements;
    final vcpus = this.vcpus;
    return {
      if (command != null) 'command': command,
      if (environment != null) 'environment': environment,
      if (instanceType != null) 'instanceType': instanceType,
      if (memory != null) 'memory': memory,
      if (resourceRequirements != null)
        'resourceRequirements': resourceRequirements,
      if (vcpus != null) 'vcpus': vcpus,
    };
  }
}

/// Container properties are used in job definitions to describe the container
/// that's launched as part of a job.
class ContainerProperties {
  /// The command that's passed to the container. This parameter maps to
  /// <code>Cmd</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>COMMAND</code> parameter to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>. For
  /// more information, see <a
  /// href="https://docs.docker.com/engine/reference/builder/#cmd">https://docs.docker.com/engine/reference/builder/#cmd</a>.
  final List<String>? command;

  /// The environment variables to pass to a container. This parameter maps to
  /// <code>Env</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--env</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>.
  /// <important>
  /// We don't recommend using plaintext environment variables for sensitive
  /// information, such as credential data.
  /// </important> <note>
  /// Environment variables must not start with <code>AWS_BATCH</code>; this
  /// naming convention is reserved for variables that are set by the Batch
  /// service.
  /// </note>
  final List<KeyValuePair>? environment;

  /// The Amazon Resource Name (ARN) of the execution role that Batch can assume.
  /// For jobs that run on Fargate resources, you must provide an execution role.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/execution-IAM-role.html">Batch
  /// execution IAM role</a> in the <i>Batch User Guide</i>.
  final String? executionRoleArn;

  /// The platform configuration for jobs that are running on Fargate resources.
  /// Jobs that are running on EC2 resources must not specify this parameter.
  final FargatePlatformConfiguration? fargatePlatformConfiguration;

  /// The image used to start a container. This string is passed directly to the
  /// Docker daemon. Images in the Docker Hub registry are available by default.
  /// Other repositories are specified with <code>
  /// <i>repository-url</i>/<i>image</i>:<i>tag</i> </code>. Up to 255 letters
  /// (uppercase and lowercase), numbers, hyphens, underscores, colons, periods,
  /// forward slashes, and number signs are allowed. This parameter maps to
  /// <code>Image</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>IMAGE</code> parameter of <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>.
  /// <note>
  /// Docker image architecture must match the processor architecture of the
  /// compute resources that they're scheduled on. For example, ARM-based Docker
  /// images can only run on ARM-based compute resources.
  /// </note>
  /// <ul>
  /// <li>
  /// Images in Amazon ECR Public repositories use the full
  /// <code>registry/repository[:tag]</code> or
  /// <code>registry/repository[@digest]</code> naming conventions. For example,
  /// <code>public.ecr.aws/<i>registry_alias</i>/<i>my-web-app</i>:<i>latest</i>
  /// </code>.
  /// </li>
  /// <li>
  /// Images in Amazon ECR repositories use the full registry and repository URI
  /// (for example,
  /// <code>012345678910.dkr.ecr.&lt;region-name&gt;.amazonaws.com/&lt;repository-name&gt;</code>).
  /// </li>
  /// <li>
  /// Images in official repositories on Docker Hub use a single name (for
  /// example, <code>ubuntu</code> or <code>mongo</code>).
  /// </li>
  /// <li>
  /// Images in other repositories on Docker Hub are qualified with an
  /// organization name (for example, <code>amazon/amazon-ecs-agent</code>).
  /// </li>
  /// <li>
  /// Images in other online repositories are qualified further by a domain name
  /// (for example, <code>quay.io/assemblyline/ubuntu</code>).
  /// </li>
  /// </ul>
  final String? image;

  /// The instance type to use for a multi-node parallel job. All node groups in a
  /// multi-node parallel job must use the same instance type.
  /// <note>
  /// This parameter isn't applicable to single-node container jobs or jobs that
  /// run on Fargate resources, and shouldn't be provided.
  /// </note>
  final String? instanceType;

  /// The Amazon Resource Name (ARN) of the IAM role that the container can assume
  /// for Amazon Web Services permissions. For more information, see <a
  /// href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html">IAM
  /// roles for tasks</a> in the <i>Amazon Elastic Container Service Developer
  /// Guide</i>.
  final String? jobRoleArn;

  /// Linux-specific modifications that are applied to the container, such as
  /// details for device mappings.
  final LinuxParameters? linuxParameters;

  /// The log configuration specification for the container.
  ///
  /// This parameter maps to <code>LogConfig</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--log-driver</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>. By
  /// default, containers use the same logging driver that the Docker daemon uses.
  /// However the container might use a different logging driver than the Docker
  /// daemon by specifying a log driver with this parameter in the container
  /// definition. To use a different logging driver for a container, the log
  /// system must be configured properly on the container instance (or on a
  /// different log server for remote logging options). For more information on
  /// the options for different supported log drivers, see <a
  /// href="https://docs.docker.com/engine/admin/logging/overview/">Configure
  /// logging drivers</a> in the Docker documentation.
  /// <note>
  /// Batch currently supports a subset of the logging drivers available to the
  /// Docker daemon (shown in the <a>LogConfiguration</a> data type).
  /// </note>
  /// This parameter requires version 1.18 of the Docker Remote API or greater on
  /// your container instance. To check the Docker Remote API version on your
  /// container instance, log into your container instance and run the following
  /// command: <code>sudo docker version | grep "Server API version"</code>
  /// <note>
  /// The Amazon ECS container agent running on a container instance must register
  /// the logging drivers available on that instance with the
  /// <code>ECS_AVAILABLE_LOGGING_DRIVERS</code> environment variable before
  /// containers placed on that instance can use these log configuration options.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html">Amazon
  /// ECS container agent configuration</a> in the <i>Amazon Elastic Container
  /// Service Developer Guide</i>.
  /// </note>
  final LogConfiguration? logConfiguration;

  /// This parameter is deprecated, use <code>resourceRequirements</code> to
  /// specify the memory requirements for the job definition. It's not supported
  /// for jobs running on Fargate resources. For jobs running on EC2 resources, it
  /// specifies the memory hard limit (in MiB) for a container. If your container
  /// attempts to exceed the specified number, it's terminated. You must specify
  /// at least 4 MiB of memory for a job using this parameter. The memory hard
  /// limit can be specified in several places. It must be specified for each node
  /// at least once.
  final int? memory;

  /// The mount points for data volumes in your container. This parameter maps to
  /// <code>Volumes</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--volume</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>.
  final List<MountPoint>? mountPoints;

  /// The network configuration for jobs that are running on Fargate resources.
  /// Jobs that are running on EC2 resources must not specify this parameter.
  final NetworkConfiguration? networkConfiguration;

  /// When this parameter is true, the container is given elevated permissions on
  /// the host container instance (similar to the <code>root</code> user). This
  /// parameter maps to <code>Privileged</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--privileged</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>. The
  /// default value is false.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources and shouldn't be provided, or specified as false.
  /// </note>
  final bool? privileged;

  /// When this parameter is true, the container is given read-only access to its
  /// root file system. This parameter maps to <code>ReadonlyRootfs</code> in the
  /// <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--read-only</code> option to <code>docker run</code>.
  final bool? readonlyRootFilesystem;

  /// The type and amount of resources to assign to a container. The supported
  /// resources include <code>GPU</code>, <code>MEMORY</code>, and
  /// <code>VCPU</code>.
  final List<ResourceRequirement>? resourceRequirements;

  /// The secrets for the container. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/specifying-sensitive-data.html">Specifying
  /// sensitive data</a> in the <i>Batch User Guide</i>.
  final List<Secret>? secrets;

  /// A list of <code>ulimits</code> to set in the container. This parameter maps
  /// to <code>Ulimits</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--ulimit</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources and shouldn't be provided.
  /// </note>
  final List<Ulimit>? ulimits;

  /// The user name to use inside the container. This parameter maps to
  /// <code>User</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--user</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>.
  final String? user;

  /// This parameter is deprecated, use <code>resourceRequirements</code> to
  /// specify the vCPU requirements for the job definition. It's not supported for
  /// jobs running on Fargate resources. For jobs running on EC2 resources, it
  /// specifies the number of vCPUs reserved for the job.
  ///
  /// Each vCPU is equivalent to 1,024 CPU shares. This parameter maps to
  /// <code>CpuShares</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--cpu-shares</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>. The
  /// number of vCPUs must be specified but can be specified in several places.
  /// You must specify it at least once for each node.
  final int? vcpus;

  /// A list of data volumes used in a job.
  final List<Volume>? volumes;

  ContainerProperties({
    this.command,
    this.environment,
    this.executionRoleArn,
    this.fargatePlatformConfiguration,
    this.image,
    this.instanceType,
    this.jobRoleArn,
    this.linuxParameters,
    this.logConfiguration,
    this.memory,
    this.mountPoints,
    this.networkConfiguration,
    this.privileged,
    this.readonlyRootFilesystem,
    this.resourceRequirements,
    this.secrets,
    this.ulimits,
    this.user,
    this.vcpus,
    this.volumes,
  });
  factory ContainerProperties.fromJson(Map<String, dynamic> json) {
    return ContainerProperties(
      command: (json['command'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      environment: (json['environment'] as List?)
          ?.whereNotNull()
          .map((e) => KeyValuePair.fromJson(e as Map<String, dynamic>))
          .toList(),
      executionRoleArn: json['executionRoleArn'] as String?,
      fargatePlatformConfiguration: json['fargatePlatformConfiguration'] != null
          ? FargatePlatformConfiguration.fromJson(
              json['fargatePlatformConfiguration'] as Map<String, dynamic>)
          : null,
      image: json['image'] as String?,
      instanceType: json['instanceType'] as String?,
      jobRoleArn: json['jobRoleArn'] as String?,
      linuxParameters: json['linuxParameters'] != null
          ? LinuxParameters.fromJson(
              json['linuxParameters'] as Map<String, dynamic>)
          : null,
      logConfiguration: json['logConfiguration'] != null
          ? LogConfiguration.fromJson(
              json['logConfiguration'] as Map<String, dynamic>)
          : null,
      memory: json['memory'] as int?,
      mountPoints: (json['mountPoints'] as List?)
          ?.whereNotNull()
          .map((e) => MountPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      networkConfiguration: json['networkConfiguration'] != null
          ? NetworkConfiguration.fromJson(
              json['networkConfiguration'] as Map<String, dynamic>)
          : null,
      privileged: json['privileged'] as bool?,
      readonlyRootFilesystem: json['readonlyRootFilesystem'] as bool?,
      resourceRequirements: (json['resourceRequirements'] as List?)
          ?.whereNotNull()
          .map((e) => ResourceRequirement.fromJson(e as Map<String, dynamic>))
          .toList(),
      secrets: (json['secrets'] as List?)
          ?.whereNotNull()
          .map((e) => Secret.fromJson(e as Map<String, dynamic>))
          .toList(),
      ulimits: (json['ulimits'] as List?)
          ?.whereNotNull()
          .map((e) => Ulimit.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: json['user'] as String?,
      vcpus: json['vcpus'] as int?,
      volumes: (json['volumes'] as List?)
          ?.whereNotNull()
          .map((e) => Volume.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final command = this.command;
    final environment = this.environment;
    final executionRoleArn = this.executionRoleArn;
    final fargatePlatformConfiguration = this.fargatePlatformConfiguration;
    final image = this.image;
    final instanceType = this.instanceType;
    final jobRoleArn = this.jobRoleArn;
    final linuxParameters = this.linuxParameters;
    final logConfiguration = this.logConfiguration;
    final memory = this.memory;
    final mountPoints = this.mountPoints;
    final networkConfiguration = this.networkConfiguration;
    final privileged = this.privileged;
    final readonlyRootFilesystem = this.readonlyRootFilesystem;
    final resourceRequirements = this.resourceRequirements;
    final secrets = this.secrets;
    final ulimits = this.ulimits;
    final user = this.user;
    final vcpus = this.vcpus;
    final volumes = this.volumes;
    return {
      if (command != null) 'command': command,
      if (environment != null) 'environment': environment,
      if (executionRoleArn != null) 'executionRoleArn': executionRoleArn,
      if (fargatePlatformConfiguration != null)
        'fargatePlatformConfiguration': fargatePlatformConfiguration,
      if (image != null) 'image': image,
      if (instanceType != null) 'instanceType': instanceType,
      if (jobRoleArn != null) 'jobRoleArn': jobRoleArn,
      if (linuxParameters != null) 'linuxParameters': linuxParameters,
      if (logConfiguration != null) 'logConfiguration': logConfiguration,
      if (memory != null) 'memory': memory,
      if (mountPoints != null) 'mountPoints': mountPoints,
      if (networkConfiguration != null)
        'networkConfiguration': networkConfiguration,
      if (privileged != null) 'privileged': privileged,
      if (readonlyRootFilesystem != null)
        'readonlyRootFilesystem': readonlyRootFilesystem,
      if (resourceRequirements != null)
        'resourceRequirements': resourceRequirements,
      if (secrets != null) 'secrets': secrets,
      if (ulimits != null) 'ulimits': ulimits,
      if (user != null) 'user': user,
      if (vcpus != null) 'vcpus': vcpus,
      if (volumes != null) 'volumes': volumes,
    };
  }
}

/// An object representing summary details of a container within a job.
class ContainerSummary {
  /// The exit code to return upon completion.
  final int? exitCode;

  /// A short (255 max characters) human-readable string to provide additional
  /// details about a running or stopped container.
  final String? reason;

  ContainerSummary({
    this.exitCode,
    this.reason,
  });
  factory ContainerSummary.fromJson(Map<String, dynamic> json) {
    return ContainerSummary(
      exitCode: json['exitCode'] as int?,
      reason: json['reason'] as String?,
    );
  }
}

class CreateComputeEnvironmentResponse {
  /// The Amazon Resource Name (ARN) of the compute environment.
  final String? computeEnvironmentArn;

  /// The name of the compute environment. It can be up to 128 letters long. It
  /// can contain uppercase and lowercase letters, numbers, hyphens (-), and
  /// underscores (_).
  final String? computeEnvironmentName;

  CreateComputeEnvironmentResponse({
    this.computeEnvironmentArn,
    this.computeEnvironmentName,
  });
  factory CreateComputeEnvironmentResponse.fromJson(Map<String, dynamic> json) {
    return CreateComputeEnvironmentResponse(
      computeEnvironmentArn: json['computeEnvironmentArn'] as String?,
      computeEnvironmentName: json['computeEnvironmentName'] as String?,
    );
  }
}

class CreateJobQueueResponse {
  /// The Amazon Resource Name (ARN) of the job queue.
  final String jobQueueArn;

  /// The name of the job queue.
  final String jobQueueName;

  CreateJobQueueResponse({
    required this.jobQueueArn,
    required this.jobQueueName,
  });
  factory CreateJobQueueResponse.fromJson(Map<String, dynamic> json) {
    return CreateJobQueueResponse(
      jobQueueArn: json['jobQueueArn'] as String,
      jobQueueName: json['jobQueueName'] as String,
    );
  }
}

class CreateSchedulingPolicyResponse {
  /// The Amazon Resource Name (ARN) of the scheduling policy. The format is
  /// <code>aws:<i>Partition</i>:batch:<i>Region</i>:<i>Account</i>:scheduling-policy/<i>Name</i>
  /// </code>. For example,
  /// <code>aws:aws:batch:us-west-2:012345678910:scheduling-policy/MySchedulingPolicy</code>.
  final String arn;

  /// The name of the scheduling policy.
  final String name;

  CreateSchedulingPolicyResponse({
    required this.arn,
    required this.name,
  });
  factory CreateSchedulingPolicyResponse.fromJson(Map<String, dynamic> json) {
    return CreateSchedulingPolicyResponse(
      arn: json['arn'] as String,
      name: json['name'] as String,
    );
  }
}

class DeleteComputeEnvironmentResponse {
  DeleteComputeEnvironmentResponse();
  factory DeleteComputeEnvironmentResponse.fromJson(Map<String, dynamic> _) {
    return DeleteComputeEnvironmentResponse();
  }
}

class DeleteJobQueueResponse {
  DeleteJobQueueResponse();
  factory DeleteJobQueueResponse.fromJson(Map<String, dynamic> _) {
    return DeleteJobQueueResponse();
  }
}

class DeleteSchedulingPolicyResponse {
  DeleteSchedulingPolicyResponse();
  factory DeleteSchedulingPolicyResponse.fromJson(Map<String, dynamic> _) {
    return DeleteSchedulingPolicyResponse();
  }
}

class DeregisterJobDefinitionResponse {
  DeregisterJobDefinitionResponse();
  factory DeregisterJobDefinitionResponse.fromJson(Map<String, dynamic> _) {
    return DeregisterJobDefinitionResponse();
  }
}

class DescribeComputeEnvironmentsResponse {
  /// The list of compute environments.
  final List<ComputeEnvironmentDetail>? computeEnvironments;

  /// The <code>nextToken</code> value to include in a future
  /// <code>DescribeComputeEnvironments</code> request. When the results of a
  /// <code>DescribeComputeEnvironments</code> request exceed
  /// <code>maxResults</code>, this value can be used to retrieve the next page of
  /// results. This value is <code>null</code> when there are no more results to
  /// return.
  final String? nextToken;

  DescribeComputeEnvironmentsResponse({
    this.computeEnvironments,
    this.nextToken,
  });
  factory DescribeComputeEnvironmentsResponse.fromJson(
      Map<String, dynamic> json) {
    return DescribeComputeEnvironmentsResponse(
      computeEnvironments: (json['computeEnvironments'] as List?)
          ?.whereNotNull()
          .map((e) =>
              ComputeEnvironmentDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['nextToken'] as String?,
    );
  }
}

class DescribeJobDefinitionsResponse {
  /// The list of job definitions.
  final List<JobDefinition>? jobDefinitions;

  /// The <code>nextToken</code> value to include in a future
  /// <code>DescribeJobDefinitions</code> request. When the results of a
  /// <code>DescribeJobDefinitions</code> request exceed <code>maxResults</code>,
  /// this value can be used to retrieve the next page of results. This value is
  /// <code>null</code> when there are no more results to return.
  final String? nextToken;

  DescribeJobDefinitionsResponse({
    this.jobDefinitions,
    this.nextToken,
  });
  factory DescribeJobDefinitionsResponse.fromJson(Map<String, dynamic> json) {
    return DescribeJobDefinitionsResponse(
      jobDefinitions: (json['jobDefinitions'] as List?)
          ?.whereNotNull()
          .map((e) => JobDefinition.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['nextToken'] as String?,
    );
  }
}

class DescribeJobQueuesResponse {
  /// The list of job queues.
  final List<JobQueueDetail>? jobQueues;

  /// The <code>nextToken</code> value to include in a future
  /// <code>DescribeJobQueues</code> request. When the results of a
  /// <code>DescribeJobQueues</code> request exceed <code>maxResults</code>, this
  /// value can be used to retrieve the next page of results. This value is
  /// <code>null</code> when there are no more results to return.
  final String? nextToken;

  DescribeJobQueuesResponse({
    this.jobQueues,
    this.nextToken,
  });
  factory DescribeJobQueuesResponse.fromJson(Map<String, dynamic> json) {
    return DescribeJobQueuesResponse(
      jobQueues: (json['jobQueues'] as List?)
          ?.whereNotNull()
          .map((e) => JobQueueDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['nextToken'] as String?,
    );
  }
}

class DescribeJobsResponse {
  /// The list of jobs.
  final List<JobDetail>? jobs;

  DescribeJobsResponse({
    this.jobs,
  });
  factory DescribeJobsResponse.fromJson(Map<String, dynamic> json) {
    return DescribeJobsResponse(
      jobs: (json['jobs'] as List?)
          ?.whereNotNull()
          .map((e) => JobDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DescribeSchedulingPoliciesResponse {
  /// The list of scheduling policies.
  final List<SchedulingPolicyDetail>? schedulingPolicies;

  DescribeSchedulingPoliciesResponse({
    this.schedulingPolicies,
  });
  factory DescribeSchedulingPoliciesResponse.fromJson(
      Map<String, dynamic> json) {
    return DescribeSchedulingPoliciesResponse(
      schedulingPolicies: (json['schedulingPolicies'] as List?)
          ?.whereNotNull()
          .map(
              (e) => SchedulingPolicyDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// An object representing a container instance host device.
/// <note>
/// This object isn't applicable to jobs that are running on Fargate resources
/// and shouldn't be provided.
/// </note>
class Device {
  /// The path for the device on the host container instance.
  final String hostPath;

  /// The path inside the container that's used to expose the host device. By
  /// default, the <code>hostPath</code> value is used.
  final String? containerPath;

  /// The explicit permissions to provide to the container for the device. By
  /// default, the container has permissions for <code>read</code>,
  /// <code>write</code>, and <code>mknod</code> for the device.
  final List<DeviceCgroupPermission>? permissions;

  Device({
    required this.hostPath,
    this.containerPath,
    this.permissions,
  });
  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      hostPath: json['hostPath'] as String,
      containerPath: json['containerPath'] as String?,
      permissions: (json['permissions'] as List?)
          ?.whereNotNull()
          .map((e) => (e as String).toDeviceCgroupPermission())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final hostPath = this.hostPath;
    final containerPath = this.containerPath;
    final permissions = this.permissions;
    return {
      'hostPath': hostPath,
      if (containerPath != null) 'containerPath': containerPath,
      if (permissions != null)
        'permissions': permissions.map((e) => e.toValue()).toList(),
    };
  }
}

enum DeviceCgroupPermission {
  read,
  write,
  mknod,
}

extension on DeviceCgroupPermission {
  String toValue() {
    switch (this) {
      case DeviceCgroupPermission.read:
        return 'READ';
      case DeviceCgroupPermission.write:
        return 'WRITE';
      case DeviceCgroupPermission.mknod:
        return 'MKNOD';
    }
  }
}

extension on String {
  DeviceCgroupPermission toDeviceCgroupPermission() {
    switch (this) {
      case 'READ':
        return DeviceCgroupPermission.read;
      case 'WRITE':
        return DeviceCgroupPermission.write;
      case 'MKNOD':
        return DeviceCgroupPermission.mknod;
    }
    throw Exception('$this is not known in enum DeviceCgroupPermission');
  }
}

/// The authorization configuration details for the Amazon EFS file system.
class EFSAuthorizationConfig {
  /// The Amazon EFS access point ID to use. If an access point is specified, the
  /// root directory value specified in the <code>EFSVolumeConfiguration</code>
  /// must either be omitted or set to <code>/</code> which will enforce the path
  /// set on the EFS access point. If an access point is used, transit encryption
  /// must be enabled in the <code>EFSVolumeConfiguration</code>. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/efs/latest/ug/efs-access-points.html">Working
  /// with Amazon EFS access points</a> in the <i>Amazon Elastic File System User
  /// Guide</i>.
  final String? accessPointId;

  /// Whether or not to use the Batch job IAM role defined in a job definition
  /// when mounting the Amazon EFS file system. If enabled, transit encryption
  /// must be enabled in the <code>EFSVolumeConfiguration</code>. If this
  /// parameter is omitted, the default value of <code>DISABLED</code> is used.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/efs-volumes.html#efs-volume-accesspoints">Using
  /// Amazon EFS access points</a> in the <i>Batch User Guide</i>. EFS IAM
  /// authorization requires that <code>TransitEncryption</code> be
  /// <code>ENABLED</code> and that a <code>JobRoleArn</code> is specified.
  final EFSAuthorizationConfigIAM? iam;

  EFSAuthorizationConfig({
    this.accessPointId,
    this.iam,
  });
  factory EFSAuthorizationConfig.fromJson(Map<String, dynamic> json) {
    return EFSAuthorizationConfig(
      accessPointId: json['accessPointId'] as String?,
      iam: (json['iam'] as String?)?.toEFSAuthorizationConfigIAM(),
    );
  }

  Map<String, dynamic> toJson() {
    final accessPointId = this.accessPointId;
    final iam = this.iam;
    return {
      if (accessPointId != null) 'accessPointId': accessPointId,
      if (iam != null) 'iam': iam.toValue(),
    };
  }
}

enum EFSAuthorizationConfigIAM {
  enabled,
  disabled,
}

extension on EFSAuthorizationConfigIAM {
  String toValue() {
    switch (this) {
      case EFSAuthorizationConfigIAM.enabled:
        return 'ENABLED';
      case EFSAuthorizationConfigIAM.disabled:
        return 'DISABLED';
    }
  }
}

extension on String {
  EFSAuthorizationConfigIAM toEFSAuthorizationConfigIAM() {
    switch (this) {
      case 'ENABLED':
        return EFSAuthorizationConfigIAM.enabled;
      case 'DISABLED':
        return EFSAuthorizationConfigIAM.disabled;
    }
    throw Exception('$this is not known in enum EFSAuthorizationConfigIAM');
  }
}

enum EFSTransitEncryption {
  enabled,
  disabled,
}

extension on EFSTransitEncryption {
  String toValue() {
    switch (this) {
      case EFSTransitEncryption.enabled:
        return 'ENABLED';
      case EFSTransitEncryption.disabled:
        return 'DISABLED';
    }
  }
}

extension on String {
  EFSTransitEncryption toEFSTransitEncryption() {
    switch (this) {
      case 'ENABLED':
        return EFSTransitEncryption.enabled;
      case 'DISABLED':
        return EFSTransitEncryption.disabled;
    }
    throw Exception('$this is not known in enum EFSTransitEncryption');
  }
}

/// This is used when you're using an Amazon Elastic File System file system for
/// job storage. For more information, see <a
/// href="https://docs.aws.amazon.com/batch/latest/userguide/efs-volumes.html">Amazon
/// EFS Volumes</a> in the <i>Batch User Guide</i>.
class EFSVolumeConfiguration {
  /// The Amazon EFS file system ID to use.
  final String fileSystemId;

  /// The authorization configuration details for the Amazon EFS file system.
  final EFSAuthorizationConfig? authorizationConfig;

  /// The directory within the Amazon EFS file system to mount as the root
  /// directory inside the host. If this parameter is omitted, the root of the
  /// Amazon EFS volume is used instead. Specifying <code>/</code> has the same
  /// effect as omitting this parameter. The maximum length is 4,096 characters.
  /// <important>
  /// If an EFS access point is specified in the <code>authorizationConfig</code>,
  /// the root directory parameter must either be omitted or set to
  /// <code>/</code>, which enforces the path set on the Amazon EFS access point.
  /// </important>
  final String? rootDirectory;

  /// Determines whether to enable encryption for Amazon EFS data in transit
  /// between the Amazon ECS host and the Amazon EFS server. Transit encryption
  /// must be enabled if Amazon EFS IAM authorization is used. If this parameter
  /// is omitted, the default value of <code>DISABLED</code> is used. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/efs/latest/ug/encryption-in-transit.html">Encrypting
  /// data in transit</a> in the <i>Amazon Elastic File System User Guide</i>.
  final EFSTransitEncryption? transitEncryption;

  /// The port to use when sending encrypted data between the Amazon ECS host and
  /// the Amazon EFS server. If you don't specify a transit encryption port, it
  /// uses the port selection strategy that the Amazon EFS mount helper uses. The
  /// value must be between 0 and 65,535. For more information, see <a
  /// href="https://docs.aws.amazon.com/efs/latest/ug/efs-mount-helper.html">EFS
  /// mount helper</a> in the <i>Amazon Elastic File System User Guide</i>.
  final int? transitEncryptionPort;

  EFSVolumeConfiguration({
    required this.fileSystemId,
    this.authorizationConfig,
    this.rootDirectory,
    this.transitEncryption,
    this.transitEncryptionPort,
  });
  factory EFSVolumeConfiguration.fromJson(Map<String, dynamic> json) {
    return EFSVolumeConfiguration(
      fileSystemId: json['fileSystemId'] as String,
      authorizationConfig: json['authorizationConfig'] != null
          ? EFSAuthorizationConfig.fromJson(
              json['authorizationConfig'] as Map<String, dynamic>)
          : null,
      rootDirectory: json['rootDirectory'] as String?,
      transitEncryption:
          (json['transitEncryption'] as String?)?.toEFSTransitEncryption(),
      transitEncryptionPort: json['transitEncryptionPort'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final fileSystemId = this.fileSystemId;
    final authorizationConfig = this.authorizationConfig;
    final rootDirectory = this.rootDirectory;
    final transitEncryption = this.transitEncryption;
    final transitEncryptionPort = this.transitEncryptionPort;
    return {
      'fileSystemId': fileSystemId,
      if (authorizationConfig != null)
        'authorizationConfig': authorizationConfig,
      if (rootDirectory != null) 'rootDirectory': rootDirectory,
      if (transitEncryption != null)
        'transitEncryption': transitEncryption.toValue(),
      if (transitEncryptionPort != null)
        'transitEncryptionPort': transitEncryptionPort,
    };
  }
}

/// Provides information used to select Amazon Machine Images (AMIs) for
/// instances in the compute environment. If <code>Ec2Configuration</code> isn't
/// specified, the default is <code>ECS_AL2</code> (<a
/// href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html#al2ami">Amazon
/// Linux 2</a>).
/// <note>
/// This object isn't applicable to jobs that are running on Fargate resources.
/// </note>
class Ec2Configuration {
  /// The image type to match with the instance type to select an AMI. If the
  /// <code>imageIdOverride</code> parameter isn't specified, then a recent <a
  /// href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html#al2ami">Amazon
  /// ECS-optimized Amazon Linux 2 AMI</a> (<code>ECS_AL2</code>) is used. If a
  /// new image type is specified in an update, but neither an
  /// <code>imageId</code> nor a <code>imageIdOverride</code> parameter is
  /// specified, then the latest Amazon ECS optimized AMI for that image type
  /// that's supported by Batch is used.
  /// <dl> <dt>ECS_AL2</dt> <dd>
  /// <a
  /// href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html#al2ami">Amazon
  /// Linux 2</a>− Default for all non-GPU instance families.
  /// </dd> <dt>ECS_AL2_NVIDIA</dt> <dd>
  /// <a
  /// href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html#gpuami">Amazon
  /// Linux 2 (GPU)</a>−Default for all GPU instance families (for example
  /// <code>P4</code> and <code>G4</code>) and can be used for all non Amazon Web
  /// Services Graviton-based instance types.
  /// </dd> <dt>ECS_AL1</dt> <dd>
  /// <a
  /// href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html#alami">Amazon
  /// Linux</a>. Amazon Linux is reaching the end-of-life of standard support. For
  /// more information, see <a
  /// href="http://aws.amazon.com/amazon-linux-ami/">Amazon Linux AMI</a>.
  /// </dd> </dl>
  final String imageType;

  /// The AMI ID used for instances launched in the compute environment that match
  /// the image type. This setting overrides the <code>imageId</code> set in the
  /// <code>computeResource</code> object.
  /// <note>
  /// The AMI that you choose for a compute environment must match the
  /// architecture of the instance types that you intend to use for that compute
  /// environment. For example, if your compute environment uses A1 instance
  /// types, the compute resource AMI that you choose must support ARM instances.
  /// Amazon ECS vends both x86 and ARM versions of the Amazon ECS-optimized
  /// Amazon Linux 2 AMI. For more information, see <a
  /// href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html#ecs-optimized-ami-linux-variants.html">Amazon
  /// ECS-optimized Amazon Linux 2 AMI</a> in the <i>Amazon Elastic Container
  /// Service Developer Guide</i>.
  /// </note>
  final String? imageIdOverride;

  Ec2Configuration({
    required this.imageType,
    this.imageIdOverride,
  });
  factory Ec2Configuration.fromJson(Map<String, dynamic> json) {
    return Ec2Configuration(
      imageType: json['imageType'] as String,
      imageIdOverride: json['imageIdOverride'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final imageType = this.imageType;
    final imageIdOverride = this.imageIdOverride;
    return {
      'imageType': imageType,
      if (imageIdOverride != null) 'imageIdOverride': imageIdOverride,
    };
  }
}

/// Specifies a set of conditions to be met, and an action to take
/// (<code>RETRY</code> or <code>EXIT</code>) if all conditions are met.
class EvaluateOnExit {
  /// Specifies the action to take if all of the specified conditions
  /// (<code>onStatusReason</code>, <code>onReason</code>, and
  /// <code>onExitCode</code>) are met. The values aren't case sensitive.
  final RetryAction action;

  /// Contains a glob pattern to match against the decimal representation of the
  /// <code>ExitCode</code> returned for a job. The pattern can be up to 512
  /// characters in length. It can contain only numbers, and can optionally end
  /// with an asterisk (*) so that only the start of the string needs to be an
  /// exact match.
  ///
  /// The string can be between 1 and 512 characters in length.
  final String? onExitCode;

  /// Contains a glob pattern to match against the <code>Reason</code> returned
  /// for a job. The pattern can be up to 512 characters in length. It can contain
  /// letters, numbers, periods (.), colons (:), and white space (including spaces
  /// and tabs). It can optionally end with an asterisk (*) so that only the start
  /// of the string needs to be an exact match.
  ///
  /// The string can be between 1 and 512 characters in length.
  final String? onReason;

  /// Contains a glob pattern to match against the <code>StatusReason</code>
  /// returned for a job. The pattern can be up to 512 characters in length. It
  /// can contain letters, numbers, periods (.), colons (:), and white space
  /// (including spaces or tabs). It can optionally end with an asterisk (*) so
  /// that only the start of the string needs to be an exact match.
  ///
  /// The string can be between 1 and 512 characters in length.
  final String? onStatusReason;

  EvaluateOnExit({
    required this.action,
    this.onExitCode,
    this.onReason,
    this.onStatusReason,
  });
  factory EvaluateOnExit.fromJson(Map<String, dynamic> json) {
    return EvaluateOnExit(
      action: (json['action'] as String).toRetryAction(),
      onExitCode: json['onExitCode'] as String?,
      onReason: json['onReason'] as String?,
      onStatusReason: json['onStatusReason'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final action = this.action;
    final onExitCode = this.onExitCode;
    final onReason = this.onReason;
    final onStatusReason = this.onStatusReason;
    return {
      'action': action.toValue(),
      if (onExitCode != null) 'onExitCode': onExitCode,
      if (onReason != null) 'onReason': onReason,
      if (onStatusReason != null) 'onStatusReason': onStatusReason,
    };
  }
}

/// The fair share policy for a scheduling policy.
class FairsharePolicy {
  /// A value used to reserve some of the available maximum vCPU for fair share
  /// identifiers that have not yet been used.
  ///
  /// The reserved ratio is
  /// <code>(<i>computeReservation</i>/100)^<i>ActiveFairShares</i> </code> where
  /// <code> <i>ActiveFairShares</i> </code> is the number of active fair share
  /// identifiers.
  ///
  /// For example, a <code>computeReservation</code> value of 50 indicates that
  /// Batch should reserve 50% of the maximum available vCPU if there is only one
  /// fair share identifier, 25% if there are two fair share identifiers, and
  /// 12.5% if there are three fair share identifiers. A
  /// <code>computeReservation</code> value of 25 indicates that Batch should
  /// reserve 25% of the maximum available vCPU if there is only one fair share
  /// identifier, 6.25% if there are two fair share identifiers, and 1.56% if
  /// there are three fair share identifiers.
  ///
  /// The minimum value is 0 and the maximum value is 99.
  final int? computeReservation;

  /// The time period to use to calculate a fair share percentage for each fair
  /// share identifier in use, in seconds. A value of zero (0) indicates that only
  /// current usage should be measured. The decay allows for more recently run
  /// jobs to have more weight than jobs that ran earlier. The maximum supported
  /// value is 604800 (1 week).
  final int? shareDecaySeconds;

  /// An array of <code>SharedIdentifier</code> objects that contain the weights
  /// for the fair share identifiers for the fair share policy. Fair share
  /// identifiers that aren't included have a default weight of <code>1.0</code>.
  final List<ShareAttributes>? shareDistribution;

  FairsharePolicy({
    this.computeReservation,
    this.shareDecaySeconds,
    this.shareDistribution,
  });
  factory FairsharePolicy.fromJson(Map<String, dynamic> json) {
    return FairsharePolicy(
      computeReservation: json['computeReservation'] as int?,
      shareDecaySeconds: json['shareDecaySeconds'] as int?,
      shareDistribution: (json['shareDistribution'] as List?)
          ?.whereNotNull()
          .map((e) => ShareAttributes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final computeReservation = this.computeReservation;
    final shareDecaySeconds = this.shareDecaySeconds;
    final shareDistribution = this.shareDistribution;
    return {
      if (computeReservation != null) 'computeReservation': computeReservation,
      if (shareDecaySeconds != null) 'shareDecaySeconds': shareDecaySeconds,
      if (shareDistribution != null) 'shareDistribution': shareDistribution,
    };
  }
}

/// The platform configuration for jobs that are running on Fargate resources.
/// Jobs that run on EC2 resources must not specify this parameter.
class FargatePlatformConfiguration {
  /// The Fargate platform version where the jobs are running. A platform version
  /// is specified only for jobs that are running on Fargate resources. If one
  /// isn't specified, the <code>LATEST</code> platform version is used by
  /// default. This uses a recent, approved version of the Fargate platform for
  /// compute resources. For more information, see <a
  /// href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html">Fargate
  /// platform versions</a> in the <i>Amazon Elastic Container Service Developer
  /// Guide</i>.
  final String? platformVersion;

  FargatePlatformConfiguration({
    this.platformVersion,
  });
  factory FargatePlatformConfiguration.fromJson(Map<String, dynamic> json) {
    return FargatePlatformConfiguration(
      platformVersion: json['platformVersion'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final platformVersion = this.platformVersion;
    return {
      if (platformVersion != null) 'platformVersion': platformVersion,
    };
  }
}

/// Determine whether your data volume persists on the host container instance
/// and where it is stored. If this parameter is empty, then the Docker daemon
/// assigns a host path for your data volume, but the data isn't guaranteed to
/// persist after the containers associated with it stop running.
class Host {
  /// The path on the host container instance that's presented to the container.
  /// If this parameter is empty, then the Docker daemon has assigned a host path
  /// for you. If this parameter contains a file location, then the data volume
  /// persists at the specified location on the host container instance until you
  /// delete it manually. If the source path location doesn't exist on the host
  /// container instance, the Docker daemon creates it. If the location does
  /// exist, the contents of the source path folder are exported.
  /// <note>
  /// This parameter isn't applicable to jobs that run on Fargate resources and
  /// shouldn't be provided.
  /// </note>
  final String? sourcePath;

  Host({
    this.sourcePath,
  });
  factory Host.fromJson(Map<String, dynamic> json) {
    return Host(
      sourcePath: json['sourcePath'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final sourcePath = this.sourcePath;
    return {
      if (sourcePath != null) 'sourcePath': sourcePath,
    };
  }
}

enum JQState {
  enabled,
  disabled,
}

extension on JQState {
  String toValue() {
    switch (this) {
      case JQState.enabled:
        return 'ENABLED';
      case JQState.disabled:
        return 'DISABLED';
    }
  }
}

extension on String {
  JQState toJQState() {
    switch (this) {
      case 'ENABLED':
        return JQState.enabled;
      case 'DISABLED':
        return JQState.disabled;
    }
    throw Exception('$this is not known in enum JQState');
  }
}

enum JQStatus {
  creating,
  updating,
  deleting,
  deleted,
  valid,
  invalid,
}

extension on JQStatus {
  String toValue() {
    switch (this) {
      case JQStatus.creating:
        return 'CREATING';
      case JQStatus.updating:
        return 'UPDATING';
      case JQStatus.deleting:
        return 'DELETING';
      case JQStatus.deleted:
        return 'DELETED';
      case JQStatus.valid:
        return 'VALID';
      case JQStatus.invalid:
        return 'INVALID';
    }
  }
}

extension on String {
  JQStatus toJQStatus() {
    switch (this) {
      case 'CREATING':
        return JQStatus.creating;
      case 'UPDATING':
        return JQStatus.updating;
      case 'DELETING':
        return JQStatus.deleting;
      case 'DELETED':
        return JQStatus.deleted;
      case 'VALID':
        return JQStatus.valid;
      case 'INVALID':
        return JQStatus.invalid;
    }
    throw Exception('$this is not known in enum JQStatus');
  }
}

/// An object representing an Batch job definition.
class JobDefinition {
  /// The Amazon Resource Name (ARN) for the job definition.
  final String jobDefinitionArn;

  /// The name of the job definition.
  final String jobDefinitionName;

  /// The revision of the job definition.
  final int revision;

  /// The type of job definition, either <code>container</code> or
  /// <code>multinode</code>. If the job is run on Fargate resources, then
  /// <code>multinode</code> isn't supported. For more information about
  /// multi-node parallel jobs, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/multi-node-job-def.html">Creating
  /// a multi-node parallel job definition</a> in the <i>Batch User Guide</i>.
  final String type;

  /// An object with various properties specific to container-based jobs.
  final ContainerProperties? containerProperties;

  /// An object with various properties specific to multi-node parallel jobs.
  /// <note>
  /// If the job runs on Fargate resources, then you must not specify
  /// <code>nodeProperties</code>; use <code>containerProperties</code> instead.
  /// </note>
  final NodeProperties? nodeProperties;

  /// Default parameters or parameter substitution placeholders that are set in
  /// the job definition. Parameters are specified as a key-value pair mapping.
  /// Parameters in a <code>SubmitJob</code> request override any corresponding
  /// parameter defaults from the job definition. For more information about
  /// specifying parameters, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/job_definition_parameters.html">Job
  /// definition parameters</a> in the <i>Batch User Guide</i>.
  final Map<String, String>? parameters;

  /// The platform capabilities required by the job definition. If no value is
  /// specified, it defaults to <code>EC2</code>. Jobs run on Fargate resources
  /// specify <code>FARGATE</code>.
  final List<PlatformCapability>? platformCapabilities;

  /// Specifies whether to propagate the tags from the job or job definition to
  /// the corresponding Amazon ECS task. If no value is specified, the tags aren't
  /// propagated. Tags can only be propagated to the tasks during task creation.
  /// For tags with the same name, job tags are given priority over job
  /// definitions tags. If the total number of combined tags from the job and job
  /// definition is over 50, the job is moved to the <code>FAILED</code> state.
  final bool? propagateTags;

  /// The retry strategy to use for failed jobs that are submitted with this job
  /// definition.
  final RetryStrategy? retryStrategy;

  /// The scheduling priority of the job definition. This only affects jobs in job
  /// queues with a fair share policy. Jobs with a higher scheduling priority are
  /// scheduled before jobs with a lower scheduling priority.
  final int? schedulingPriority;

  /// The status of the job definition.
  final String? status;

  /// The tags applied to the job definition.
  final Map<String, String>? tags;

  /// The timeout configuration for jobs that are submitted with this job
  /// definition. You can specify a timeout duration after which Batch terminates
  /// your jobs if they haven't finished.
  final JobTimeout? timeout;

  JobDefinition({
    required this.jobDefinitionArn,
    required this.jobDefinitionName,
    required this.revision,
    required this.type,
    this.containerProperties,
    this.nodeProperties,
    this.parameters,
    this.platformCapabilities,
    this.propagateTags,
    this.retryStrategy,
    this.schedulingPriority,
    this.status,
    this.tags,
    this.timeout,
  });
  factory JobDefinition.fromJson(Map<String, dynamic> json) {
    return JobDefinition(
      jobDefinitionArn: json['jobDefinitionArn'] as String,
      jobDefinitionName: json['jobDefinitionName'] as String,
      revision: json['revision'] as int,
      type: json['type'] as String,
      containerProperties: json['containerProperties'] != null
          ? ContainerProperties.fromJson(
              json['containerProperties'] as Map<String, dynamic>)
          : null,
      nodeProperties: json['nodeProperties'] != null
          ? NodeProperties.fromJson(
              json['nodeProperties'] as Map<String, dynamic>)
          : null,
      parameters: (json['parameters'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      platformCapabilities: (json['platformCapabilities'] as List?)
          ?.whereNotNull()
          .map((e) => (e as String).toPlatformCapability())
          .toList(),
      propagateTags: json['propagateTags'] as bool?,
      retryStrategy: json['retryStrategy'] != null
          ? RetryStrategy.fromJson(
              json['retryStrategy'] as Map<String, dynamic>)
          : null,
      schedulingPriority: json['schedulingPriority'] as int?,
      status: json['status'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      timeout: json['timeout'] != null
          ? JobTimeout.fromJson(json['timeout'] as Map<String, dynamic>)
          : null,
    );
  }
}

enum JobDefinitionType {
  container,
  multinode,
}

extension on JobDefinitionType {
  String toValue() {
    switch (this) {
      case JobDefinitionType.container:
        return 'container';
      case JobDefinitionType.multinode:
        return 'multinode';
    }
  }
}

extension on String {
  JobDefinitionType toJobDefinitionType() {
    switch (this) {
      case 'container':
        return JobDefinitionType.container;
      case 'multinode':
        return JobDefinitionType.multinode;
    }
    throw Exception('$this is not known in enum JobDefinitionType');
  }
}

/// An object representing an Batch job dependency.
class JobDependency {
  /// The job ID of the Batch job associated with this dependency.
  final String? jobId;

  /// The type of the job dependency.
  final ArrayJobDependency? type;

  JobDependency({
    this.jobId,
    this.type,
  });
  factory JobDependency.fromJson(Map<String, dynamic> json) {
    return JobDependency(
      jobId: json['jobId'] as String?,
      type: (json['type'] as String?)?.toArrayJobDependency(),
    );
  }

  Map<String, dynamic> toJson() {
    final jobId = this.jobId;
    final type = this.type;
    return {
      if (jobId != null) 'jobId': jobId,
      if (type != null) 'type': type.toValue(),
    };
  }
}

/// An object representing an Batch job.
class JobDetail {
  /// The Amazon Resource Name (ARN) of the job definition that's used by this
  /// job.
  final String jobDefinition;

  /// The ID for the job.
  final String jobId;

  /// The name of the job.
  final String jobName;

  /// The Amazon Resource Name (ARN) of the job queue that the job is associated
  /// with.
  final String jobQueue;

  /// The Unix timestamp (in milliseconds) for when the job was started (when the
  /// job transitioned from the <code>STARTING</code> state to the
  /// <code>RUNNING</code> state). This parameter isn't provided for child jobs of
  /// array jobs or multi-node parallel jobs.
  final int startedAt;

  /// The current status for the job.
  /// <note>
  /// If your jobs don't progress to <code>STARTING</code>, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/troubleshooting.html#job_stuck_in_runnable">Jobs
  /// stuck in RUNNABLE status</a> in the troubleshooting section of the <i>Batch
  /// User Guide</i>.
  /// </note>
  final JobStatus status;

  /// The array properties of the job, if it is an array job.
  final ArrayPropertiesDetail? arrayProperties;

  /// A list of job attempts associated with this job.
  final List<AttemptDetail>? attempts;

  /// An object representing the details of the container that's associated with
  /// the job.
  final ContainerDetail? container;

  /// The Unix timestamp (in milliseconds) for when the job was created. For
  /// non-array jobs and parent array jobs, this is when the job entered the
  /// <code>SUBMITTED</code> state (at the time <a>SubmitJob</a> was called). For
  /// array child jobs, this is when the child job was spawned by its parent and
  /// entered the <code>PENDING</code> state.
  final int? createdAt;

  /// A list of job IDs that this job depends on.
  final List<JobDependency>? dependsOn;

  /// The Amazon Resource Name (ARN) of the job.
  final String? jobArn;

  /// An object representing the details of a node that's associated with a
  /// multi-node parallel job.
  final NodeDetails? nodeDetails;

  /// An object representing the node properties of a multi-node parallel job.
  /// <note>
  /// This isn't applicable to jobs that are running on Fargate resources.
  /// </note>
  final NodeProperties? nodeProperties;

  /// Additional parameters passed to the job that replace parameter substitution
  /// placeholders or override any corresponding parameter defaults from the job
  /// definition.
  final Map<String, String>? parameters;

  /// The platform capabilities required by the job definition. If no value is
  /// specified, it defaults to <code>EC2</code>. Jobs run on Fargate resources
  /// specify <code>FARGATE</code>.
  final List<PlatformCapability>? platformCapabilities;

  /// Specifies whether to propagate the tags from the job or job definition to
  /// the corresponding Amazon ECS task. If no value is specified, the tags aren't
  /// propagated. Tags can only be propagated to the tasks during task creation.
  /// For tags with the same name, job tags are given priority over job
  /// definitions tags. If the total number of combined tags from the job and job
  /// definition is over 50, the job is moved to the <code>FAILED</code> state.
  final bool? propagateTags;

  /// The retry strategy to use for this job if an attempt fails.
  final RetryStrategy? retryStrategy;

  /// The scheduling policy of the job definition. This only affects jobs in job
  /// queues with a fair share policy. Jobs with a higher scheduling priority are
  /// scheduled before jobs with a lower scheduling priority.
  final int? schedulingPriority;

  /// The share identifier for the job.
  final String? shareIdentifier;

  /// A short, human-readable string to provide additional details about the
  /// current status of the job.
  final String? statusReason;

  /// The Unix timestamp (in milliseconds) for when the job was stopped (when the
  /// job transitioned from the <code>RUNNING</code> state to a terminal state,
  /// such as <code>SUCCEEDED</code> or <code>FAILED</code>).
  final int? stoppedAt;

  /// The tags applied to the job.
  final Map<String, String>? tags;

  /// The timeout configuration for the job.
  final JobTimeout? timeout;

  JobDetail({
    required this.jobDefinition,
    required this.jobId,
    required this.jobName,
    required this.jobQueue,
    required this.startedAt,
    required this.status,
    this.arrayProperties,
    this.attempts,
    this.container,
    this.createdAt,
    this.dependsOn,
    this.jobArn,
    this.nodeDetails,
    this.nodeProperties,
    this.parameters,
    this.platformCapabilities,
    this.propagateTags,
    this.retryStrategy,
    this.schedulingPriority,
    this.shareIdentifier,
    this.statusReason,
    this.stoppedAt,
    this.tags,
    this.timeout,
  });
  factory JobDetail.fromJson(Map<String, dynamic> json) {
    return JobDetail(
      jobDefinition: json['jobDefinition'] as String,
      jobId: json['jobId'] as String,
      jobName: json['jobName'] as String,
      jobQueue: json['jobQueue'] as String,
      startedAt: json['startedAt'] as int,
      status: (json['status'] as String).toJobStatus(),
      arrayProperties: json['arrayProperties'] != null
          ? ArrayPropertiesDetail.fromJson(
              json['arrayProperties'] as Map<String, dynamic>)
          : null,
      attempts: (json['attempts'] as List?)
          ?.whereNotNull()
          .map((e) => AttemptDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      container: json['container'] != null
          ? ContainerDetail.fromJson(json['container'] as Map<String, dynamic>)
          : null,
      createdAt: json['createdAt'] as int?,
      dependsOn: (json['dependsOn'] as List?)
          ?.whereNotNull()
          .map((e) => JobDependency.fromJson(e as Map<String, dynamic>))
          .toList(),
      jobArn: json['jobArn'] as String?,
      nodeDetails: json['nodeDetails'] != null
          ? NodeDetails.fromJson(json['nodeDetails'] as Map<String, dynamic>)
          : null,
      nodeProperties: json['nodeProperties'] != null
          ? NodeProperties.fromJson(
              json['nodeProperties'] as Map<String, dynamic>)
          : null,
      parameters: (json['parameters'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      platformCapabilities: (json['platformCapabilities'] as List?)
          ?.whereNotNull()
          .map((e) => (e as String).toPlatformCapability())
          .toList(),
      propagateTags: json['propagateTags'] as bool?,
      retryStrategy: json['retryStrategy'] != null
          ? RetryStrategy.fromJson(
              json['retryStrategy'] as Map<String, dynamic>)
          : null,
      schedulingPriority: json['schedulingPriority'] as int?,
      shareIdentifier: json['shareIdentifier'] as String?,
      statusReason: json['statusReason'] as String?,
      stoppedAt: json['stoppedAt'] as int?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      timeout: json['timeout'] != null
          ? JobTimeout.fromJson(json['timeout'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// An object representing the details of an Batch job queue.
class JobQueueDetail {
  /// The compute environments that are attached to the job queue and the order
  /// that job placement is preferred. Compute environments are selected for job
  /// placement in ascending order.
  final List<ComputeEnvironmentOrder> computeEnvironmentOrder;

  /// The Amazon Resource Name (ARN) of the job queue.
  final String jobQueueArn;

  /// The name of the job queue.
  final String jobQueueName;

  /// The priority of the job queue. Job queues with a higher priority (or a
  /// higher integer value for the <code>priority</code> parameter) are evaluated
  /// first when associated with the same compute environment. Priority is
  /// determined in descending order, for example, a job queue with a priority
  /// value of <code>10</code> is given scheduling preference over a job queue
  /// with a priority value of <code>1</code>. All of the compute environments
  /// must be either EC2 (<code>EC2</code> or <code>SPOT</code>) or Fargate
  /// (<code>FARGATE</code> or <code>FARGATE_SPOT</code>); EC2 and Fargate compute
  /// environments can't be mixed.
  final int priority;

  /// Describes the ability of the queue to accept new jobs. If the job queue
  /// state is <code>ENABLED</code>, it's able to accept jobs. If the job queue
  /// state is <code>DISABLED</code>, new jobs can't be added to the queue, but
  /// jobs already in the queue can finish.
  final JQState state;

  /// The Amazon Resource Name (ARN) of the scheduling policy. The format is
  /// <code>aws:<i>Partition</i>:batch:<i>Region</i>:<i>Account</i>:scheduling-policy/<i>Name</i>
  /// </code>. For example,
  /// <code>aws:aws:batch:us-west-2:012345678910:scheduling-policy/MySchedulingPolicy</code>.
  final String? schedulingPolicyArn;

  /// The status of the job queue (for example, <code>CREATING</code> or
  /// <code>VALID</code>).
  final JQStatus? status;

  /// A short, human-readable string to provide additional details about the
  /// current status of the job queue.
  final String? statusReason;

  /// The tags applied to the job queue. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/using-tags.html">Tagging
  /// your Batch resources</a> in <i>Batch User Guide</i>.
  final Map<String, String>? tags;

  JobQueueDetail({
    required this.computeEnvironmentOrder,
    required this.jobQueueArn,
    required this.jobQueueName,
    required this.priority,
    required this.state,
    this.schedulingPolicyArn,
    this.status,
    this.statusReason,
    this.tags,
  });
  factory JobQueueDetail.fromJson(Map<String, dynamic> json) {
    return JobQueueDetail(
      computeEnvironmentOrder: (json['computeEnvironmentOrder'] as List)
          .whereNotNull()
          .map((e) =>
              ComputeEnvironmentOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
      jobQueueArn: json['jobQueueArn'] as String,
      jobQueueName: json['jobQueueName'] as String,
      priority: json['priority'] as int,
      state: (json['state'] as String).toJQState(),
      schedulingPolicyArn: json['schedulingPolicyArn'] as String?,
      status: (json['status'] as String?)?.toJQStatus(),
      statusReason: json['statusReason'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

enum JobStatus {
  submitted,
  pending,
  runnable,
  starting,
  running,
  succeeded,
  failed,
}

extension on JobStatus {
  String toValue() {
    switch (this) {
      case JobStatus.submitted:
        return 'SUBMITTED';
      case JobStatus.pending:
        return 'PENDING';
      case JobStatus.runnable:
        return 'RUNNABLE';
      case JobStatus.starting:
        return 'STARTING';
      case JobStatus.running:
        return 'RUNNING';
      case JobStatus.succeeded:
        return 'SUCCEEDED';
      case JobStatus.failed:
        return 'FAILED';
    }
  }
}

extension on String {
  JobStatus toJobStatus() {
    switch (this) {
      case 'SUBMITTED':
        return JobStatus.submitted;
      case 'PENDING':
        return JobStatus.pending;
      case 'RUNNABLE':
        return JobStatus.runnable;
      case 'STARTING':
        return JobStatus.starting;
      case 'RUNNING':
        return JobStatus.running;
      case 'SUCCEEDED':
        return JobStatus.succeeded;
      case 'FAILED':
        return JobStatus.failed;
    }
    throw Exception('$this is not known in enum JobStatus');
  }
}

/// An object representing summary details of a job.
class JobSummary {
  /// The ID of the job.
  final String jobId;

  /// The name of the job.
  final String jobName;

  /// The array properties of the job, if it is an array job.
  final ArrayPropertiesSummary? arrayProperties;

  /// An object representing the details of the container that's associated with
  /// the job.
  final ContainerSummary? container;

  /// The Unix timestamp (in milliseconds) for when the job was created. For
  /// non-array jobs and parent array jobs, this is when the job entered the
  /// <code>SUBMITTED</code> state (at the time <a>SubmitJob</a> was called). For
  /// array child jobs, this is when the child job was spawned by its parent and
  /// entered the <code>PENDING</code> state.
  final int? createdAt;

  /// The Amazon Resource Name (ARN) of the job.
  final String? jobArn;

  /// The Amazon Resource Name (ARN) of the job definition.
  final String? jobDefinition;

  /// The node properties for a single node in a job summary list.
  /// <note>
  /// This isn't applicable to jobs that are running on Fargate resources.
  /// </note>
  final NodePropertiesSummary? nodeProperties;

  /// The Unix timestamp for when the job was started (when the job transitioned
  /// from the <code>STARTING</code> state to the <code>RUNNING</code> state).
  final int? startedAt;

  /// The current status for the job.
  final JobStatus? status;

  /// A short, human-readable string to provide additional details about the
  /// current status of the job.
  final String? statusReason;

  /// The Unix timestamp for when the job was stopped (when the job transitioned
  /// from the <code>RUNNING</code> state to a terminal state, such as
  /// <code>SUCCEEDED</code> or <code>FAILED</code>).
  final int? stoppedAt;

  JobSummary({
    required this.jobId,
    required this.jobName,
    this.arrayProperties,
    this.container,
    this.createdAt,
    this.jobArn,
    this.jobDefinition,
    this.nodeProperties,
    this.startedAt,
    this.status,
    this.statusReason,
    this.stoppedAt,
  });
  factory JobSummary.fromJson(Map<String, dynamic> json) {
    return JobSummary(
      jobId: json['jobId'] as String,
      jobName: json['jobName'] as String,
      arrayProperties: json['arrayProperties'] != null
          ? ArrayPropertiesSummary.fromJson(
              json['arrayProperties'] as Map<String, dynamic>)
          : null,
      container: json['container'] != null
          ? ContainerSummary.fromJson(json['container'] as Map<String, dynamic>)
          : null,
      createdAt: json['createdAt'] as int?,
      jobArn: json['jobArn'] as String?,
      jobDefinition: json['jobDefinition'] as String?,
      nodeProperties: json['nodeProperties'] != null
          ? NodePropertiesSummary.fromJson(
              json['nodeProperties'] as Map<String, dynamic>)
          : null,
      startedAt: json['startedAt'] as int?,
      status: (json['status'] as String?)?.toJobStatus(),
      statusReason: json['statusReason'] as String?,
      stoppedAt: json['stoppedAt'] as int?,
    );
  }
}

/// An object representing a job timeout configuration.
class JobTimeout {
  /// The time duration in seconds (measured from the job attempt's
  /// <code>startedAt</code> timestamp) after which Batch terminates your jobs if
  /// they have not finished. The minimum value for the timeout is 60 seconds.
  final int? attemptDurationSeconds;

  JobTimeout({
    this.attemptDurationSeconds,
  });
  factory JobTimeout.fromJson(Map<String, dynamic> json) {
    return JobTimeout(
      attemptDurationSeconds: json['attemptDurationSeconds'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final attemptDurationSeconds = this.attemptDurationSeconds;
    return {
      if (attemptDurationSeconds != null)
        'attemptDurationSeconds': attemptDurationSeconds,
    };
  }
}

/// A key-value pair object.
class KeyValuePair {
  /// The name of the key-value pair. For environment variables, this is the name
  /// of the environment variable.
  final String? name;

  /// The value of the key-value pair. For environment variables, this is the
  /// value of the environment variable.
  final String? value;

  KeyValuePair({
    this.name,
    this.value,
  });
  factory KeyValuePair.fromJson(Map<String, dynamic> json) {
    return KeyValuePair(
      name: json['name'] as String?,
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final name = this.name;
    final value = this.value;
    return {
      if (name != null) 'name': name,
      if (value != null) 'value': value,
    };
  }
}

/// A filter name and value pair that's used to return a more specific list of
/// results from a <code>ListJobs</code> API operation.
class KeyValuesPair {
  /// The name of the filter. Filter names are case sensitive.
  final String? name;

  /// The filter values.
  final List<String>? values;

  KeyValuesPair({
    this.name,
    this.values,
  });
  Map<String, dynamic> toJson() {
    final name = this.name;
    final values = this.values;
    return {
      if (name != null) 'name': name,
      if (values != null) 'values': values,
    };
  }
}

/// An object representing a launch template associated with a compute resource.
/// You must specify either the launch template ID or launch template name in
/// the request, but not both.
///
/// If security groups are specified using both the
/// <code>securityGroupIds</code> parameter of
/// <code>CreateComputeEnvironment</code> and the launch template, the values in
/// the <code>securityGroupIds</code> parameter of
/// <code>CreateComputeEnvironment</code> will be used.
/// <note>
/// This object isn't applicable to jobs that are running on Fargate resources.
/// </note>
class LaunchTemplateSpecification {
  /// The ID of the launch template.
  final String? launchTemplateId;

  /// The name of the launch template.
  final String? launchTemplateName;

  /// The version number of the launch template, <code>$Latest</code>, or
  /// <code>$Default</code>.
  ///
  /// If the value is <code>$Latest</code>, the latest version of the launch
  /// template is used. If the value is <code>$Default</code>, the default version
  /// of the launch template is used.
  /// <important>
  /// If the AMI ID that's used in a compute environment is from the launch
  /// template, the AMI isn't changed when the compute environment is updated.
  /// It's only changed if the <code>updateToLatestImageVersion</code> parameter
  /// for the compute environment is set to <code>true</code>. During an
  /// infrastructure update, if either <code>$Latest</code> or
  /// <code>$Default</code> is specified, Batch re-evaluates the launch template
  /// version, and it might use a different version of the launch template. This
  /// is the case even if the launch template isn't specified in the update. When
  /// updating a compute environment, changing the launch template requires an
  /// infrastructure update of the compute environment. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html">Updating
  /// compute environments</a> in the <i>Batch User Guide</i>.
  /// </important>
  /// Default: <code>$Default</code>.
  final String? version;

  LaunchTemplateSpecification({
    this.launchTemplateId,
    this.launchTemplateName,
    this.version,
  });
  factory LaunchTemplateSpecification.fromJson(Map<String, dynamic> json) {
    return LaunchTemplateSpecification(
      launchTemplateId: json['launchTemplateId'] as String?,
      launchTemplateName: json['launchTemplateName'] as String?,
      version: json['version'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final launchTemplateId = this.launchTemplateId;
    final launchTemplateName = this.launchTemplateName;
    final version = this.version;
    return {
      if (launchTemplateId != null) 'launchTemplateId': launchTemplateId,
      if (launchTemplateName != null) 'launchTemplateName': launchTemplateName,
      if (version != null) 'version': version,
    };
  }
}

/// Linux-specific modifications that are applied to the container, such as
/// details for device mappings.
class LinuxParameters {
  /// Any host devices to expose to the container. This parameter maps to
  /// <code>Devices</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--device</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources and shouldn't be provided.
  /// </note>
  final List<Device>? devices;

  /// If true, run an <code>init</code> process inside the container that forwards
  /// signals and reaps processes. This parameter maps to the <code>--init</code>
  /// option to <a href="https://docs.docker.com/engine/reference/run/">docker
  /// run</a>. This parameter requires version 1.25 of the Docker Remote API or
  /// greater on your container instance. To check the Docker Remote API version
  /// on your container instance, log into your container instance and run the
  /// following command: <code>sudo docker version | grep "Server API
  /// version"</code>
  final bool? initProcessEnabled;

  /// The total amount of swap memory (in MiB) a container can use. This parameter
  /// is translated to the <code>--memory-swap</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a> where
  /// the value is the sum of the container memory plus the <code>maxSwap</code>
  /// value. For more information, see <a
  /// href="https://docs.docker.com/config/containers/resource_constraints/#--memory-swap-details">
  /// <code>--memory-swap</code> details</a> in the Docker documentation.
  ///
  /// If a <code>maxSwap</code> value of <code>0</code> is specified, the
  /// container doesn't use swap. Accepted values are <code>0</code> or any
  /// positive integer. If the <code>maxSwap</code> parameter is omitted, the
  /// container doesn't use the swap configuration for the container instance it
  /// is running on. A <code>maxSwap</code> value must be set for the
  /// <code>swappiness</code> parameter to be used.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources and shouldn't be provided.
  /// </note>
  final int? maxSwap;

  /// The value for the size (in MiB) of the <code>/dev/shm</code> volume. This
  /// parameter maps to the <code>--shm-size</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources and shouldn't be provided.
  /// </note>
  final int? sharedMemorySize;

  /// This allows you to tune a container's memory swappiness behavior. A
  /// <code>swappiness</code> value of <code>0</code> causes swapping not to
  /// happen unless absolutely necessary. A <code>swappiness</code> value of
  /// <code>100</code> causes pages to be swapped very aggressively. Accepted
  /// values are whole numbers between <code>0</code> and <code>100</code>. If the
  /// <code>swappiness</code> parameter isn't specified, a default value of
  /// <code>60</code> is used. If a value isn't specified for
  /// <code>maxSwap</code>, then this parameter is ignored. If
  /// <code>maxSwap</code> is set to 0, the container doesn't use swap. This
  /// parameter maps to the <code>--memory-swappiness</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>.
  ///
  /// Consider the following when you use a per-container swap configuration.
  ///
  /// <ul>
  /// <li>
  /// Swap space must be enabled and allocated on the container instance for the
  /// containers to use.
  /// <note>
  /// The Amazon ECS optimized AMIs don't have swap enabled by default. You must
  /// enable swap on the instance to use this feature. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-store-swap-volumes.html">Instance
  /// store swap volumes</a> in the <i>Amazon EC2 User Guide for Linux
  /// Instances</i> or <a
  /// href="http://aws.amazon.com/premiumsupport/knowledge-center/ec2-memory-swap-file/">How
  /// do I allocate memory to work as swap space in an Amazon EC2 instance by
  /// using a swap file?</a>
  /// </note> </li>
  /// <li>
  /// The swap space parameters are only supported for job definitions using EC2
  /// resources.
  /// </li>
  /// <li>
  /// If the <code>maxSwap</code> and <code>swappiness</code> parameters are
  /// omitted from a job definition, each container will have a default
  /// <code>swappiness</code> value of 60, and the total swap usage will be
  /// limited to two times the memory reservation of the container.
  /// </li>
  /// </ul> <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources and shouldn't be provided.
  /// </note>
  final int? swappiness;

  /// The container path, mount options, and size (in MiB) of the tmpfs mount.
  /// This parameter maps to the <code>--tmpfs</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources and shouldn't be provided.
  /// </note>
  final List<Tmpfs>? tmpfs;

  LinuxParameters({
    this.devices,
    this.initProcessEnabled,
    this.maxSwap,
    this.sharedMemorySize,
    this.swappiness,
    this.tmpfs,
  });
  factory LinuxParameters.fromJson(Map<String, dynamic> json) {
    return LinuxParameters(
      devices: (json['devices'] as List?)
          ?.whereNotNull()
          .map((e) => Device.fromJson(e as Map<String, dynamic>))
          .toList(),
      initProcessEnabled: json['initProcessEnabled'] as bool?,
      maxSwap: json['maxSwap'] as int?,
      sharedMemorySize: json['sharedMemorySize'] as int?,
      swappiness: json['swappiness'] as int?,
      tmpfs: (json['tmpfs'] as List?)
          ?.whereNotNull()
          .map((e) => Tmpfs.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final devices = this.devices;
    final initProcessEnabled = this.initProcessEnabled;
    final maxSwap = this.maxSwap;
    final sharedMemorySize = this.sharedMemorySize;
    final swappiness = this.swappiness;
    final tmpfs = this.tmpfs;
    return {
      if (devices != null) 'devices': devices,
      if (initProcessEnabled != null) 'initProcessEnabled': initProcessEnabled,
      if (maxSwap != null) 'maxSwap': maxSwap,
      if (sharedMemorySize != null) 'sharedMemorySize': sharedMemorySize,
      if (swappiness != null) 'swappiness': swappiness,
      if (tmpfs != null) 'tmpfs': tmpfs,
    };
  }
}

class ListJobsResponse {
  /// A list of job summaries that match the request.
  final List<JobSummary> jobSummaryList;

  /// The <code>nextToken</code> value to include in a future
  /// <code>ListJobs</code> request. When the results of a <code>ListJobs</code>
  /// request exceed <code>maxResults</code>, this value can be used to retrieve
  /// the next page of results. This value is <code>null</code> when there are no
  /// more results to return.
  final String? nextToken;

  ListJobsResponse({
    required this.jobSummaryList,
    this.nextToken,
  });
  factory ListJobsResponse.fromJson(Map<String, dynamic> json) {
    return ListJobsResponse(
      jobSummaryList: (json['jobSummaryList'] as List)
          .whereNotNull()
          .map((e) => JobSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['nextToken'] as String?,
    );
  }
}

class ListSchedulingPoliciesResponse {
  /// The <code>nextToken</code> value to include in a future
  /// <code>ListSchedulingPolicies</code> request. When the results of a
  /// <code>ListSchedulingPolicies</code> request exceed <code>maxResults</code>,
  /// this value can be used to retrieve the next page of results. This value is
  /// <code>null</code> when there are no more results to return.
  final String? nextToken;

  /// A list of scheduling policies that match the request.
  final List<SchedulingPolicyListingDetail>? schedulingPolicies;

  ListSchedulingPoliciesResponse({
    this.nextToken,
    this.schedulingPolicies,
  });
  factory ListSchedulingPoliciesResponse.fromJson(Map<String, dynamic> json) {
    return ListSchedulingPoliciesResponse(
      nextToken: json['nextToken'] as String?,
      schedulingPolicies: (json['schedulingPolicies'] as List?)
          ?.whereNotNull()
          .map((e) =>
              SchedulingPolicyListingDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListTagsForResourceResponse {
  /// The tags for the resource.
  final Map<String, String>? tags;

  ListTagsForResourceResponse({
    this.tags,
  });
  factory ListTagsForResourceResponse.fromJson(Map<String, dynamic> json) {
    return ListTagsForResourceResponse(
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

/// Log configuration options to send to a custom log driver for the container.
class LogConfiguration {
  /// The log driver to use for the container. The valid values listed for this
  /// parameter are log drivers that the Amazon ECS container agent can
  /// communicate with by default.
  ///
  /// The supported log drivers are <code>awslogs</code>, <code>fluentd</code>,
  /// <code>gelf</code>, <code>json-file</code>, <code>journald</code>,
  /// <code>logentries</code>, <code>syslog</code>, and <code>splunk</code>.
  /// <note>
  /// Jobs that are running on Fargate resources are restricted to the
  /// <code>awslogs</code> and <code>splunk</code> log drivers.
  /// </note> <dl> <dt>awslogs</dt> <dd>
  /// Specifies the Amazon CloudWatch Logs logging driver. For more information,
  /// see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/using_awslogs.html">Using
  /// the awslogs log driver</a> in the <i>Batch User Guide</i> and <a
  /// href="https://docs.docker.com/config/containers/logging/awslogs/">Amazon
  /// CloudWatch Logs logging driver</a> in the Docker documentation.
  /// </dd> <dt>fluentd</dt> <dd>
  /// Specifies the Fluentd logging driver. For more information, including usage
  /// and options, see <a
  /// href="https://docs.docker.com/config/containers/logging/fluentd/">Fluentd
  /// logging driver</a> in the Docker documentation.
  /// </dd> <dt>gelf</dt> <dd>
  /// Specifies the Graylog Extended Format (GELF) logging driver. For more
  /// information, including usage and options, see <a
  /// href="https://docs.docker.com/config/containers/logging/gelf/">Graylog
  /// Extended Format logging driver</a> in the Docker documentation.
  /// </dd> <dt>journald</dt> <dd>
  /// Specifies the journald logging driver. For more information, including usage
  /// and options, see <a
  /// href="https://docs.docker.com/config/containers/logging/journald/">Journald
  /// logging driver</a> in the Docker documentation.
  /// </dd> <dt>json-file</dt> <dd>
  /// Specifies the JSON file logging driver. For more information, including
  /// usage and options, see <a
  /// href="https://docs.docker.com/config/containers/logging/json-file/">JSON
  /// File logging driver</a> in the Docker documentation.
  /// </dd> <dt>splunk</dt> <dd>
  /// Specifies the Splunk logging driver. For more information, including usage
  /// and options, see <a
  /// href="https://docs.docker.com/config/containers/logging/splunk/">Splunk
  /// logging driver</a> in the Docker documentation.
  /// </dd> <dt>syslog</dt> <dd>
  /// Specifies the syslog logging driver. For more information, including usage
  /// and options, see <a
  /// href="https://docs.docker.com/config/containers/logging/syslog/">Syslog
  /// logging driver</a> in the Docker documentation.
  /// </dd> </dl> <note>
  /// If you have a custom driver that's not listed earlier that you want to work
  /// with the Amazon ECS container agent, you can fork the Amazon ECS container
  /// agent project that's <a
  /// href="https://github.com/aws/amazon-ecs-agent">available on GitHub</a> and
  /// customize it to work with that driver. We encourage you to submit pull
  /// requests for changes that you want to have included. However, Amazon Web
  /// Services doesn't currently support running modified copies of this software.
  /// </note>
  /// This parameter requires version 1.18 of the Docker Remote API or greater on
  /// your container instance. To check the Docker Remote API version on your
  /// container instance, log into your container instance and run the following
  /// command: <code>sudo docker version | grep "Server API version"</code>
  final LogDriver logDriver;

  /// The configuration options to send to the log driver. This parameter requires
  /// version 1.19 of the Docker Remote API or greater on your container instance.
  /// To check the Docker Remote API version on your container instance, log into
  /// your container instance and run the following command: <code>sudo docker
  /// version | grep "Server API version"</code>
  final Map<String, String>? options;

  /// The secrets to pass to the log configuration. For more information, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/specifying-sensitive-data.html">Specifying
  /// sensitive data</a> in the <i>Batch User Guide</i>.
  final List<Secret>? secretOptions;

  LogConfiguration({
    required this.logDriver,
    this.options,
    this.secretOptions,
  });
  factory LogConfiguration.fromJson(Map<String, dynamic> json) {
    return LogConfiguration(
      logDriver: (json['logDriver'] as String).toLogDriver(),
      options: (json['options'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      secretOptions: (json['secretOptions'] as List?)
          ?.whereNotNull()
          .map((e) => Secret.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final logDriver = this.logDriver;
    final options = this.options;
    final secretOptions = this.secretOptions;
    return {
      'logDriver': logDriver.toValue(),
      if (options != null) 'options': options,
      if (secretOptions != null) 'secretOptions': secretOptions,
    };
  }
}

enum LogDriver {
  jsonFile,
  syslog,
  journald,
  gelf,
  fluentd,
  awslogs,
  splunk,
}

extension on LogDriver {
  String toValue() {
    switch (this) {
      case LogDriver.jsonFile:
        return 'json-file';
      case LogDriver.syslog:
        return 'syslog';
      case LogDriver.journald:
        return 'journald';
      case LogDriver.gelf:
        return 'gelf';
      case LogDriver.fluentd:
        return 'fluentd';
      case LogDriver.awslogs:
        return 'awslogs';
      case LogDriver.splunk:
        return 'splunk';
    }
  }
}

extension on String {
  LogDriver toLogDriver() {
    switch (this) {
      case 'json-file':
        return LogDriver.jsonFile;
      case 'syslog':
        return LogDriver.syslog;
      case 'journald':
        return LogDriver.journald;
      case 'gelf':
        return LogDriver.gelf;
      case 'fluentd':
        return LogDriver.fluentd;
      case 'awslogs':
        return LogDriver.awslogs;
      case 'splunk':
        return LogDriver.splunk;
    }
    throw Exception('$this is not known in enum LogDriver');
  }
}

/// Details on a Docker volume mount point that's used in a job's container
/// properties. This parameter maps to <code>Volumes</code> in the <a
/// href="https://docs.docker.com/engine/reference/api/docker_remote_api_v1.19/#create-a-container">Create
/// a container</a> section of the Docker Remote API and the
/// <code>--volume</code> option to docker run.
class MountPoint {
  /// The path on the container where the host volume is mounted.
  final String? containerPath;

  /// If this value is <code>true</code>, the container has read-only access to
  /// the volume. Otherwise, the container can write to the volume. The default
  /// value is <code>false</code>.
  final bool? readOnly;

  /// The name of the volume to mount.
  final String? sourceVolume;

  MountPoint({
    this.containerPath,
    this.readOnly,
    this.sourceVolume,
  });
  factory MountPoint.fromJson(Map<String, dynamic> json) {
    return MountPoint(
      containerPath: json['containerPath'] as String?,
      readOnly: json['readOnly'] as bool?,
      sourceVolume: json['sourceVolume'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final containerPath = this.containerPath;
    final readOnly = this.readOnly;
    final sourceVolume = this.sourceVolume;
    return {
      if (containerPath != null) 'containerPath': containerPath,
      if (readOnly != null) 'readOnly': readOnly,
      if (sourceVolume != null) 'sourceVolume': sourceVolume,
    };
  }
}

/// The network configuration for jobs that are running on Fargate resources.
/// Jobs that are running on EC2 resources must not specify this parameter.
class NetworkConfiguration {
  /// Indicates whether the job should have a public IP address. For a job that is
  /// running on Fargate resources in a private subnet to send outbound traffic to
  /// the internet (for example, to pull container images), the private subnet
  /// requires a NAT gateway be attached to route requests to the internet. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html">Amazon
  /// ECS task networking</a>. The default value is "DISABLED".
  final AssignPublicIp? assignPublicIp;

  NetworkConfiguration({
    this.assignPublicIp,
  });
  factory NetworkConfiguration.fromJson(Map<String, dynamic> json) {
    return NetworkConfiguration(
      assignPublicIp: (json['assignPublicIp'] as String?)?.toAssignPublicIp(),
    );
  }

  Map<String, dynamic> toJson() {
    final assignPublicIp = this.assignPublicIp;
    return {
      if (assignPublicIp != null) 'assignPublicIp': assignPublicIp.toValue(),
    };
  }
}

/// An object representing the elastic network interface for a multi-node
/// parallel job node.
class NetworkInterface {
  /// The attachment ID for the network interface.
  final String? attachmentId;

  /// The private IPv6 address for the network interface.
  final String? ipv6Address;

  /// The private IPv4 address for the network interface.
  final String? privateIpv4Address;

  NetworkInterface({
    this.attachmentId,
    this.ipv6Address,
    this.privateIpv4Address,
  });
  factory NetworkInterface.fromJson(Map<String, dynamic> json) {
    return NetworkInterface(
      attachmentId: json['attachmentId'] as String?,
      ipv6Address: json['ipv6Address'] as String?,
      privateIpv4Address: json['privateIpv4Address'] as String?,
    );
  }
}

/// An object representing the details of a multi-node parallel job node.
class NodeDetails {
  /// Specifies whether the current node is the main node for a multi-node
  /// parallel job.
  final bool? isMainNode;

  /// The node index for the node. Node index numbering begins at zero. This index
  /// is also available on the node with the <code>AWS_BATCH_JOB_NODE_INDEX</code>
  /// environment variable.
  final int? nodeIndex;

  NodeDetails({
    this.isMainNode,
    this.nodeIndex,
  });
  factory NodeDetails.fromJson(Map<String, dynamic> json) {
    return NodeDetails(
      isMainNode: json['isMainNode'] as bool?,
      nodeIndex: json['nodeIndex'] as int?,
    );
  }
}

/// Object representing any node overrides to a job definition that's used in a
/// <a>SubmitJob</a> API operation.
/// <note>
/// This isn't applicable to jobs that are running on Fargate resources and
/// shouldn't be provided; use <code>containerOverrides</code> instead.
/// </note>
class NodeOverrides {
  /// The node property overrides for the job.
  final List<NodePropertyOverride>? nodePropertyOverrides;

  /// The number of nodes to use with a multi-node parallel job. This value
  /// overrides the number of nodes that are specified in the job definition. To
  /// use this override:
  ///
  /// <ul>
  /// <li>
  /// There must be at least one node range in your job definition that has an
  /// open upper boundary (such as <code>:</code> or <code>n:</code>).
  /// </li>
  /// <li>
  /// The lower boundary of the node range specified in the job definition must be
  /// fewer than the number of nodes specified in the override.
  /// </li>
  /// <li>
  /// The main node index specified in the job definition must be fewer than the
  /// number of nodes specified in the override.
  /// </li>
  /// </ul>
  final int? numNodes;

  NodeOverrides({
    this.nodePropertyOverrides,
    this.numNodes,
  });
  Map<String, dynamic> toJson() {
    final nodePropertyOverrides = this.nodePropertyOverrides;
    final numNodes = this.numNodes;
    return {
      if (nodePropertyOverrides != null)
        'nodePropertyOverrides': nodePropertyOverrides,
      if (numNodes != null) 'numNodes': numNodes,
    };
  }
}

/// An object representing the node properties of a multi-node parallel job.
class NodeProperties {
  /// Specifies the node index for the main node of a multi-node parallel job.
  /// This node index value must be fewer than the number of nodes.
  final int mainNode;

  /// A list of node ranges and their properties associated with a multi-node
  /// parallel job.
  final List<NodeRangeProperty> nodeRangeProperties;

  /// The number of nodes associated with a multi-node parallel job.
  final int numNodes;

  NodeProperties({
    required this.mainNode,
    required this.nodeRangeProperties,
    required this.numNodes,
  });
  factory NodeProperties.fromJson(Map<String, dynamic> json) {
    return NodeProperties(
      mainNode: json['mainNode'] as int,
      nodeRangeProperties: (json['nodeRangeProperties'] as List)
          .whereNotNull()
          .map((e) => NodeRangeProperty.fromJson(e as Map<String, dynamic>))
          .toList(),
      numNodes: json['numNodes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final mainNode = this.mainNode;
    final nodeRangeProperties = this.nodeRangeProperties;
    final numNodes = this.numNodes;
    return {
      'mainNode': mainNode,
      'nodeRangeProperties': nodeRangeProperties,
      'numNodes': numNodes,
    };
  }
}

/// An object representing the properties of a node that's associated with a
/// multi-node parallel job.
class NodePropertiesSummary {
  /// Specifies whether the current node is the main node for a multi-node
  /// parallel job.
  final bool? isMainNode;

  /// The node index for the node. Node index numbering begins at zero. This index
  /// is also available on the node with the <code>AWS_BATCH_JOB_NODE_INDEX</code>
  /// environment variable.
  final int? nodeIndex;

  /// The number of nodes associated with a multi-node parallel job.
  final int? numNodes;

  NodePropertiesSummary({
    this.isMainNode,
    this.nodeIndex,
    this.numNodes,
  });
  factory NodePropertiesSummary.fromJson(Map<String, dynamic> json) {
    return NodePropertiesSummary(
      isMainNode: json['isMainNode'] as bool?,
      nodeIndex: json['nodeIndex'] as int?,
      numNodes: json['numNodes'] as int?,
    );
  }
}

/// Object representing any node overrides to a job definition that's used in a
/// <a>SubmitJob</a> API operation.
class NodePropertyOverride {
  /// The range of nodes, using node index values, that's used to override. A
  /// range of <code>0:3</code> indicates nodes with index values of
  /// <code>0</code> through <code>3</code>. If the starting range value is
  /// omitted (<code>:n</code>), then <code>0</code> is used to start the range.
  /// If the ending range value is omitted (<code>n:</code>), then the highest
  /// possible node index is used to end the range.
  final String targetNodes;

  /// The overrides that should be sent to a node range.
  final ContainerOverrides? containerOverrides;

  NodePropertyOverride({
    required this.targetNodes,
    this.containerOverrides,
  });
  Map<String, dynamic> toJson() {
    final targetNodes = this.targetNodes;
    final containerOverrides = this.containerOverrides;
    return {
      'targetNodes': targetNodes,
      if (containerOverrides != null) 'containerOverrides': containerOverrides,
    };
  }
}

/// An object representing the properties of the node range for a multi-node
/// parallel job.
class NodeRangeProperty {
  /// The range of nodes, using node index values. A range of <code>0:3</code>
  /// indicates nodes with index values of <code>0</code> through <code>3</code>.
  /// If the starting range value is omitted (<code>:n</code>), then
  /// <code>0</code> is used to start the range. If the ending range value is
  /// omitted (<code>n:</code>), then the highest possible node index is used to
  /// end the range. Your accumulative node ranges must account for all nodes
  /// (<code>0:n</code>). You can nest node ranges, for example <code>0:10</code>
  /// and <code>4:5</code>, in which case the <code>4:5</code> range properties
  /// override the <code>0:10</code> properties.
  final String targetNodes;

  /// The container details for the node range.
  final ContainerProperties? container;

  NodeRangeProperty({
    required this.targetNodes,
    this.container,
  });
  factory NodeRangeProperty.fromJson(Map<String, dynamic> json) {
    return NodeRangeProperty(
      targetNodes: json['targetNodes'] as String,
      container: json['container'] != null
          ? ContainerProperties.fromJson(
              json['container'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final targetNodes = this.targetNodes;
    final container = this.container;
    return {
      'targetNodes': targetNodes,
      if (container != null) 'container': container,
    };
  }
}

enum PlatformCapability {
  ec2,
  fargate,
}

extension on PlatformCapability {
  String toValue() {
    switch (this) {
      case PlatformCapability.ec2:
        return 'EC2';
      case PlatformCapability.fargate:
        return 'FARGATE';
    }
  }
}

extension on String {
  PlatformCapability toPlatformCapability() {
    switch (this) {
      case 'EC2':
        return PlatformCapability.ec2;
      case 'FARGATE':
        return PlatformCapability.fargate;
    }
    throw Exception('$this is not known in enum PlatformCapability');
  }
}

class RegisterJobDefinitionResponse {
  /// The Amazon Resource Name (ARN) of the job definition.
  final String jobDefinitionArn;

  /// The name of the job definition.
  final String jobDefinitionName;

  /// The revision of the job definition.
  final int revision;

  RegisterJobDefinitionResponse({
    required this.jobDefinitionArn,
    required this.jobDefinitionName,
    required this.revision,
  });
  factory RegisterJobDefinitionResponse.fromJson(Map<String, dynamic> json) {
    return RegisterJobDefinitionResponse(
      jobDefinitionArn: json['jobDefinitionArn'] as String,
      jobDefinitionName: json['jobDefinitionName'] as String,
      revision: json['revision'] as int,
    );
  }
}

/// The type and amount of a resource to assign to a container. The supported
/// resources include <code>GPU</code>, <code>MEMORY</code>, and
/// <code>VCPU</code>.
class ResourceRequirement {
  /// The type of resource to assign to a container. The supported resources
  /// include <code>GPU</code>, <code>MEMORY</code>, and <code>VCPU</code>.
  final ResourceType type;

  /// The quantity of the specified resource to reserve for the container. The
  /// values vary based on the <code>type</code> specified.
  /// <dl> <dt>type="GPU"</dt> <dd>
  /// The number of physical GPUs to reserve for the container. The number of GPUs
  /// reserved for all containers in a job shouldn't exceed the number of
  /// available GPUs on the compute resource that the job is launched on.
  /// <note>
  /// GPUs are not available for jobs that are running on Fargate resources.
  /// </note> </dd> <dt>type="MEMORY"</dt> <dd>
  /// The memory hard limit (in MiB) present to the container. This parameter is
  /// supported for jobs that are running on EC2 resources. If your container
  /// attempts to exceed the memory specified, the container is terminated. This
  /// parameter maps to <code>Memory</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--memory</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>. You
  /// must specify at least 4 MiB of memory for a job. This is required but can be
  /// specified in several places for multi-node parallel (MNP) jobs. It must be
  /// specified for each node at least once. This parameter maps to
  /// <code>Memory</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--memory</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>.
  /// <note>
  /// If you're trying to maximize your resource utilization by providing your
  /// jobs as much memory as possible for a particular instance type, see <a
  /// href="https://docs.aws.amazon.com/batch/latest/userguide/memory-management.html">Memory
  /// management</a> in the <i>Batch User Guide</i>.
  /// </note>
  /// For jobs that are running on Fargate resources, then <code>value</code> is
  /// the hard limit (in MiB), and must match one of the supported values and the
  /// <code>VCPU</code> values must be one of the values supported for that memory
  /// value.
  /// <dl> <dt>value = 512</dt> <dd>
  /// <code>VCPU</code> = 0.25
  /// </dd> <dt>value = 1024</dt> <dd>
  /// <code>VCPU</code> = 0.25 or 0.5
  /// </dd> <dt>value = 2048</dt> <dd>
  /// <code>VCPU</code> = 0.25, 0.5, or 1
  /// </dd> <dt>value = 3072</dt> <dd>
  /// <code>VCPU</code> = 0.5, or 1
  /// </dd> <dt>value = 4096</dt> <dd>
  /// <code>VCPU</code> = 0.5, 1, or 2
  /// </dd> <dt>value = 5120, 6144, or 7168</dt> <dd>
  /// <code>VCPU</code> = 1 or 2
  /// </dd> <dt>value = 8192</dt> <dd>
  /// <code>VCPU</code> = 1, 2, or 4
  /// </dd> <dt>value = 9216, 10240, 11264, 12288, 13312, 14336, 15360, or
  /// 16384</dt> <dd>
  /// <code>VCPU</code> = 2 or 4
  /// </dd> <dt>value = 17408, 18432, 19456, 20480, 21504, 22528, 23552, 24576,
  /// 25600, 26624, 27648, 28672, 29696, or 30720</dt> <dd>
  /// <code>VCPU</code> = 4
  /// </dd> </dl> </dd> <dt>type="VCPU"</dt> <dd>
  /// The number of vCPUs reserved for the container. This parameter maps to
  /// <code>CpuShares</code> in the <a
  /// href="https://docs.docker.com/engine/api/v1.23/#create-a-container">Create a
  /// container</a> section of the <a
  /// href="https://docs.docker.com/engine/api/v1.23/">Docker Remote API</a> and
  /// the <code>--cpu-shares</code> option to <a
  /// href="https://docs.docker.com/engine/reference/run/">docker run</a>. Each
  /// vCPU is equivalent to 1,024 CPU shares. For EC2 resources, you must specify
  /// at least one vCPU. This is required but can be specified in several places;
  /// it must be specified for each node at least once.
  ///
  /// For jobs that are running on Fargate resources, then <code>value</code> must
  /// match one of the supported values and the <code>MEMORY</code> values must be
  /// one of the values supported for that <code>VCPU</code> value. The supported
  /// values are 0.25, 0.5, 1, 2, and 4
  /// <dl> <dt>value = 0.25</dt> <dd>
  /// <code>MEMORY</code> = 512, 1024, or 2048
  /// </dd> <dt>value = 0.5</dt> <dd>
  /// <code>MEMORY</code> = 1024, 2048, 3072, or 4096
  /// </dd> <dt>value = 1</dt> <dd>
  /// <code>MEMORY</code> = 2048, 3072, 4096, 5120, 6144, 7168, or 8192
  /// </dd> <dt>value = 2</dt> <dd>
  /// <code>MEMORY</code> = 4096, 5120, 6144, 7168, 8192, 9216, 10240, 11264,
  /// 12288, 13312, 14336, 15360, or 16384
  /// </dd> <dt>value = 4</dt> <dd>
  /// <code>MEMORY</code> = 8192, 9216, 10240, 11264, 12288, 13312, 14336, 15360,
  /// 16384, 17408, 18432, 19456, 20480, 21504, 22528, 23552, 24576, 25600, 26624,
  /// 27648, 28672, 29696, or 30720
  /// </dd> </dl> </dd> </dl>
  final String value;

  ResourceRequirement({
    required this.type,
    required this.value,
  });
  factory ResourceRequirement.fromJson(Map<String, dynamic> json) {
    return ResourceRequirement(
      type: (json['type'] as String).toResourceType(),
      value: json['value'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final type = this.type;
    final value = this.value;
    return {
      'type': type.toValue(),
      'value': value,
    };
  }
}

enum ResourceType {
  gpu,
  vcpu,
  memory,
}

extension on ResourceType {
  String toValue() {
    switch (this) {
      case ResourceType.gpu:
        return 'GPU';
      case ResourceType.vcpu:
        return 'VCPU';
      case ResourceType.memory:
        return 'MEMORY';
    }
  }
}

extension on String {
  ResourceType toResourceType() {
    switch (this) {
      case 'GPU':
        return ResourceType.gpu;
      case 'VCPU':
        return ResourceType.vcpu;
      case 'MEMORY':
        return ResourceType.memory;
    }
    throw Exception('$this is not known in enum ResourceType');
  }
}

enum RetryAction {
  retry,
  exit,
}

extension on RetryAction {
  String toValue() {
    switch (this) {
      case RetryAction.retry:
        return 'RETRY';
      case RetryAction.exit:
        return 'EXIT';
    }
  }
}

extension on String {
  RetryAction toRetryAction() {
    switch (this) {
      case 'RETRY':
        return RetryAction.retry;
      case 'EXIT':
        return RetryAction.exit;
    }
    throw Exception('$this is not known in enum RetryAction');
  }
}

/// The retry strategy associated with a job. For more information, see <a
/// href="https://docs.aws.amazon.com/batch/latest/userguide/job_retries.html">Automated
/// job retries</a> in the <i>Batch User Guide</i>.
class RetryStrategy {
  /// The number of times to move a job to the <code>RUNNABLE</code> status. You
  /// can specify between 1 and 10 attempts. If the value of <code>attempts</code>
  /// is greater than one, the job is retried on failure the same number of
  /// attempts as the value.
  final int? attempts;

  /// Array of up to 5 objects that specify conditions under which the job should
  /// be retried or failed. If this parameter is specified, then the
  /// <code>attempts</code> parameter must also be specified.
  final List<EvaluateOnExit>? evaluateOnExit;

  RetryStrategy({
    this.attempts,
    this.evaluateOnExit,
  });
  factory RetryStrategy.fromJson(Map<String, dynamic> json) {
    return RetryStrategy(
      attempts: json['attempts'] as int?,
      evaluateOnExit: (json['evaluateOnExit'] as List?)
          ?.whereNotNull()
          .map((e) => EvaluateOnExit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final attempts = this.attempts;
    final evaluateOnExit = this.evaluateOnExit;
    return {
      if (attempts != null) 'attempts': attempts,
      if (evaluateOnExit != null) 'evaluateOnExit': evaluateOnExit,
    };
  }
}

/// An object that represents a scheduling policy.
class SchedulingPolicyDetail {
  /// The Amazon Resource Name (ARN) of the scheduling policy. An example is
  /// <code>arn:<i>aws</i>:batch:<i>us-east-1</i>:<i>123456789012</i>:scheduling-policy/<i>HighPriority</i>
  /// </code>.
  final String arn;

  /// The name of the scheduling policy.
  final String name;

  /// The fair share policy for the scheduling policy.
  final FairsharePolicy? fairsharePolicy;

  /// The tags that you apply to the scheduling policy to categorize and organize
  /// your resources. Each tag consists of a key and an optional value. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html">Tagging
  /// Amazon Web Services resources</a> in <i>Amazon Web Services General
  /// Reference</i>.
  final Map<String, String>? tags;

  SchedulingPolicyDetail({
    required this.arn,
    required this.name,
    this.fairsharePolicy,
    this.tags,
  });
  factory SchedulingPolicyDetail.fromJson(Map<String, dynamic> json) {
    return SchedulingPolicyDetail(
      arn: json['arn'] as String,
      name: json['name'] as String,
      fairsharePolicy: json['fairsharePolicy'] != null
          ? FairsharePolicy.fromJson(
              json['fairsharePolicy'] as Map<String, dynamic>)
          : null,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

/// An object that contains the details of a scheduling policy that's returned
/// in a <code>ListSchedulingPolicy</code> action.
class SchedulingPolicyListingDetail {
  /// Amazon Resource Name (ARN) of the scheduling policy.
  final String arn;

  SchedulingPolicyListingDetail({
    required this.arn,
  });
  factory SchedulingPolicyListingDetail.fromJson(Map<String, dynamic> json) {
    return SchedulingPolicyListingDetail(
      arn: json['arn'] as String,
    );
  }
}

/// An object representing the secret to expose to your container. Secrets can
/// be exposed to a container in the following ways:
///
/// <ul>
/// <li>
/// To inject sensitive data into your containers as environment variables, use
/// the <code>secrets</code> container definition parameter.
/// </li>
/// <li>
/// To reference sensitive information in the log configuration of a container,
/// use the <code>secretOptions</code> container definition parameter.
/// </li>
/// </ul>
/// For more information, see <a
/// href="https://docs.aws.amazon.com/batch/latest/userguide/specifying-sensitive-data.html">Specifying
/// sensitive data</a> in the <i>Batch User Guide</i>.
class Secret {
  /// The name of the secret.
  final String name;

  /// The secret to expose to the container. The supported values are either the
  /// full ARN of the Secrets Manager secret or the full ARN of the parameter in
  /// the Amazon Web Services Systems Manager Parameter Store.
  /// <note>
  /// If the Amazon Web Services Systems Manager Parameter Store parameter exists
  /// in the same Region as the job you're launching, then you can use either the
  /// full ARN or name of the parameter. If the parameter exists in a different
  /// Region, then the full ARN must be specified.
  /// </note>
  final String valueFrom;

  Secret({
    required this.name,
    required this.valueFrom,
  });
  factory Secret.fromJson(Map<String, dynamic> json) {
    return Secret(
      name: json['name'] as String,
      valueFrom: json['valueFrom'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final name = this.name;
    final valueFrom = this.valueFrom;
    return {
      'name': name,
      'valueFrom': valueFrom,
    };
  }
}

/// Specifies the weights for the fair share identifiers for the fair share
/// policy. Fair share identifiers that aren't included have a default weight of
/// <code>1.0</code>.
class ShareAttributes {
  /// A fair share identifier or fair share identifier prefix. If the string ends
  /// with an asterisk (*), this entry specifies the weight factor to use for fair
  /// share identifiers that start with that prefix. The list of fair share
  /// identifiers in a fair share policy cannot overlap. For example, you can't
  /// have one that specifies a <code>shareIdentifier</code> of
  /// <code>UserA*</code> and another that specifies a
  /// <code>shareIdentifier</code> of <code>UserA-1</code>.
  ///
  /// There can be no more than 500 fair share identifiers active in a job queue.
  ///
  /// The string is limited to 255 alphanumeric characters, optionally followed by
  /// an asterisk (*).
  final String shareIdentifier;

  /// The weight factor for the fair share identifier. The default value is 1.0. A
  /// lower value has a higher priority for compute resources. For example, jobs
  /// that use a share identifier with a weight factor of 0.125 (1/8) get 8 times
  /// the compute resources of jobs that use a share identifier with a weight
  /// factor of 1.
  ///
  /// The smallest supported value is 0.0001, and the largest supported value is
  /// 999.9999.
  final double? weightFactor;

  ShareAttributes({
    required this.shareIdentifier,
    this.weightFactor,
  });
  factory ShareAttributes.fromJson(Map<String, dynamic> json) {
    return ShareAttributes(
      shareIdentifier: json['shareIdentifier'] as String,
      weightFactor: json['weightFactor'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    final shareIdentifier = this.shareIdentifier;
    final weightFactor = this.weightFactor;
    return {
      'shareIdentifier': shareIdentifier,
      if (weightFactor != null) 'weightFactor': weightFactor,
    };
  }
}

class SubmitJobResponse {
  /// The unique identifier for the job.
  final String jobId;

  /// The name of the job.
  final String jobName;

  /// The Amazon Resource Name (ARN) for the job.
  final String? jobArn;

  SubmitJobResponse({
    required this.jobId,
    required this.jobName,
    this.jobArn,
  });
  factory SubmitJobResponse.fromJson(Map<String, dynamic> json) {
    return SubmitJobResponse(
      jobId: json['jobId'] as String,
      jobName: json['jobName'] as String,
      jobArn: json['jobArn'] as String?,
    );
  }
}

class TagResourceResponse {
  TagResourceResponse();
  factory TagResourceResponse.fromJson(Map<String, dynamic> _) {
    return TagResourceResponse();
  }
}

class TerminateJobResponse {
  TerminateJobResponse();
  factory TerminateJobResponse.fromJson(Map<String, dynamic> _) {
    return TerminateJobResponse();
  }
}

/// The container path, mount options, and size of the tmpfs mount.
/// <note>
/// This object isn't applicable to jobs that are running on Fargate resources.
/// </note>
class Tmpfs {
  /// The absolute file path in the container where the tmpfs volume is mounted.
  final String containerPath;

  /// The size (in MiB) of the tmpfs volume.
  final int size;

  /// The list of tmpfs volume mount options.
  ///
  /// Valid values: "<code>defaults</code>" | "<code>ro</code>" |
  /// "<code>rw</code>" | "<code>suid</code>" | "<code>nosuid</code>" |
  /// "<code>dev</code>" | "<code>nodev</code>" | "<code>exec</code>" |
  /// "<code>noexec</code>" | "<code>sync</code>" | "<code>async</code>" |
  /// "<code>dirsync</code>" | "<code>remount</code>" | "<code>mand</code>" |
  /// "<code>nomand</code>" | "<code>atime</code>" | "<code>noatime</code>" |
  /// "<code>diratime</code>" | "<code>nodiratime</code>" | "<code>bind</code>" |
  /// "<code>rbind" | "unbindable" | "runbindable" | "private" | "rprivate" |
  /// "shared" | "rshared" | "slave" | "rslave" | "relatime</code>" |
  /// "<code>norelatime</code>" | "<code>strictatime</code>" |
  /// "<code>nostrictatime</code>" | "<code>mode</code>" | "<code>uid</code>" |
  /// "<code>gid</code>" | "<code>nr_inodes</code>" | "<code>nr_blocks</code>" |
  /// "<code>mpol</code>"
  final List<String>? mountOptions;

  Tmpfs({
    required this.containerPath,
    required this.size,
    this.mountOptions,
  });
  factory Tmpfs.fromJson(Map<String, dynamic> json) {
    return Tmpfs(
      containerPath: json['containerPath'] as String,
      size: json['size'] as int,
      mountOptions: (json['mountOptions'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final containerPath = this.containerPath;
    final size = this.size;
    final mountOptions = this.mountOptions;
    return {
      'containerPath': containerPath,
      'size': size,
      if (mountOptions != null) 'mountOptions': mountOptions,
    };
  }
}

/// The <code>ulimit</code> settings to pass to the container.
/// <note>
/// This object isn't applicable to jobs that are running on Fargate resources.
/// </note>
class Ulimit {
  /// The hard limit for the <code>ulimit</code> type.
  final int hardLimit;

  /// The <code>type</code> of the <code>ulimit</code>.
  final String name;

  /// The soft limit for the <code>ulimit</code> type.
  final int softLimit;

  Ulimit({
    required this.hardLimit,
    required this.name,
    required this.softLimit,
  });
  factory Ulimit.fromJson(Map<String, dynamic> json) {
    return Ulimit(
      hardLimit: json['hardLimit'] as int,
      name: json['name'] as String,
      softLimit: json['softLimit'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final hardLimit = this.hardLimit;
    final name = this.name;
    final softLimit = this.softLimit;
    return {
      'hardLimit': hardLimit,
      'name': name,
      'softLimit': softLimit,
    };
  }
}

class UntagResourceResponse {
  UntagResourceResponse();
  factory UntagResourceResponse.fromJson(Map<String, dynamic> _) {
    return UntagResourceResponse();
  }
}

class UpdateComputeEnvironmentResponse {
  /// The Amazon Resource Name (ARN) of the compute environment.
  final String? computeEnvironmentArn;

  /// The name of the compute environment. It can be up to 128 letters long. It
  /// can contain uppercase and lowercase letters, numbers, hyphens (-), and
  /// underscores (_).
  final String? computeEnvironmentName;

  UpdateComputeEnvironmentResponse({
    this.computeEnvironmentArn,
    this.computeEnvironmentName,
  });
  factory UpdateComputeEnvironmentResponse.fromJson(Map<String, dynamic> json) {
    return UpdateComputeEnvironmentResponse(
      computeEnvironmentArn: json['computeEnvironmentArn'] as String?,
      computeEnvironmentName: json['computeEnvironmentName'] as String?,
    );
  }
}

class UpdateJobQueueResponse {
  /// The Amazon Resource Name (ARN) of the job queue.
  final String? jobQueueArn;

  /// The name of the job queue.
  final String? jobQueueName;

  UpdateJobQueueResponse({
    this.jobQueueArn,
    this.jobQueueName,
  });
  factory UpdateJobQueueResponse.fromJson(Map<String, dynamic> json) {
    return UpdateJobQueueResponse(
      jobQueueArn: json['jobQueueArn'] as String?,
      jobQueueName: json['jobQueueName'] as String?,
    );
  }
}

/// Specifies the infrastructure update policy for the compute environment. For
/// more information about infrastructure updates, see <a
/// href="https://docs.aws.amazon.com/batch/latest/userguide/infrastructure-updates.html">Infrastructure
/// updates</a> in the <i>Batch User Guide</i>.
class UpdatePolicy {
  /// Specifies the job timeout, in minutes, when the compute environment
  /// infrastructure is updated. The default value is 30.
  final int? jobExecutionTimeoutMinutes;

  /// Specifies whether jobs are automatically terminated when the computer
  /// environment infrastructure is updated. The default value is
  /// <code>false</code>.
  final bool? terminateJobsOnUpdate;

  UpdatePolicy({
    this.jobExecutionTimeoutMinutes,
    this.terminateJobsOnUpdate,
  });
  factory UpdatePolicy.fromJson(Map<String, dynamic> json) {
    return UpdatePolicy(
      jobExecutionTimeoutMinutes: json['jobExecutionTimeoutMinutes'] as int?,
      terminateJobsOnUpdate: json['terminateJobsOnUpdate'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    final jobExecutionTimeoutMinutes = this.jobExecutionTimeoutMinutes;
    final terminateJobsOnUpdate = this.terminateJobsOnUpdate;
    return {
      if (jobExecutionTimeoutMinutes != null)
        'jobExecutionTimeoutMinutes': jobExecutionTimeoutMinutes,
      if (terminateJobsOnUpdate != null)
        'terminateJobsOnUpdate': terminateJobsOnUpdate,
    };
  }
}

class UpdateSchedulingPolicyResponse {
  UpdateSchedulingPolicyResponse();
  factory UpdateSchedulingPolicyResponse.fromJson(Map<String, dynamic> _) {
    return UpdateSchedulingPolicyResponse();
  }
}

/// A data volume used in a job's container properties.
class Volume {
  /// This parameter is specified when you are using an Amazon Elastic File System
  /// file system for job storage. Jobs that are running on Fargate resources must
  /// specify a <code>platformVersion</code> of at least <code>1.4.0</code>.
  final EFSVolumeConfiguration? efsVolumeConfiguration;

  /// The contents of the <code>host</code> parameter determine whether your data
  /// volume persists on the host container instance and where it is stored. If
  /// the host parameter is empty, then the Docker daemon assigns a host path for
  /// your data volume. However, the data isn't guaranteed to persist after the
  /// containers associated with it stop running.
  /// <note>
  /// This parameter isn't applicable to jobs that are running on Fargate
  /// resources and shouldn't be provided.
  /// </note>
  final Host? host;

  /// The name of the volume. It can be up to 255 letters long. It can contain
  /// uppercase and lowercase letters, numbers, hyphens (-), and underscores (_).
  /// This name is referenced in the <code>sourceVolume</code> parameter of
  /// container definition <code>mountPoints</code>.
  final String? name;

  Volume({
    this.efsVolumeConfiguration,
    this.host,
    this.name,
  });
  factory Volume.fromJson(Map<String, dynamic> json) {
    return Volume(
      efsVolumeConfiguration: json['efsVolumeConfiguration'] != null
          ? EFSVolumeConfiguration.fromJson(
              json['efsVolumeConfiguration'] as Map<String, dynamic>)
          : null,
      host: json['host'] != null
          ? Host.fromJson(json['host'] as Map<String, dynamic>)
          : null,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final efsVolumeConfiguration = this.efsVolumeConfiguration;
    final host = this.host;
    final name = this.name;
    return {
      if (efsVolumeConfiguration != null)
        'efsVolumeConfiguration': efsVolumeConfiguration,
      if (host != null) 'host': host,
      if (name != null) 'name': name,
    };
  }
}

class ClientException extends _s.GenericAwsException {
  ClientException({String? type, String? message})
      : super(type: type, code: 'ClientException', message: message);
}

class ServerException extends _s.GenericAwsException {
  ServerException({String? type, String? message})
      : super(type: type, code: 'ServerException', message: message);
}

final _exceptionFns = <String, _s.AwsExceptionFn>{
  'ClientException': (type, message) =>
      ClientException(type: type, message: message),
  'ServerException': (type, message) =>
      ServerException(type: type, message: message),
};
