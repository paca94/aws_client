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

import 'autoscaling-2011-01-01.meta.dart';
export 'package:shared_aws_api/shared.dart' show AwsClientCredentials;

/// Amazon EC2 Auto Scaling is designed to automatically launch and terminate
/// EC2 instances based on user-defined scaling policies, scheduled actions, and
/// health checks.
class AutoScaling {
  final _s.QueryProtocol _protocol;
  final Map<String, _s.Shape> shapes;

  AutoScaling({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.AwsClientCredentialsProvider? credentialsProvider,
    _s.Client? client,
    String? endpointUrl,
  })  : _protocol = _s.QueryProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'autoscaling',
          ),
          region: region,
          credentials: credentials,
          credentialsProvider: credentialsProvider,
          endpointUrl: endpointUrl,
        ),
        shapes = shapesJson
            .map((key, value) => MapEntry(key, _s.Shape.fromJson(value)));

  /// Closes the internal HTTP client if none was provided at creation.
  /// If a client was passed as a constructor argument, this becomes a noop.
  ///
  /// It's important to close all clients when it's done being used; failing to
  /// do so can cause the Dart process to hang.
  void close() {
    _protocol.close();
  }

  /// Attaches one or more EC2 instances to the specified Auto Scaling group.
  ///
  /// When you attach instances, Amazon EC2 Auto Scaling increases the desired
  /// capacity of the group by the number of instances being attached. If the
  /// number of instances being attached plus the desired capacity of the group
  /// exceeds the maximum size of the group, the operation fails.
  ///
  /// If there is a Classic Load Balancer attached to your Auto Scaling group,
  /// the instances are also registered with the load balancer. If there are
  /// target groups attached to your Auto Scaling group, the instances are also
  /// registered with the target groups.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/attach-instance-asg.html">Attach
  /// EC2 instances to your Auto Scaling group</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>.
  ///
  /// May throw [ResourceContentionFault].
  /// May throw [ServiceLinkedRoleFailure].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [instanceIds] :
  /// The IDs of the instances. You can specify up to 20 instances.
  Future<void> attachInstances({
    required String autoScalingGroupName,
    List<String>? instanceIds,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    instanceIds?.also((arg) => $request['InstanceIds'] = arg);
    await _protocol.send(
      $request,
      action: 'AttachInstances',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['AttachInstancesQuery'],
      shapes: shapes,
    );
  }

  /// Attaches one or more target groups to the specified Auto Scaling group.
  ///
  /// This operation is used with the following load balancer types:
  ///
  /// <ul>
  /// <li>
  /// Application Load Balancer - Operates at the application layer (layer 7)
  /// and supports HTTP and HTTPS.
  /// </li>
  /// <li>
  /// Network Load Balancer - Operates at the transport layer (layer 4) and
  /// supports TCP, TLS, and UDP.
  /// </li>
  /// <li>
  /// Gateway Load Balancer - Operates at the network layer (layer 3).
  /// </li>
  /// </ul>
  /// To describe the target groups for an Auto Scaling group, call the
  /// <a>DescribeLoadBalancerTargetGroups</a> API. To detach the target group
  /// from the Auto Scaling group, call the
  /// <a>DetachLoadBalancerTargetGroups</a> API.
  ///
  /// This operation is additive and does not detach existing target groups or
  /// Classic Load Balancers from the Auto Scaling group.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-load-balancer.html">Use
  /// Elastic Load Balancing to distribute traffic across the instances in your
  /// Auto Scaling group</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// May throw [ResourceContentionFault].
  /// May throw [ServiceLinkedRoleFailure].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [targetGroupARNs] :
  /// The Amazon Resource Names (ARN) of the target groups. You can specify up
  /// to 10 target groups. To get the ARN of a target group, use the Elastic
  /// Load Balancing <a
  /// href="https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeTargetGroups.html">DescribeTargetGroups</a>
  /// API operation.
  Future<void> attachLoadBalancerTargetGroups({
    required String autoScalingGroupName,
    required List<String> targetGroupARNs,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(targetGroupARNs, 'targetGroupARNs');
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['TargetGroupARNs'] = targetGroupARNs;
    await _protocol.send(
      $request,
      action: 'AttachLoadBalancerTargetGroups',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['AttachLoadBalancerTargetGroupsType'],
      shapes: shapes,
      resultWrapper: 'AttachLoadBalancerTargetGroupsResult',
    );
  }

  /// <note>
  /// To attach an Application Load Balancer, Network Load Balancer, or Gateway
  /// Load Balancer, use the <a>AttachLoadBalancerTargetGroups</a> API operation
  /// instead.
  /// </note>
  /// Attaches one or more Classic Load Balancers to the specified Auto Scaling
  /// group. Amazon EC2 Auto Scaling registers the running instances with these
  /// Classic Load Balancers.
  ///
  /// To describe the load balancers for an Auto Scaling group, call the
  /// <a>DescribeLoadBalancers</a> API. To detach a load balancer from the Auto
  /// Scaling group, call the <a>DetachLoadBalancers</a> API.
  ///
  /// This operation is additive and does not detach existing Classic Load
  /// Balancers or target groups from the Auto Scaling group.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-load-balancer.html">Use
  /// Elastic Load Balancing to distribute traffic across the instances in your
  /// Auto Scaling group</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// May throw [ResourceContentionFault].
  /// May throw [ServiceLinkedRoleFailure].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [loadBalancerNames] :
  /// The names of the load balancers. You can specify up to 10 load balancers.
  Future<void> attachLoadBalancers({
    required String autoScalingGroupName,
    required List<String> loadBalancerNames,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(loadBalancerNames, 'loadBalancerNames');
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['LoadBalancerNames'] = loadBalancerNames;
    await _protocol.send(
      $request,
      action: 'AttachLoadBalancers',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['AttachLoadBalancersType'],
      shapes: shapes,
      resultWrapper: 'AttachLoadBalancersResult',
    );
  }

  /// Deletes one or more scheduled actions for the specified Auto Scaling
  /// group.
  ///
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [scheduledActionNames] :
  /// The names of the scheduled actions to delete. The maximum number allowed
  /// is 50.
  Future<BatchDeleteScheduledActionAnswer> batchDeleteScheduledAction({
    required String autoScalingGroupName,
    required List<String> scheduledActionNames,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(scheduledActionNames, 'scheduledActionNames');
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['ScheduledActionNames'] = scheduledActionNames;
    final $result = await _protocol.send(
      $request,
      action: 'BatchDeleteScheduledAction',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['BatchDeleteScheduledActionType'],
      shapes: shapes,
      resultWrapper: 'BatchDeleteScheduledActionResult',
    );
    return BatchDeleteScheduledActionAnswer.fromXml($result);
  }

  /// Creates or updates one or more scheduled scaling actions for an Auto
  /// Scaling group.
  ///
  /// May throw [AlreadyExistsFault].
  /// May throw [LimitExceededFault].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [scheduledUpdateGroupActions] :
  /// One or more scheduled actions. The maximum number allowed is 50.
  Future<BatchPutScheduledUpdateGroupActionAnswer>
      batchPutScheduledUpdateGroupAction({
    required String autoScalingGroupName,
    required List<ScheduledUpdateGroupActionRequest>
        scheduledUpdateGroupActions,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(
        scheduledUpdateGroupActions, 'scheduledUpdateGroupActions');
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['ScheduledUpdateGroupActions'] = scheduledUpdateGroupActions;
    final $result = await _protocol.send(
      $request,
      action: 'BatchPutScheduledUpdateGroupAction',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['BatchPutScheduledUpdateGroupActionType'],
      shapes: shapes,
      resultWrapper: 'BatchPutScheduledUpdateGroupActionResult',
    );
    return BatchPutScheduledUpdateGroupActionAnswer.fromXml($result);
  }

  /// Cancels an instance refresh operation in progress. Cancellation does not
  /// roll back any replacements that have already been completed, but it
  /// prevents new replacements from being started.
  ///
  /// This operation is part of the <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-instance-refresh.html">instance
  /// refresh feature</a> in Amazon EC2 Auto Scaling, which helps you update
  /// instances in your Auto Scaling group after you make configuration changes.
  ///
  /// May throw [LimitExceededFault].
  /// May throw [ResourceContentionFault].
  /// May throw [ActiveInstanceRefreshNotFoundFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  Future<CancelInstanceRefreshAnswer> cancelInstanceRefresh({
    required String autoScalingGroupName,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    final $result = await _protocol.send(
      $request,
      action: 'CancelInstanceRefresh',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['CancelInstanceRefreshType'],
      shapes: shapes,
      resultWrapper: 'CancelInstanceRefreshResult',
    );
    return CancelInstanceRefreshAnswer.fromXml($result);
  }

  /// Completes the lifecycle action for the specified token or instance with
  /// the specified result.
  ///
  /// This step is a part of the procedure for adding a lifecycle hook to an
  /// Auto Scaling group:
  /// <ol>
  /// <li>
  /// (Optional) Create a launch template or launch configuration with a user
  /// data script that runs while an instance is in a wait state due to a
  /// lifecycle hook.
  /// </li>
  /// <li>
  /// (Optional) Create a Lambda function and a rule that allows Amazon
  /// EventBridge to invoke your Lambda function when an instance is put into a
  /// wait state due to a lifecycle hook.
  /// </li>
  /// <li>
  /// (Optional) Create a notification target and an IAM role. The target can be
  /// either an Amazon SQS queue or an Amazon SNS topic. The role allows Amazon
  /// EC2 Auto Scaling to publish lifecycle notifications to the target.
  /// </li>
  /// <li>
  /// Create the lifecycle hook. Specify whether the hook is used when the
  /// instances launch or terminate.
  /// </li>
  /// <li>
  /// If you need more time, record the lifecycle action heartbeat to keep the
  /// instance in a wait state.
  /// </li>
  /// <li>
  /// <b>If you finish before the timeout period ends, send a callback by using
  /// the <a>CompleteLifecycleAction</a> API call.</b>
  /// </li> </ol>
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/lifecycle-hooks.html">Amazon
  /// EC2 Auto Scaling lifecycle hooks</a> in the <i>Amazon EC2 Auto Scaling
  /// User Guide</i>.
  ///
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [lifecycleActionResult] :
  /// The action for the group to take. You can specify either
  /// <code>CONTINUE</code> or <code>ABANDON</code>.
  ///
  /// Parameter [lifecycleHookName] :
  /// The name of the lifecycle hook.
  ///
  /// Parameter [instanceId] :
  /// The ID of the instance.
  ///
  /// Parameter [lifecycleActionToken] :
  /// A universally unique identifier (UUID) that identifies a specific
  /// lifecycle action associated with an instance. Amazon EC2 Auto Scaling
  /// sends this token to the notification target you specified when you created
  /// the lifecycle hook.
  Future<void> completeLifecycleAction({
    required String autoScalingGroupName,
    required String lifecycleActionResult,
    required String lifecycleHookName,
    String? instanceId,
    String? lifecycleActionToken,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      1600,
      isRequired: true,
    );
    ArgumentError.checkNotNull(lifecycleActionResult, 'lifecycleActionResult');
    ArgumentError.checkNotNull(lifecycleHookName, 'lifecycleHookName');
    _s.validateStringLength(
      'lifecycleHookName',
      lifecycleHookName,
      1,
      255,
      isRequired: true,
    );
    _s.validateStringLength(
      'instanceId',
      instanceId,
      1,
      19,
    );
    _s.validateStringLength(
      'lifecycleActionToken',
      lifecycleActionToken,
      36,
      36,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['LifecycleActionResult'] = lifecycleActionResult;
    $request['LifecycleHookName'] = lifecycleHookName;
    instanceId?.also((arg) => $request['InstanceId'] = arg);
    lifecycleActionToken?.also((arg) => $request['LifecycleActionToken'] = arg);
    await _protocol.send(
      $request,
      action: 'CompleteLifecycleAction',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['CompleteLifecycleActionType'],
      shapes: shapes,
      resultWrapper: 'CompleteLifecycleActionResult',
    );
  }

  /// <b>We strongly recommend using a launch template when calling this
  /// operation to ensure full functionality for Amazon EC2 Auto Scaling and
  /// Amazon EC2.</b>
  ///
  /// Creates an Auto Scaling group with the specified name and attributes.
  ///
  /// If you exceed your maximum limit of Auto Scaling groups, the call fails.
  /// To query this limit, call the <a>DescribeAccountLimits</a> API. For
  /// information about updating this limit, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-quotas.html">Quotas
  /// for Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  ///
  /// For introductory exercises for creating an Auto Scaling group, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/GettingStartedTutorial.html">Getting
  /// started with Amazon EC2 Auto Scaling</a> and <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-register-lbs-with-asg.html">Tutorial:
  /// Set up a scaled and load-balanced application</a> in the <i>Amazon EC2
  /// Auto Scaling User Guide</i>. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html">Auto
  /// Scaling groups</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// Every Auto Scaling group has three size properties
  /// (<code>DesiredCapacity</code>, <code>MaxSize</code>, and
  /// <code>MinSize</code>). Usually, you set these sizes based on a specific
  /// number of instances. However, if you configure a mixed instances policy
  /// that defines weights for the instance types, you must specify these sizes
  /// with the same units that you use for weighting instances.
  ///
  /// May throw [AlreadyExistsFault].
  /// May throw [LimitExceededFault].
  /// May throw [ResourceContentionFault].
  /// May throw [ServiceLinkedRoleFailure].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group. This name must be unique per Region
  /// per account.
  ///
  /// Parameter [maxSize] :
  /// The maximum size of the group.
  /// <note>
  /// With a mixed instances policy that uses instance weighting, Amazon EC2
  /// Auto Scaling may need to go above <code>MaxSize</code> to meet your
  /// capacity requirements. In this event, Amazon EC2 Auto Scaling will never
  /// go above <code>MaxSize</code> by more than your largest instance weight
  /// (weights that define how many units each instance contributes to the
  /// desired capacity of the group).
  /// </note>
  ///
  /// Parameter [minSize] :
  /// The minimum size of the group.
  ///
  /// Parameter [availabilityZones] :
  /// A list of Availability Zones where instances in the Auto Scaling group can
  /// be created. Used for launching into the default VPC subnet in each
  /// Availability Zone when not using the <code>VPCZoneIdentifier</code>
  /// property, or for attaching a network interface when an existing network
  /// interface ID is specified in a launch template.
  ///
  /// Parameter [capacityRebalance] :
  /// Indicates whether Capacity Rebalancing is enabled. Otherwise, Capacity
  /// Rebalancing is disabled. When you turn on Capacity Rebalancing, Amazon EC2
  /// Auto Scaling attempts to launch a Spot Instance whenever Amazon EC2
  /// notifies that a Spot Instance is at an elevated risk of interruption.
  /// After launching a new instance, it then terminates an old instance. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-capacity-rebalancing.html">Use
  /// Capacity Rebalancing to handle Amazon EC2 Spot Interruptions</a> in the in
  /// the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// Parameter [context] :
  /// Reserved.
  ///
  /// Parameter [defaultCooldown] :
  /// <i>Only needed if you use simple scaling policies.</i>
  ///
  /// The amount of time, in seconds, between one scaling activity ending and
  /// another one starting due to simple scaling policies. For more information,
  /// see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/Cooldown.html">Scaling
  /// cooldowns for Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>.
  ///
  /// Default: <code>300</code> seconds
  ///
  /// Parameter [defaultInstanceWarmup] :
  /// The amount of time, in seconds, until a newly launched instance can
  /// contribute to the Amazon CloudWatch metrics. This delay lets an instance
  /// finish initializing before Amazon EC2 Auto Scaling aggregates instance
  /// metrics, resulting in more reliable usage data. Set this value equal to
  /// the amount of time that it takes for resource consumption to become stable
  /// after an instance reaches the <code>InService</code> state. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-default-instance-warmup.html">Set
  /// the default instance warmup for an Auto Scaling group</a> in the <i>Amazon
  /// EC2 Auto Scaling User Guide</i>.
  /// <important>
  /// To manage your warm-up settings at the group level, we recommend that you
  /// set the default instance warmup, <i>even if its value is set to 0
  /// seconds</i>. This also optimizes the performance of scaling policies that
  /// scale continuously, such as target tracking and step scaling policies.
  ///
  /// If you need to remove a value that you previously set, include the
  /// property but specify <code>-1</code> for the value. However, we strongly
  /// recommend keeping the default instance warmup enabled by specifying a
  /// minimum value of <code>0</code>.
  /// </important>
  /// Default: None
  ///
  /// Parameter [desiredCapacity] :
  /// The desired capacity is the initial capacity of the Auto Scaling group at
  /// the time of its creation and the capacity it attempts to maintain. It can
  /// scale beyond this capacity if you configure auto scaling. This number must
  /// be greater than or equal to the minimum size of the group and less than or
  /// equal to the maximum size of the group. If you do not specify a desired
  /// capacity, the default is the minimum size of the group.
  ///
  /// Parameter [desiredCapacityType] :
  /// The unit of measurement for the value specified for desired capacity.
  /// Amazon EC2 Auto Scaling supports <code>DesiredCapacityType</code> for
  /// attribute-based instance type selection only. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-asg-instance-type-requirements.html">Creating
  /// an Auto Scaling group using attribute-based instance type selection</a> in
  /// the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// By default, Amazon EC2 Auto Scaling specifies <code>units</code>, which
  /// translates into number of instances.
  ///
  /// Valid values: <code>units</code> | <code>vcpu</code> |
  /// <code>memory-mib</code>
  ///
  /// Parameter [healthCheckGracePeriod] :
  /// The amount of time, in seconds, that Amazon EC2 Auto Scaling waits before
  /// checking the health status of an EC2 instance that has come into service
  /// and marking it unhealthy due to a failed Elastic Load Balancing or custom
  /// health check. This is useful if your instances do not immediately pass
  /// these health checks after they enter the <code>InService</code> state. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/healthcheck.html#health-check-grace-period">Health
  /// check grace period</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// Default: <code>0</code> seconds
  ///
  /// Parameter [healthCheckType] :
  /// The service to use for the health checks. The valid values are
  /// <code>EC2</code> (default) and <code>ELB</code>. If you configure an Auto
  /// Scaling group to use load balancer (ELB) health checks, it considers the
  /// instance unhealthy if it fails either the EC2 status checks or the load
  /// balancer health checks. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/healthcheck.html">Health
  /// checks for Auto Scaling instances</a> in the <i>Amazon EC2 Auto Scaling
  /// User Guide</i>.
  ///
  /// Parameter [instanceId] :
  /// The ID of the instance used to base the launch configuration on. If
  /// specified, Amazon EC2 Auto Scaling uses the configuration values from the
  /// specified instance to create a new launch configuration. To get the
  /// instance ID, use the Amazon EC2 <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html">DescribeInstances</a>
  /// API operation. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-asg-from-instance.html">Creating
  /// an Auto Scaling group using an EC2 instance</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>.
  ///
  /// Parameter [launchConfigurationName] :
  /// The name of the launch configuration to use to launch instances.
  ///
  /// Conditional: You must specify either a launch template
  /// (<code>LaunchTemplate</code> or <code>MixedInstancesPolicy</code>) or a
  /// launch configuration (<code>LaunchConfigurationName</code> or
  /// <code>InstanceId</code>).
  ///
  /// Parameter [launchTemplate] :
  /// Information used to specify the launch template and version to use to
  /// launch instances.
  ///
  /// Conditional: You must specify either a launch template
  /// (<code>LaunchTemplate</code> or <code>MixedInstancesPolicy</code>) or a
  /// launch configuration (<code>LaunchConfigurationName</code> or
  /// <code>InstanceId</code>).
  /// <note>
  /// The launch template that is specified must be configured for use with an
  /// Auto Scaling group. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-launch-template.html">Creating
  /// a launch template for an Auto Scaling group</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>.
  /// </note>
  ///
  /// Parameter [lifecycleHookSpecificationList] :
  /// One or more lifecycle hooks to add to the Auto Scaling group before
  /// instances are launched.
  ///
  /// Parameter [loadBalancerNames] :
  /// A list of Classic Load Balancers associated with this Auto Scaling group.
  /// For Application Load Balancers, Network Load Balancers, and Gateway Load
  /// Balancer, specify the <code>TargetGroupARNs</code> property instead.
  ///
  /// Parameter [maxInstanceLifetime] :
  /// The maximum amount of time, in seconds, that an instance can be in
  /// service. The default is null. If specified, the value must be either 0 or
  /// a number equal to or greater than 86,400 seconds (1 day). For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-max-instance-lifetime.html">Replacing
  /// Auto Scaling instances based on maximum instance lifetime</a> in the
  /// <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// Parameter [mixedInstancesPolicy] :
  /// An embedded object that specifies a mixed instances policy.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-mixed-instances-groups.html">Auto
  /// Scaling groups with multiple instance types and purchase options</a> in
  /// the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// Parameter [newInstancesProtectedFromScaleIn] :
  /// Indicates whether newly launched instances are protected from termination
  /// by Amazon EC2 Auto Scaling when scaling in. For more information about
  /// preventing instances from terminating on scale in, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-instance-protection.html">Using
  /// instance scale-in protection</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  ///
  /// Parameter [placementGroup] :
  /// The name of the placement group into which to launch your instances. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html">Placement
  /// groups</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.
  /// <note>
  /// A <i>cluster</i> placement group is a logical grouping of instances within
  /// a single Availability Zone. You cannot specify multiple Availability Zones
  /// and a cluster placement group.
  /// </note>
  ///
  /// Parameter [serviceLinkedRoleARN] :
  /// The Amazon Resource Name (ARN) of the service-linked role that the Auto
  /// Scaling group uses to call other Amazon Web Services service on your
  /// behalf. By default, Amazon EC2 Auto Scaling uses a service-linked role
  /// named <code>AWSServiceRoleForAutoScaling</code>, which it creates if it
  /// does not exist. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-service-linked-role.html">Service-linked
  /// roles</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// Parameter [tags] :
  /// One or more tags. You can tag your Auto Scaling group and propagate the
  /// tags to the Amazon EC2 instances it launches. Tags are not propagated to
  /// Amazon EBS volumes. To add tags to Amazon EBS volumes, specify the tags in
  /// a launch template but use caution. If the launch template specifies an
  /// instance tag with a key that is also specified for the Auto Scaling group,
  /// Amazon EC2 Auto Scaling overrides the value of that instance tag with the
  /// value specified by the Auto Scaling group. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-tagging.html">Tag
  /// Auto Scaling groups and instances</a> in the <i>Amazon EC2 Auto Scaling
  /// User Guide</i>.
  ///
  /// Parameter [targetGroupARNs] :
  /// The Amazon Resource Names (ARN) of the target groups to associate with the
  /// Auto Scaling group. Instances are registered as targets with the target
  /// groups. The target groups receive incoming traffic and route requests to
  /// one or more registered targets. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-load-balancer.html">Use
  /// Elastic Load Balancing to distribute traffic across the instances in your
  /// Auto Scaling group</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// Parameter [terminationPolicies] :
  /// A policy or a list of policies that are used to select the instance to
  /// terminate. These policies are executed in the order that you list them.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-termination-policies.html">Work
  /// with Amazon EC2 Auto Scaling termination policies</a> in the <i>Amazon EC2
  /// Auto Scaling User Guide</i>.
  ///
  /// Valid values: <code>Default</code> | <code>AllocationStrategy</code> |
  /// <code>ClosestToNextInstanceHour</code> | <code>NewestInstance</code> |
  /// <code>OldestInstance</code> | <code>OldestLaunchConfiguration</code> |
  /// <code>OldestLaunchTemplate</code> |
  /// <code>arn:aws:lambda:region:account-id:function:my-function:my-alias</code>
  ///
  /// Parameter [vPCZoneIdentifier] :
  /// A comma-separated list of subnet IDs for a virtual private cloud (VPC)
  /// where instances in the Auto Scaling group can be created. If you specify
  /// <code>VPCZoneIdentifier</code> with <code>AvailabilityZones</code>, the
  /// subnets that you specify must reside in those Availability Zones.
  Future<void> createAutoScalingGroup({
    required String autoScalingGroupName,
    required int maxSize,
    required int minSize,
    List<String>? availabilityZones,
    bool? capacityRebalance,
    String? context,
    int? defaultCooldown,
    int? defaultInstanceWarmup,
    int? desiredCapacity,
    String? desiredCapacityType,
    int? healthCheckGracePeriod,
    String? healthCheckType,
    String? instanceId,
    String? launchConfigurationName,
    LaunchTemplateSpecification? launchTemplate,
    List<LifecycleHookSpecification>? lifecycleHookSpecificationList,
    List<String>? loadBalancerNames,
    int? maxInstanceLifetime,
    MixedInstancesPolicy? mixedInstancesPolicy,
    bool? newInstancesProtectedFromScaleIn,
    String? placementGroup,
    String? serviceLinkedRoleARN,
    List<Tag>? tags,
    List<String>? targetGroupARNs,
    List<String>? terminationPolicies,
    String? vPCZoneIdentifier,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(maxSize, 'maxSize');
    ArgumentError.checkNotNull(minSize, 'minSize');
    _s.validateStringLength(
      'desiredCapacityType',
      desiredCapacityType,
      1,
      255,
    );
    _s.validateStringLength(
      'healthCheckType',
      healthCheckType,
      1,
      32,
    );
    _s.validateStringLength(
      'instanceId',
      instanceId,
      1,
      19,
    );
    _s.validateStringLength(
      'launchConfigurationName',
      launchConfigurationName,
      1,
      255,
    );
    _s.validateStringLength(
      'placementGroup',
      placementGroup,
      1,
      255,
    );
    _s.validateStringLength(
      'serviceLinkedRoleARN',
      serviceLinkedRoleARN,
      1,
      1600,
    );
    _s.validateStringLength(
      'vPCZoneIdentifier',
      vPCZoneIdentifier,
      1,
      2047,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['MaxSize'] = maxSize;
    $request['MinSize'] = minSize;
    availabilityZones?.also((arg) => $request['AvailabilityZones'] = arg);
    capacityRebalance?.also((arg) => $request['CapacityRebalance'] = arg);
    context?.also((arg) => $request['Context'] = arg);
    defaultCooldown?.also((arg) => $request['DefaultCooldown'] = arg);
    defaultInstanceWarmup
        ?.also((arg) => $request['DefaultInstanceWarmup'] = arg);
    desiredCapacity?.also((arg) => $request['DesiredCapacity'] = arg);
    desiredCapacityType?.also((arg) => $request['DesiredCapacityType'] = arg);
    healthCheckGracePeriod
        ?.also((arg) => $request['HealthCheckGracePeriod'] = arg);
    healthCheckType?.also((arg) => $request['HealthCheckType'] = arg);
    instanceId?.also((arg) => $request['InstanceId'] = arg);
    launchConfigurationName
        ?.also((arg) => $request['LaunchConfigurationName'] = arg);
    launchTemplate?.also((arg) => $request['LaunchTemplate'] = arg);
    lifecycleHookSpecificationList
        ?.also((arg) => $request['LifecycleHookSpecificationList'] = arg);
    loadBalancerNames?.also((arg) => $request['LoadBalancerNames'] = arg);
    maxInstanceLifetime?.also((arg) => $request['MaxInstanceLifetime'] = arg);
    mixedInstancesPolicy?.also((arg) => $request['MixedInstancesPolicy'] = arg);
    newInstancesProtectedFromScaleIn
        ?.also((arg) => $request['NewInstancesProtectedFromScaleIn'] = arg);
    placementGroup?.also((arg) => $request['PlacementGroup'] = arg);
    serviceLinkedRoleARN?.also((arg) => $request['ServiceLinkedRoleARN'] = arg);
    tags?.also((arg) => $request['Tags'] = arg);
    targetGroupARNs?.also((arg) => $request['TargetGroupARNs'] = arg);
    terminationPolicies?.also((arg) => $request['TerminationPolicies'] = arg);
    vPCZoneIdentifier?.also((arg) => $request['VPCZoneIdentifier'] = arg);
    await _protocol.send(
      $request,
      action: 'CreateAutoScalingGroup',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['CreateAutoScalingGroupType'],
      shapes: shapes,
    );
  }

  /// Creates a launch configuration.
  ///
  /// If you exceed your maximum limit of launch configurations, the call fails.
  /// To query this limit, call the <a>DescribeAccountLimits</a> API. For
  /// information about updating this limit, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-quotas.html">Quotas
  /// for Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/LaunchConfiguration.html">Launch
  /// configurations</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// May throw [AlreadyExistsFault].
  /// May throw [LimitExceededFault].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [launchConfigurationName] :
  /// The name of the launch configuration. This name must be unique per Region
  /// per account.
  ///
  /// Parameter [associatePublicIpAddress] :
  /// Specifies whether to assign a public IPv4 address to the group's
  /// instances. If the instance is launched into a default subnet, the default
  /// is to assign a public IPv4 address, unless you disabled the option to
  /// assign a public IPv4 address on the subnet. If the instance is launched
  /// into a nondefault subnet, the default is not to assign a public IPv4
  /// address, unless you enabled the option to assign a public IPv4 address on
  /// the subnet.
  ///
  /// If you specify <code>true</code>, each instance in the Auto Scaling group
  /// receives a unique public IPv4 address. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-in-vpc.html">Launching
  /// Auto Scaling instances in a VPC</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  ///
  /// If you specify this property, you must specify at least one subnet for
  /// <code>VPCZoneIdentifier</code> when you create your group.
  ///
  /// Parameter [blockDeviceMappings] :
  /// The block device mapping entries that define the block devices to attach
  /// to the instances at launch. By default, the block devices specified in the
  /// block device mapping for the AMI are used. For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html">Block
  /// device mappings</a> in the <i>Amazon EC2 User Guide for Linux
  /// Instances</i>.
  ///
  /// Parameter [classicLinkVPCId] :
  /// <i>EC2-Classic retires on August 15, 2022. This property is not supported
  /// after that date.</i>
  ///
  /// The ID of a ClassicLink-enabled VPC to link your EC2-Classic instances to.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/vpc-classiclink.html">ClassicLink</a>
  /// in the <i>Amazon EC2 User Guide for Linux Instances</i>.
  ///
  /// Parameter [classicLinkVPCSecurityGroups] :
  /// <i>EC2-Classic retires on August 15, 2022. This property is not supported
  /// after that date.</i>
  ///
  /// The IDs of one or more security groups for the specified
  /// ClassicLink-enabled VPC.
  ///
  /// If you specify the <code>ClassicLinkVPCId</code> property, you must
  /// specify <code>ClassicLinkVPCSecurityGroups</code>.
  ///
  /// Parameter [ebsOptimized] :
  /// Specifies whether the launch configuration is optimized for EBS I/O
  /// (<code>true</code>) or not (<code>false</code>). The optimization provides
  /// dedicated throughput to Amazon EBS and an optimized configuration stack to
  /// provide optimal I/O performance. This optimization is not available with
  /// all instance types. Additional fees are incurred when you enable EBS
  /// optimization for an instance type that is not EBS-optimized by default.
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSOptimized.html">Amazon
  /// EBS-optimized instances</a> in the <i>Amazon EC2 User Guide for Linux
  /// Instances</i>.
  ///
  /// The default value is <code>false</code>.
  ///
  /// Parameter [iamInstanceProfile] :
  /// The name or the Amazon Resource Name (ARN) of the instance profile
  /// associated with the IAM role for the instance. The instance profile
  /// contains the IAM role. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/us-iam-role.html">IAM
  /// role for applications that run on Amazon EC2 instances</a> in the
  /// <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// Parameter [imageId] :
  /// The ID of the Amazon Machine Image (AMI) that was assigned during
  /// registration. For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html">Finding
  /// a Linux AMI</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.
  ///
  /// If you specify <code>InstanceId</code>, an <code>ImageId</code> is not
  /// required.
  ///
  /// Parameter [instanceId] :
  /// The ID of the instance to use to create the launch configuration. The new
  /// launch configuration derives attributes from the instance, except for the
  /// block device mapping.
  ///
  /// To create a launch configuration with a block device mapping or override
  /// any other instance attributes, specify them as part of the same request.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-lc-with-instanceID.html">Creating
  /// a launch configuration using an EC2 instance</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>.
  ///
  /// Parameter [instanceMonitoring] :
  /// Controls whether instances in this group are launched with detailed
  /// (<code>true</code>) or basic (<code>false</code>) monitoring.
  ///
  /// The default value is <code>true</code> (enabled).
  /// <important>
  /// When detailed monitoring is enabled, Amazon CloudWatch generates metrics
  /// every minute and your account is charged a fee. When you disable detailed
  /// monitoring, CloudWatch generates metrics every 5 minutes. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/latest/userguide/enable-as-instance-metrics.html">Configure
  /// Monitoring for Auto Scaling Instances</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>.
  /// </important>
  ///
  /// Parameter [instanceType] :
  /// Specifies the instance type of the EC2 instance. For information about
  /// available instance types, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#AvailableInstanceTypes">Available
  /// instance types</a> in the <i>Amazon EC2 User Guide for Linux
  /// Instances</i>.
  ///
  /// If you specify <code>InstanceId</code>, an <code>InstanceType</code> is
  /// not required.
  ///
  /// Parameter [kernelId] :
  /// The ID of the kernel associated with the AMI.
  /// <note>
  /// We recommend that you use PV-GRUB instead of kernels and RAM disks. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedKernels.html">User
  /// provided kernels</a> in the <i>Amazon EC2 User Guide for Linux
  /// Instances</i>.
  /// </note>
  ///
  /// Parameter [keyName] :
  /// The name of the key pair. For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html">Amazon
  /// EC2 key pairs and Linux instances</a> in the <i>Amazon EC2 User Guide for
  /// Linux Instances</i>.
  ///
  /// Parameter [metadataOptions] :
  /// The metadata options for the instances. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-launch-config.html#launch-configurations-imds">Configuring
  /// the Instance Metadata Options</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  ///
  /// Parameter [placementTenancy] :
  /// The tenancy of the instance, either <code>default</code> or
  /// <code>dedicated</code>. An instance with <code>dedicated</code> tenancy
  /// runs on isolated, single-tenant hardware and can only be launched into a
  /// VPC. To launch dedicated instances into a shared tenancy VPC (a VPC with
  /// the instance placement tenancy attribute set to <code>default</code>), you
  /// must set the value of this property to <code>dedicated</code>. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/auto-scaling-dedicated-instances.html">Configuring
  /// instance tenancy with Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2
  /// Auto Scaling User Guide</i>.
  ///
  /// If you specify <code>PlacementTenancy</code>, you must specify at least
  /// one subnet for <code>VPCZoneIdentifier</code> when you create your group.
  ///
  /// Valid values: <code>default</code> | <code>dedicated</code>
  ///
  /// Parameter [ramdiskId] :
  /// The ID of the RAM disk to select.
  /// <note>
  /// We recommend that you use PV-GRUB instead of kernels and RAM disks. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UserProvidedKernels.html">User
  /// provided kernels</a> in the <i>Amazon EC2 User Guide for Linux
  /// Instances</i>.
  /// </note>
  ///
  /// Parameter [securityGroups] :
  /// A list that contains the security group IDs to assign to the instances in
  /// the Auto Scaling group. For more information, see <a
  /// href="https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html">Control
  /// traffic to resources using security groups</a> in the <i>Amazon Virtual
  /// Private Cloud User Guide</i>.
  ///
  /// Parameter [spotPrice] :
  /// The maximum hourly price to be paid for any Spot Instance launched to
  /// fulfill the request. Spot Instances are launched when the price you
  /// specify exceeds the current Spot price. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/launch-template-spot-instances.html">Request
  /// Spot Instances for fault-tolerant and flexible applications</a> in the
  /// <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// Valid Range: Minimum value of 0.001
  /// <note>
  /// When you change your maximum price by creating a new launch configuration,
  /// running instances will continue to run as long as the maximum price for
  /// those running instances is higher than the current Spot price.
  /// </note>
  ///
  /// Parameter [userData] :
  /// The user data to make available to the launched EC2 instances. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html">Instance
  /// metadata and user data</a> (Linux) and <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ec2-instance-metadata.html">Instance
  /// metadata and user data</a> (Windows). If you are using a command line
  /// tool, base64-encoding is performed for you, and you can load the text from
  /// a file. Otherwise, you must provide base64-encoded text. User data is
  /// limited to 16 KB.
  Future<void> createLaunchConfiguration({
    required String launchConfigurationName,
    bool? associatePublicIpAddress,
    List<BlockDeviceMapping>? blockDeviceMappings,
    String? classicLinkVPCId,
    List<String>? classicLinkVPCSecurityGroups,
    bool? ebsOptimized,
    String? iamInstanceProfile,
    String? imageId,
    String? instanceId,
    InstanceMonitoring? instanceMonitoring,
    String? instanceType,
    String? kernelId,
    String? keyName,
    InstanceMetadataOptions? metadataOptions,
    String? placementTenancy,
    String? ramdiskId,
    List<String>? securityGroups,
    String? spotPrice,
    String? userData,
  }) async {
    ArgumentError.checkNotNull(
        launchConfigurationName, 'launchConfigurationName');
    _s.validateStringLength(
      'launchConfigurationName',
      launchConfigurationName,
      1,
      255,
      isRequired: true,
    );
    _s.validateStringLength(
      'classicLinkVPCId',
      classicLinkVPCId,
      1,
      255,
    );
    _s.validateStringLength(
      'iamInstanceProfile',
      iamInstanceProfile,
      1,
      1600,
    );
    _s.validateStringLength(
      'imageId',
      imageId,
      1,
      255,
    );
    _s.validateStringLength(
      'instanceId',
      instanceId,
      1,
      19,
    );
    _s.validateStringLength(
      'instanceType',
      instanceType,
      1,
      255,
    );
    _s.validateStringLength(
      'kernelId',
      kernelId,
      1,
      255,
    );
    _s.validateStringLength(
      'keyName',
      keyName,
      1,
      255,
    );
    _s.validateStringLength(
      'placementTenancy',
      placementTenancy,
      1,
      64,
    );
    _s.validateStringLength(
      'ramdiskId',
      ramdiskId,
      1,
      255,
    );
    _s.validateStringLength(
      'spotPrice',
      spotPrice,
      1,
      255,
    );
    _s.validateStringLength(
      'userData',
      userData,
      0,
      21847,
    );
    final $request = <String, dynamic>{};
    $request['LaunchConfigurationName'] = launchConfigurationName;
    associatePublicIpAddress
        ?.also((arg) => $request['AssociatePublicIpAddress'] = arg);
    blockDeviceMappings?.also((arg) => $request['BlockDeviceMappings'] = arg);
    classicLinkVPCId?.also((arg) => $request['ClassicLinkVPCId'] = arg);
    classicLinkVPCSecurityGroups
        ?.also((arg) => $request['ClassicLinkVPCSecurityGroups'] = arg);
    ebsOptimized?.also((arg) => $request['EbsOptimized'] = arg);
    iamInstanceProfile?.also((arg) => $request['IamInstanceProfile'] = arg);
    imageId?.also((arg) => $request['ImageId'] = arg);
    instanceId?.also((arg) => $request['InstanceId'] = arg);
    instanceMonitoring?.also((arg) => $request['InstanceMonitoring'] = arg);
    instanceType?.also((arg) => $request['InstanceType'] = arg);
    kernelId?.also((arg) => $request['KernelId'] = arg);
    keyName?.also((arg) => $request['KeyName'] = arg);
    metadataOptions?.also((arg) => $request['MetadataOptions'] = arg);
    placementTenancy?.also((arg) => $request['PlacementTenancy'] = arg);
    ramdiskId?.also((arg) => $request['RamdiskId'] = arg);
    securityGroups?.also((arg) => $request['SecurityGroups'] = arg);
    spotPrice?.also((arg) => $request['SpotPrice'] = arg);
    userData?.also((arg) => $request['UserData'] = arg);
    await _protocol.send(
      $request,
      action: 'CreateLaunchConfiguration',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['CreateLaunchConfigurationType'],
      shapes: shapes,
    );
  }

  /// Creates or updates tags for the specified Auto Scaling group.
  ///
  /// When you specify a tag with a key that already exists, the operation
  /// overwrites the previous tag definition, and you do not get an error
  /// message.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-tagging.html">Tag
  /// Auto Scaling groups and instances</a> in the <i>Amazon EC2 Auto Scaling
  /// User Guide</i>.
  ///
  /// May throw [LimitExceededFault].
  /// May throw [AlreadyExistsFault].
  /// May throw [ResourceContentionFault].
  /// May throw [ResourceInUseFault].
  ///
  /// Parameter [tags] :
  /// One or more tags.
  Future<void> createOrUpdateTags({
    required List<Tag> tags,
  }) async {
    ArgumentError.checkNotNull(tags, 'tags');
    final $request = <String, dynamic>{};
    $request['Tags'] = tags;
    await _protocol.send(
      $request,
      action: 'CreateOrUpdateTags',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['CreateOrUpdateTagsType'],
      shapes: shapes,
    );
  }

  /// Deletes the specified Auto Scaling group.
  ///
  /// If the group has instances or scaling activities in progress, you must
  /// specify the option to force the deletion in order for it to succeed.
  ///
  /// If the group has policies, deleting the group deletes the policies, the
  /// underlying alarm actions, and any alarm that no longer has an associated
  /// action.
  ///
  /// To remove instances from the Auto Scaling group before deleting it, call
  /// the <a>DetachInstances</a> API with the list of instances and the option
  /// to decrement the desired capacity. This ensures that Amazon EC2 Auto
  /// Scaling does not launch replacement instances.
  ///
  /// To terminate all instances before deleting the Auto Scaling group, call
  /// the <a>UpdateAutoScalingGroup</a> API and set the minimum size and desired
  /// capacity of the Auto Scaling group to zero.
  ///
  /// May throw [ScalingActivityInProgressFault].
  /// May throw [ResourceInUseFault].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [forceDelete] :
  /// Specifies that the group is to be deleted along with all instances
  /// associated with the group, without waiting for all instances to be
  /// terminated. This action also deletes any outstanding lifecycle actions
  /// associated with the group.
  Future<void> deleteAutoScalingGroup({
    required String autoScalingGroupName,
    bool? forceDelete,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    forceDelete?.also((arg) => $request['ForceDelete'] = arg);
    await _protocol.send(
      $request,
      action: 'DeleteAutoScalingGroup',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DeleteAutoScalingGroupType'],
      shapes: shapes,
    );
  }

  /// Deletes the specified launch configuration.
  ///
  /// The launch configuration must not be attached to an Auto Scaling group.
  /// When this call completes, the launch configuration is no longer available
  /// for use.
  ///
  /// May throw [ResourceInUseFault].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [launchConfigurationName] :
  /// The name of the launch configuration.
  Future<void> deleteLaunchConfiguration({
    required String launchConfigurationName,
  }) async {
    ArgumentError.checkNotNull(
        launchConfigurationName, 'launchConfigurationName');
    _s.validateStringLength(
      'launchConfigurationName',
      launchConfigurationName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['LaunchConfigurationName'] = launchConfigurationName;
    await _protocol.send(
      $request,
      action: 'DeleteLaunchConfiguration',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['LaunchConfigurationNameType'],
      shapes: shapes,
    );
  }

  /// Deletes the specified lifecycle hook.
  ///
  /// If there are any outstanding lifecycle actions, they are completed first
  /// (<code>ABANDON</code> for launching instances, <code>CONTINUE</code> for
  /// terminating instances).
  ///
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [lifecycleHookName] :
  /// The name of the lifecycle hook.
  Future<void> deleteLifecycleHook({
    required String autoScalingGroupName,
    required String lifecycleHookName,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(lifecycleHookName, 'lifecycleHookName');
    _s.validateStringLength(
      'lifecycleHookName',
      lifecycleHookName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['LifecycleHookName'] = lifecycleHookName;
    await _protocol.send(
      $request,
      action: 'DeleteLifecycleHook',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DeleteLifecycleHookType'],
      shapes: shapes,
      resultWrapper: 'DeleteLifecycleHookResult',
    );
  }

  /// Deletes the specified notification.
  ///
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [topicARN] :
  /// The Amazon Resource Name (ARN) of the Amazon SNS topic.
  Future<void> deleteNotificationConfiguration({
    required String autoScalingGroupName,
    required String topicARN,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(topicARN, 'topicARN');
    _s.validateStringLength(
      'topicARN',
      topicARN,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['TopicARN'] = topicARN;
    await _protocol.send(
      $request,
      action: 'DeleteNotificationConfiguration',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DeleteNotificationConfigurationType'],
      shapes: shapes,
    );
  }

  /// Deletes the specified scaling policy.
  ///
  /// Deleting either a step scaling policy or a simple scaling policy deletes
  /// the underlying alarm action, but does not delete the alarm, even if it no
  /// longer has an associated action.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/deleting-scaling-policy.html">Deleting
  /// a scaling policy</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// May throw [ResourceContentionFault].
  /// May throw [ServiceLinkedRoleFailure].
  ///
  /// Parameter [policyName] :
  /// The name or Amazon Resource Name (ARN) of the policy.
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  Future<void> deletePolicy({
    required String policyName,
    String? autoScalingGroupName,
  }) async {
    ArgumentError.checkNotNull(policyName, 'policyName');
    _s.validateStringLength(
      'policyName',
      policyName,
      1,
      1600,
      isRequired: true,
    );
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
    );
    final $request = <String, dynamic>{};
    $request['PolicyName'] = policyName;
    autoScalingGroupName?.also((arg) => $request['AutoScalingGroupName'] = arg);
    await _protocol.send(
      $request,
      action: 'DeletePolicy',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DeletePolicyType'],
      shapes: shapes,
    );
  }

  /// Deletes the specified scheduled action.
  ///
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [scheduledActionName] :
  /// The name of the action to delete.
  Future<void> deleteScheduledAction({
    required String autoScalingGroupName,
    required String scheduledActionName,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(scheduledActionName, 'scheduledActionName');
    _s.validateStringLength(
      'scheduledActionName',
      scheduledActionName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['ScheduledActionName'] = scheduledActionName;
    await _protocol.send(
      $request,
      action: 'DeleteScheduledAction',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DeleteScheduledActionType'],
      shapes: shapes,
    );
  }

  /// Deletes the specified tags.
  ///
  /// May throw [ResourceContentionFault].
  /// May throw [ResourceInUseFault].
  ///
  /// Parameter [tags] :
  /// One or more tags.
  Future<void> deleteTags({
    required List<Tag> tags,
  }) async {
    ArgumentError.checkNotNull(tags, 'tags');
    final $request = <String, dynamic>{};
    $request['Tags'] = tags;
    await _protocol.send(
      $request,
      action: 'DeleteTags',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DeleteTagsType'],
      shapes: shapes,
    );
  }

  /// Deletes the warm pool for the specified Auto Scaling group.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-warm-pools.html">Warm
  /// pools for Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2 Auto Scaling
  /// User Guide</i>.
  ///
  /// May throw [LimitExceededFault].
  /// May throw [ResourceContentionFault].
  /// May throw [ScalingActivityInProgressFault].
  /// May throw [ResourceInUseFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [forceDelete] :
  /// Specifies that the warm pool is to be deleted along with all of its
  /// associated instances, without waiting for all instances to be terminated.
  /// This parameter also deletes any outstanding lifecycle actions associated
  /// with the warm pool instances.
  Future<void> deleteWarmPool({
    required String autoScalingGroupName,
    bool? forceDelete,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    forceDelete?.also((arg) => $request['ForceDelete'] = arg);
    await _protocol.send(
      $request,
      action: 'DeleteWarmPool',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DeleteWarmPoolType'],
      shapes: shapes,
      resultWrapper: 'DeleteWarmPoolResult',
    );
  }

  /// Describes the current Amazon EC2 Auto Scaling resource quotas for your
  /// account.
  ///
  /// When you establish an Amazon Web Services account, the account has initial
  /// quotas on the maximum number of Auto Scaling groups and launch
  /// configurations that you can create in a given Region. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-quotas.html">Quotas
  /// for Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  ///
  /// May throw [ResourceContentionFault].
  Future<DescribeAccountLimitsAnswer> describeAccountLimits() async {
    final $request = <String, dynamic>{};
    final $result = await _protocol.send(
      $request,
      action: 'DescribeAccountLimits',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shapes: shapes,
      resultWrapper: 'DescribeAccountLimitsResult',
    );
    return DescribeAccountLimitsAnswer.fromXml($result);
  }

  /// Describes the available adjustment types for step scaling and simple
  /// scaling policies.
  ///
  /// The following adjustment types are supported:
  ///
  /// <ul>
  /// <li>
  /// <code>ChangeInCapacity</code>
  /// </li>
  /// <li>
  /// <code>ExactCapacity</code>
  /// </li>
  /// <li>
  /// <code>PercentChangeInCapacity</code>
  /// </li>
  /// </ul>
  ///
  /// May throw [ResourceContentionFault].
  Future<DescribeAdjustmentTypesAnswer> describeAdjustmentTypes() async {
    final $request = <String, dynamic>{};
    final $result = await _protocol.send(
      $request,
      action: 'DescribeAdjustmentTypes',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shapes: shapes,
      resultWrapper: 'DescribeAdjustmentTypesResult',
    );
    return DescribeAdjustmentTypesAnswer.fromXml($result);
  }

  /// Gets information about the Auto Scaling groups in the account and Region.
  ///
  /// If you specify Auto Scaling group names, the output includes information
  /// for only the specified Auto Scaling groups. If you specify filters, the
  /// output includes information for only those Auto Scaling groups that meet
  /// the filter criteria. If you do not specify group names or filters, the
  /// output includes information for all Auto Scaling groups.
  ///
  /// This operation also returns information about instances in Auto Scaling
  /// groups. To retrieve information about the instances in a warm pool, you
  /// must call the <a>DescribeWarmPool</a> API.
  ///
  /// May throw [InvalidNextToken].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupNames] :
  /// The names of the Auto Scaling groups. By default, you can only specify up
  /// to 50 names. You can optionally increase this limit using the
  /// <code>MaxRecords</code> property.
  ///
  /// If you omit this property, all Auto Scaling groups are described.
  ///
  /// Parameter [filters] :
  /// One or more filters to limit the results based on specific tags.
  ///
  /// Parameter [maxRecords] :
  /// The maximum number of items to return with this call. The default value is
  /// <code>50</code> and the maximum value is <code>100</code>.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<AutoScalingGroupsType> describeAutoScalingGroups({
    List<String>? autoScalingGroupNames,
    List<Filter>? filters,
    int? maxRecords,
    String? nextToken,
  }) async {
    final $request = <String, dynamic>{};
    autoScalingGroupNames
        ?.also((arg) => $request['AutoScalingGroupNames'] = arg);
    filters?.also((arg) => $request['Filters'] = arg);
    maxRecords?.also((arg) => $request['MaxRecords'] = arg);
    nextToken?.also((arg) => $request['NextToken'] = arg);
    final $result = await _protocol.send(
      $request,
      action: 'DescribeAutoScalingGroups',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['AutoScalingGroupNamesType'],
      shapes: shapes,
      resultWrapper: 'DescribeAutoScalingGroupsResult',
    );
    return AutoScalingGroupsType.fromXml($result);
  }

  /// Gets information about the Auto Scaling instances in the account and
  /// Region.
  ///
  /// May throw [InvalidNextToken].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [instanceIds] :
  /// The IDs of the instances. If you omit this property, all Auto Scaling
  /// instances are described. If you specify an ID that does not exist, it is
  /// ignored with no error.
  ///
  /// Array Members: Maximum number of 50 items.
  ///
  /// Parameter [maxRecords] :
  /// The maximum number of items to return with this call. The default value is
  /// <code>50</code> and the maximum value is <code>50</code>.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<AutoScalingInstancesType> describeAutoScalingInstances({
    List<String>? instanceIds,
    int? maxRecords,
    String? nextToken,
  }) async {
    final $request = <String, dynamic>{};
    instanceIds?.also((arg) => $request['InstanceIds'] = arg);
    maxRecords?.also((arg) => $request['MaxRecords'] = arg);
    nextToken?.also((arg) => $request['NextToken'] = arg);
    final $result = await _protocol.send(
      $request,
      action: 'DescribeAutoScalingInstances',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DescribeAutoScalingInstancesType'],
      shapes: shapes,
      resultWrapper: 'DescribeAutoScalingInstancesResult',
    );
    return AutoScalingInstancesType.fromXml($result);
  }

  /// Describes the notification types that are supported by Amazon EC2 Auto
  /// Scaling.
  ///
  /// May throw [ResourceContentionFault].
  Future<DescribeAutoScalingNotificationTypesAnswer>
      describeAutoScalingNotificationTypes() async {
    final $request = <String, dynamic>{};
    final $result = await _protocol.send(
      $request,
      action: 'DescribeAutoScalingNotificationTypes',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shapes: shapes,
      resultWrapper: 'DescribeAutoScalingNotificationTypesResult',
    );
    return DescribeAutoScalingNotificationTypesAnswer.fromXml($result);
  }

  /// Gets information about the instance refreshes for the specified Auto
  /// Scaling group.
  ///
  /// This operation is part of the <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-instance-refresh.html">instance
  /// refresh feature</a> in Amazon EC2 Auto Scaling, which helps you update
  /// instances in your Auto Scaling group after you make configuration changes.
  ///
  /// To help you determine the status of an instance refresh, this operation
  /// returns information about the instance refreshes you previously initiated,
  /// including their status, end time, the percentage of the instance refresh
  /// that is complete, and the number of instances remaining to update before
  /// the instance refresh is complete.
  ///
  /// The following are the possible statuses:
  ///
  /// <ul>
  /// <li>
  /// <code>Pending</code> - The request was created, but the operation has not
  /// started.
  /// </li>
  /// <li>
  /// <code>InProgress</code> - The operation is in progress.
  /// </li>
  /// <li>
  /// <code>Successful</code> - The operation completed successfully.
  /// </li>
  /// <li>
  /// <code>Failed</code> - The operation failed to complete. You can
  /// troubleshoot using the status reason and the scaling activities.
  /// </li>
  /// <li>
  /// <code>Cancelling</code> - An ongoing operation is being cancelled.
  /// Cancellation does not roll back any replacements that have already been
  /// completed, but it prevents new replacements from being started.
  /// </li>
  /// <li>
  /// <code>Cancelled</code> - The operation is cancelled.
  /// </li>
  /// </ul>
  ///
  /// May throw [InvalidNextToken].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [instanceRefreshIds] :
  /// One or more instance refresh IDs.
  ///
  /// Parameter [maxRecords] :
  /// The maximum number of items to return with this call. The default value is
  /// <code>50</code> and the maximum value is <code>100</code>.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeInstanceRefreshesAnswer> describeInstanceRefreshes({
    required String autoScalingGroupName,
    List<String>? instanceRefreshIds,
    int? maxRecords,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    instanceRefreshIds?.also((arg) => $request['InstanceRefreshIds'] = arg);
    maxRecords?.also((arg) => $request['MaxRecords'] = arg);
    nextToken?.also((arg) => $request['NextToken'] = arg);
    final $result = await _protocol.send(
      $request,
      action: 'DescribeInstanceRefreshes',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DescribeInstanceRefreshesType'],
      shapes: shapes,
      resultWrapper: 'DescribeInstanceRefreshesResult',
    );
    return DescribeInstanceRefreshesAnswer.fromXml($result);
  }

  /// Gets information about the launch configurations in the account and
  /// Region.
  ///
  /// May throw [InvalidNextToken].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [launchConfigurationNames] :
  /// The launch configuration names. If you omit this property, all launch
  /// configurations are described.
  ///
  /// Array Members: Maximum number of 50 items.
  ///
  /// Parameter [maxRecords] :
  /// The maximum number of items to return with this call. The default value is
  /// <code>50</code> and the maximum value is <code>100</code>.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<LaunchConfigurationsType> describeLaunchConfigurations({
    List<String>? launchConfigurationNames,
    int? maxRecords,
    String? nextToken,
  }) async {
    final $request = <String, dynamic>{};
    launchConfigurationNames
        ?.also((arg) => $request['LaunchConfigurationNames'] = arg);
    maxRecords?.also((arg) => $request['MaxRecords'] = arg);
    nextToken?.also((arg) => $request['NextToken'] = arg);
    final $result = await _protocol.send(
      $request,
      action: 'DescribeLaunchConfigurations',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['LaunchConfigurationNamesType'],
      shapes: shapes,
      resultWrapper: 'DescribeLaunchConfigurationsResult',
    );
    return LaunchConfigurationsType.fromXml($result);
  }

  /// Describes the available types of lifecycle hooks.
  ///
  /// The following hook types are supported:
  ///
  /// <ul>
  /// <li>
  /// <code>autoscaling:EC2_INSTANCE_LAUNCHING</code>
  /// </li>
  /// <li>
  /// <code>autoscaling:EC2_INSTANCE_TERMINATING</code>
  /// </li>
  /// </ul>
  ///
  /// May throw [ResourceContentionFault].
  Future<DescribeLifecycleHookTypesAnswer> describeLifecycleHookTypes() async {
    final $request = <String, dynamic>{};
    final $result = await _protocol.send(
      $request,
      action: 'DescribeLifecycleHookTypes',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shapes: shapes,
      resultWrapper: 'DescribeLifecycleHookTypesResult',
    );
    return DescribeLifecycleHookTypesAnswer.fromXml($result);
  }

  /// Gets information about the lifecycle hooks for the specified Auto Scaling
  /// group.
  ///
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [lifecycleHookNames] :
  /// The names of one or more lifecycle hooks. If you omit this property, all
  /// lifecycle hooks are described.
  Future<DescribeLifecycleHooksAnswer> describeLifecycleHooks({
    required String autoScalingGroupName,
    List<String>? lifecycleHookNames,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    lifecycleHookNames?.also((arg) => $request['LifecycleHookNames'] = arg);
    final $result = await _protocol.send(
      $request,
      action: 'DescribeLifecycleHooks',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DescribeLifecycleHooksType'],
      shapes: shapes,
      resultWrapper: 'DescribeLifecycleHooksResult',
    );
    return DescribeLifecycleHooksAnswer.fromXml($result);
  }

  /// Gets information about the Elastic Load Balancing target groups for the
  /// specified Auto Scaling group.
  ///
  /// To determine the attachment status of the target group, use the
  /// <code>State</code> element in the response. When you attach a target group
  /// to an Auto Scaling group, the initial <code>State</code> value is
  /// <code>Adding</code>. The state transitions to <code>Added</code> after all
  /// Auto Scaling instances are registered with the target group. If Elastic
  /// Load Balancing health checks are enabled for the Auto Scaling group, the
  /// state transitions to <code>InService</code> after at least one Auto
  /// Scaling instance passes the health check. When the target group is in the
  /// <code>InService</code> state, Amazon EC2 Auto Scaling can terminate and
  /// replace any instances that are reported as unhealthy. If no registered
  /// instances pass the health checks, the target group doesn't enter the
  /// <code>InService</code> state.
  ///
  /// Target groups also have an <code>InService</code> state if you attach them
  /// in the <a>CreateAutoScalingGroup</a> API call. If your target group state
  /// is <code>InService</code>, but it is not working properly, check the
  /// scaling activities by calling <a>DescribeScalingActivities</a> and take
  /// any corrective actions necessary.
  ///
  /// For help with failed health checks, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ts-as-healthchecks.html">Troubleshooting
  /// Amazon EC2 Auto Scaling: Health checks</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-load-balancer.html">Use
  /// Elastic Load Balancing to distribute traffic across the instances in your
  /// Auto Scaling group</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// May throw [ResourceContentionFault].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [maxRecords] :
  /// The maximum number of items to return with this call. The default value is
  /// <code>100</code> and the maximum value is <code>100</code>.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeLoadBalancerTargetGroupsResponse>
      describeLoadBalancerTargetGroups({
    required String autoScalingGroupName,
    int? maxRecords,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    maxRecords?.also((arg) => $request['MaxRecords'] = arg);
    nextToken?.also((arg) => $request['NextToken'] = arg);
    final $result = await _protocol.send(
      $request,
      action: 'DescribeLoadBalancerTargetGroups',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DescribeLoadBalancerTargetGroupsRequest'],
      shapes: shapes,
      resultWrapper: 'DescribeLoadBalancerTargetGroupsResult',
    );
    return DescribeLoadBalancerTargetGroupsResponse.fromXml($result);
  }

  /// Gets information about the load balancers for the specified Auto Scaling
  /// group.
  ///
  /// This operation describes only Classic Load Balancers. If you have
  /// Application Load Balancers, Network Load Balancers, or Gateway Load
  /// Balancer, use the <a>DescribeLoadBalancerTargetGroups</a> API instead.
  ///
  /// To determine the attachment status of the load balancer, use the
  /// <code>State</code> element in the response. When you attach a load
  /// balancer to an Auto Scaling group, the initial <code>State</code> value is
  /// <code>Adding</code>. The state transitions to <code>Added</code> after all
  /// Auto Scaling instances are registered with the load balancer. If Elastic
  /// Load Balancing health checks are enabled for the Auto Scaling group, the
  /// state transitions to <code>InService</code> after at least one Auto
  /// Scaling instance passes the health check. When the load balancer is in the
  /// <code>InService</code> state, Amazon EC2 Auto Scaling can terminate and
  /// replace any instances that are reported as unhealthy. If no registered
  /// instances pass the health checks, the load balancer doesn't enter the
  /// <code>InService</code> state.
  ///
  /// Load balancers also have an <code>InService</code> state if you attach
  /// them in the <a>CreateAutoScalingGroup</a> API call. If your load balancer
  /// state is <code>InService</code>, but it is not working properly, check the
  /// scaling activities by calling <a>DescribeScalingActivities</a> and take
  /// any corrective actions necessary.
  ///
  /// For help with failed health checks, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ts-as-healthchecks.html">Troubleshooting
  /// Amazon EC2 Auto Scaling: Health checks</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-load-balancer.html">Use
  /// Elastic Load Balancing to distribute traffic across the instances in your
  /// Auto Scaling group</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// May throw [ResourceContentionFault].
  /// May throw [InvalidNextToken].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [maxRecords] :
  /// The maximum number of items to return with this call. The default value is
  /// <code>100</code> and the maximum value is <code>100</code>.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeLoadBalancersResponse> describeLoadBalancers({
    required String autoScalingGroupName,
    int? maxRecords,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    maxRecords?.also((arg) => $request['MaxRecords'] = arg);
    nextToken?.also((arg) => $request['NextToken'] = arg);
    final $result = await _protocol.send(
      $request,
      action: 'DescribeLoadBalancers',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DescribeLoadBalancersRequest'],
      shapes: shapes,
      resultWrapper: 'DescribeLoadBalancersResult',
    );
    return DescribeLoadBalancersResponse.fromXml($result);
  }

  /// Describes the available CloudWatch metrics for Amazon EC2 Auto Scaling.
  ///
  /// May throw [ResourceContentionFault].
  Future<DescribeMetricCollectionTypesAnswer>
      describeMetricCollectionTypes() async {
    final $request = <String, dynamic>{};
    final $result = await _protocol.send(
      $request,
      action: 'DescribeMetricCollectionTypes',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shapes: shapes,
      resultWrapper: 'DescribeMetricCollectionTypesResult',
    );
    return DescribeMetricCollectionTypesAnswer.fromXml($result);
  }

  /// Gets information about the Amazon SNS notifications that are configured
  /// for one or more Auto Scaling groups.
  ///
  /// May throw [InvalidNextToken].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupNames] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [maxRecords] :
  /// The maximum number of items to return with this call. The default value is
  /// <code>50</code> and the maximum value is <code>100</code>.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<DescribeNotificationConfigurationsAnswer>
      describeNotificationConfigurations({
    List<String>? autoScalingGroupNames,
    int? maxRecords,
    String? nextToken,
  }) async {
    final $request = <String, dynamic>{};
    autoScalingGroupNames
        ?.also((arg) => $request['AutoScalingGroupNames'] = arg);
    maxRecords?.also((arg) => $request['MaxRecords'] = arg);
    nextToken?.also((arg) => $request['NextToken'] = arg);
    final $result = await _protocol.send(
      $request,
      action: 'DescribeNotificationConfigurations',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DescribeNotificationConfigurationsType'],
      shapes: shapes,
      resultWrapper: 'DescribeNotificationConfigurationsResult',
    );
    return DescribeNotificationConfigurationsAnswer.fromXml($result);
  }

  /// Gets information about the scaling policies in the account and Region.
  ///
  /// May throw [InvalidNextToken].
  /// May throw [ResourceContentionFault].
  /// May throw [ServiceLinkedRoleFailure].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [maxRecords] :
  /// The maximum number of items to be returned with each call. The default
  /// value is <code>50</code> and the maximum value is <code>100</code>.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  ///
  /// Parameter [policyNames] :
  /// The names of one or more policies. If you omit this property, all policies
  /// are described. If a group name is provided, the results are limited to
  /// that group. If you specify an unknown policy name, it is ignored with no
  /// error.
  ///
  /// Array Members: Maximum number of 50 items.
  ///
  /// Parameter [policyTypes] :
  /// One or more policy types. The valid values are <code>SimpleScaling</code>,
  /// <code>StepScaling</code>, <code>TargetTrackingScaling</code>, and
  /// <code>PredictiveScaling</code>.
  Future<PoliciesType> describePolicies({
    String? autoScalingGroupName,
    int? maxRecords,
    String? nextToken,
    List<String>? policyNames,
    List<String>? policyTypes,
  }) async {
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
    );
    final $request = <String, dynamic>{};
    autoScalingGroupName?.also((arg) => $request['AutoScalingGroupName'] = arg);
    maxRecords?.also((arg) => $request['MaxRecords'] = arg);
    nextToken?.also((arg) => $request['NextToken'] = arg);
    policyNames?.also((arg) => $request['PolicyNames'] = arg);
    policyTypes?.also((arg) => $request['PolicyTypes'] = arg);
    final $result = await _protocol.send(
      $request,
      action: 'DescribePolicies',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DescribePoliciesType'],
      shapes: shapes,
      resultWrapper: 'DescribePoliciesResult',
    );
    return PoliciesType.fromXml($result);
  }

  /// Gets information about the scaling activities in the account and Region.
  ///
  /// When scaling events occur, you see a record of the scaling activity in the
  /// scaling activities. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-verify-scaling-activity.html">Verifying
  /// a scaling activity for an Auto Scaling group</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>.
  ///
  /// If the scaling event succeeds, the value of the <code>StatusCode</code>
  /// element in the response is <code>Successful</code>. If an attempt to
  /// launch instances failed, the <code>StatusCode</code> value is
  /// <code>Failed</code> or <code>Cancelled</code> and the
  /// <code>StatusMessage</code> element in the response indicates the cause of
  /// the failure. For help interpreting the <code>StatusMessage</code>, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/CHAP_Troubleshooting.html">Troubleshooting
  /// Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  ///
  /// May throw [InvalidNextToken].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [activityIds] :
  /// The activity IDs of the desired scaling activities. If you omit this
  /// property, all activities for the past six weeks are described. If unknown
  /// activities are requested, they are ignored with no error. If you specify
  /// an Auto Scaling group, the results are limited to that group.
  ///
  /// Array Members: Maximum number of 50 IDs.
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [includeDeletedGroups] :
  /// Indicates whether to include scaling activity from deleted Auto Scaling
  /// groups.
  ///
  /// Parameter [maxRecords] :
  /// The maximum number of items to return with this call. The default value is
  /// <code>100</code> and the maximum value is <code>100</code>.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<ActivitiesType> describeScalingActivities({
    List<String>? activityIds,
    String? autoScalingGroupName,
    bool? includeDeletedGroups,
    int? maxRecords,
    String? nextToken,
  }) async {
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
    );
    final $request = <String, dynamic>{};
    activityIds?.also((arg) => $request['ActivityIds'] = arg);
    autoScalingGroupName?.also((arg) => $request['AutoScalingGroupName'] = arg);
    includeDeletedGroups?.also((arg) => $request['IncludeDeletedGroups'] = arg);
    maxRecords?.also((arg) => $request['MaxRecords'] = arg);
    nextToken?.also((arg) => $request['NextToken'] = arg);
    final $result = await _protocol.send(
      $request,
      action: 'DescribeScalingActivities',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DescribeScalingActivitiesType'],
      shapes: shapes,
      resultWrapper: 'DescribeScalingActivitiesResult',
    );
    return ActivitiesType.fromXml($result);
  }

  /// Describes the scaling process types for use with the
  /// <a>ResumeProcesses</a> and <a>SuspendProcesses</a> APIs.
  ///
  /// May throw [ResourceContentionFault].
  Future<ProcessesType> describeScalingProcessTypes() async {
    final $request = <String, dynamic>{};
    final $result = await _protocol.send(
      $request,
      action: 'DescribeScalingProcessTypes',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shapes: shapes,
      resultWrapper: 'DescribeScalingProcessTypesResult',
    );
    return ProcessesType.fromXml($result);
  }

  /// Gets information about the scheduled actions that haven't run or that have
  /// not reached their end time.
  ///
  /// To describe the scaling activities for scheduled actions that have already
  /// run, call the <a>DescribeScalingActivities</a> API.
  ///
  /// May throw [InvalidNextToken].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [endTime] :
  /// The latest scheduled start time to return. If scheduled action names are
  /// provided, this property is ignored.
  ///
  /// Parameter [maxRecords] :
  /// The maximum number of items to return with this call. The default value is
  /// <code>50</code> and the maximum value is <code>100</code>.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  ///
  /// Parameter [scheduledActionNames] :
  /// The names of one or more scheduled actions. If you omit this property, all
  /// scheduled actions are described. If you specify an unknown scheduled
  /// action, it is ignored with no error.
  ///
  /// Array Members: Maximum number of 50 actions.
  ///
  /// Parameter [startTime] :
  /// The earliest scheduled start time to return. If scheduled action names are
  /// provided, this property is ignored.
  Future<ScheduledActionsType> describeScheduledActions({
    String? autoScalingGroupName,
    DateTime? endTime,
    int? maxRecords,
    String? nextToken,
    List<String>? scheduledActionNames,
    DateTime? startTime,
  }) async {
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
    );
    final $request = <String, dynamic>{};
    autoScalingGroupName?.also((arg) => $request['AutoScalingGroupName'] = arg);
    endTime?.also((arg) => $request['EndTime'] = _s.iso8601ToJson(arg));
    maxRecords?.also((arg) => $request['MaxRecords'] = arg);
    nextToken?.also((arg) => $request['NextToken'] = arg);
    scheduledActionNames?.also((arg) => $request['ScheduledActionNames'] = arg);
    startTime?.also((arg) => $request['StartTime'] = _s.iso8601ToJson(arg));
    final $result = await _protocol.send(
      $request,
      action: 'DescribeScheduledActions',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DescribeScheduledActionsType'],
      shapes: shapes,
      resultWrapper: 'DescribeScheduledActionsResult',
    );
    return ScheduledActionsType.fromXml($result);
  }

  /// Describes the specified tags.
  ///
  /// You can use filters to limit the results. For example, you can query for
  /// the tags for a specific Auto Scaling group. You can specify multiple
  /// values for a filter. A tag must match at least one of the specified values
  /// for it to be included in the results.
  ///
  /// You can also specify multiple filters. The result includes information for
  /// a particular tag only if it matches all the filters. If there's no match,
  /// no special message is returned.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-tagging.html">Tag
  /// Auto Scaling groups and instances</a> in the <i>Amazon EC2 Auto Scaling
  /// User Guide</i>.
  ///
  /// May throw [InvalidNextToken].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [filters] :
  /// One or more filters to scope the tags to return. The maximum number of
  /// filters per filter type (for example, <code>auto-scaling-group</code>) is
  /// 1000.
  ///
  /// Parameter [maxRecords] :
  /// The maximum number of items to return with this call. The default value is
  /// <code>50</code> and the maximum value is <code>100</code>.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of items to return. (You received this token
  /// from a previous call.)
  Future<TagsType> describeTags({
    List<Filter>? filters,
    int? maxRecords,
    String? nextToken,
  }) async {
    final $request = <String, dynamic>{};
    filters?.also((arg) => $request['Filters'] = arg);
    maxRecords?.also((arg) => $request['MaxRecords'] = arg);
    nextToken?.also((arg) => $request['NextToken'] = arg);
    final $result = await _protocol.send(
      $request,
      action: 'DescribeTags',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DescribeTagsType'],
      shapes: shapes,
      resultWrapper: 'DescribeTagsResult',
    );
    return TagsType.fromXml($result);
  }

  /// Describes the termination policies supported by Amazon EC2 Auto Scaling.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-termination-policies.html">Work
  /// with Amazon EC2 Auto Scaling termination policies</a> in the <i>Amazon EC2
  /// Auto Scaling User Guide</i>.
  ///
  /// May throw [ResourceContentionFault].
  Future<DescribeTerminationPolicyTypesAnswer>
      describeTerminationPolicyTypes() async {
    final $request = <String, dynamic>{};
    final $result = await _protocol.send(
      $request,
      action: 'DescribeTerminationPolicyTypes',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shapes: shapes,
      resultWrapper: 'DescribeTerminationPolicyTypesResult',
    );
    return DescribeTerminationPolicyTypesAnswer.fromXml($result);
  }

  /// Gets information about a warm pool and its instances.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-warm-pools.html">Warm
  /// pools for Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2 Auto Scaling
  /// User Guide</i>.
  ///
  /// May throw [InvalidNextToken].
  /// May throw [LimitExceededFault].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [maxRecords] :
  /// The maximum number of instances to return with this call. The maximum
  /// value is <code>50</code>.
  ///
  /// Parameter [nextToken] :
  /// The token for the next set of instances to return. (You received this
  /// token from a previous call.)
  Future<DescribeWarmPoolAnswer> describeWarmPool({
    required String autoScalingGroupName,
    int? maxRecords,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    maxRecords?.also((arg) => $request['MaxRecords'] = arg);
    nextToken?.also((arg) => $request['NextToken'] = arg);
    final $result = await _protocol.send(
      $request,
      action: 'DescribeWarmPool',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DescribeWarmPoolType'],
      shapes: shapes,
      resultWrapper: 'DescribeWarmPoolResult',
    );
    return DescribeWarmPoolAnswer.fromXml($result);
  }

  /// Removes one or more instances from the specified Auto Scaling group.
  ///
  /// After the instances are detached, you can manage them independent of the
  /// Auto Scaling group.
  ///
  /// If you do not specify the option to decrement the desired capacity, Amazon
  /// EC2 Auto Scaling launches instances to replace the ones that are detached.
  ///
  /// If there is a Classic Load Balancer attached to the Auto Scaling group,
  /// the instances are deregistered from the load balancer. If there are target
  /// groups attached to the Auto Scaling group, the instances are deregistered
  /// from the target groups.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/detach-instance-asg.html">Detach
  /// EC2 instances from your Auto Scaling group</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>.
  ///
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [shouldDecrementDesiredCapacity] :
  /// Indicates whether the Auto Scaling group decrements the desired capacity
  /// value by the number of instances detached.
  ///
  /// Parameter [instanceIds] :
  /// The IDs of the instances. You can specify up to 20 instances.
  Future<DetachInstancesAnswer> detachInstances({
    required String autoScalingGroupName,
    required bool shouldDecrementDesiredCapacity,
    List<String>? instanceIds,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(
        shouldDecrementDesiredCapacity, 'shouldDecrementDesiredCapacity');
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['ShouldDecrementDesiredCapacity'] = shouldDecrementDesiredCapacity;
    instanceIds?.also((arg) => $request['InstanceIds'] = arg);
    final $result = await _protocol.send(
      $request,
      action: 'DetachInstances',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DetachInstancesQuery'],
      shapes: shapes,
      resultWrapper: 'DetachInstancesResult',
    );
    return DetachInstancesAnswer.fromXml($result);
  }

  /// Detaches one or more target groups from the specified Auto Scaling group.
  ///
  /// When you detach a target group, it enters the <code>Removing</code> state
  /// while deregistering the instances in the group. When all instances are
  /// deregistered, then you can no longer describe the target group using the
  /// <a>DescribeLoadBalancerTargetGroups</a> API call. The instances remain
  /// running.
  ///
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [targetGroupARNs] :
  /// The Amazon Resource Names (ARN) of the target groups. You can specify up
  /// to 10 target groups.
  Future<void> detachLoadBalancerTargetGroups({
    required String autoScalingGroupName,
    required List<String> targetGroupARNs,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(targetGroupARNs, 'targetGroupARNs');
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['TargetGroupARNs'] = targetGroupARNs;
    await _protocol.send(
      $request,
      action: 'DetachLoadBalancerTargetGroups',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DetachLoadBalancerTargetGroupsType'],
      shapes: shapes,
      resultWrapper: 'DetachLoadBalancerTargetGroupsResult',
    );
  }

  /// Detaches one or more Classic Load Balancers from the specified Auto
  /// Scaling group.
  ///
  /// This operation detaches only Classic Load Balancers. If you have
  /// Application Load Balancers, Network Load Balancers, or Gateway Load
  /// Balancer, use the <a>DetachLoadBalancerTargetGroups</a> API instead.
  ///
  /// When you detach a load balancer, it enters the <code>Removing</code> state
  /// while deregistering the instances in the group. When all instances are
  /// deregistered, then you can no longer describe the load balancer using the
  /// <a>DescribeLoadBalancers</a> API call. The instances remain running.
  ///
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [loadBalancerNames] :
  /// The names of the load balancers. You can specify up to 10 load balancers.
  Future<void> detachLoadBalancers({
    required String autoScalingGroupName,
    required List<String> loadBalancerNames,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(loadBalancerNames, 'loadBalancerNames');
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['LoadBalancerNames'] = loadBalancerNames;
    await _protocol.send(
      $request,
      action: 'DetachLoadBalancers',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DetachLoadBalancersType'],
      shapes: shapes,
      resultWrapper: 'DetachLoadBalancersResult',
    );
  }

  /// Disables group metrics collection for the specified Auto Scaling group.
  ///
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [metrics] :
  /// Identifies the metrics to disable.
  ///
  /// You can specify one or more of the following metrics:
  ///
  /// <ul>
  /// <li>
  /// <code>GroupMinSize</code>
  /// </li>
  /// <li>
  /// <code>GroupMaxSize</code>
  /// </li>
  /// <li>
  /// <code>GroupDesiredCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupInServiceInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupPendingInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupStandbyInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupTerminatingInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupTotalInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupInServiceCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupPendingCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupStandbyCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupTerminatingCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupTotalCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolDesiredCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolWarmedCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolPendingCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolTerminatingCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolTotalCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupAndWarmPoolDesiredCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupAndWarmPoolTotalCapacity</code>
  /// </li>
  /// </ul>
  /// If you omit this property, all metrics are disabled.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-cloudwatch-monitoring.html#as-group-metrics">Auto
  /// Scaling group metrics</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  Future<void> disableMetricsCollection({
    required String autoScalingGroupName,
    List<String>? metrics,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    metrics?.also((arg) => $request['Metrics'] = arg);
    await _protocol.send(
      $request,
      action: 'DisableMetricsCollection',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['DisableMetricsCollectionQuery'],
      shapes: shapes,
    );
  }

  /// Enables group metrics collection for the specified Auto Scaling group.
  ///
  /// You can use these metrics to track changes in an Auto Scaling group and to
  /// set alarms on threshold values. You can view group metrics using the
  /// Amazon EC2 Auto Scaling console or the CloudWatch console. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-cloudwatch-monitoring.html">Monitor
  /// CloudWatch metrics for your Auto Scaling groups and instances</a> in the
  /// <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [granularity] :
  /// The frequency at which Amazon EC2 Auto Scaling sends aggregated data to
  /// CloudWatch. The only valid value is <code>1Minute</code>.
  ///
  /// Parameter [metrics] :
  /// Identifies the metrics to enable.
  ///
  /// You can specify one or more of the following metrics:
  ///
  /// <ul>
  /// <li>
  /// <code>GroupMinSize</code>
  /// </li>
  /// <li>
  /// <code>GroupMaxSize</code>
  /// </li>
  /// <li>
  /// <code>GroupDesiredCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupInServiceInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupPendingInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupStandbyInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupTerminatingInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupTotalInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupInServiceCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupPendingCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupStandbyCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupTerminatingCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupTotalCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolDesiredCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolWarmedCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolPendingCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolTerminatingCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolTotalCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupAndWarmPoolDesiredCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupAndWarmPoolTotalCapacity</code>
  /// </li>
  /// </ul>
  /// If you specify <code>Granularity</code> and don't specify any metrics, all
  /// metrics are enabled.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-cloudwatch-monitoring.html#as-group-metrics">Auto
  /// Scaling group metrics</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  Future<void> enableMetricsCollection({
    required String autoScalingGroupName,
    required String granularity,
    List<String>? metrics,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(granularity, 'granularity');
    _s.validateStringLength(
      'granularity',
      granularity,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['Granularity'] = granularity;
    metrics?.also((arg) => $request['Metrics'] = arg);
    await _protocol.send(
      $request,
      action: 'EnableMetricsCollection',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['EnableMetricsCollectionQuery'],
      shapes: shapes,
    );
  }

  /// Moves the specified instances into the standby state.
  ///
  /// If you choose to decrement the desired capacity of the Auto Scaling group,
  /// the instances can enter standby as long as the desired capacity of the
  /// Auto Scaling group after the instances are placed into standby is equal to
  /// or greater than the minimum capacity of the group.
  ///
  /// If you choose not to decrement the desired capacity of the Auto Scaling
  /// group, the Auto Scaling group launches new instances to replace the
  /// instances on standby.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-enter-exit-standby.html">Temporarily
  /// removing instances from your Auto Scaling group</a> in the <i>Amazon EC2
  /// Auto Scaling User Guide</i>.
  ///
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [shouldDecrementDesiredCapacity] :
  /// Indicates whether to decrement the desired capacity of the Auto Scaling
  /// group by the number of instances moved to <code>Standby</code> mode.
  ///
  /// Parameter [instanceIds] :
  /// The IDs of the instances. You can specify up to 20 instances.
  Future<EnterStandbyAnswer> enterStandby({
    required String autoScalingGroupName,
    required bool shouldDecrementDesiredCapacity,
    List<String>? instanceIds,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(
        shouldDecrementDesiredCapacity, 'shouldDecrementDesiredCapacity');
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['ShouldDecrementDesiredCapacity'] = shouldDecrementDesiredCapacity;
    instanceIds?.also((arg) => $request['InstanceIds'] = arg);
    final $result = await _protocol.send(
      $request,
      action: 'EnterStandby',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['EnterStandbyQuery'],
      shapes: shapes,
      resultWrapper: 'EnterStandbyResult',
    );
    return EnterStandbyAnswer.fromXml($result);
  }

  /// Executes the specified policy. This can be useful for testing the design
  /// of your scaling policy.
  ///
  /// May throw [ScalingActivityInProgressFault].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [policyName] :
  /// The name or ARN of the policy.
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [breachThreshold] :
  /// The breach threshold for the alarm.
  ///
  /// Required if the policy type is <code>StepScaling</code> and not supported
  /// otherwise.
  ///
  /// Parameter [honorCooldown] :
  /// Indicates whether Amazon EC2 Auto Scaling waits for the cooldown period to
  /// complete before executing the policy.
  ///
  /// Valid only if the policy type is <code>SimpleScaling</code>. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/Cooldown.html">Scaling
  /// cooldowns for Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>.
  ///
  /// Parameter [metricValue] :
  /// The metric value to compare to <code>BreachThreshold</code>. This enables
  /// you to execute a policy of type <code>StepScaling</code> and determine
  /// which step adjustment to use. For example, if the breach threshold is 50
  /// and you want to use a step adjustment with a lower bound of 0 and an upper
  /// bound of 10, you can set the metric value to 59.
  ///
  /// If you specify a metric value that doesn't correspond to a step adjustment
  /// for the policy, the call returns an error.
  ///
  /// Required if the policy type is <code>StepScaling</code> and not supported
  /// otherwise.
  Future<void> executePolicy({
    required String policyName,
    String? autoScalingGroupName,
    double? breachThreshold,
    bool? honorCooldown,
    double? metricValue,
  }) async {
    ArgumentError.checkNotNull(policyName, 'policyName');
    _s.validateStringLength(
      'policyName',
      policyName,
      1,
      1600,
      isRequired: true,
    );
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
    );
    final $request = <String, dynamic>{};
    $request['PolicyName'] = policyName;
    autoScalingGroupName?.also((arg) => $request['AutoScalingGroupName'] = arg);
    breachThreshold?.also((arg) => $request['BreachThreshold'] = arg);
    honorCooldown?.also((arg) => $request['HonorCooldown'] = arg);
    metricValue?.also((arg) => $request['MetricValue'] = arg);
    await _protocol.send(
      $request,
      action: 'ExecutePolicy',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['ExecutePolicyType'],
      shapes: shapes,
    );
  }

  /// Moves the specified instances out of the standby state.
  ///
  /// After you put the instances back in service, the desired capacity is
  /// incremented.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-enter-exit-standby.html">Temporarily
  /// removing instances from your Auto Scaling group</a> in the <i>Amazon EC2
  /// Auto Scaling User Guide</i>.
  ///
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [instanceIds] :
  /// The IDs of the instances. You can specify up to 20 instances.
  Future<ExitStandbyAnswer> exitStandby({
    required String autoScalingGroupName,
    List<String>? instanceIds,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    instanceIds?.also((arg) => $request['InstanceIds'] = arg);
    final $result = await _protocol.send(
      $request,
      action: 'ExitStandby',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['ExitStandbyQuery'],
      shapes: shapes,
      resultWrapper: 'ExitStandbyResult',
    );
    return ExitStandbyAnswer.fromXml($result);
  }

  /// Retrieves the forecast data for a predictive scaling policy.
  ///
  /// Load forecasts are predictions of the hourly load values using historical
  /// load data from CloudWatch and an analysis of historical trends. Capacity
  /// forecasts are represented as predicted values for the minimum capacity
  /// that is needed on an hourly basis, based on the hourly load forecast.
  ///
  /// A minimum of 24 hours of data is required to create the initial forecasts.
  /// However, having a full 14 days of historical data results in more accurate
  /// forecasts.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-predictive-scaling.html">Predictive
  /// scaling for Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2 Auto Scaling
  /// User Guide</i>.
  ///
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [endTime] :
  /// The exclusive end time of the time range for the forecast data to get. The
  /// maximum time duration between the start and end time is 30 days.
  ///
  /// Although this parameter can accept a date and time that is more than two
  /// days in the future, the availability of forecast data has limits. Amazon
  /// EC2 Auto Scaling only issues forecasts for periods of two days in advance.
  ///
  /// Parameter [policyName] :
  /// The name of the policy.
  ///
  /// Parameter [startTime] :
  /// The inclusive start time of the time range for the forecast data to get.
  /// At most, the date and time can be one year before the current date and
  /// time.
  Future<GetPredictiveScalingForecastAnswer> getPredictiveScalingForecast({
    required String autoScalingGroupName,
    required DateTime endTime,
    required String policyName,
    required DateTime startTime,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(endTime, 'endTime');
    ArgumentError.checkNotNull(policyName, 'policyName');
    _s.validateStringLength(
      'policyName',
      policyName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(startTime, 'startTime');
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['EndTime'] = _s.iso8601ToJson(endTime);
    $request['PolicyName'] = policyName;
    $request['StartTime'] = _s.iso8601ToJson(startTime);
    final $result = await _protocol.send(
      $request,
      action: 'GetPredictiveScalingForecast',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['GetPredictiveScalingForecastType'],
      shapes: shapes,
      resultWrapper: 'GetPredictiveScalingForecastResult',
    );
    return GetPredictiveScalingForecastAnswer.fromXml($result);
  }

  /// Creates or updates a lifecycle hook for the specified Auto Scaling group.
  ///
  /// Lifecycle hooks let you create solutions that are aware of events in the
  /// Auto Scaling instance lifecycle, and then perform a custom action on
  /// instances when the corresponding lifecycle event occurs.
  ///
  /// This step is a part of the procedure for adding a lifecycle hook to an
  /// Auto Scaling group:
  /// <ol>
  /// <li>
  /// (Optional) Create a launch template or launch configuration with a user
  /// data script that runs while an instance is in a wait state due to a
  /// lifecycle hook.
  /// </li>
  /// <li>
  /// (Optional) Create a Lambda function and a rule that allows Amazon
  /// EventBridge to invoke your Lambda function when an instance is put into a
  /// wait state due to a lifecycle hook.
  /// </li>
  /// <li>
  /// (Optional) Create a notification target and an IAM role. The target can be
  /// either an Amazon SQS queue or an Amazon SNS topic. The role allows Amazon
  /// EC2 Auto Scaling to publish lifecycle notifications to the target.
  /// </li>
  /// <li>
  /// <b>Create the lifecycle hook. Specify whether the hook is used when the
  /// instances launch or terminate.</b>
  /// </li>
  /// <li>
  /// If you need more time, record the lifecycle action heartbeat to keep the
  /// instance in a wait state using the <a>RecordLifecycleActionHeartbeat</a>
  /// API call.
  /// </li>
  /// <li>
  /// If you finish before the timeout period ends, send a callback by using the
  /// <a>CompleteLifecycleAction</a> API call.
  /// </li> </ol>
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/lifecycle-hooks.html">Amazon
  /// EC2 Auto Scaling lifecycle hooks</a> in the <i>Amazon EC2 Auto Scaling
  /// User Guide</i>.
  ///
  /// If you exceed your maximum limit of lifecycle hooks, which by default is
  /// 50 per Auto Scaling group, the call fails.
  ///
  /// You can view the lifecycle hooks for an Auto Scaling group using the
  /// <a>DescribeLifecycleHooks</a> API call. If you are no longer using a
  /// lifecycle hook, you can delete it by calling the
  /// <a>DeleteLifecycleHook</a> API.
  ///
  /// May throw [LimitExceededFault].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [lifecycleHookName] :
  /// The name of the lifecycle hook.
  ///
  /// Parameter [defaultResult] :
  /// The action the Auto Scaling group takes when the lifecycle hook timeout
  /// elapses or if an unexpected failure occurs. The default value is
  /// <code>ABANDON</code>.
  ///
  /// Valid values: <code>CONTINUE</code> | <code>ABANDON</code>
  ///
  /// Parameter [heartbeatTimeout] :
  /// The maximum time, in seconds, that can elapse before the lifecycle hook
  /// times out. The range is from <code>30</code> to <code>7200</code> seconds.
  /// The default value is <code>3600</code> seconds (1 hour).
  ///
  /// Parameter [lifecycleTransition] :
  /// The lifecycle transition. For Auto Scaling groups, there are two major
  /// lifecycle transitions.
  ///
  /// <ul>
  /// <li>
  /// To create a lifecycle hook for scale-out events, specify
  /// <code>autoscaling:EC2_INSTANCE_LAUNCHING</code>.
  /// </li>
  /// <li>
  /// To create a lifecycle hook for scale-in events, specify
  /// <code>autoscaling:EC2_INSTANCE_TERMINATING</code>.
  /// </li>
  /// </ul>
  /// Required for new lifecycle hooks, but optional when updating existing
  /// hooks.
  ///
  /// Parameter [notificationMetadata] :
  /// Additional information that you want to include any time Amazon EC2 Auto
  /// Scaling sends a message to the notification target.
  ///
  /// Parameter [notificationTargetARN] :
  /// The Amazon Resource Name (ARN) of the notification target that Amazon EC2
  /// Auto Scaling uses to notify you when an instance is in a wait state for
  /// the lifecycle hook. You can specify either an Amazon SNS topic or an
  /// Amazon SQS queue.
  ///
  /// If you specify an empty string, this overrides the current ARN.
  ///
  /// This operation uses the JSON format when sending notifications to an
  /// Amazon SQS queue, and an email key-value pair format when sending
  /// notifications to an Amazon SNS topic.
  ///
  /// When you specify a notification target, Amazon EC2 Auto Scaling sends it a
  /// test message. Test messages contain the following additional key-value
  /// pair: <code>"Event": "autoscaling:TEST_NOTIFICATION"</code>.
  ///
  /// Parameter [roleARN] :
  /// The ARN of the IAM role that allows the Auto Scaling group to publish to
  /// the specified notification target.
  ///
  /// Valid only if the notification target is an Amazon SNS topic or an Amazon
  /// SQS queue. Required for new lifecycle hooks, but optional when updating
  /// existing hooks.
  Future<void> putLifecycleHook({
    required String autoScalingGroupName,
    required String lifecycleHookName,
    String? defaultResult,
    int? heartbeatTimeout,
    String? lifecycleTransition,
    String? notificationMetadata,
    String? notificationTargetARN,
    String? roleARN,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(lifecycleHookName, 'lifecycleHookName');
    _s.validateStringLength(
      'lifecycleHookName',
      lifecycleHookName,
      1,
      255,
      isRequired: true,
    );
    _s.validateStringLength(
      'notificationMetadata',
      notificationMetadata,
      1,
      1023,
    );
    _s.validateStringLength(
      'notificationTargetARN',
      notificationTargetARN,
      0,
      255,
    );
    _s.validateStringLength(
      'roleARN',
      roleARN,
      1,
      255,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['LifecycleHookName'] = lifecycleHookName;
    defaultResult?.also((arg) => $request['DefaultResult'] = arg);
    heartbeatTimeout?.also((arg) => $request['HeartbeatTimeout'] = arg);
    lifecycleTransition?.also((arg) => $request['LifecycleTransition'] = arg);
    notificationMetadata?.also((arg) => $request['NotificationMetadata'] = arg);
    notificationTargetARN
        ?.also((arg) => $request['NotificationTargetARN'] = arg);
    roleARN?.also((arg) => $request['RoleARN'] = arg);
    await _protocol.send(
      $request,
      action: 'PutLifecycleHook',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['PutLifecycleHookType'],
      shapes: shapes,
      resultWrapper: 'PutLifecycleHookResult',
    );
  }

  /// Configures an Auto Scaling group to send notifications when specified
  /// events take place. Subscribers to the specified topic can have messages
  /// delivered to an endpoint such as a web server or an email address.
  ///
  /// This configuration overwrites any existing configuration.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ASGettingNotifications.html">Getting
  /// Amazon SNS notifications when your Auto Scaling group scales</a> in the
  /// <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// If you exceed your maximum limit of SNS topics, which is 10 per Auto
  /// Scaling group, the call fails.
  ///
  /// May throw [LimitExceededFault].
  /// May throw [ResourceContentionFault].
  /// May throw [ServiceLinkedRoleFailure].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [notificationTypes] :
  /// The type of event that causes the notification to be sent. To query the
  /// notification types supported by Amazon EC2 Auto Scaling, call the
  /// <a>DescribeAutoScalingNotificationTypes</a> API.
  ///
  /// Parameter [topicARN] :
  /// The Amazon Resource Name (ARN) of the Amazon SNS topic.
  Future<void> putNotificationConfiguration({
    required String autoScalingGroupName,
    required List<String> notificationTypes,
    required String topicARN,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(notificationTypes, 'notificationTypes');
    ArgumentError.checkNotNull(topicARN, 'topicARN');
    _s.validateStringLength(
      'topicARN',
      topicARN,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['NotificationTypes'] = notificationTypes;
    $request['TopicARN'] = topicARN;
    await _protocol.send(
      $request,
      action: 'PutNotificationConfiguration',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['PutNotificationConfigurationType'],
      shapes: shapes,
    );
  }

  /// Creates or updates a scaling policy for an Auto Scaling group. Scaling
  /// policies are used to scale an Auto Scaling group based on configurable
  /// metrics. If no policies are defined, the dynamic scaling and predictive
  /// scaling features are not used.
  ///
  /// For more information about using dynamic scaling, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-target-tracking.html">Target
  /// tracking scaling policies</a> and <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-simple-step.html">Step
  /// and simple scaling policies</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  ///
  /// For more information about using predictive scaling, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-predictive-scaling.html">Predictive
  /// scaling for Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2 Auto Scaling
  /// User Guide</i>.
  ///
  /// You can view the scaling policies for an Auto Scaling group using the
  /// <a>DescribePolicies</a> API call. If you are no longer using a scaling
  /// policy, you can delete it by calling the <a>DeletePolicy</a> API.
  ///
  /// May throw [LimitExceededFault].
  /// May throw [ResourceContentionFault].
  /// May throw [ServiceLinkedRoleFailure].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [policyName] :
  /// The name of the policy.
  ///
  /// Parameter [adjustmentType] :
  /// Specifies how the scaling adjustment is interpreted (for example, an
  /// absolute number or a percentage). The valid values are
  /// <code>ChangeInCapacity</code>, <code>ExactCapacity</code>, and
  /// <code>PercentChangeInCapacity</code>.
  ///
  /// Required if the policy type is <code>StepScaling</code> or
  /// <code>SimpleScaling</code>. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-simple-step.html#as-scaling-adjustment">Scaling
  /// adjustment types</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// Parameter [cooldown] :
  /// A cooldown period, in seconds, that applies to a specific simple scaling
  /// policy. When a cooldown period is specified here, it overrides the default
  /// cooldown.
  ///
  /// Valid only if the policy type is <code>SimpleScaling</code>. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/Cooldown.html">Scaling
  /// cooldowns for Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>.
  ///
  /// Default: None
  ///
  /// Parameter [enabled] :
  /// Indicates whether the scaling policy is enabled or disabled. The default
  /// is enabled. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-enable-disable-scaling-policy.html">Disabling
  /// a scaling policy for an Auto Scaling group</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>.
  ///
  /// Parameter [estimatedInstanceWarmup] :
  /// <i>Not needed if the default instance warmup is defined for the group.</i>
  ///
  /// The estimated time, in seconds, until a newly launched instance can
  /// contribute to the CloudWatch metrics. This warm-up period applies to
  /// instances launched due to a specific target tracking or step scaling
  /// policy. When a warm-up period is specified here, it overrides the default
  /// instance warmup.
  ///
  /// Valid only if the policy type is <code>TargetTrackingScaling</code> or
  /// <code>StepScaling</code>.
  /// <note>
  /// The default is to use the value for the default instance warmup defined
  /// for the group. If default instance warmup is null, then
  /// <code>EstimatedInstanceWarmup</code> falls back to the value of default
  /// cooldown.
  /// </note>
  ///
  /// Parameter [metricAggregationType] :
  /// The aggregation type for the CloudWatch metrics. The valid values are
  /// <code>Minimum</code>, <code>Maximum</code>, and <code>Average</code>. If
  /// the aggregation type is null, the value is treated as
  /// <code>Average</code>.
  ///
  /// Valid only if the policy type is <code>StepScaling</code>.
  ///
  /// Parameter [minAdjustmentMagnitude] :
  /// The minimum value to scale by when the adjustment type is
  /// <code>PercentChangeInCapacity</code>. For example, suppose that you create
  /// a step scaling policy to scale out an Auto Scaling group by 25 percent and
  /// you specify a <code>MinAdjustmentMagnitude</code> of 2. If the group has 4
  /// instances and the scaling policy is performed, 25 percent of 4 is 1.
  /// However, because you specified a <code>MinAdjustmentMagnitude</code> of 2,
  /// Amazon EC2 Auto Scaling scales out the group by 2 instances.
  ///
  /// Valid only if the policy type is <code>StepScaling</code> or
  /// <code>SimpleScaling</code>. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-simple-step.html#as-scaling-adjustment">Scaling
  /// adjustment types</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  /// <note>
  /// Some Auto Scaling groups use instance weights. In this case, set the
  /// <code>MinAdjustmentMagnitude</code> to a value that is at least as large
  /// as your largest instance weight.
  /// </note>
  ///
  /// Parameter [minAdjustmentStep] :
  /// Available for backward compatibility. Use
  /// <code>MinAdjustmentMagnitude</code> instead.
  ///
  /// Parameter [policyType] :
  /// One of the following policy types:
  ///
  /// <ul>
  /// <li>
  /// <code>TargetTrackingScaling</code>
  /// </li>
  /// <li>
  /// <code>StepScaling</code>
  /// </li>
  /// <li>
  /// <code>SimpleScaling</code> (default)
  /// </li>
  /// <li>
  /// <code>PredictiveScaling</code>
  /// </li>
  /// </ul>
  ///
  /// Parameter [predictiveScalingConfiguration] :
  /// A predictive scaling policy. Provides support for predefined and custom
  /// metrics.
  ///
  /// Predefined metrics include CPU utilization, network in/out, and the
  /// Application Load Balancer request count.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_PredictiveScalingConfiguration.html">PredictiveScalingConfiguration</a>
  /// in the <i>Amazon EC2 Auto Scaling API Reference</i>.
  ///
  /// Required if the policy type is <code>PredictiveScaling</code>.
  ///
  /// Parameter [scalingAdjustment] :
  /// The amount by which to scale, based on the specified adjustment type. A
  /// positive value adds to the current capacity while a negative number
  /// removes from the current capacity. For exact capacity, you must specify a
  /// positive value.
  ///
  /// Required if the policy type is <code>SimpleScaling</code>. (Not used with
  /// any other policy type.)
  ///
  /// Parameter [stepAdjustments] :
  /// A set of adjustments that enable you to scale based on the size of the
  /// alarm breach.
  ///
  /// Required if the policy type is <code>StepScaling</code>. (Not used with
  /// any other policy type.)
  ///
  /// Parameter [targetTrackingConfiguration] :
  /// A target tracking scaling policy. Provides support for predefined or
  /// custom metrics.
  ///
  /// The following predefined metrics are available:
  ///
  /// <ul>
  /// <li>
  /// <code>ASGAverageCPUUtilization</code>
  /// </li>
  /// <li>
  /// <code>ASGAverageNetworkIn</code>
  /// </li>
  /// <li>
  /// <code>ASGAverageNetworkOut</code>
  /// </li>
  /// <li>
  /// <code>ALBRequestCountPerTarget</code>
  /// </li>
  /// </ul>
  /// If you specify <code>ALBRequestCountPerTarget</code> for the metric, you
  /// must specify the <code>ResourceLabel</code> property with the
  /// <code>PredefinedMetricSpecification</code>.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_TargetTrackingConfiguration.html">TargetTrackingConfiguration</a>
  /// in the <i>Amazon EC2 Auto Scaling API Reference</i>.
  ///
  /// Required if the policy type is <code>TargetTrackingScaling</code>.
  Future<PolicyARNType> putScalingPolicy({
    required String autoScalingGroupName,
    required String policyName,
    String? adjustmentType,
    int? cooldown,
    bool? enabled,
    int? estimatedInstanceWarmup,
    String? metricAggregationType,
    int? minAdjustmentMagnitude,
    int? minAdjustmentStep,
    String? policyType,
    PredictiveScalingConfiguration? predictiveScalingConfiguration,
    int? scalingAdjustment,
    List<StepAdjustment>? stepAdjustments,
    TargetTrackingConfiguration? targetTrackingConfiguration,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(policyName, 'policyName');
    _s.validateStringLength(
      'policyName',
      policyName,
      1,
      255,
      isRequired: true,
    );
    _s.validateStringLength(
      'adjustmentType',
      adjustmentType,
      1,
      255,
    );
    _s.validateStringLength(
      'metricAggregationType',
      metricAggregationType,
      1,
      32,
    );
    _s.validateStringLength(
      'policyType',
      policyType,
      1,
      64,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['PolicyName'] = policyName;
    adjustmentType?.also((arg) => $request['AdjustmentType'] = arg);
    cooldown?.also((arg) => $request['Cooldown'] = arg);
    enabled?.also((arg) => $request['Enabled'] = arg);
    estimatedInstanceWarmup
        ?.also((arg) => $request['EstimatedInstanceWarmup'] = arg);
    metricAggregationType
        ?.also((arg) => $request['MetricAggregationType'] = arg);
    minAdjustmentMagnitude
        ?.also((arg) => $request['MinAdjustmentMagnitude'] = arg);
    minAdjustmentStep?.also((arg) => $request['MinAdjustmentStep'] = arg);
    policyType?.also((arg) => $request['PolicyType'] = arg);
    predictiveScalingConfiguration
        ?.also((arg) => $request['PredictiveScalingConfiguration'] = arg);
    scalingAdjustment?.also((arg) => $request['ScalingAdjustment'] = arg);
    stepAdjustments?.also((arg) => $request['StepAdjustments'] = arg);
    targetTrackingConfiguration
        ?.also((arg) => $request['TargetTrackingConfiguration'] = arg);
    final $result = await _protocol.send(
      $request,
      action: 'PutScalingPolicy',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['PutScalingPolicyType'],
      shapes: shapes,
      resultWrapper: 'PutScalingPolicyResult',
    );
    return PolicyARNType.fromXml($result);
  }

  /// Creates or updates a scheduled scaling action for an Auto Scaling group.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/schedule_time.html">Scheduled
  /// scaling</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// You can view the scheduled actions for an Auto Scaling group using the
  /// <a>DescribeScheduledActions</a> API call. If you are no longer using a
  /// scheduled action, you can delete it by calling the
  /// <a>DeleteScheduledAction</a> API.
  ///
  /// If you try to schedule your action in the past, Amazon EC2 Auto Scaling
  /// returns an error message.
  ///
  /// May throw [AlreadyExistsFault].
  /// May throw [LimitExceededFault].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [scheduledActionName] :
  /// The name of this scaling action.
  ///
  /// Parameter [desiredCapacity] :
  /// The desired capacity is the initial capacity of the Auto Scaling group
  /// after the scheduled action runs and the capacity it attempts to maintain.
  /// It can scale beyond this capacity if you add more scaling conditions.
  /// <note>
  /// You must specify at least one of the following properties:
  /// <code>MaxSize</code>, <code>MinSize</code>, or
  /// <code>DesiredCapacity</code>.
  /// </note>
  ///
  /// Parameter [endTime] :
  /// The date and time for the recurring schedule to end, in UTC. For example,
  /// <code>"2021-06-01T00:00:00Z"</code>.
  ///
  /// Parameter [maxSize] :
  /// The maximum size of the Auto Scaling group.
  ///
  /// Parameter [minSize] :
  /// The minimum size of the Auto Scaling group.
  ///
  /// Parameter [recurrence] :
  /// The recurring schedule for this action. This format consists of five
  /// fields separated by white spaces: [Minute] [Hour] [Day_of_Month]
  /// [Month_of_Year] [Day_of_Week]. The value must be in quotes (for example,
  /// <code>"30 0 1 1,6,12 *"</code>). For more information about this format,
  /// see <a href="http://crontab.org">Crontab</a>.
  ///
  /// When <code>StartTime</code> and <code>EndTime</code> are specified with
  /// <code>Recurrence</code>, they form the boundaries of when the recurring
  /// action starts and stops.
  ///
  /// Cron expressions use Universal Coordinated Time (UTC) by default.
  ///
  /// Parameter [startTime] :
  /// The date and time for this action to start, in YYYY-MM-DDThh:mm:ssZ format
  /// in UTC/GMT only and in quotes (for example,
  /// <code>"2021-06-01T00:00:00Z"</code>).
  ///
  /// If you specify <code>Recurrence</code> and <code>StartTime</code>, Amazon
  /// EC2 Auto Scaling performs the action at this time, and then performs the
  /// action based on the specified recurrence.
  ///
  /// Parameter [time] :
  /// This property is no longer used.
  ///
  /// Parameter [timeZone] :
  /// Specifies the time zone for a cron expression. If a time zone is not
  /// provided, UTC is used by default.
  ///
  /// Valid values are the canonical names of the IANA time zones, derived from
  /// the IANA Time Zone Database (such as <code>Etc/GMT+9</code> or
  /// <code>Pacific/Tahiti</code>). For more information, see <a
  /// href="https://en.wikipedia.org/wiki/List_of_tz_database_time_zones">https://en.wikipedia.org/wiki/List_of_tz_database_time_zones</a>.
  Future<void> putScheduledUpdateGroupAction({
    required String autoScalingGroupName,
    required String scheduledActionName,
    int? desiredCapacity,
    DateTime? endTime,
    int? maxSize,
    int? minSize,
    String? recurrence,
    DateTime? startTime,
    DateTime? time,
    String? timeZone,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(scheduledActionName, 'scheduledActionName');
    _s.validateStringLength(
      'scheduledActionName',
      scheduledActionName,
      1,
      255,
      isRequired: true,
    );
    _s.validateStringLength(
      'recurrence',
      recurrence,
      1,
      255,
    );
    _s.validateStringLength(
      'timeZone',
      timeZone,
      1,
      255,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['ScheduledActionName'] = scheduledActionName;
    desiredCapacity?.also((arg) => $request['DesiredCapacity'] = arg);
    endTime?.also((arg) => $request['EndTime'] = _s.iso8601ToJson(arg));
    maxSize?.also((arg) => $request['MaxSize'] = arg);
    minSize?.also((arg) => $request['MinSize'] = arg);
    recurrence?.also((arg) => $request['Recurrence'] = arg);
    startTime?.also((arg) => $request['StartTime'] = _s.iso8601ToJson(arg));
    time?.also((arg) => $request['Time'] = _s.iso8601ToJson(arg));
    timeZone?.also((arg) => $request['TimeZone'] = arg);
    await _protocol.send(
      $request,
      action: 'PutScheduledUpdateGroupAction',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['PutScheduledUpdateGroupActionType'],
      shapes: shapes,
    );
  }

  /// Creates or updates a warm pool for the specified Auto Scaling group. A
  /// warm pool is a pool of pre-initialized EC2 instances that sits alongside
  /// the Auto Scaling group. Whenever your application needs to scale out, the
  /// Auto Scaling group can draw on the warm pool to meet its new desired
  /// capacity. For more information and example configurations, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-warm-pools.html">Warm
  /// pools for Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2 Auto Scaling
  /// User Guide</i>.
  ///
  /// This operation must be called from the Region in which the Auto Scaling
  /// group was created. This operation cannot be called on an Auto Scaling
  /// group that has a mixed instances policy or a launch template or launch
  /// configuration that requests Spot Instances.
  ///
  /// You can view the instances in the warm pool using the
  /// <a>DescribeWarmPool</a> API call. If you are no longer using a warm pool,
  /// you can delete it by calling the <a>DeleteWarmPool</a> API.
  ///
  /// May throw [LimitExceededFault].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [instanceReusePolicy] :
  /// Indicates whether instances in the Auto Scaling group can be returned to
  /// the warm pool on scale in. The default is to terminate instances in the
  /// Auto Scaling group when the group scales in.
  ///
  /// Parameter [maxGroupPreparedCapacity] :
  /// Specifies the maximum number of instances that are allowed to be in the
  /// warm pool or in any state except <code>Terminated</code> for the Auto
  /// Scaling group. This is an optional property. Specify it only if you do not
  /// want the warm pool size to be determined by the difference between the
  /// group's maximum capacity and its desired capacity.
  /// <important>
  /// If a value for <code>MaxGroupPreparedCapacity</code> is not specified,
  /// Amazon EC2 Auto Scaling launches and maintains the difference between the
  /// group's maximum capacity and its desired capacity. If you specify a value
  /// for <code>MaxGroupPreparedCapacity</code>, Amazon EC2 Auto Scaling uses
  /// the difference between the <code>MaxGroupPreparedCapacity</code> and the
  /// desired capacity instead.
  ///
  /// The size of the warm pool is dynamic. Only when
  /// <code>MaxGroupPreparedCapacity</code> and <code>MinSize</code> are set to
  /// the same value does the warm pool have an absolute size.
  /// </important>
  /// If the desired capacity of the Auto Scaling group is higher than the
  /// <code>MaxGroupPreparedCapacity</code>, the capacity of the warm pool is 0,
  /// unless you specify a value for <code>MinSize</code>. To remove a value
  /// that you previously set, include the property but specify -1 for the
  /// value.
  ///
  /// Parameter [minSize] :
  /// Specifies the minimum number of instances to maintain in the warm pool.
  /// This helps you to ensure that there is always a certain number of warmed
  /// instances available to handle traffic spikes. Defaults to 0 if not
  /// specified.
  ///
  /// Parameter [poolState] :
  /// Sets the instance state to transition to after the lifecycle actions are
  /// complete. Default is <code>Stopped</code>.
  Future<void> putWarmPool({
    required String autoScalingGroupName,
    InstanceReusePolicy? instanceReusePolicy,
    int? maxGroupPreparedCapacity,
    int? minSize,
    WarmPoolState? poolState,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    _s.validateNumRange(
      'maxGroupPreparedCapacity',
      maxGroupPreparedCapacity,
      -1,
      1152921504606846976,
    );
    _s.validateNumRange(
      'minSize',
      minSize,
      0,
      1152921504606846976,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    instanceReusePolicy?.also((arg) => $request['InstanceReusePolicy'] = arg);
    maxGroupPreparedCapacity
        ?.also((arg) => $request['MaxGroupPreparedCapacity'] = arg);
    minSize?.also((arg) => $request['MinSize'] = arg);
    poolState?.also((arg) => $request['PoolState'] = arg.toValue());
    await _protocol.send(
      $request,
      action: 'PutWarmPool',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['PutWarmPoolType'],
      shapes: shapes,
      resultWrapper: 'PutWarmPoolResult',
    );
  }

  /// Records a heartbeat for the lifecycle action associated with the specified
  /// token or instance. This extends the timeout by the length of time defined
  /// using the <a>PutLifecycleHook</a> API call.
  ///
  /// This step is a part of the procedure for adding a lifecycle hook to an
  /// Auto Scaling group:
  /// <ol>
  /// <li>
  /// (Optional) Create a launch template or launch configuration with a user
  /// data script that runs while an instance is in a wait state due to a
  /// lifecycle hook.
  /// </li>
  /// <li>
  /// (Optional) Create a Lambda function and a rule that allows Amazon
  /// EventBridge to invoke your Lambda function when an instance is put into a
  /// wait state due to a lifecycle hook.
  /// </li>
  /// <li>
  /// (Optional) Create a notification target and an IAM role. The target can be
  /// either an Amazon SQS queue or an Amazon SNS topic. The role allows Amazon
  /// EC2 Auto Scaling to publish lifecycle notifications to the target.
  /// </li>
  /// <li>
  /// Create the lifecycle hook. Specify whether the hook is used when the
  /// instances launch or terminate.
  /// </li>
  /// <li>
  /// <b>If you need more time, record the lifecycle action heartbeat to keep
  /// the instance in a wait state.</b>
  /// </li>
  /// <li>
  /// If you finish before the timeout period ends, send a callback by using the
  /// <a>CompleteLifecycleAction</a> API call.
  /// </li> </ol>
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/lifecycle-hooks.html">Amazon
  /// EC2 Auto Scaling lifecycle hooks</a> in the <i>Amazon EC2 Auto Scaling
  /// User Guide</i>.
  ///
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [lifecycleHookName] :
  /// The name of the lifecycle hook.
  ///
  /// Parameter [instanceId] :
  /// The ID of the instance.
  ///
  /// Parameter [lifecycleActionToken] :
  /// A token that uniquely identifies a specific lifecycle action associated
  /// with an instance. Amazon EC2 Auto Scaling sends this token to the
  /// notification target that you specified when you created the lifecycle
  /// hook.
  Future<void> recordLifecycleActionHeartbeat({
    required String autoScalingGroupName,
    required String lifecycleHookName,
    String? instanceId,
    String? lifecycleActionToken,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      1600,
      isRequired: true,
    );
    ArgumentError.checkNotNull(lifecycleHookName, 'lifecycleHookName');
    _s.validateStringLength(
      'lifecycleHookName',
      lifecycleHookName,
      1,
      255,
      isRequired: true,
    );
    _s.validateStringLength(
      'instanceId',
      instanceId,
      1,
      19,
    );
    _s.validateStringLength(
      'lifecycleActionToken',
      lifecycleActionToken,
      36,
      36,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['LifecycleHookName'] = lifecycleHookName;
    instanceId?.also((arg) => $request['InstanceId'] = arg);
    lifecycleActionToken?.also((arg) => $request['LifecycleActionToken'] = arg);
    await _protocol.send(
      $request,
      action: 'RecordLifecycleActionHeartbeat',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['RecordLifecycleActionHeartbeatType'],
      shapes: shapes,
      resultWrapper: 'RecordLifecycleActionHeartbeatResult',
    );
  }

  /// Resumes the specified suspended auto scaling processes, or all suspended
  /// process, for the specified Auto Scaling group.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-suspend-resume-processes.html">Suspending
  /// and resuming scaling processes</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  ///
  /// May throw [ResourceInUseFault].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [scalingProcesses] :
  /// One or more of the following processes:
  ///
  /// <ul>
  /// <li>
  /// <code>Launch</code>
  /// </li>
  /// <li>
  /// <code>Terminate</code>
  /// </li>
  /// <li>
  /// <code>AddToLoadBalancer</code>
  /// </li>
  /// <li>
  /// <code>AlarmNotification</code>
  /// </li>
  /// <li>
  /// <code>AZRebalance</code>
  /// </li>
  /// <li>
  /// <code>HealthCheck</code>
  /// </li>
  /// <li>
  /// <code>InstanceRefresh</code>
  /// </li>
  /// <li>
  /// <code>ReplaceUnhealthy</code>
  /// </li>
  /// <li>
  /// <code>ScheduledActions</code>
  /// </li>
  /// </ul>
  /// If you omit this property, all processes are specified.
  Future<void> resumeProcesses({
    required String autoScalingGroupName,
    List<String>? scalingProcesses,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    scalingProcesses?.also((arg) => $request['ScalingProcesses'] = arg);
    await _protocol.send(
      $request,
      action: 'ResumeProcesses',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['ScalingProcessQuery'],
      shapes: shapes,
    );
  }

  /// Sets the size of the specified Auto Scaling group.
  ///
  /// If a scale-in activity occurs as a result of a new
  /// <code>DesiredCapacity</code> value that is lower than the current size of
  /// the group, the Auto Scaling group uses its termination policy to determine
  /// which instances to terminate.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-manual-scaling.html">Manual
  /// scaling</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// May throw [ScalingActivityInProgressFault].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [desiredCapacity] :
  /// The desired capacity is the initial capacity of the Auto Scaling group
  /// after this operation completes and the capacity it attempts to maintain.
  ///
  /// Parameter [honorCooldown] :
  /// Indicates whether Amazon EC2 Auto Scaling waits for the cooldown period to
  /// complete before initiating a scaling activity to set your Auto Scaling
  /// group to its new capacity. By default, Amazon EC2 Auto Scaling does not
  /// honor the cooldown period during manual scaling activities.
  Future<void> setDesiredCapacity({
    required String autoScalingGroupName,
    required int desiredCapacity,
    bool? honorCooldown,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(desiredCapacity, 'desiredCapacity');
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['DesiredCapacity'] = desiredCapacity;
    honorCooldown?.also((arg) => $request['HonorCooldown'] = arg);
    await _protocol.send(
      $request,
      action: 'SetDesiredCapacity',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['SetDesiredCapacityType'],
      shapes: shapes,
    );
  }

  /// Sets the health status of the specified instance.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/healthcheck.html">Health
  /// checks for Auto Scaling instances</a> in the <i>Amazon EC2 Auto Scaling
  /// User Guide</i>.
  ///
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [healthStatus] :
  /// The health status of the instance. Set to <code>Healthy</code> to have the
  /// instance remain in service. Set to <code>Unhealthy</code> to have the
  /// instance be out of service. Amazon EC2 Auto Scaling terminates and
  /// replaces the unhealthy instance.
  ///
  /// Parameter [instanceId] :
  /// The ID of the instance.
  ///
  /// Parameter [shouldRespectGracePeriod] :
  /// If the Auto Scaling group of the specified instance has a
  /// <code>HealthCheckGracePeriod</code> specified for the group, by default,
  /// this call respects the grace period. Set this to <code>False</code>, to
  /// have the call not respect the grace period associated with the group.
  ///
  /// For more information about the health check grace period, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_CreateAutoScalingGroup.html">CreateAutoScalingGroup</a>
  /// in the <i>Amazon EC2 Auto Scaling API Reference</i>.
  Future<void> setInstanceHealth({
    required String healthStatus,
    required String instanceId,
    bool? shouldRespectGracePeriod,
  }) async {
    ArgumentError.checkNotNull(healthStatus, 'healthStatus');
    _s.validateStringLength(
      'healthStatus',
      healthStatus,
      1,
      32,
      isRequired: true,
    );
    ArgumentError.checkNotNull(instanceId, 'instanceId');
    _s.validateStringLength(
      'instanceId',
      instanceId,
      1,
      19,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['HealthStatus'] = healthStatus;
    $request['InstanceId'] = instanceId;
    shouldRespectGracePeriod
        ?.also((arg) => $request['ShouldRespectGracePeriod'] = arg);
    await _protocol.send(
      $request,
      action: 'SetInstanceHealth',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['SetInstanceHealthQuery'],
      shapes: shapes,
    );
  }

  /// Updates the instance protection settings of the specified instances. This
  /// operation cannot be called on instances in a warm pool.
  ///
  /// For more information about preventing instances that are part of an Auto
  /// Scaling group from terminating on scale in, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-instance-protection.html">Using
  /// instance scale-in protection</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  ///
  /// If you exceed your maximum limit of instance IDs, which is 50 per Auto
  /// Scaling group, the call fails.
  ///
  /// May throw [LimitExceededFault].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [instanceIds] :
  /// One or more instance IDs. You can specify up to 50 instances.
  ///
  /// Parameter [protectedFromScaleIn] :
  /// Indicates whether the instance is protected from termination by Amazon EC2
  /// Auto Scaling when scaling in.
  Future<void> setInstanceProtection({
    required String autoScalingGroupName,
    required List<String> instanceIds,
    required bool protectedFromScaleIn,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    ArgumentError.checkNotNull(instanceIds, 'instanceIds');
    ArgumentError.checkNotNull(protectedFromScaleIn, 'protectedFromScaleIn');
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    $request['InstanceIds'] = instanceIds;
    $request['ProtectedFromScaleIn'] = protectedFromScaleIn;
    await _protocol.send(
      $request,
      action: 'SetInstanceProtection',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['SetInstanceProtectionQuery'],
      shapes: shapes,
      resultWrapper: 'SetInstanceProtectionResult',
    );
  }

  /// Starts a new instance refresh operation. An instance refresh performs a
  /// rolling replacement of all or some instances in an Auto Scaling group.
  /// Each instance is terminated first and then replaced, which temporarily
  /// reduces the capacity available within your Auto Scaling group.
  ///
  /// This operation is part of the <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-instance-refresh.html">instance
  /// refresh feature</a> in Amazon EC2 Auto Scaling, which helps you update
  /// instances in your Auto Scaling group. This feature is helpful, for
  /// example, when you have a new AMI or a new user data script. You just need
  /// to create a new launch template that specifies the new AMI or user data
  /// script. Then start an instance refresh to immediately begin the process of
  /// updating instances in the group.
  ///
  /// If the call succeeds, it creates a new instance refresh request with a
  /// unique ID that you can use to track its progress. To query its status,
  /// call the <a>DescribeInstanceRefreshes</a> API. To describe the instance
  /// refreshes that have already run, call the <a>DescribeInstanceRefreshes</a>
  /// API. To cancel an instance refresh operation in progress, use the
  /// <a>CancelInstanceRefresh</a> API.
  ///
  /// May throw [LimitExceededFault].
  /// May throw [ResourceContentionFault].
  /// May throw [InstanceRefreshInProgressFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [desiredConfiguration] :
  /// The desired configuration. For example, the desired configuration can
  /// specify a new launch template or a new version of the current launch
  /// template.
  ///
  /// Once the instance refresh succeeds, Amazon EC2 Auto Scaling updates the
  /// settings of the Auto Scaling group to reflect the new desired
  /// configuration.
  /// <note>
  /// When you specify a new launch template or a new version of the current
  /// launch template for your desired configuration, consider enabling the
  /// <code>SkipMatching</code> property in preferences. If it's enabled, Amazon
  /// EC2 Auto Scaling skips replacing instances that already use the specified
  /// launch template and version. This can help you reduce the number of
  /// replacements that are required to apply updates.
  /// </note>
  ///
  /// Parameter [preferences] :
  /// Set of preferences associated with the instance refresh request. If not
  /// provided, the default values are used.
  ///
  /// Parameter [strategy] :
  /// The strategy to use for the instance refresh. The only valid value is
  /// <code>Rolling</code>.
  ///
  /// A rolling update helps you update your instances gradually. A rolling
  /// update can fail due to failed health checks or if instances are on standby
  /// or are protected from scale in. If the rolling update process fails, any
  /// instances that are replaced are not rolled back to their previous
  /// configuration.
  Future<StartInstanceRefreshAnswer> startInstanceRefresh({
    required String autoScalingGroupName,
    DesiredConfiguration? desiredConfiguration,
    RefreshPreferences? preferences,
    RefreshStrategy? strategy,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    desiredConfiguration?.also((arg) => $request['DesiredConfiguration'] = arg);
    preferences?.also((arg) => $request['Preferences'] = arg);
    strategy?.also((arg) => $request['Strategy'] = arg.toValue());
    final $result = await _protocol.send(
      $request,
      action: 'StartInstanceRefresh',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['StartInstanceRefreshType'],
      shapes: shapes,
      resultWrapper: 'StartInstanceRefreshResult',
    );
    return StartInstanceRefreshAnswer.fromXml($result);
  }

  /// Suspends the specified auto scaling processes, or all processes, for the
  /// specified Auto Scaling group.
  ///
  /// If you suspend either the <code>Launch</code> or <code>Terminate</code>
  /// process types, it can prevent other process types from functioning
  /// properly. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-suspend-resume-processes.html">Suspending
  /// and resuming scaling processes</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  ///
  /// To resume processes that have been suspended, call the
  /// <a>ResumeProcesses</a> API.
  ///
  /// May throw [ResourceInUseFault].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [scalingProcesses] :
  /// One or more of the following processes:
  ///
  /// <ul>
  /// <li>
  /// <code>Launch</code>
  /// </li>
  /// <li>
  /// <code>Terminate</code>
  /// </li>
  /// <li>
  /// <code>AddToLoadBalancer</code>
  /// </li>
  /// <li>
  /// <code>AlarmNotification</code>
  /// </li>
  /// <li>
  /// <code>AZRebalance</code>
  /// </li>
  /// <li>
  /// <code>HealthCheck</code>
  /// </li>
  /// <li>
  /// <code>InstanceRefresh</code>
  /// </li>
  /// <li>
  /// <code>ReplaceUnhealthy</code>
  /// </li>
  /// <li>
  /// <code>ScheduledActions</code>
  /// </li>
  /// </ul>
  /// If you omit this property, all processes are specified.
  Future<void> suspendProcesses({
    required String autoScalingGroupName,
    List<String>? scalingProcesses,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    scalingProcesses?.also((arg) => $request['ScalingProcesses'] = arg);
    await _protocol.send(
      $request,
      action: 'SuspendProcesses',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['ScalingProcessQuery'],
      shapes: shapes,
    );
  }

  /// Terminates the specified instance and optionally adjusts the desired group
  /// size. This operation cannot be called on instances in a warm pool.
  ///
  /// This call simply makes a termination request. The instance is not
  /// terminated immediately. When an instance is terminated, the instance
  /// status changes to <code>terminated</code>. You can't connect to or start
  /// an instance after you've terminated it.
  ///
  /// If you do not specify the option to decrement the desired capacity, Amazon
  /// EC2 Auto Scaling launches instances to replace the ones that are
  /// terminated.
  ///
  /// By default, Amazon EC2 Auto Scaling balances instances across all
  /// Availability Zones. If you decrement the desired capacity, your Auto
  /// Scaling group can become unbalanced between Availability Zones. Amazon EC2
  /// Auto Scaling tries to rebalance the group, and rebalancing might terminate
  /// instances in other zones. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/auto-scaling-benefits.html#AutoScalingBehavior.InstanceUsage">Rebalancing
  /// activities</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// May throw [ScalingActivityInProgressFault].
  /// May throw [ResourceContentionFault].
  ///
  /// Parameter [instanceId] :
  /// The ID of the instance.
  ///
  /// Parameter [shouldDecrementDesiredCapacity] :
  /// Indicates whether terminating the instance also decrements the size of the
  /// Auto Scaling group.
  Future<ActivityType> terminateInstanceInAutoScalingGroup({
    required String instanceId,
    required bool shouldDecrementDesiredCapacity,
  }) async {
    ArgumentError.checkNotNull(instanceId, 'instanceId');
    _s.validateStringLength(
      'instanceId',
      instanceId,
      1,
      19,
      isRequired: true,
    );
    ArgumentError.checkNotNull(
        shouldDecrementDesiredCapacity, 'shouldDecrementDesiredCapacity');
    final $request = <String, dynamic>{};
    $request['InstanceId'] = instanceId;
    $request['ShouldDecrementDesiredCapacity'] = shouldDecrementDesiredCapacity;
    final $result = await _protocol.send(
      $request,
      action: 'TerminateInstanceInAutoScalingGroup',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['TerminateInstanceInAutoScalingGroupType'],
      shapes: shapes,
      resultWrapper: 'TerminateInstanceInAutoScalingGroupResult',
    );
    return ActivityType.fromXml($result);
  }

  /// <b>We strongly recommend that all Auto Scaling groups use launch templates
  /// to ensure full functionality for Amazon EC2 Auto Scaling and Amazon
  /// EC2.</b>
  ///
  /// Updates the configuration for the specified Auto Scaling group.
  ///
  /// To update an Auto Scaling group, specify the name of the group and the
  /// property that you want to change. Any properties that you don't specify
  /// are not changed by this update request. The new settings take effect on
  /// any scaling activities after this call returns.
  ///
  /// If you associate a new launch configuration or template with an Auto
  /// Scaling group, all new instances will get the updated configuration.
  /// Existing instances continue to run with the configuration that they were
  /// originally launched with. When you update a group to specify a mixed
  /// instances policy instead of a launch configuration or template, existing
  /// instances may be replaced to match the new purchasing options that you
  /// specified in the policy. For example, if the group currently has 100%
  /// On-Demand capacity and the policy specifies 50% Spot capacity, this means
  /// that half of your instances will be gradually terminated and relaunched as
  /// Spot Instances. When replacing instances, Amazon EC2 Auto Scaling launches
  /// new instances before terminating the old ones, so that updating your group
  /// does not compromise the performance or availability of your application.
  ///
  /// Note the following about changing <code>DesiredCapacity</code>,
  /// <code>MaxSize</code>, or <code>MinSize</code>:
  ///
  /// <ul>
  /// <li>
  /// If a scale-in activity occurs as a result of a new
  /// <code>DesiredCapacity</code> value that is lower than the current size of
  /// the group, the Auto Scaling group uses its termination policy to determine
  /// which instances to terminate.
  /// </li>
  /// <li>
  /// If you specify a new value for <code>MinSize</code> without specifying a
  /// value for <code>DesiredCapacity</code>, and the new <code>MinSize</code>
  /// is larger than the current size of the group, this sets the group's
  /// <code>DesiredCapacity</code> to the new <code>MinSize</code> value.
  /// </li>
  /// <li>
  /// If you specify a new value for <code>MaxSize</code> without specifying a
  /// value for <code>DesiredCapacity</code>, and the new <code>MaxSize</code>
  /// is smaller than the current size of the group, this sets the group's
  /// <code>DesiredCapacity</code> to the new <code>MaxSize</code> value.
  /// </li>
  /// </ul>
  /// To see which properties have been set, call the
  /// <a>DescribeAutoScalingGroups</a> API. To view the scaling policies for an
  /// Auto Scaling group, call the <a>DescribePolicies</a> API. If the group has
  /// scaling policies, you can update them by calling the
  /// <a>PutScalingPolicy</a> API.
  ///
  /// May throw [ScalingActivityInProgressFault].
  /// May throw [ResourceContentionFault].
  /// May throw [ServiceLinkedRoleFailure].
  ///
  /// Parameter [autoScalingGroupName] :
  /// The name of the Auto Scaling group.
  ///
  /// Parameter [availabilityZones] :
  /// One or more Availability Zones for the group.
  ///
  /// Parameter [capacityRebalance] :
  /// Enables or disables Capacity Rebalancing. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-capacity-rebalancing.html">Use
  /// Capacity Rebalancing to handle Amazon EC2 Spot Interruptions</a> in the
  /// <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// Parameter [context] :
  /// Reserved.
  ///
  /// Parameter [defaultCooldown] :
  /// <i>Only needed if you use simple scaling policies.</i>
  ///
  /// The amount of time, in seconds, between one scaling activity ending and
  /// another one starting due to simple scaling policies. For more information,
  /// see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/Cooldown.html">Scaling
  /// cooldowns for Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>.
  ///
  /// Parameter [defaultInstanceWarmup] :
  /// The amount of time, in seconds, until a newly launched instance can
  /// contribute to the Amazon CloudWatch metrics. This delay lets an instance
  /// finish initializing before Amazon EC2 Auto Scaling aggregates instance
  /// metrics, resulting in more reliable usage data. Set this value equal to
  /// the amount of time that it takes for resource consumption to become stable
  /// after an instance reaches the <code>InService</code> state. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-default-instance-warmup.html">Set
  /// the default instance warmup for an Auto Scaling group</a> in the <i>Amazon
  /// EC2 Auto Scaling User Guide</i>.
  /// <important>
  /// To manage your warm-up settings at the group level, we recommend that you
  /// set the default instance warmup, <i>even if its value is set to 0
  /// seconds</i>. This also optimizes the performance of scaling policies that
  /// scale continuously, such as target tracking and step scaling policies.
  ///
  /// If you need to remove a value that you previously set, include the
  /// property but specify <code>-1</code> for the value. However, we strongly
  /// recommend keeping the default instance warmup enabled by specifying a
  /// minimum value of <code>0</code>.
  /// </important>
  ///
  /// Parameter [desiredCapacity] :
  /// The desired capacity is the initial capacity of the Auto Scaling group
  /// after this operation completes and the capacity it attempts to maintain.
  /// This number must be greater than or equal to the minimum size of the group
  /// and less than or equal to the maximum size of the group.
  ///
  /// Parameter [desiredCapacityType] :
  /// The unit of measurement for the value specified for desired capacity.
  /// Amazon EC2 Auto Scaling supports <code>DesiredCapacityType</code> for
  /// attribute-based instance type selection only. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-asg-instance-type-requirements.html">Creating
  /// an Auto Scaling group using attribute-based instance type selection</a> in
  /// the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// By default, Amazon EC2 Auto Scaling specifies <code>units</code>, which
  /// translates into number of instances.
  ///
  /// Valid values: <code>units</code> | <code>vcpu</code> |
  /// <code>memory-mib</code>
  ///
  /// Parameter [healthCheckGracePeriod] :
  /// The amount of time, in seconds, that Amazon EC2 Auto Scaling waits before
  /// checking the health status of an EC2 instance that has come into service
  /// and marking it unhealthy due to a failed Elastic Load Balancing or custom
  /// health check. This is useful if your instances do not immediately pass
  /// these health checks after they enter the <code>InService</code> state. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/healthcheck.html#health-check-grace-period">Health
  /// check grace period</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// Parameter [healthCheckType] :
  /// The service to use for the health checks. The valid values are
  /// <code>EC2</code> and <code>ELB</code>. If you configure an Auto Scaling
  /// group to use <code>ELB</code> health checks, it considers the instance
  /// unhealthy if it fails either the EC2 status checks or the load balancer
  /// health checks.
  ///
  /// Parameter [launchConfigurationName] :
  /// The name of the launch configuration. If you specify
  /// <code>LaunchConfigurationName</code> in your update request, you can't
  /// specify <code>LaunchTemplate</code> or <code>MixedInstancesPolicy</code>.
  ///
  /// Parameter [launchTemplate] :
  /// The launch template and version to use to specify the updates. If you
  /// specify <code>LaunchTemplate</code> in your update request, you can't
  /// specify <code>LaunchConfigurationName</code> or
  /// <code>MixedInstancesPolicy</code>.
  ///
  /// Parameter [maxInstanceLifetime] :
  /// The maximum amount of time, in seconds, that an instance can be in
  /// service. The default is null. If specified, the value must be either 0 or
  /// a number equal to or greater than 86,400 seconds (1 day). To clear a
  /// previously set value, specify a new value of 0. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-max-instance-lifetime.html">Replacing
  /// Auto Scaling instances based on maximum instance lifetime</a> in the
  /// <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// Parameter [maxSize] :
  /// The maximum size of the Auto Scaling group.
  /// <note>
  /// With a mixed instances policy that uses instance weighting, Amazon EC2
  /// Auto Scaling may need to go above <code>MaxSize</code> to meet your
  /// capacity requirements. In this event, Amazon EC2 Auto Scaling will never
  /// go above <code>MaxSize</code> by more than your largest instance weight
  /// (weights that define how many units each instance contributes to the
  /// desired capacity of the group).
  /// </note>
  ///
  /// Parameter [minSize] :
  /// The minimum size of the Auto Scaling group.
  ///
  /// Parameter [mixedInstancesPolicy] :
  /// An embedded object that specifies a mixed instances policy. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-mixed-instances-groups.html">Auto
  /// Scaling groups with multiple instance types and purchase options</a> in
  /// the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// Parameter [newInstancesProtectedFromScaleIn] :
  /// Indicates whether newly launched instances are protected from termination
  /// by Amazon EC2 Auto Scaling when scaling in. For more information about
  /// preventing instances from terminating on scale in, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-instance-protection.html">Using
  /// instance scale-in protection</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  ///
  /// Parameter [placementGroup] :
  /// The name of an existing placement group into which to launch your
  /// instances. For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html">Placement
  /// groups</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.
  /// <note>
  /// A <i>cluster</i> placement group is a logical grouping of instances within
  /// a single Availability Zone. You cannot specify multiple Availability Zones
  /// and a cluster placement group.
  /// </note>
  ///
  /// Parameter [serviceLinkedRoleARN] :
  /// The Amazon Resource Name (ARN) of the service-linked role that the Auto
  /// Scaling group uses to call other Amazon Web Services on your behalf. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-service-linked-role.html">Service-linked
  /// roles</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// Parameter [terminationPolicies] :
  /// A policy or a list of policies that are used to select the instances to
  /// terminate. The policies are executed in the order that you list them. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-termination-policies.html">Work
  /// with Amazon EC2 Auto Scaling termination policies</a> in the <i>Amazon EC2
  /// Auto Scaling User Guide</i>.
  ///
  /// Valid values: <code>Default</code> | <code>AllocationStrategy</code> |
  /// <code>ClosestToNextInstanceHour</code> | <code>NewestInstance</code> |
  /// <code>OldestInstance</code> | <code>OldestLaunchConfiguration</code> |
  /// <code>OldestLaunchTemplate</code> |
  /// <code>arn:aws:lambda:region:account-id:function:my-function:my-alias</code>
  ///
  /// Parameter [vPCZoneIdentifier] :
  /// A comma-separated list of subnet IDs for a virtual private cloud (VPC). If
  /// you specify <code>VPCZoneIdentifier</code> with
  /// <code>AvailabilityZones</code>, the subnets that you specify must reside
  /// in those Availability Zones.
  Future<void> updateAutoScalingGroup({
    required String autoScalingGroupName,
    List<String>? availabilityZones,
    bool? capacityRebalance,
    String? context,
    int? defaultCooldown,
    int? defaultInstanceWarmup,
    int? desiredCapacity,
    String? desiredCapacityType,
    int? healthCheckGracePeriod,
    String? healthCheckType,
    String? launchConfigurationName,
    LaunchTemplateSpecification? launchTemplate,
    int? maxInstanceLifetime,
    int? maxSize,
    int? minSize,
    MixedInstancesPolicy? mixedInstancesPolicy,
    bool? newInstancesProtectedFromScaleIn,
    String? placementGroup,
    String? serviceLinkedRoleARN,
    List<String>? terminationPolicies,
    String? vPCZoneIdentifier,
  }) async {
    ArgumentError.checkNotNull(autoScalingGroupName, 'autoScalingGroupName');
    _s.validateStringLength(
      'autoScalingGroupName',
      autoScalingGroupName,
      1,
      255,
      isRequired: true,
    );
    _s.validateStringLength(
      'desiredCapacityType',
      desiredCapacityType,
      1,
      255,
    );
    _s.validateStringLength(
      'healthCheckType',
      healthCheckType,
      1,
      32,
    );
    _s.validateStringLength(
      'launchConfigurationName',
      launchConfigurationName,
      1,
      255,
    );
    _s.validateStringLength(
      'placementGroup',
      placementGroup,
      1,
      255,
    );
    _s.validateStringLength(
      'serviceLinkedRoleARN',
      serviceLinkedRoleARN,
      1,
      1600,
    );
    _s.validateStringLength(
      'vPCZoneIdentifier',
      vPCZoneIdentifier,
      1,
      2047,
    );
    final $request = <String, dynamic>{};
    $request['AutoScalingGroupName'] = autoScalingGroupName;
    availabilityZones?.also((arg) => $request['AvailabilityZones'] = arg);
    capacityRebalance?.also((arg) => $request['CapacityRebalance'] = arg);
    context?.also((arg) => $request['Context'] = arg);
    defaultCooldown?.also((arg) => $request['DefaultCooldown'] = arg);
    defaultInstanceWarmup
        ?.also((arg) => $request['DefaultInstanceWarmup'] = arg);
    desiredCapacity?.also((arg) => $request['DesiredCapacity'] = arg);
    desiredCapacityType?.also((arg) => $request['DesiredCapacityType'] = arg);
    healthCheckGracePeriod
        ?.also((arg) => $request['HealthCheckGracePeriod'] = arg);
    healthCheckType?.also((arg) => $request['HealthCheckType'] = arg);
    launchConfigurationName
        ?.also((arg) => $request['LaunchConfigurationName'] = arg);
    launchTemplate?.also((arg) => $request['LaunchTemplate'] = arg);
    maxInstanceLifetime?.also((arg) => $request['MaxInstanceLifetime'] = arg);
    maxSize?.also((arg) => $request['MaxSize'] = arg);
    minSize?.also((arg) => $request['MinSize'] = arg);
    mixedInstancesPolicy?.also((arg) => $request['MixedInstancesPolicy'] = arg);
    newInstancesProtectedFromScaleIn
        ?.also((arg) => $request['NewInstancesProtectedFromScaleIn'] = arg);
    placementGroup?.also((arg) => $request['PlacementGroup'] = arg);
    serviceLinkedRoleARN?.also((arg) => $request['ServiceLinkedRoleARN'] = arg);
    terminationPolicies?.also((arg) => $request['TerminationPolicies'] = arg);
    vPCZoneIdentifier?.also((arg) => $request['VPCZoneIdentifier'] = arg);
    await _protocol.send(
      $request,
      action: 'UpdateAutoScalingGroup',
      version: '2011-01-01',
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      shape: shapes['UpdateAutoScalingGroupType'],
      shapes: shapes,
    );
  }
}

/// Specifies the minimum and maximum for the <code>AcceleratorCount</code>
/// object when you specify <a>InstanceRequirements</a> for an Auto Scaling
/// group.
class AcceleratorCountRequest {
  /// The maximum value.
  final int? max;

  /// The minimum value.
  final int? min;

  AcceleratorCountRequest({
    this.max,
    this.min,
  });
  factory AcceleratorCountRequest.fromXml(_s.XmlElement elem) {
    return AcceleratorCountRequest(
      max: _s.extractXmlIntValue(elem, 'Max'),
      min: _s.extractXmlIntValue(elem, 'Min'),
    );
  }

  Map<String, dynamic> toJson() {
    final max = this.max;
    final min = this.min;
    return {
      if (max != null) 'Max': max,
      if (min != null) 'Min': min,
    };
  }
}

enum AcceleratorManufacturer {
  nvidia,
  amd,
  amazonWebServices,
  xilinx,
}

extension on AcceleratorManufacturer {
  String toValue() {
    switch (this) {
      case AcceleratorManufacturer.nvidia:
        return 'nvidia';
      case AcceleratorManufacturer.amd:
        return 'amd';
      case AcceleratorManufacturer.amazonWebServices:
        return 'amazon-web-services';
      case AcceleratorManufacturer.xilinx:
        return 'xilinx';
    }
  }
}

extension on String {
  AcceleratorManufacturer toAcceleratorManufacturer() {
    switch (this) {
      case 'nvidia':
        return AcceleratorManufacturer.nvidia;
      case 'amd':
        return AcceleratorManufacturer.amd;
      case 'amazon-web-services':
        return AcceleratorManufacturer.amazonWebServices;
      case 'xilinx':
        return AcceleratorManufacturer.xilinx;
    }
    throw Exception('$this is not known in enum AcceleratorManufacturer');
  }
}

enum AcceleratorName {
  a100,
  v100,
  k80,
  t4,
  m60,
  radeonProV520,
  vu9p,
}

extension on AcceleratorName {
  String toValue() {
    switch (this) {
      case AcceleratorName.a100:
        return 'a100';
      case AcceleratorName.v100:
        return 'v100';
      case AcceleratorName.k80:
        return 'k80';
      case AcceleratorName.t4:
        return 't4';
      case AcceleratorName.m60:
        return 'm60';
      case AcceleratorName.radeonProV520:
        return 'radeon-pro-v520';
      case AcceleratorName.vu9p:
        return 'vu9p';
    }
  }
}

extension on String {
  AcceleratorName toAcceleratorName() {
    switch (this) {
      case 'a100':
        return AcceleratorName.a100;
      case 'v100':
        return AcceleratorName.v100;
      case 'k80':
        return AcceleratorName.k80;
      case 't4':
        return AcceleratorName.t4;
      case 'm60':
        return AcceleratorName.m60;
      case 'radeon-pro-v520':
        return AcceleratorName.radeonProV520;
      case 'vu9p':
        return AcceleratorName.vu9p;
    }
    throw Exception('$this is not known in enum AcceleratorName');
  }
}

/// Specifies the minimum and maximum for the
/// <code>AcceleratorTotalMemoryMiB</code> object when you specify
/// <a>InstanceRequirements</a> for an Auto Scaling group.
class AcceleratorTotalMemoryMiBRequest {
  /// The memory maximum in MiB.
  final int? max;

  /// The memory minimum in MiB.
  final int? min;

  AcceleratorTotalMemoryMiBRequest({
    this.max,
    this.min,
  });
  factory AcceleratorTotalMemoryMiBRequest.fromXml(_s.XmlElement elem) {
    return AcceleratorTotalMemoryMiBRequest(
      max: _s.extractXmlIntValue(elem, 'Max'),
      min: _s.extractXmlIntValue(elem, 'Min'),
    );
  }

  Map<String, dynamic> toJson() {
    final max = this.max;
    final min = this.min;
    return {
      if (max != null) 'Max': max,
      if (min != null) 'Min': min,
    };
  }
}

enum AcceleratorType {
  gpu,
  fpga,
  inference,
}

extension on AcceleratorType {
  String toValue() {
    switch (this) {
      case AcceleratorType.gpu:
        return 'gpu';
      case AcceleratorType.fpga:
        return 'fpga';
      case AcceleratorType.inference:
        return 'inference';
    }
  }
}

extension on String {
  AcceleratorType toAcceleratorType() {
    switch (this) {
      case 'gpu':
        return AcceleratorType.gpu;
      case 'fpga':
        return AcceleratorType.fpga;
      case 'inference':
        return AcceleratorType.inference;
    }
    throw Exception('$this is not known in enum AcceleratorType');
  }
}

class ActivitiesType {
  /// The scaling activities. Activities are sorted by start time. Activities
  /// still in progress are described first.
  final List<Activity> activities;

  /// A string that indicates that the response contains more items than can be
  /// returned in a single response. To receive additional items, specify this
  /// string for the <code>NextToken</code> value when requesting the next set of
  /// items. This value is null when there are no more items to return.
  final String? nextToken;

  ActivitiesType({
    required this.activities,
    this.nextToken,
  });
  factory ActivitiesType.fromXml(_s.XmlElement elem) {
    return ActivitiesType(
      activities: _s
          .extractXmlChild(elem, 'Activities')!
          .findElements('member')
          .map((c) => Activity.fromXml(c))
          .toList(),
      nextToken: _s.extractXmlStringValue(elem, 'NextToken'),
    );
  }
}

/// Describes scaling activity, which is a long-running process that represents
/// a change to your Auto Scaling group, such as changing its size or replacing
/// an instance.
class Activity {
  /// The ID of the activity.
  final String activityId;

  /// The name of the Auto Scaling group.
  final String autoScalingGroupName;

  /// The reason the activity began.
  final String cause;

  /// The start time of the activity.
  final DateTime startTime;

  /// The current status of the activity.
  final ScalingActivityStatusCode statusCode;

  /// The Amazon Resource Name (ARN) of the Auto Scaling group.
  final String? autoScalingGroupARN;

  /// The state of the Auto Scaling group, which is either <code>InService</code>
  /// or <code>Deleted</code>.
  final String? autoScalingGroupState;

  /// A friendly, more verbose description of the activity.
  final String? description;

  /// The details about the activity.
  final String? details;

  /// The end time of the activity.
  final DateTime? endTime;

  /// A value between 0 and 100 that indicates the progress of the activity.
  final int? progress;

  /// A friendly, more verbose description of the activity status.
  final String? statusMessage;

  Activity({
    required this.activityId,
    required this.autoScalingGroupName,
    required this.cause,
    required this.startTime,
    required this.statusCode,
    this.autoScalingGroupARN,
    this.autoScalingGroupState,
    this.description,
    this.details,
    this.endTime,
    this.progress,
    this.statusMessage,
  });
  factory Activity.fromXml(_s.XmlElement elem) {
    return Activity(
      activityId: _s.extractXmlStringValue(elem, 'ActivityId')!,
      autoScalingGroupName:
          _s.extractXmlStringValue(elem, 'AutoScalingGroupName')!,
      cause: _s.extractXmlStringValue(elem, 'Cause')!,
      startTime: _s.extractXmlDateTimeValue(elem, 'StartTime')!,
      statusCode: _s
          .extractXmlStringValue(elem, 'StatusCode')!
          .toScalingActivityStatusCode(),
      autoScalingGroupARN:
          _s.extractXmlStringValue(elem, 'AutoScalingGroupARN'),
      autoScalingGroupState:
          _s.extractXmlStringValue(elem, 'AutoScalingGroupState'),
      description: _s.extractXmlStringValue(elem, 'Description'),
      details: _s.extractXmlStringValue(elem, 'Details'),
      endTime: _s.extractXmlDateTimeValue(elem, 'EndTime'),
      progress: _s.extractXmlIntValue(elem, 'Progress'),
      statusMessage: _s.extractXmlStringValue(elem, 'StatusMessage'),
    );
  }
}

class ActivityType {
  /// A scaling activity.
  final Activity? activity;

  ActivityType({
    this.activity,
  });
  factory ActivityType.fromXml(_s.XmlElement elem) {
    return ActivityType(
      activity:
          _s.extractXmlChild(elem, 'Activity')?.let((e) => Activity.fromXml(e)),
    );
  }
}

/// Describes a policy adjustment type.
class AdjustmentType {
  /// The policy adjustment type. The valid values are
  /// <code>ChangeInCapacity</code>, <code>ExactCapacity</code>, and
  /// <code>PercentChangeInCapacity</code>.
  final String? adjustmentType;

  AdjustmentType({
    this.adjustmentType,
  });
  factory AdjustmentType.fromXml(_s.XmlElement elem) {
    return AdjustmentType(
      adjustmentType: _s.extractXmlStringValue(elem, 'AdjustmentType'),
    );
  }
}

/// Describes an alarm.
class Alarm {
  /// The Amazon Resource Name (ARN) of the alarm.
  final String? alarmARN;

  /// The name of the alarm.
  final String? alarmName;

  Alarm({
    this.alarmARN,
    this.alarmName,
  });
  factory Alarm.fromXml(_s.XmlElement elem) {
    return Alarm(
      alarmARN: _s.extractXmlStringValue(elem, 'AlarmARN'),
      alarmName: _s.extractXmlStringValue(elem, 'AlarmName'),
    );
  }
}

class AttachLoadBalancerTargetGroupsResultType {
  AttachLoadBalancerTargetGroupsResultType();
  factory AttachLoadBalancerTargetGroupsResultType.fromXml(
      // ignore: avoid_unused_constructor_parameters
      _s.XmlElement elem) {
    return AttachLoadBalancerTargetGroupsResultType();
  }
}

class AttachLoadBalancersResultType {
  AttachLoadBalancersResultType();
  factory AttachLoadBalancersResultType.fromXml(
      // ignore: avoid_unused_constructor_parameters
      _s.XmlElement elem) {
    return AttachLoadBalancersResultType();
  }
}

/// Describes an Auto Scaling group.
class AutoScalingGroup {
  /// The name of the Auto Scaling group.
  final String autoScalingGroupName;

  /// One or more Availability Zones for the group.
  final List<String> availabilityZones;

  /// The date and time the group was created.
  final DateTime createdTime;

  /// The duration of the default cooldown period, in seconds.
  final int defaultCooldown;

  /// The desired size of the group.
  final int desiredCapacity;

  /// The service to use for the health checks. The valid values are
  /// <code>EC2</code> and <code>ELB</code>. If you configure an Auto Scaling
  /// group to use <code>ELB</code> health checks, it considers the instance
  /// unhealthy if it fails either the EC2 status checks or the load balancer
  /// health checks.
  final String healthCheckType;

  /// The maximum size of the group.
  final int maxSize;

  /// The minimum size of the group.
  final int minSize;

  /// The Amazon Resource Name (ARN) of the Auto Scaling group.
  final String? autoScalingGroupARN;

  /// Indicates whether Capacity Rebalancing is enabled.
  final bool? capacityRebalance;

  /// Reserved.
  final String? context;

  /// The duration of the default instance warmup, in seconds.
  final int? defaultInstanceWarmup;

  /// The unit of measurement for the value specified for desired capacity. Amazon
  /// EC2 Auto Scaling supports <code>DesiredCapacityType</code> for
  /// attribute-based instance type selection only.
  final String? desiredCapacityType;

  /// The metrics enabled for the group.
  final List<EnabledMetric>? enabledMetrics;

  /// The duration of the health check grace period, in seconds.
  final int? healthCheckGracePeriod;

  /// The EC2 instances associated with the group.
  final List<Instance>? instances;

  /// The name of the associated launch configuration.
  final String? launchConfigurationName;

  /// The launch template for the group.
  final LaunchTemplateSpecification? launchTemplate;

  /// One or more load balancers associated with the group.
  final List<String>? loadBalancerNames;

  /// The maximum amount of time, in seconds, that an instance can be in service.
  ///
  /// Valid Range: Minimum value of 0.
  final int? maxInstanceLifetime;

  /// The mixed instances policy for the group.
  final MixedInstancesPolicy? mixedInstancesPolicy;

  /// Indicates whether newly launched instances are protected from termination by
  /// Amazon EC2 Auto Scaling when scaling in.
  final bool? newInstancesProtectedFromScaleIn;

  /// The name of the placement group into which to launch your instances, if any.
  final String? placementGroup;

  /// The predicted capacity of the group when it has a predictive scaling policy.
  final int? predictedCapacity;

  /// The Amazon Resource Name (ARN) of the service-linked role that the Auto
  /// Scaling group uses to call other Amazon Web Services on your behalf.
  final String? serviceLinkedRoleARN;

  /// The current state of the group when the <a>DeleteAutoScalingGroup</a>
  /// operation is in progress.
  final String? status;

  /// The suspended processes associated with the group.
  final List<SuspendedProcess>? suspendedProcesses;

  /// The tags for the group.
  final List<TagDescription>? tags;

  /// The Amazon Resource Names (ARN) of the target groups for your load balancer.
  final List<String>? targetGroupARNs;

  /// The termination policies for the group.
  final List<String>? terminationPolicies;

  /// One or more subnet IDs, if applicable, separated by commas.
  final String? vPCZoneIdentifier;

  /// The warm pool for the group.
  final WarmPoolConfiguration? warmPoolConfiguration;

  /// The current size of the warm pool.
  final int? warmPoolSize;

  AutoScalingGroup({
    required this.autoScalingGroupName,
    required this.availabilityZones,
    required this.createdTime,
    required this.defaultCooldown,
    required this.desiredCapacity,
    required this.healthCheckType,
    required this.maxSize,
    required this.minSize,
    this.autoScalingGroupARN,
    this.capacityRebalance,
    this.context,
    this.defaultInstanceWarmup,
    this.desiredCapacityType,
    this.enabledMetrics,
    this.healthCheckGracePeriod,
    this.instances,
    this.launchConfigurationName,
    this.launchTemplate,
    this.loadBalancerNames,
    this.maxInstanceLifetime,
    this.mixedInstancesPolicy,
    this.newInstancesProtectedFromScaleIn,
    this.placementGroup,
    this.predictedCapacity,
    this.serviceLinkedRoleARN,
    this.status,
    this.suspendedProcesses,
    this.tags,
    this.targetGroupARNs,
    this.terminationPolicies,
    this.vPCZoneIdentifier,
    this.warmPoolConfiguration,
    this.warmPoolSize,
  });
  factory AutoScalingGroup.fromXml(_s.XmlElement elem) {
    return AutoScalingGroup(
      autoScalingGroupName:
          _s.extractXmlStringValue(elem, 'AutoScalingGroupName')!,
      availabilityZones: _s.extractXmlStringListValues(
          _s.extractXmlChild(elem, 'AvailabilityZones')!, 'member'),
      createdTime: _s.extractXmlDateTimeValue(elem, 'CreatedTime')!,
      defaultCooldown: _s.extractXmlIntValue(elem, 'DefaultCooldown')!,
      desiredCapacity: _s.extractXmlIntValue(elem, 'DesiredCapacity')!,
      healthCheckType: _s.extractXmlStringValue(elem, 'HealthCheckType')!,
      maxSize: _s.extractXmlIntValue(elem, 'MaxSize')!,
      minSize: _s.extractXmlIntValue(elem, 'MinSize')!,
      autoScalingGroupARN:
          _s.extractXmlStringValue(elem, 'AutoScalingGroupARN'),
      capacityRebalance: _s.extractXmlBoolValue(elem, 'CapacityRebalance'),
      context: _s.extractXmlStringValue(elem, 'Context'),
      defaultInstanceWarmup:
          _s.extractXmlIntValue(elem, 'DefaultInstanceWarmup'),
      desiredCapacityType:
          _s.extractXmlStringValue(elem, 'DesiredCapacityType'),
      enabledMetrics: _s.extractXmlChild(elem, 'EnabledMetrics')?.let((elem) =>
          elem
              .findElements('member')
              .map((c) => EnabledMetric.fromXml(c))
              .toList()),
      healthCheckGracePeriod:
          _s.extractXmlIntValue(elem, 'HealthCheckGracePeriod'),
      instances: _s.extractXmlChild(elem, 'Instances')?.let((elem) =>
          elem.findElements('member').map((c) => Instance.fromXml(c)).toList()),
      launchConfigurationName:
          _s.extractXmlStringValue(elem, 'LaunchConfigurationName'),
      launchTemplate: _s
          .extractXmlChild(elem, 'LaunchTemplate')
          ?.let((e) => LaunchTemplateSpecification.fromXml(e)),
      loadBalancerNames: _s
          .extractXmlChild(elem, 'LoadBalancerNames')
          ?.let((elem) => _s.extractXmlStringListValues(elem, 'member')),
      maxInstanceLifetime: _s.extractXmlIntValue(elem, 'MaxInstanceLifetime'),
      mixedInstancesPolicy: _s
          .extractXmlChild(elem, 'MixedInstancesPolicy')
          ?.let((e) => MixedInstancesPolicy.fromXml(e)),
      newInstancesProtectedFromScaleIn:
          _s.extractXmlBoolValue(elem, 'NewInstancesProtectedFromScaleIn'),
      placementGroup: _s.extractXmlStringValue(elem, 'PlacementGroup'),
      predictedCapacity: _s.extractXmlIntValue(elem, 'PredictedCapacity'),
      serviceLinkedRoleARN:
          _s.extractXmlStringValue(elem, 'ServiceLinkedRoleARN'),
      status: _s.extractXmlStringValue(elem, 'Status'),
      suspendedProcesses: _s.extractXmlChild(elem, 'SuspendedProcesses')?.let(
          (elem) => elem
              .findElements('member')
              .map((c) => SuspendedProcess.fromXml(c))
              .toList()),
      tags: _s.extractXmlChild(elem, 'Tags')?.let((elem) => elem
          .findElements('member')
          .map((c) => TagDescription.fromXml(c))
          .toList()),
      targetGroupARNs: _s
          .extractXmlChild(elem, 'TargetGroupARNs')
          ?.let((elem) => _s.extractXmlStringListValues(elem, 'member')),
      terminationPolicies: _s
          .extractXmlChild(elem, 'TerminationPolicies')
          ?.let((elem) => _s.extractXmlStringListValues(elem, 'member')),
      vPCZoneIdentifier: _s.extractXmlStringValue(elem, 'VPCZoneIdentifier'),
      warmPoolConfiguration: _s
          .extractXmlChild(elem, 'WarmPoolConfiguration')
          ?.let((e) => WarmPoolConfiguration.fromXml(e)),
      warmPoolSize: _s.extractXmlIntValue(elem, 'WarmPoolSize'),
    );
  }
}

class AutoScalingGroupsType {
  /// The groups.
  final List<AutoScalingGroup> autoScalingGroups;

  /// A string that indicates that the response contains more items than can be
  /// returned in a single response. To receive additional items, specify this
  /// string for the <code>NextToken</code> value when requesting the next set of
  /// items. This value is null when there are no more items to return.
  final String? nextToken;

  AutoScalingGroupsType({
    required this.autoScalingGroups,
    this.nextToken,
  });
  factory AutoScalingGroupsType.fromXml(_s.XmlElement elem) {
    return AutoScalingGroupsType(
      autoScalingGroups: _s
          .extractXmlChild(elem, 'AutoScalingGroups')!
          .findElements('member')
          .map((c) => AutoScalingGroup.fromXml(c))
          .toList(),
      nextToken: _s.extractXmlStringValue(elem, 'NextToken'),
    );
  }
}

/// Describes an EC2 instance associated with an Auto Scaling group.
class AutoScalingInstanceDetails {
  /// The name of the Auto Scaling group for the instance.
  final String autoScalingGroupName;

  /// The Availability Zone for the instance.
  final String availabilityZone;

  /// The last reported health status of this instance. "Healthy" means that the
  /// instance is healthy and should remain in service. "Unhealthy" means that the
  /// instance is unhealthy and Amazon EC2 Auto Scaling should terminate and
  /// replace it.
  final String healthStatus;

  /// The ID of the instance.
  final String instanceId;

  /// The lifecycle state for the instance. The <code>Quarantined</code> state is
  /// not used. For information about lifecycle states, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroupLifecycle.html">Instance
  /// lifecycle</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  ///
  /// Valid values: <code>Pending</code> | <code>Pending:Wait</code> |
  /// <code>Pending:Proceed</code> | <code>Quarantined</code> |
  /// <code>InService</code> | <code>Terminating</code> |
  /// <code>Terminating:Wait</code> | <code>Terminating:Proceed</code> |
  /// <code>Terminated</code> | <code>Detaching</code> | <code>Detached</code> |
  /// <code>EnteringStandby</code> | <code>Standby</code> |
  /// <code>Warmed:Pending</code> | <code>Warmed:Pending:Wait</code> |
  /// <code>Warmed:Pending:Proceed</code> | <code>Warmed:Terminating</code> |
  /// <code>Warmed:Terminating:Wait</code> |
  /// <code>Warmed:Terminating:Proceed</code> | <code>Warmed:Terminated</code> |
  /// <code>Warmed:Stopped</code> | <code>Warmed:Running</code>
  final String lifecycleState;

  /// Indicates whether the instance is protected from termination by Amazon EC2
  /// Auto Scaling when scaling in.
  final bool protectedFromScaleIn;

  /// The instance type of the EC2 instance.
  final String? instanceType;

  /// The launch configuration used to launch the instance. This value is not
  /// available if you attached the instance to the Auto Scaling group.
  final String? launchConfigurationName;

  /// The launch template for the instance.
  final LaunchTemplateSpecification? launchTemplate;

  /// The number of capacity units contributed by the instance based on its
  /// instance type.
  ///
  /// Valid Range: Minimum value of 1. Maximum value of 999.
  final String? weightedCapacity;

  AutoScalingInstanceDetails({
    required this.autoScalingGroupName,
    required this.availabilityZone,
    required this.healthStatus,
    required this.instanceId,
    required this.lifecycleState,
    required this.protectedFromScaleIn,
    this.instanceType,
    this.launchConfigurationName,
    this.launchTemplate,
    this.weightedCapacity,
  });
  factory AutoScalingInstanceDetails.fromXml(_s.XmlElement elem) {
    return AutoScalingInstanceDetails(
      autoScalingGroupName:
          _s.extractXmlStringValue(elem, 'AutoScalingGroupName')!,
      availabilityZone: _s.extractXmlStringValue(elem, 'AvailabilityZone')!,
      healthStatus: _s.extractXmlStringValue(elem, 'HealthStatus')!,
      instanceId: _s.extractXmlStringValue(elem, 'InstanceId')!,
      lifecycleState: _s.extractXmlStringValue(elem, 'LifecycleState')!,
      protectedFromScaleIn:
          _s.extractXmlBoolValue(elem, 'ProtectedFromScaleIn')!,
      instanceType: _s.extractXmlStringValue(elem, 'InstanceType'),
      launchConfigurationName:
          _s.extractXmlStringValue(elem, 'LaunchConfigurationName'),
      launchTemplate: _s
          .extractXmlChild(elem, 'LaunchTemplate')
          ?.let((e) => LaunchTemplateSpecification.fromXml(e)),
      weightedCapacity: _s.extractXmlStringValue(elem, 'WeightedCapacity'),
    );
  }
}

class AutoScalingInstancesType {
  /// The instances.
  final List<AutoScalingInstanceDetails>? autoScalingInstances;

  /// A string that indicates that the response contains more items than can be
  /// returned in a single response. To receive additional items, specify this
  /// string for the <code>NextToken</code> value when requesting the next set of
  /// items. This value is null when there are no more items to return.
  final String? nextToken;

  AutoScalingInstancesType({
    this.autoScalingInstances,
    this.nextToken,
  });
  factory AutoScalingInstancesType.fromXml(_s.XmlElement elem) {
    return AutoScalingInstancesType(
      autoScalingInstances: _s
          .extractXmlChild(elem, 'AutoScalingInstances')
          ?.let((elem) => elem
              .findElements('member')
              .map((c) => AutoScalingInstanceDetails.fromXml(c))
              .toList()),
      nextToken: _s.extractXmlStringValue(elem, 'NextToken'),
    );
  }
}

enum BareMetal {
  included,
  excluded,
  required,
}

extension on BareMetal {
  String toValue() {
    switch (this) {
      case BareMetal.included:
        return 'included';
      case BareMetal.excluded:
        return 'excluded';
      case BareMetal.required:
        return 'required';
    }
  }
}

extension on String {
  BareMetal toBareMetal() {
    switch (this) {
      case 'included':
        return BareMetal.included;
      case 'excluded':
        return BareMetal.excluded;
      case 'required':
        return BareMetal.required;
    }
    throw Exception('$this is not known in enum BareMetal');
  }
}

/// Specifies the minimum and maximum for the
/// <code>BaselineEbsBandwidthMbps</code> object when you specify
/// <a>InstanceRequirements</a> for an Auto Scaling group.
class BaselineEbsBandwidthMbpsRequest {
  /// The maximum value in Mbps.
  final int? max;

  /// The minimum value in Mbps.
  final int? min;

  BaselineEbsBandwidthMbpsRequest({
    this.max,
    this.min,
  });
  factory BaselineEbsBandwidthMbpsRequest.fromXml(_s.XmlElement elem) {
    return BaselineEbsBandwidthMbpsRequest(
      max: _s.extractXmlIntValue(elem, 'Max'),
      min: _s.extractXmlIntValue(elem, 'Min'),
    );
  }

  Map<String, dynamic> toJson() {
    final max = this.max;
    final min = this.min;
    return {
      if (max != null) 'Max': max,
      if (min != null) 'Min': min,
    };
  }
}

class BatchDeleteScheduledActionAnswer {
  /// The names of the scheduled actions that could not be deleted, including an
  /// error message.
  final List<FailedScheduledUpdateGroupActionRequest>? failedScheduledActions;

  BatchDeleteScheduledActionAnswer({
    this.failedScheduledActions,
  });
  factory BatchDeleteScheduledActionAnswer.fromXml(_s.XmlElement elem) {
    return BatchDeleteScheduledActionAnswer(
      failedScheduledActions: _s
          .extractXmlChild(elem, 'FailedScheduledActions')
          ?.let((elem) => elem
              .findElements('member')
              .map((c) => FailedScheduledUpdateGroupActionRequest.fromXml(c))
              .toList()),
    );
  }
}

class BatchPutScheduledUpdateGroupActionAnswer {
  /// The names of the scheduled actions that could not be created or updated,
  /// including an error message.
  final List<FailedScheduledUpdateGroupActionRequest>?
      failedScheduledUpdateGroupActions;

  BatchPutScheduledUpdateGroupActionAnswer({
    this.failedScheduledUpdateGroupActions,
  });
  factory BatchPutScheduledUpdateGroupActionAnswer.fromXml(_s.XmlElement elem) {
    return BatchPutScheduledUpdateGroupActionAnswer(
      failedScheduledUpdateGroupActions: _s
          .extractXmlChild(elem, 'FailedScheduledUpdateGroupActions')
          ?.let((elem) => elem
              .findElements('member')
              .map((c) => FailedScheduledUpdateGroupActionRequest.fromXml(c))
              .toList()),
    );
  }
}

/// Describes a block device mapping.
class BlockDeviceMapping {
  /// The device name assigned to the volume (for example, <code>/dev/sdh</code>
  /// or <code>xvdh</code>). For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html">Device
  /// naming on Linux instances</a> in the <i>Amazon EC2 User Guide for Linux
  /// Instances</i>.
  /// <note>
  /// To define a block device mapping, set the device name and exactly one of the
  /// following properties: <code>Ebs</code>, <code>NoDevice</code>, or
  /// <code>VirtualName</code>.
  /// </note>
  final String deviceName;

  /// Information to attach an EBS volume to an instance at launch.
  final Ebs? ebs;

  /// Setting this value to <code>true</code> prevents a volume that is included
  /// in the block device mapping of the AMI from being mapped to the specified
  /// device name at launch.
  ///
  /// If <code>NoDevice</code> is <code>true</code> for the root device, instances
  /// might fail the EC2 health check. In that case, Amazon EC2 Auto Scaling
  /// launches replacement instances.
  final bool? noDevice;

  /// The name of the instance store volume (virtual device) to attach to an
  /// instance at launch. The name must be in the form ephemeral<i>X</i> where
  /// <i>X</i> is a number starting from zero (0), for example,
  /// <code>ephemeral0</code>.
  final String? virtualName;

  BlockDeviceMapping({
    required this.deviceName,
    this.ebs,
    this.noDevice,
    this.virtualName,
  });
  factory BlockDeviceMapping.fromXml(_s.XmlElement elem) {
    return BlockDeviceMapping(
      deviceName: _s.extractXmlStringValue(elem, 'DeviceName')!,
      ebs: _s.extractXmlChild(elem, 'Ebs')?.let((e) => Ebs.fromXml(e)),
      noDevice: _s.extractXmlBoolValue(elem, 'NoDevice'),
      virtualName: _s.extractXmlStringValue(elem, 'VirtualName'),
    );
  }

  Map<String, dynamic> toJson() {
    final deviceName = this.deviceName;
    final ebs = this.ebs;
    final noDevice = this.noDevice;
    final virtualName = this.virtualName;
    return {
      'DeviceName': deviceName,
      if (ebs != null) 'Ebs': ebs,
      if (noDevice != null) 'NoDevice': noDevice,
      if (virtualName != null) 'VirtualName': virtualName,
    };
  }
}

enum BurstablePerformance {
  included,
  excluded,
  required,
}

extension on BurstablePerformance {
  String toValue() {
    switch (this) {
      case BurstablePerformance.included:
        return 'included';
      case BurstablePerformance.excluded:
        return 'excluded';
      case BurstablePerformance.required:
        return 'required';
    }
  }
}

extension on String {
  BurstablePerformance toBurstablePerformance() {
    switch (this) {
      case 'included':
        return BurstablePerformance.included;
      case 'excluded':
        return BurstablePerformance.excluded;
      case 'required':
        return BurstablePerformance.required;
    }
    throw Exception('$this is not known in enum BurstablePerformance');
  }
}

class CancelInstanceRefreshAnswer {
  /// The instance refresh ID.
  final String? instanceRefreshId;

  CancelInstanceRefreshAnswer({
    this.instanceRefreshId,
  });
  factory CancelInstanceRefreshAnswer.fromXml(_s.XmlElement elem) {
    return CancelInstanceRefreshAnswer(
      instanceRefreshId: _s.extractXmlStringValue(elem, 'InstanceRefreshId'),
    );
  }
}

/// A <code>GetPredictiveScalingForecast</code> call returns the capacity
/// forecast for a predictive scaling policy. This structure includes the data
/// points for that capacity forecast, along with the timestamps of those data
/// points.
class CapacityForecast {
  /// The timestamps for the data points, in UTC format.
  final List<DateTime> timestamps;

  /// The values of the data points.
  final List<double> values;

  CapacityForecast({
    required this.timestamps,
    required this.values,
  });
  factory CapacityForecast.fromXml(_s.XmlElement elem) {
    return CapacityForecast(
      timestamps: _s.extractXmlDateTimeListValues(
          _s.extractXmlChild(elem, 'Timestamps')!, 'member'),
      values: _s.extractXmlDoubleListValues(
          _s.extractXmlChild(elem, 'Values')!, 'member'),
    );
  }
}

class CompleteLifecycleActionAnswer {
  CompleteLifecycleActionAnswer();
  factory CompleteLifecycleActionAnswer.fromXml(
      // ignore: avoid_unused_constructor_parameters
      _s.XmlElement elem) {
    return CompleteLifecycleActionAnswer();
  }
}

enum CpuManufacturer {
  intel,
  amd,
  amazonWebServices,
}

extension on CpuManufacturer {
  String toValue() {
    switch (this) {
      case CpuManufacturer.intel:
        return 'intel';
      case CpuManufacturer.amd:
        return 'amd';
      case CpuManufacturer.amazonWebServices:
        return 'amazon-web-services';
    }
  }
}

extension on String {
  CpuManufacturer toCpuManufacturer() {
    switch (this) {
      case 'intel':
        return CpuManufacturer.intel;
      case 'amd':
        return CpuManufacturer.amd;
      case 'amazon-web-services':
        return CpuManufacturer.amazonWebServices;
    }
    throw Exception('$this is not known in enum CpuManufacturer');
  }
}

/// Represents a CloudWatch metric of your choosing for a target tracking
/// scaling policy to use with Amazon EC2 Auto Scaling.
///
/// To create your customized metric specification:
///
/// <ul>
/// <li>
/// Add values for each required property from CloudWatch. You can use an
/// existing metric, or a new metric that you create. To use your own metric,
/// you must first publish the metric to CloudWatch. For more information, see
/// <a
/// href="https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/publishingMetrics.html">Publish
/// custom metrics</a> in the <i>Amazon CloudWatch User Guide</i>.
/// </li>
/// <li>
/// Choose a metric that changes proportionally with capacity. The value of the
/// metric should increase or decrease in inverse proportion to the number of
/// capacity units. That is, the value of the metric should decrease when
/// capacity increases.
/// </li>
/// </ul>
/// For more information about the CloudWatch terminology below, see <a
/// href="https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html">Amazon
/// CloudWatch concepts</a>.
/// <note>
/// Each individual service provides information about the metrics, namespace,
/// and dimensions they use. For more information, see <a
/// href="https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html">Amazon
/// Web Services services that publish CloudWatch metrics</a> in the <i>Amazon
/// CloudWatch User Guide</i>.
/// </note>
class CustomizedMetricSpecification {
  /// The name of the metric. To get the exact metric name, namespace, and
  /// dimensions, inspect the <a
  /// href="https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_Metric.html">Metric</a>
  /// object that is returned by a call to <a
  /// href="https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_ListMetrics.html">ListMetrics</a>.
  final String metricName;

  /// The namespace of the metric.
  final String namespace;

  /// The statistic of the metric.
  final MetricStatistic statistic;

  /// The dimensions of the metric.
  ///
  /// Conditional: If you published your metric with dimensions, you must specify
  /// the same dimensions in your scaling policy.
  final List<MetricDimension>? dimensions;

  /// The unit of the metric. For a complete list of the units that CloudWatch
  /// supports, see the <a
  /// href="https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_MetricDatum.html">MetricDatum</a>
  /// data type in the <i>Amazon CloudWatch API Reference</i>.
  final String? unit;

  CustomizedMetricSpecification({
    required this.metricName,
    required this.namespace,
    required this.statistic,
    this.dimensions,
    this.unit,
  });
  factory CustomizedMetricSpecification.fromXml(_s.XmlElement elem) {
    return CustomizedMetricSpecification(
      metricName: _s.extractXmlStringValue(elem, 'MetricName')!,
      namespace: _s.extractXmlStringValue(elem, 'Namespace')!,
      statistic:
          _s.extractXmlStringValue(elem, 'Statistic')!.toMetricStatistic(),
      dimensions: _s.extractXmlChild(elem, 'Dimensions')?.let((elem) => elem
          .findElements('member')
          .map((c) => MetricDimension.fromXml(c))
          .toList()),
      unit: _s.extractXmlStringValue(elem, 'Unit'),
    );
  }

  Map<String, dynamic> toJson() {
    final metricName = this.metricName;
    final namespace = this.namespace;
    final statistic = this.statistic;
    final dimensions = this.dimensions;
    final unit = this.unit;
    return {
      'MetricName': metricName,
      'Namespace': namespace,
      'Statistic': statistic.toValue(),
      if (dimensions != null) 'Dimensions': dimensions,
      if (unit != null) 'Unit': unit,
    };
  }
}

class DeleteLifecycleHookAnswer {
  DeleteLifecycleHookAnswer();
  factory DeleteLifecycleHookAnswer.fromXml(
      // ignore: avoid_unused_constructor_parameters
      _s.XmlElement elem) {
    return DeleteLifecycleHookAnswer();
  }
}

class DeleteWarmPoolAnswer {
  DeleteWarmPoolAnswer();
  factory DeleteWarmPoolAnswer.fromXml(
      // ignore: avoid_unused_constructor_parameters
      _s.XmlElement elem) {
    return DeleteWarmPoolAnswer();
  }
}

class DescribeAccountLimitsAnswer {
  /// The maximum number of groups allowed for your account. The default is 200
  /// groups per Region.
  final int? maxNumberOfAutoScalingGroups;

  /// The maximum number of launch configurations allowed for your account. The
  /// default is 200 launch configurations per Region.
  final int? maxNumberOfLaunchConfigurations;

  /// The current number of groups for your account.
  final int? numberOfAutoScalingGroups;

  /// The current number of launch configurations for your account.
  final int? numberOfLaunchConfigurations;

  DescribeAccountLimitsAnswer({
    this.maxNumberOfAutoScalingGroups,
    this.maxNumberOfLaunchConfigurations,
    this.numberOfAutoScalingGroups,
    this.numberOfLaunchConfigurations,
  });
  factory DescribeAccountLimitsAnswer.fromXml(_s.XmlElement elem) {
    return DescribeAccountLimitsAnswer(
      maxNumberOfAutoScalingGroups:
          _s.extractXmlIntValue(elem, 'MaxNumberOfAutoScalingGroups'),
      maxNumberOfLaunchConfigurations:
          _s.extractXmlIntValue(elem, 'MaxNumberOfLaunchConfigurations'),
      numberOfAutoScalingGroups:
          _s.extractXmlIntValue(elem, 'NumberOfAutoScalingGroups'),
      numberOfLaunchConfigurations:
          _s.extractXmlIntValue(elem, 'NumberOfLaunchConfigurations'),
    );
  }
}

class DescribeAdjustmentTypesAnswer {
  /// The policy adjustment types.
  final List<AdjustmentType>? adjustmentTypes;

  DescribeAdjustmentTypesAnswer({
    this.adjustmentTypes,
  });
  factory DescribeAdjustmentTypesAnswer.fromXml(_s.XmlElement elem) {
    return DescribeAdjustmentTypesAnswer(
      adjustmentTypes: _s.extractXmlChild(elem, 'AdjustmentTypes')?.let(
          (elem) => elem
              .findElements('member')
              .map((c) => AdjustmentType.fromXml(c))
              .toList()),
    );
  }
}

class DescribeAutoScalingNotificationTypesAnswer {
  /// The notification types.
  final List<String>? autoScalingNotificationTypes;

  DescribeAutoScalingNotificationTypesAnswer({
    this.autoScalingNotificationTypes,
  });
  factory DescribeAutoScalingNotificationTypesAnswer.fromXml(
      _s.XmlElement elem) {
    return DescribeAutoScalingNotificationTypesAnswer(
      autoScalingNotificationTypes: _s
          .extractXmlChild(elem, 'AutoScalingNotificationTypes')
          ?.let((elem) => _s.extractXmlStringListValues(elem, 'member')),
    );
  }
}

class DescribeInstanceRefreshesAnswer {
  /// The instance refreshes for the specified group, sorted by creation timestamp
  /// in descending order.
  final List<InstanceRefresh>? instanceRefreshes;

  /// A string that indicates that the response contains more items than can be
  /// returned in a single response. To receive additional items, specify this
  /// string for the <code>NextToken</code> value when requesting the next set of
  /// items. This value is null when there are no more items to return.
  final String? nextToken;

  DescribeInstanceRefreshesAnswer({
    this.instanceRefreshes,
    this.nextToken,
  });
  factory DescribeInstanceRefreshesAnswer.fromXml(_s.XmlElement elem) {
    return DescribeInstanceRefreshesAnswer(
      instanceRefreshes: _s.extractXmlChild(elem, 'InstanceRefreshes')?.let(
          (elem) => elem
              .findElements('member')
              .map((c) => InstanceRefresh.fromXml(c))
              .toList()),
      nextToken: _s.extractXmlStringValue(elem, 'NextToken'),
    );
  }
}

class DescribeLifecycleHookTypesAnswer {
  /// The lifecycle hook types.
  final List<String>? lifecycleHookTypes;

  DescribeLifecycleHookTypesAnswer({
    this.lifecycleHookTypes,
  });
  factory DescribeLifecycleHookTypesAnswer.fromXml(_s.XmlElement elem) {
    return DescribeLifecycleHookTypesAnswer(
      lifecycleHookTypes: _s
          .extractXmlChild(elem, 'LifecycleHookTypes')
          ?.let((elem) => _s.extractXmlStringListValues(elem, 'member')),
    );
  }
}

class DescribeLifecycleHooksAnswer {
  /// The lifecycle hooks for the specified group.
  final List<LifecycleHook>? lifecycleHooks;

  DescribeLifecycleHooksAnswer({
    this.lifecycleHooks,
  });
  factory DescribeLifecycleHooksAnswer.fromXml(_s.XmlElement elem) {
    return DescribeLifecycleHooksAnswer(
      lifecycleHooks: _s.extractXmlChild(elem, 'LifecycleHooks')?.let((elem) =>
          elem
              .findElements('member')
              .map((c) => LifecycleHook.fromXml(c))
              .toList()),
    );
  }
}

class DescribeLoadBalancerTargetGroupsResponse {
  /// Information about the target groups.
  final List<LoadBalancerTargetGroupState>? loadBalancerTargetGroups;

  /// A string that indicates that the response contains more items than can be
  /// returned in a single response. To receive additional items, specify this
  /// string for the <code>NextToken</code> value when requesting the next set of
  /// items. This value is null when there are no more items to return.
  final String? nextToken;

  DescribeLoadBalancerTargetGroupsResponse({
    this.loadBalancerTargetGroups,
    this.nextToken,
  });
  factory DescribeLoadBalancerTargetGroupsResponse.fromXml(_s.XmlElement elem) {
    return DescribeLoadBalancerTargetGroupsResponse(
      loadBalancerTargetGroups: _s
          .extractXmlChild(elem, 'LoadBalancerTargetGroups')
          ?.let((elem) => elem
              .findElements('member')
              .map((c) => LoadBalancerTargetGroupState.fromXml(c))
              .toList()),
      nextToken: _s.extractXmlStringValue(elem, 'NextToken'),
    );
  }
}

class DescribeLoadBalancersResponse {
  /// The load balancers.
  final List<LoadBalancerState>? loadBalancers;

  /// A string that indicates that the response contains more items than can be
  /// returned in a single response. To receive additional items, specify this
  /// string for the <code>NextToken</code> value when requesting the next set of
  /// items. This value is null when there are no more items to return.
  final String? nextToken;

  DescribeLoadBalancersResponse({
    this.loadBalancers,
    this.nextToken,
  });
  factory DescribeLoadBalancersResponse.fromXml(_s.XmlElement elem) {
    return DescribeLoadBalancersResponse(
      loadBalancers: _s.extractXmlChild(elem, 'LoadBalancers')?.let((elem) =>
          elem
              .findElements('member')
              .map((c) => LoadBalancerState.fromXml(c))
              .toList()),
      nextToken: _s.extractXmlStringValue(elem, 'NextToken'),
    );
  }
}

class DescribeMetricCollectionTypesAnswer {
  /// The granularities for the metrics.
  final List<MetricGranularityType>? granularities;

  /// The metrics.
  final List<MetricCollectionType>? metrics;

  DescribeMetricCollectionTypesAnswer({
    this.granularities,
    this.metrics,
  });
  factory DescribeMetricCollectionTypesAnswer.fromXml(_s.XmlElement elem) {
    return DescribeMetricCollectionTypesAnswer(
      granularities: _s.extractXmlChild(elem, 'Granularities')?.let((elem) =>
          elem
              .findElements('member')
              .map((c) => MetricGranularityType.fromXml(c))
              .toList()),
      metrics: _s.extractXmlChild(elem, 'Metrics')?.let((elem) => elem
          .findElements('member')
          .map((c) => MetricCollectionType.fromXml(c))
          .toList()),
    );
  }
}

class DescribeNotificationConfigurationsAnswer {
  /// The notification configurations.
  final List<NotificationConfiguration> notificationConfigurations;

  /// A string that indicates that the response contains more items than can be
  /// returned in a single response. To receive additional items, specify this
  /// string for the <code>NextToken</code> value when requesting the next set of
  /// items. This value is null when there are no more items to return.
  final String? nextToken;

  DescribeNotificationConfigurationsAnswer({
    required this.notificationConfigurations,
    this.nextToken,
  });
  factory DescribeNotificationConfigurationsAnswer.fromXml(_s.XmlElement elem) {
    return DescribeNotificationConfigurationsAnswer(
      notificationConfigurations: _s
          .extractXmlChild(elem, 'NotificationConfigurations')!
          .findElements('member')
          .map((c) => NotificationConfiguration.fromXml(c))
          .toList(),
      nextToken: _s.extractXmlStringValue(elem, 'NextToken'),
    );
  }
}

class DescribeTerminationPolicyTypesAnswer {
  /// The termination policies supported by Amazon EC2 Auto Scaling:
  /// <code>OldestInstance</code>, <code>OldestLaunchConfiguration</code>,
  /// <code>NewestInstance</code>, <code>ClosestToNextInstanceHour</code>,
  /// <code>Default</code>, <code>OldestLaunchTemplate</code>, and
  /// <code>AllocationStrategy</code>.
  final List<String>? terminationPolicyTypes;

  DescribeTerminationPolicyTypesAnswer({
    this.terminationPolicyTypes,
  });
  factory DescribeTerminationPolicyTypesAnswer.fromXml(_s.XmlElement elem) {
    return DescribeTerminationPolicyTypesAnswer(
      terminationPolicyTypes: _s
          .extractXmlChild(elem, 'TerminationPolicyTypes')
          ?.let((elem) => _s.extractXmlStringListValues(elem, 'member')),
    );
  }
}

class DescribeWarmPoolAnswer {
  /// The instances that are currently in the warm pool.
  final List<Instance>? instances;

  /// The token for the next set of items to return. (You received this token from
  /// a previous call.)
  final String? nextToken;

  /// The warm pool configuration details.
  final WarmPoolConfiguration? warmPoolConfiguration;

  DescribeWarmPoolAnswer({
    this.instances,
    this.nextToken,
    this.warmPoolConfiguration,
  });
  factory DescribeWarmPoolAnswer.fromXml(_s.XmlElement elem) {
    return DescribeWarmPoolAnswer(
      instances: _s.extractXmlChild(elem, 'Instances')?.let((elem) =>
          elem.findElements('member').map((c) => Instance.fromXml(c)).toList()),
      nextToken: _s.extractXmlStringValue(elem, 'NextToken'),
      warmPoolConfiguration: _s
          .extractXmlChild(elem, 'WarmPoolConfiguration')
          ?.let((e) => WarmPoolConfiguration.fromXml(e)),
    );
  }
}

/// Describes the desired configuration for an instance refresh.
///
/// If you specify a desired configuration, you must specify either a
/// <code>LaunchTemplate</code> or a <code>MixedInstancesPolicy</code>.
class DesiredConfiguration {
  final LaunchTemplateSpecification? launchTemplate;
  final MixedInstancesPolicy? mixedInstancesPolicy;

  DesiredConfiguration({
    this.launchTemplate,
    this.mixedInstancesPolicy,
  });
  factory DesiredConfiguration.fromXml(_s.XmlElement elem) {
    return DesiredConfiguration(
      launchTemplate: _s
          .extractXmlChild(elem, 'LaunchTemplate')
          ?.let((e) => LaunchTemplateSpecification.fromXml(e)),
      mixedInstancesPolicy: _s
          .extractXmlChild(elem, 'MixedInstancesPolicy')
          ?.let((e) => MixedInstancesPolicy.fromXml(e)),
    );
  }

  Map<String, dynamic> toJson() {
    final launchTemplate = this.launchTemplate;
    final mixedInstancesPolicy = this.mixedInstancesPolicy;
    return {
      if (launchTemplate != null) 'LaunchTemplate': launchTemplate,
      if (mixedInstancesPolicy != null)
        'MixedInstancesPolicy': mixedInstancesPolicy,
    };
  }
}

class DetachInstancesAnswer {
  /// The activities related to detaching the instances from the Auto Scaling
  /// group.
  final List<Activity>? activities;

  DetachInstancesAnswer({
    this.activities,
  });
  factory DetachInstancesAnswer.fromXml(_s.XmlElement elem) {
    return DetachInstancesAnswer(
      activities: _s.extractXmlChild(elem, 'Activities')?.let((elem) =>
          elem.findElements('member').map((c) => Activity.fromXml(c)).toList()),
    );
  }
}

class DetachLoadBalancerTargetGroupsResultType {
  DetachLoadBalancerTargetGroupsResultType();
  factory DetachLoadBalancerTargetGroupsResultType.fromXml(
      // ignore: avoid_unused_constructor_parameters
      _s.XmlElement elem) {
    return DetachLoadBalancerTargetGroupsResultType();
  }
}

class DetachLoadBalancersResultType {
  DetachLoadBalancersResultType();
  factory DetachLoadBalancersResultType.fromXml(
      // ignore: avoid_unused_constructor_parameters
      _s.XmlElement elem) {
    return DetachLoadBalancersResultType();
  }
}

/// Describes information used to set up an Amazon EBS volume specified in a
/// block device mapping.
class Ebs {
  /// Indicates whether the volume is deleted on instance termination. For Amazon
  /// EC2 Auto Scaling, the default value is <code>true</code>.
  final bool? deleteOnTermination;

  /// Specifies whether the volume should be encrypted. Encrypted EBS volumes can
  /// only be attached to instances that support Amazon EBS encryption. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html#EBSEncryption_supported_instances">Supported
  /// instance types</a>. If your AMI uses encrypted volumes, you can also only
  /// launch it on supported instance types.
  /// <note>
  /// If you are creating a volume from a snapshot, you cannot create an
  /// unencrypted volume from an encrypted snapshot. Also, you cannot specify a
  /// KMS key ID when using a launch configuration.
  ///
  /// If you enable encryption by default, the EBS volumes that you create are
  /// always encrypted, either using the Amazon Web Services managed KMS key or a
  /// customer-managed KMS key, regardless of whether the snapshot was encrypted.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-data-protection.html#encryption">Use
  /// Amazon Web Services KMS keys to encrypt Amazon EBS volumes</a> in the
  /// <i>Amazon EC2 Auto Scaling User Guide</i>.
  /// </note>
  final bool? encrypted;

  /// The number of input/output (I/O) operations per second (IOPS) to provision
  /// for the volume. For <code>gp3</code> and <code>io1</code> volumes, this
  /// represents the number of IOPS that are provisioned for the volume. For
  /// <code>gp2</code> volumes, this represents the baseline performance of the
  /// volume and the rate at which the volume accumulates I/O credits for
  /// bursting.
  ///
  /// The following are the supported values for each volume type:
  ///
  /// <ul>
  /// <li>
  /// <code>gp3</code>: 3,000-16,000 IOPS
  /// </li>
  /// <li>
  /// <code>io1</code>: 100-64,000 IOPS
  /// </li>
  /// </ul>
  /// For <code>io1</code> volumes, we guarantee 64,000 IOPS only for <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#ec2-nitro-instances">Instances
  /// built on the Nitro System</a>. Other instance families guarantee performance
  /// up to 32,000 IOPS.
  ///
  /// <code>Iops</code> is supported when the volume type is <code>gp3</code> or
  /// <code>io1</code> and required only when the volume type is <code>io1</code>.
  /// (Not used with <code>standard</code>, <code>gp2</code>, <code>st1</code>, or
  /// <code>sc1</code> volumes.)
  final int? iops;

  /// The snapshot ID of the volume to use.
  ///
  /// You must specify either a <code>VolumeSize</code> or a
  /// <code>SnapshotId</code>.
  final String? snapshotId;

  /// The throughput (MiBps) to provision for a <code>gp3</code> volume.
  final int? throughput;

  /// The volume size, in GiBs. The following are the supported volumes sizes for
  /// each volume type:
  ///
  /// <ul>
  /// <li>
  /// <code>gp2</code> and <code>gp3</code>: 1-16,384
  /// </li>
  /// <li>
  /// <code>io1</code>: 4-16,384
  /// </li>
  /// <li>
  /// <code>st1</code> and <code>sc1</code>: 125-16,384
  /// </li>
  /// <li>
  /// <code>standard</code>: 1-1,024
  /// </li>
  /// </ul>
  /// You must specify either a <code>SnapshotId</code> or a
  /// <code>VolumeSize</code>. If you specify both <code>SnapshotId</code> and
  /// <code>VolumeSize</code>, the volume size must be equal or greater than the
  /// size of the snapshot.
  final int? volumeSize;

  /// The volume type. For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html">Amazon
  /// EBS volume types</a> in the <i>Amazon EC2 User Guide for Linux
  /// Instances</i>.
  ///
  /// Valid values: <code>standard</code> | <code>io1</code> | <code>gp2</code> |
  /// <code>st1</code> | <code>sc1</code> | <code>gp3</code>
  final String? volumeType;

  Ebs({
    this.deleteOnTermination,
    this.encrypted,
    this.iops,
    this.snapshotId,
    this.throughput,
    this.volumeSize,
    this.volumeType,
  });
  factory Ebs.fromXml(_s.XmlElement elem) {
    return Ebs(
      deleteOnTermination: _s.extractXmlBoolValue(elem, 'DeleteOnTermination'),
      encrypted: _s.extractXmlBoolValue(elem, 'Encrypted'),
      iops: _s.extractXmlIntValue(elem, 'Iops'),
      snapshotId: _s.extractXmlStringValue(elem, 'SnapshotId'),
      throughput: _s.extractXmlIntValue(elem, 'Throughput'),
      volumeSize: _s.extractXmlIntValue(elem, 'VolumeSize'),
      volumeType: _s.extractXmlStringValue(elem, 'VolumeType'),
    );
  }

  Map<String, dynamic> toJson() {
    final deleteOnTermination = this.deleteOnTermination;
    final encrypted = this.encrypted;
    final iops = this.iops;
    final snapshotId = this.snapshotId;
    final throughput = this.throughput;
    final volumeSize = this.volumeSize;
    final volumeType = this.volumeType;
    return {
      if (deleteOnTermination != null)
        'DeleteOnTermination': deleteOnTermination,
      if (encrypted != null) 'Encrypted': encrypted,
      if (iops != null) 'Iops': iops,
      if (snapshotId != null) 'SnapshotId': snapshotId,
      if (throughput != null) 'Throughput': throughput,
      if (volumeSize != null) 'VolumeSize': volumeSize,
      if (volumeType != null) 'VolumeType': volumeType,
    };
  }
}

/// Describes an enabled Auto Scaling group metric.
class EnabledMetric {
  /// The granularity of the metric. The only valid value is <code>1Minute</code>.
  final String? granularity;

  /// One of the following metrics:
  ///
  /// <ul>
  /// <li>
  /// <code>GroupMinSize</code>
  /// </li>
  /// <li>
  /// <code>GroupMaxSize</code>
  /// </li>
  /// <li>
  /// <code>GroupDesiredCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupInServiceInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupPendingInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupStandbyInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupTerminatingInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupTotalInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupInServiceCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupPendingCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupStandbyCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupTerminatingCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupTotalCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolDesiredCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolWarmedCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolPendingCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolTerminatingCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolTotalCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupAndWarmPoolDesiredCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupAndWarmPoolTotalCapacity</code>
  /// </li>
  /// </ul>
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-cloudwatch-monitoring.html#as-group-metrics">Auto
  /// Scaling group metrics</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  final String? metric;

  EnabledMetric({
    this.granularity,
    this.metric,
  });
  factory EnabledMetric.fromXml(_s.XmlElement elem) {
    return EnabledMetric(
      granularity: _s.extractXmlStringValue(elem, 'Granularity'),
      metric: _s.extractXmlStringValue(elem, 'Metric'),
    );
  }
}

class EnterStandbyAnswer {
  /// The activities related to moving instances into <code>Standby</code> mode.
  final List<Activity>? activities;

  EnterStandbyAnswer({
    this.activities,
  });
  factory EnterStandbyAnswer.fromXml(_s.XmlElement elem) {
    return EnterStandbyAnswer(
      activities: _s.extractXmlChild(elem, 'Activities')?.let((elem) =>
          elem.findElements('member').map((c) => Activity.fromXml(c)).toList()),
    );
  }
}

class ExitStandbyAnswer {
  /// The activities related to moving instances out of <code>Standby</code> mode.
  final List<Activity>? activities;

  ExitStandbyAnswer({
    this.activities,
  });
  factory ExitStandbyAnswer.fromXml(_s.XmlElement elem) {
    return ExitStandbyAnswer(
      activities: _s.extractXmlChild(elem, 'Activities')?.let((elem) =>
          elem.findElements('member').map((c) => Activity.fromXml(c)).toList()),
    );
  }
}

/// Describes a scheduled action that could not be created, updated, or deleted.
class FailedScheduledUpdateGroupActionRequest {
  /// The name of the scheduled action.
  final String scheduledActionName;

  /// The error code.
  final String? errorCode;

  /// The error message accompanying the error code.
  final String? errorMessage;

  FailedScheduledUpdateGroupActionRequest({
    required this.scheduledActionName,
    this.errorCode,
    this.errorMessage,
  });
  factory FailedScheduledUpdateGroupActionRequest.fromXml(_s.XmlElement elem) {
    return FailedScheduledUpdateGroupActionRequest(
      scheduledActionName:
          _s.extractXmlStringValue(elem, 'ScheduledActionName')!,
      errorCode: _s.extractXmlStringValue(elem, 'ErrorCode'),
      errorMessage: _s.extractXmlStringValue(elem, 'ErrorMessage'),
    );
  }
}

/// Describes a filter that is used to return a more specific list of results
/// from a describe operation.
///
/// If you specify multiple filters, the filters are automatically logically
/// joined with an <code>AND</code>, and the request returns only the results
/// that match all of the specified filters.
///
/// For more information, see <a
/// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-tagging.html">Tag
/// Auto Scaling groups and instances</a> in the <i>Amazon EC2 Auto Scaling User
/// Guide</i>.
class Filter {
  /// The name of the filter.
  ///
  /// The valid values for <code>Name</code> depend on which API operation you're
  /// using with the filter (<a>DescribeAutoScalingGroups</a> or
  /// <a>DescribeTags</a>).
  ///
  /// <b>DescribeAutoScalingGroups</b>
  ///
  /// Valid values for <code>Name</code> include the following:
  ///
  /// <ul>
  /// <li>
  /// <code>tag-key</code> - Accepts tag keys. The results only include
  /// information about the Auto Scaling groups associated with these tag keys.
  /// </li>
  /// <li>
  /// <code>tag-value</code> - Accepts tag values. The results only include
  /// information about the Auto Scaling groups associated with these tag values.
  /// </li>
  /// <li>
  /// <code>tag:&lt;key&gt;</code> - Accepts the key/value combination of the tag.
  /// Use the tag key in the filter name and the tag value as the filter value.
  /// The results only include information about the Auto Scaling groups
  /// associated with the specified key/value combination.
  /// </li>
  /// </ul>
  /// <b>DescribeTags</b>
  ///
  /// Valid values for <code>Name</code> include the following:
  ///
  /// <ul>
  /// <li>
  /// <code>auto-scaling-group</code> - Accepts the names of Auto Scaling groups.
  /// The results only include information about the tags associated with these
  /// Auto Scaling groups.
  /// </li>
  /// <li>
  /// <code>key</code> - Accepts tag keys. The results only include information
  /// about the tags associated with these tag keys.
  /// </li>
  /// <li>
  /// <code>value</code> - Accepts tag values. The results only include
  /// information about the tags associated with these tag values.
  /// </li>
  /// <li>
  /// <code>propagate-at-launch</code> - Accepts a Boolean value, which specifies
  /// whether tags propagate to instances at launch. The results only include
  /// information about the tags associated with the specified Boolean value.
  /// </li>
  /// </ul>
  final String? name;

  /// One or more filter values. Filter values are case-sensitive.
  ///
  /// If you specify multiple values for a filter, the values are automatically
  /// logically joined with an <code>OR</code>, and the request returns all
  /// results that match any of the specified values. For example, specify
  /// "tag:environment" for the filter name and "production,development" for the
  /// filter values to find Auto Scaling groups with the tag
  /// "environment=production" or "environment=development".
  final List<String>? values;

  Filter({
    this.name,
    this.values,
  });
  Map<String, dynamic> toJson() {
    final name = this.name;
    final values = this.values;
    return {
      if (name != null) 'Name': name,
      if (values != null) 'Values': values,
    };
  }
}

class GetPredictiveScalingForecastAnswer {
  /// The capacity forecast.
  final CapacityForecast capacityForecast;

  /// The load forecast.
  final List<LoadForecast> loadForecast;

  /// The time the forecast was made.
  final DateTime updateTime;

  GetPredictiveScalingForecastAnswer({
    required this.capacityForecast,
    required this.loadForecast,
    required this.updateTime,
  });
  factory GetPredictiveScalingForecastAnswer.fromXml(_s.XmlElement elem) {
    return GetPredictiveScalingForecastAnswer(
      capacityForecast: CapacityForecast.fromXml(
          _s.extractXmlChild(elem, 'CapacityForecast')!),
      loadForecast: _s
          .extractXmlChild(elem, 'LoadForecast')!
          .findElements('member')
          .map((c) => LoadForecast.fromXml(c))
          .toList(),
      updateTime: _s.extractXmlDateTimeValue(elem, 'UpdateTime')!,
    );
  }
}

/// Describes an EC2 instance.
class Instance {
  /// The Availability Zone in which the instance is running.
  final String availabilityZone;

  /// The last reported health status of the instance. "Healthy" means that the
  /// instance is healthy and should remain in service. "Unhealthy" means that the
  /// instance is unhealthy and that Amazon EC2 Auto Scaling should terminate and
  /// replace it.
  final String healthStatus;

  /// The ID of the instance.
  final String instanceId;

  /// A description of the current lifecycle state. The <code>Quarantined</code>
  /// state is not used. For information about lifecycle states, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroupLifecycle.html">Instance
  /// lifecycle</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  final LifecycleState lifecycleState;

  /// Indicates whether the instance is protected from termination by Amazon EC2
  /// Auto Scaling when scaling in.
  final bool protectedFromScaleIn;

  /// The instance type of the EC2 instance.
  final String? instanceType;

  /// The launch configuration associated with the instance.
  final String? launchConfigurationName;

  /// The launch template for the instance.
  final LaunchTemplateSpecification? launchTemplate;

  /// The number of capacity units contributed by the instance based on its
  /// instance type.
  ///
  /// Valid Range: Minimum value of 1. Maximum value of 999.
  final String? weightedCapacity;

  Instance({
    required this.availabilityZone,
    required this.healthStatus,
    required this.instanceId,
    required this.lifecycleState,
    required this.protectedFromScaleIn,
    this.instanceType,
    this.launchConfigurationName,
    this.launchTemplate,
    this.weightedCapacity,
  });
  factory Instance.fromXml(_s.XmlElement elem) {
    return Instance(
      availabilityZone: _s.extractXmlStringValue(elem, 'AvailabilityZone')!,
      healthStatus: _s.extractXmlStringValue(elem, 'HealthStatus')!,
      instanceId: _s.extractXmlStringValue(elem, 'InstanceId')!,
      lifecycleState:
          _s.extractXmlStringValue(elem, 'LifecycleState')!.toLifecycleState(),
      protectedFromScaleIn:
          _s.extractXmlBoolValue(elem, 'ProtectedFromScaleIn')!,
      instanceType: _s.extractXmlStringValue(elem, 'InstanceType'),
      launchConfigurationName:
          _s.extractXmlStringValue(elem, 'LaunchConfigurationName'),
      launchTemplate: _s
          .extractXmlChild(elem, 'LaunchTemplate')
          ?.let((e) => LaunchTemplateSpecification.fromXml(e)),
      weightedCapacity: _s.extractXmlStringValue(elem, 'WeightedCapacity'),
    );
  }
}

enum InstanceGeneration {
  current,
  previous,
}

extension on InstanceGeneration {
  String toValue() {
    switch (this) {
      case InstanceGeneration.current:
        return 'current';
      case InstanceGeneration.previous:
        return 'previous';
    }
  }
}

extension on String {
  InstanceGeneration toInstanceGeneration() {
    switch (this) {
      case 'current':
        return InstanceGeneration.current;
      case 'previous':
        return InstanceGeneration.previous;
    }
    throw Exception('$this is not known in enum InstanceGeneration');
  }
}

enum InstanceMetadataEndpointState {
  disabled,
  enabled,
}

extension on InstanceMetadataEndpointState {
  String toValue() {
    switch (this) {
      case InstanceMetadataEndpointState.disabled:
        return 'disabled';
      case InstanceMetadataEndpointState.enabled:
        return 'enabled';
    }
  }
}

extension on String {
  InstanceMetadataEndpointState toInstanceMetadataEndpointState() {
    switch (this) {
      case 'disabled':
        return InstanceMetadataEndpointState.disabled;
      case 'enabled':
        return InstanceMetadataEndpointState.enabled;
    }
    throw Exception('$this is not known in enum InstanceMetadataEndpointState');
  }
}

enum InstanceMetadataHttpTokensState {
  optional,
  required,
}

extension on InstanceMetadataHttpTokensState {
  String toValue() {
    switch (this) {
      case InstanceMetadataHttpTokensState.optional:
        return 'optional';
      case InstanceMetadataHttpTokensState.required:
        return 'required';
    }
  }
}

extension on String {
  InstanceMetadataHttpTokensState toInstanceMetadataHttpTokensState() {
    switch (this) {
      case 'optional':
        return InstanceMetadataHttpTokensState.optional;
      case 'required':
        return InstanceMetadataHttpTokensState.required;
    }
    throw Exception(
        '$this is not known in enum InstanceMetadataHttpTokensState');
  }
}

/// The metadata options for the instances. For more information, see <a
/// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-launch-config.html#launch-configurations-imds">Configuring
/// the Instance Metadata Options</a> in the <i>Amazon EC2 Auto Scaling User
/// Guide</i>.
class InstanceMetadataOptions {
  /// This parameter enables or disables the HTTP metadata endpoint on your
  /// instances. If the parameter is not specified, the default state is
  /// <code>enabled</code>.
  /// <note>
  /// If you specify a value of <code>disabled</code>, you will not be able to
  /// access your instance metadata.
  /// </note>
  final InstanceMetadataEndpointState? httpEndpoint;

  /// The desired HTTP PUT response hop limit for instance metadata requests. The
  /// larger the number, the further instance metadata requests can travel.
  ///
  /// Default: 1
  final int? httpPutResponseHopLimit;

  /// The state of token usage for your instance metadata requests. If the
  /// parameter is not specified in the request, the default state is
  /// <code>optional</code>.
  ///
  /// If the state is <code>optional</code>, you can choose to retrieve instance
  /// metadata with or without a signed token header on your request. If you
  /// retrieve the IAM role credentials without a token, the version 1.0 role
  /// credentials are returned. If you retrieve the IAM role credentials using a
  /// valid signed token, the version 2.0 role credentials are returned.
  ///
  /// If the state is <code>required</code>, you must send a signed token header
  /// with any instance metadata retrieval requests. In this state, retrieving the
  /// IAM role credentials always returns the version 2.0 credentials; the version
  /// 1.0 credentials are not available.
  final InstanceMetadataHttpTokensState? httpTokens;

  InstanceMetadataOptions({
    this.httpEndpoint,
    this.httpPutResponseHopLimit,
    this.httpTokens,
  });
  factory InstanceMetadataOptions.fromXml(_s.XmlElement elem) {
    return InstanceMetadataOptions(
      httpEndpoint: _s
          .extractXmlStringValue(elem, 'HttpEndpoint')
          ?.toInstanceMetadataEndpointState(),
      httpPutResponseHopLimit:
          _s.extractXmlIntValue(elem, 'HttpPutResponseHopLimit'),
      httpTokens: _s
          .extractXmlStringValue(elem, 'HttpTokens')
          ?.toInstanceMetadataHttpTokensState(),
    );
  }

  Map<String, dynamic> toJson() {
    final httpEndpoint = this.httpEndpoint;
    final httpPutResponseHopLimit = this.httpPutResponseHopLimit;
    final httpTokens = this.httpTokens;
    return {
      if (httpEndpoint != null) 'HttpEndpoint': httpEndpoint.toValue(),
      if (httpPutResponseHopLimit != null)
        'HttpPutResponseHopLimit': httpPutResponseHopLimit,
      if (httpTokens != null) 'HttpTokens': httpTokens.toValue(),
    };
  }
}

/// Describes whether detailed monitoring is enabled for the Auto Scaling
/// instances.
class InstanceMonitoring {
  /// If <code>true</code>, detailed monitoring is enabled. Otherwise, basic
  /// monitoring is enabled.
  final bool? enabled;

  InstanceMonitoring({
    this.enabled,
  });
  factory InstanceMonitoring.fromXml(_s.XmlElement elem) {
    return InstanceMonitoring(
      enabled: _s.extractXmlBoolValue(elem, 'Enabled'),
    );
  }

  Map<String, dynamic> toJson() {
    final enabled = this.enabled;
    return {
      if (enabled != null) 'Enabled': enabled,
    };
  }
}

/// Describes an instance refresh for an Auto Scaling group.
class InstanceRefresh {
  /// The name of the Auto Scaling group.
  final String? autoScalingGroupName;

  /// Describes the specific update you want to deploy.
  final DesiredConfiguration? desiredConfiguration;

  /// The date and time at which the instance refresh ended.
  final DateTime? endTime;

  /// The instance refresh ID.
  final String? instanceRefreshId;

  /// The number of instances remaining to update before the instance refresh is
  /// complete.
  final int? instancesToUpdate;

  /// The percentage of the instance refresh that is complete. For each instance
  /// replacement, Amazon EC2 Auto Scaling tracks the instance's health status and
  /// warm-up time. When the instance's health status changes to healthy and the
  /// specified warm-up time passes, the instance is considered updated and is
  /// added to the percentage complete.
  final int? percentageComplete;
  final RefreshPreferences? preferences;

  /// Additional progress details for an Auto Scaling group that has a warm pool.
  final InstanceRefreshProgressDetails? progressDetails;

  /// The date and time at which the instance refresh began.
  final DateTime? startTime;

  /// The current status for the instance refresh operation:
  ///
  /// <ul>
  /// <li>
  /// <code>Pending</code> - The request was created, but the operation has not
  /// started.
  /// </li>
  /// <li>
  /// <code>InProgress</code> - The operation is in progress.
  /// </li>
  /// <li>
  /// <code>Successful</code> - The operation completed successfully.
  /// </li>
  /// <li>
  /// <code>Failed</code> - The operation failed to complete. You can troubleshoot
  /// using the status reason and the scaling activities.
  /// </li>
  /// <li>
  /// <code>Cancelling</code> - An ongoing operation is being cancelled.
  /// Cancellation does not roll back any replacements that have already been
  /// completed, but it prevents new replacements from being started.
  /// </li>
  /// <li>
  /// <code>Cancelled</code> - The operation is cancelled.
  /// </li>
  /// </ul>
  final InstanceRefreshStatus? status;

  /// Provides more details about the current status of the instance refresh.
  final String? statusReason;

  InstanceRefresh({
    this.autoScalingGroupName,
    this.desiredConfiguration,
    this.endTime,
    this.instanceRefreshId,
    this.instancesToUpdate,
    this.percentageComplete,
    this.preferences,
    this.progressDetails,
    this.startTime,
    this.status,
    this.statusReason,
  });
  factory InstanceRefresh.fromXml(_s.XmlElement elem) {
    return InstanceRefresh(
      autoScalingGroupName:
          _s.extractXmlStringValue(elem, 'AutoScalingGroupName'),
      desiredConfiguration: _s
          .extractXmlChild(elem, 'DesiredConfiguration')
          ?.let((e) => DesiredConfiguration.fromXml(e)),
      endTime: _s.extractXmlDateTimeValue(elem, 'EndTime'),
      instanceRefreshId: _s.extractXmlStringValue(elem, 'InstanceRefreshId'),
      instancesToUpdate: _s.extractXmlIntValue(elem, 'InstancesToUpdate'),
      percentageComplete: _s.extractXmlIntValue(elem, 'PercentageComplete'),
      preferences: _s
          .extractXmlChild(elem, 'Preferences')
          ?.let((e) => RefreshPreferences.fromXml(e)),
      progressDetails: _s
          .extractXmlChild(elem, 'ProgressDetails')
          ?.let((e) => InstanceRefreshProgressDetails.fromXml(e)),
      startTime: _s.extractXmlDateTimeValue(elem, 'StartTime'),
      status:
          _s.extractXmlStringValue(elem, 'Status')?.toInstanceRefreshStatus(),
      statusReason: _s.extractXmlStringValue(elem, 'StatusReason'),
    );
  }
}

/// Reports the progress of an instance refresh on instances that are in the
/// Auto Scaling group.
class InstanceRefreshLivePoolProgress {
  /// The number of instances remaining to update.
  final int? instancesToUpdate;

  /// The percentage of instances in the Auto Scaling group that have been
  /// replaced. For each instance replacement, Amazon EC2 Auto Scaling tracks the
  /// instance's health status and warm-up time. When the instance's health status
  /// changes to healthy and the specified warm-up time passes, the instance is
  /// considered updated and is added to the percentage complete.
  final int? percentageComplete;

  InstanceRefreshLivePoolProgress({
    this.instancesToUpdate,
    this.percentageComplete,
  });
  factory InstanceRefreshLivePoolProgress.fromXml(_s.XmlElement elem) {
    return InstanceRefreshLivePoolProgress(
      instancesToUpdate: _s.extractXmlIntValue(elem, 'InstancesToUpdate'),
      percentageComplete: _s.extractXmlIntValue(elem, 'PercentageComplete'),
    );
  }
}

/// Reports the progress of an instance refresh on an Auto Scaling group that
/// has a warm pool. This includes separate details for instances in the warm
/// pool and instances in the Auto Scaling group (the live pool).
class InstanceRefreshProgressDetails {
  /// Indicates the progress of an instance refresh on instances that are in the
  /// Auto Scaling group.
  final InstanceRefreshLivePoolProgress? livePoolProgress;

  /// Indicates the progress of an instance refresh on instances that are in the
  /// warm pool.
  final InstanceRefreshWarmPoolProgress? warmPoolProgress;

  InstanceRefreshProgressDetails({
    this.livePoolProgress,
    this.warmPoolProgress,
  });
  factory InstanceRefreshProgressDetails.fromXml(_s.XmlElement elem) {
    return InstanceRefreshProgressDetails(
      livePoolProgress: _s
          .extractXmlChild(elem, 'LivePoolProgress')
          ?.let((e) => InstanceRefreshLivePoolProgress.fromXml(e)),
      warmPoolProgress: _s
          .extractXmlChild(elem, 'WarmPoolProgress')
          ?.let((e) => InstanceRefreshWarmPoolProgress.fromXml(e)),
    );
  }
}

enum InstanceRefreshStatus {
  pending,
  inProgress,
  successful,
  failed,
  cancelling,
  cancelled,
}

extension on InstanceRefreshStatus {
  String toValue() {
    switch (this) {
      case InstanceRefreshStatus.pending:
        return 'Pending';
      case InstanceRefreshStatus.inProgress:
        return 'InProgress';
      case InstanceRefreshStatus.successful:
        return 'Successful';
      case InstanceRefreshStatus.failed:
        return 'Failed';
      case InstanceRefreshStatus.cancelling:
        return 'Cancelling';
      case InstanceRefreshStatus.cancelled:
        return 'Cancelled';
    }
  }
}

extension on String {
  InstanceRefreshStatus toInstanceRefreshStatus() {
    switch (this) {
      case 'Pending':
        return InstanceRefreshStatus.pending;
      case 'InProgress':
        return InstanceRefreshStatus.inProgress;
      case 'Successful':
        return InstanceRefreshStatus.successful;
      case 'Failed':
        return InstanceRefreshStatus.failed;
      case 'Cancelling':
        return InstanceRefreshStatus.cancelling;
      case 'Cancelled':
        return InstanceRefreshStatus.cancelled;
    }
    throw Exception('$this is not known in enum InstanceRefreshStatus');
  }
}

/// Reports the progress of an instance refresh on instances that are in the
/// warm pool.
class InstanceRefreshWarmPoolProgress {
  /// The number of instances remaining to update.
  final int? instancesToUpdate;

  /// The percentage of instances in the warm pool that have been replaced. For
  /// each instance replacement, Amazon EC2 Auto Scaling tracks the instance's
  /// health status and warm-up time. When the instance's health status changes to
  /// healthy and the specified warm-up time passes, the instance is considered
  /// updated and is added to the percentage complete.
  final int? percentageComplete;

  InstanceRefreshWarmPoolProgress({
    this.instancesToUpdate,
    this.percentageComplete,
  });
  factory InstanceRefreshWarmPoolProgress.fromXml(_s.XmlElement elem) {
    return InstanceRefreshWarmPoolProgress(
      instancesToUpdate: _s.extractXmlIntValue(elem, 'InstancesToUpdate'),
      percentageComplete: _s.extractXmlIntValue(elem, 'PercentageComplete'),
    );
  }
}

/// When you specify multiple parameters, you get instance types that satisfy
/// all of the specified parameters. If you specify multiple values for a
/// parameter, you get instance types that satisfy any of the specified values.
///
/// Represents requirements for the types of instances that can be launched. You
/// must specify <code>VCpuCount</code> and <code>MemoryMiB</code>, but all
/// other parameters are optional. For more information, see <a
/// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-asg-instance-type-requirements.html">Creating
/// an Auto Scaling group using attribute-based instance type selection</a> in
/// the <i>Amazon EC2 Auto Scaling User Guide</i>.
class InstanceRequirements {
  /// The minimum and maximum instance memory size for an instance type, in MiB.
  final MemoryMiBRequest memoryMiB;

  /// The minimum and maximum number of vCPUs for an instance type.
  final VCpuCountRequest vCpuCount;

  /// The minimum and maximum number of accelerators (GPUs, FPGAs, or Amazon Web
  /// Services Inferentia chips) for an instance type.
  ///
  /// To exclude accelerator-enabled instance types, set <code>Max</code> to
  /// <code>0</code>.
  ///
  /// Default: No minimum or maximum
  final AcceleratorCountRequest? acceleratorCount;

  /// Indicates whether instance types must have accelerators by specific
  /// manufacturers.
  ///
  /// <ul>
  /// <li>
  /// For instance types with NVIDIA devices, specify <code>nvidia</code>.
  /// </li>
  /// <li>
  /// For instance types with AMD devices, specify <code>amd</code>.
  /// </li>
  /// <li>
  /// For instance types with Amazon Web Services devices, specify
  /// <code>amazon-web-services</code>.
  /// </li>
  /// <li>
  /// For instance types with Xilinx devices, specify <code>xilinx</code>.
  /// </li>
  /// </ul>
  /// Default: Any manufacturer
  final List<AcceleratorManufacturer>? acceleratorManufacturers;

  /// Lists the accelerators that must be on an instance type.
  ///
  /// <ul>
  /// <li>
  /// For instance types with NVIDIA A100 GPUs, specify <code>a100</code>.
  /// </li>
  /// <li>
  /// For instance types with NVIDIA V100 GPUs, specify <code>v100</code>.
  /// </li>
  /// <li>
  /// For instance types with NVIDIA K80 GPUs, specify <code>k80</code>.
  /// </li>
  /// <li>
  /// For instance types with NVIDIA T4 GPUs, specify <code>t4</code>.
  /// </li>
  /// <li>
  /// For instance types with NVIDIA M60 GPUs, specify <code>m60</code>.
  /// </li>
  /// <li>
  /// For instance types with AMD Radeon Pro V520 GPUs, specify
  /// <code>radeon-pro-v520</code>.
  /// </li>
  /// <li>
  /// For instance types with Xilinx VU9P FPGAs, specify <code>vu9p</code>.
  /// </li>
  /// </ul>
  /// Default: Any accelerator
  final List<AcceleratorName>? acceleratorNames;

  /// The minimum and maximum total memory size for the accelerators on an
  /// instance type, in MiB.
  ///
  /// Default: No minimum or maximum
  final AcceleratorTotalMemoryMiBRequest? acceleratorTotalMemoryMiB;

  /// Lists the accelerator types that must be on an instance type.
  ///
  /// <ul>
  /// <li>
  /// For instance types with GPU accelerators, specify <code>gpu</code>.
  /// </li>
  /// <li>
  /// For instance types with FPGA accelerators, specify <code>fpga</code>.
  /// </li>
  /// <li>
  /// For instance types with inference accelerators, specify
  /// <code>inference</code>.
  /// </li>
  /// </ul>
  /// Default: Any accelerator type
  final List<AcceleratorType>? acceleratorTypes;

  /// Indicates whether bare metal instance types are included, excluded, or
  /// required.
  ///
  /// Default: <code>excluded</code>
  final BareMetal? bareMetal;

  /// The minimum and maximum baseline bandwidth performance for an instance type,
  /// in Mbps. For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html">Amazon
  /// EBS–optimized instances</a> in the <i>Amazon EC2 User Guide for Linux
  /// Instances</i>.
  ///
  /// Default: No minimum or maximum
  final BaselineEbsBandwidthMbpsRequest? baselineEbsBandwidthMbps;

  /// Indicates whether burstable performance instance types are included,
  /// excluded, or required. For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html">Burstable
  /// performance instances</a> in the <i>Amazon EC2 User Guide for Linux
  /// Instances</i>.
  ///
  /// Default: <code>excluded</code>
  final BurstablePerformance? burstablePerformance;

  /// Lists which specific CPU manufacturers to include.
  ///
  /// <ul>
  /// <li>
  /// For instance types with Intel CPUs, specify <code>intel</code>.
  /// </li>
  /// <li>
  /// For instance types with AMD CPUs, specify <code>amd</code>.
  /// </li>
  /// <li>
  /// For instance types with Amazon Web Services CPUs, specify
  /// <code>amazon-web-services</code>.
  /// </li>
  /// </ul> <note>
  /// Don't confuse the CPU hardware manufacturer with the CPU hardware
  /// architecture. Instances will be launched with a compatible CPU architecture
  /// based on the Amazon Machine Image (AMI) that you specify in your launch
  /// template.
  /// </note>
  /// Default: Any manufacturer
  final List<CpuManufacturer>? cpuManufacturers;

  /// Lists which instance types to exclude. You can use strings with one or more
  /// wild cards, represented by an asterisk (<code>*</code>). The following are
  /// examples: <code>c5*</code>, <code>m5a.*</code>, <code>r*</code>,
  /// <code>*3*</code>.
  ///
  /// For example, if you specify <code>c5*</code>, you are excluding the entire
  /// C5 instance family, which includes all C5a and C5n instance types. If you
  /// specify <code>m5a.*</code>, you are excluding all the M5a instance types,
  /// but not the M5n instance types.
  ///
  /// Default: No excluded instance types
  final List<String>? excludedInstanceTypes;

  /// Indicates whether current or previous generation instance types are
  /// included.
  ///
  /// <ul>
  /// <li>
  /// For current generation instance types, specify <code>current</code>. The
  /// current generation includes EC2 instance types currently recommended for
  /// use. This typically includes the latest two to three generations in each
  /// instance family. For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html">Instance
  /// types</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.
  /// </li>
  /// <li>
  /// For previous generation instance types, specify <code>previous</code>.
  /// </li>
  /// </ul>
  /// Default: Any current or previous generation
  final List<InstanceGeneration>? instanceGenerations;

  /// Indicates whether instance types with instance store volumes are included,
  /// excluded, or required. For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html">Amazon
  /// EC2 instance store</a> in the <i>Amazon EC2 User Guide for Linux
  /// Instances</i>.
  ///
  /// Default: <code>included</code>
  final LocalStorage? localStorage;

  /// Indicates the type of local storage that is required.
  ///
  /// <ul>
  /// <li>
  /// For instance types with hard disk drive (HDD) storage, specify
  /// <code>hdd</code>.
  /// </li>
  /// <li>
  /// For instance types with solid state drive (SSD) storage, specify
  /// <code>ssd</code>.
  /// </li>
  /// </ul>
  /// Default: Any local storage type
  final List<LocalStorageType>? localStorageTypes;

  /// The minimum and maximum amount of memory per vCPU for an instance type, in
  /// GiB.
  ///
  /// Default: No minimum or maximum
  final MemoryGiBPerVCpuRequest? memoryGiBPerVCpu;

  /// The minimum and maximum number of network interfaces for an instance type.
  ///
  /// Default: No minimum or maximum
  final NetworkInterfaceCountRequest? networkInterfaceCount;

  /// The price protection threshold for On-Demand Instances. This is the maximum
  /// you’ll pay for an On-Demand Instance, expressed as a percentage higher than
  /// the least expensive current generation M, C, or R instance type with your
  /// specified attributes. When Amazon EC2 Auto Scaling selects instance types
  /// with your attributes, we will exclude instance types whose price is higher
  /// than your threshold. The parameter accepts an integer, which Amazon EC2 Auto
  /// Scaling interprets as a percentage. To turn off price protection, specify a
  /// high value, such as <code>999999</code>.
  ///
  /// If you set <code>DesiredCapacityType</code> to <code>vcpu</code> or
  /// <code>memory-mib</code>, the price protection threshold is applied based on
  /// the per vCPU or per memory price instead of the per instance price.
  ///
  /// Default: <code>20</code>
  final int? onDemandMaxPricePercentageOverLowestPrice;

  /// Indicates whether instance types must provide On-Demand Instance hibernation
  /// support.
  ///
  /// Default: <code>false</code>
  final bool? requireHibernateSupport;

  /// The price protection threshold for Spot Instances. This is the maximum
  /// you’ll pay for a Spot Instance, expressed as a percentage higher than the
  /// least expensive current generation M, C, or R instance type with your
  /// specified attributes. When Amazon EC2 Auto Scaling selects instance types
  /// with your attributes, we will exclude instance types whose price is higher
  /// than your threshold. The parameter accepts an integer, which Amazon EC2 Auto
  /// Scaling interprets as a percentage. To turn off price protection, specify a
  /// high value, such as <code>999999</code>.
  ///
  /// If you set <code>DesiredCapacityType</code> to <code>vcpu</code> or
  /// <code>memory-mib</code>, the price protection threshold is applied based on
  /// the per vCPU or per memory price instead of the per instance price.
  ///
  /// Default: <code>100</code>
  final int? spotMaxPricePercentageOverLowestPrice;

  /// The minimum and maximum total local storage size for an instance type, in
  /// GB.
  ///
  /// Default: No minimum or maximum
  final TotalLocalStorageGBRequest? totalLocalStorageGB;

  InstanceRequirements({
    required this.memoryMiB,
    required this.vCpuCount,
    this.acceleratorCount,
    this.acceleratorManufacturers,
    this.acceleratorNames,
    this.acceleratorTotalMemoryMiB,
    this.acceleratorTypes,
    this.bareMetal,
    this.baselineEbsBandwidthMbps,
    this.burstablePerformance,
    this.cpuManufacturers,
    this.excludedInstanceTypes,
    this.instanceGenerations,
    this.localStorage,
    this.localStorageTypes,
    this.memoryGiBPerVCpu,
    this.networkInterfaceCount,
    this.onDemandMaxPricePercentageOverLowestPrice,
    this.requireHibernateSupport,
    this.spotMaxPricePercentageOverLowestPrice,
    this.totalLocalStorageGB,
  });
  factory InstanceRequirements.fromXml(_s.XmlElement elem) {
    return InstanceRequirements(
      memoryMiB:
          MemoryMiBRequest.fromXml(_s.extractXmlChild(elem, 'MemoryMiB')!),
      vCpuCount:
          VCpuCountRequest.fromXml(_s.extractXmlChild(elem, 'VCpuCount')!),
      acceleratorCount: _s
          .extractXmlChild(elem, 'AcceleratorCount')
          ?.let((e) => AcceleratorCountRequest.fromXml(e)),
      acceleratorManufacturers: _s
          .extractXmlChild(elem, 'AcceleratorManufacturers')
          ?.let((elem) => _s
              .extractXmlStringListValues(elem, 'member')
              .map((s) => s.toAcceleratorManufacturer())
              .toList()),
      acceleratorNames: _s.extractXmlChild(elem, 'AcceleratorNames')?.let(
          (elem) => _s
              .extractXmlStringListValues(elem, 'member')
              .map((s) => s.toAcceleratorName())
              .toList()),
      acceleratorTotalMemoryMiB: _s
          .extractXmlChild(elem, 'AcceleratorTotalMemoryMiB')
          ?.let((e) => AcceleratorTotalMemoryMiBRequest.fromXml(e)),
      acceleratorTypes: _s.extractXmlChild(elem, 'AcceleratorTypes')?.let(
          (elem) => _s
              .extractXmlStringListValues(elem, 'member')
              .map((s) => s.toAcceleratorType())
              .toList()),
      bareMetal: _s.extractXmlStringValue(elem, 'BareMetal')?.toBareMetal(),
      baselineEbsBandwidthMbps: _s
          .extractXmlChild(elem, 'BaselineEbsBandwidthMbps')
          ?.let((e) => BaselineEbsBandwidthMbpsRequest.fromXml(e)),
      burstablePerformance: _s
          .extractXmlStringValue(elem, 'BurstablePerformance')
          ?.toBurstablePerformance(),
      cpuManufacturers: _s.extractXmlChild(elem, 'CpuManufacturers')?.let(
          (elem) => _s
              .extractXmlStringListValues(elem, 'member')
              .map((s) => s.toCpuManufacturer())
              .toList()),
      excludedInstanceTypes: _s
          .extractXmlChild(elem, 'ExcludedInstanceTypes')
          ?.let((elem) => _s.extractXmlStringListValues(elem, 'member')),
      instanceGenerations: _s.extractXmlChild(elem, 'InstanceGenerations')?.let(
          (elem) => _s
              .extractXmlStringListValues(elem, 'member')
              .map((s) => s.toInstanceGeneration())
              .toList()),
      localStorage:
          _s.extractXmlStringValue(elem, 'LocalStorage')?.toLocalStorage(),
      localStorageTypes: _s.extractXmlChild(elem, 'LocalStorageTypes')?.let(
          (elem) => _s
              .extractXmlStringListValues(elem, 'member')
              .map((s) => s.toLocalStorageType())
              .toList()),
      memoryGiBPerVCpu: _s
          .extractXmlChild(elem, 'MemoryGiBPerVCpu')
          ?.let((e) => MemoryGiBPerVCpuRequest.fromXml(e)),
      networkInterfaceCount: _s
          .extractXmlChild(elem, 'NetworkInterfaceCount')
          ?.let((e) => NetworkInterfaceCountRequest.fromXml(e)),
      onDemandMaxPricePercentageOverLowestPrice: _s.extractXmlIntValue(
          elem, 'OnDemandMaxPricePercentageOverLowestPrice'),
      requireHibernateSupport:
          _s.extractXmlBoolValue(elem, 'RequireHibernateSupport'),
      spotMaxPricePercentageOverLowestPrice:
          _s.extractXmlIntValue(elem, 'SpotMaxPricePercentageOverLowestPrice'),
      totalLocalStorageGB: _s
          .extractXmlChild(elem, 'TotalLocalStorageGB')
          ?.let((e) => TotalLocalStorageGBRequest.fromXml(e)),
    );
  }

  Map<String, dynamic> toJson() {
    final memoryMiB = this.memoryMiB;
    final vCpuCount = this.vCpuCount;
    final acceleratorCount = this.acceleratorCount;
    final acceleratorManufacturers = this.acceleratorManufacturers;
    final acceleratorNames = this.acceleratorNames;
    final acceleratorTotalMemoryMiB = this.acceleratorTotalMemoryMiB;
    final acceleratorTypes = this.acceleratorTypes;
    final bareMetal = this.bareMetal;
    final baselineEbsBandwidthMbps = this.baselineEbsBandwidthMbps;
    final burstablePerformance = this.burstablePerformance;
    final cpuManufacturers = this.cpuManufacturers;
    final excludedInstanceTypes = this.excludedInstanceTypes;
    final instanceGenerations = this.instanceGenerations;
    final localStorage = this.localStorage;
    final localStorageTypes = this.localStorageTypes;
    final memoryGiBPerVCpu = this.memoryGiBPerVCpu;
    final networkInterfaceCount = this.networkInterfaceCount;
    final onDemandMaxPricePercentageOverLowestPrice =
        this.onDemandMaxPricePercentageOverLowestPrice;
    final requireHibernateSupport = this.requireHibernateSupport;
    final spotMaxPricePercentageOverLowestPrice =
        this.spotMaxPricePercentageOverLowestPrice;
    final totalLocalStorageGB = this.totalLocalStorageGB;
    return {
      'MemoryMiB': memoryMiB,
      'VCpuCount': vCpuCount,
      if (acceleratorCount != null) 'AcceleratorCount': acceleratorCount,
      if (acceleratorManufacturers != null)
        'AcceleratorManufacturers':
            acceleratorManufacturers.map((e) => e.toValue()).toList(),
      if (acceleratorNames != null)
        'AcceleratorNames': acceleratorNames.map((e) => e.toValue()).toList(),
      if (acceleratorTotalMemoryMiB != null)
        'AcceleratorTotalMemoryMiB': acceleratorTotalMemoryMiB,
      if (acceleratorTypes != null)
        'AcceleratorTypes': acceleratorTypes.map((e) => e.toValue()).toList(),
      if (bareMetal != null) 'BareMetal': bareMetal.toValue(),
      if (baselineEbsBandwidthMbps != null)
        'BaselineEbsBandwidthMbps': baselineEbsBandwidthMbps,
      if (burstablePerformance != null)
        'BurstablePerformance': burstablePerformance.toValue(),
      if (cpuManufacturers != null)
        'CpuManufacturers': cpuManufacturers.map((e) => e.toValue()).toList(),
      if (excludedInstanceTypes != null)
        'ExcludedInstanceTypes': excludedInstanceTypes,
      if (instanceGenerations != null)
        'InstanceGenerations':
            instanceGenerations.map((e) => e.toValue()).toList(),
      if (localStorage != null) 'LocalStorage': localStorage.toValue(),
      if (localStorageTypes != null)
        'LocalStorageTypes': localStorageTypes.map((e) => e.toValue()).toList(),
      if (memoryGiBPerVCpu != null) 'MemoryGiBPerVCpu': memoryGiBPerVCpu,
      if (networkInterfaceCount != null)
        'NetworkInterfaceCount': networkInterfaceCount,
      if (onDemandMaxPricePercentageOverLowestPrice != null)
        'OnDemandMaxPricePercentageOverLowestPrice':
            onDemandMaxPricePercentageOverLowestPrice,
      if (requireHibernateSupport != null)
        'RequireHibernateSupport': requireHibernateSupport,
      if (spotMaxPricePercentageOverLowestPrice != null)
        'SpotMaxPricePercentageOverLowestPrice':
            spotMaxPricePercentageOverLowestPrice,
      if (totalLocalStorageGB != null)
        'TotalLocalStorageGB': totalLocalStorageGB,
    };
  }
}

/// Describes an instance reuse policy for a warm pool.
///
/// For more information, see <a
/// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-warm-pools.html">Warm
/// pools for Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2 Auto Scaling User
/// Guide</i>.
class InstanceReusePolicy {
  /// Specifies whether instances in the Auto Scaling group can be returned to the
  /// warm pool on scale in.
  final bool? reuseOnScaleIn;

  InstanceReusePolicy({
    this.reuseOnScaleIn,
  });
  factory InstanceReusePolicy.fromXml(_s.XmlElement elem) {
    return InstanceReusePolicy(
      reuseOnScaleIn: _s.extractXmlBoolValue(elem, 'ReuseOnScaleIn'),
    );
  }

  Map<String, dynamic> toJson() {
    final reuseOnScaleIn = this.reuseOnScaleIn;
    return {
      if (reuseOnScaleIn != null) 'ReuseOnScaleIn': reuseOnScaleIn,
    };
  }
}

/// Describes an instances distribution for an Auto Scaling group.
class InstancesDistribution {
  /// The order of the launch template overrides to use in fulfilling On-Demand
  /// capacity.
  ///
  /// If you specify <code>lowest-price</code>, Amazon EC2 Auto Scaling uses price
  /// to determine the order, launching the lowest price first.
  ///
  /// If you specify <code>prioritized</code>, Amazon EC2 Auto Scaling uses the
  /// priority that you assigned to each launch template override, launching the
  /// highest priority first. If all your On-Demand capacity cannot be fulfilled
  /// using your highest priority instance, then Amazon EC2 Auto Scaling launches
  /// the remaining capacity using the second priority instance type, and so on.
  ///
  /// Default: <code>lowest-price</code> for Auto Scaling groups that specify
  /// <a>InstanceRequirements</a> in the overrides and <code>prioritized</code>
  /// for Auto Scaling groups that don't.
  ///
  /// Valid values: <code>lowest-price</code> | <code>prioritized</code>
  final String? onDemandAllocationStrategy;

  /// The minimum amount of the Auto Scaling group's capacity that must be
  /// fulfilled by On-Demand Instances. This base portion is launched first as
  /// your group scales.
  ///
  /// If you specify weights for the instance types in the overrides, the base
  /// capacity is measured in the same unit of measurement as the instance types.
  /// If you specify <a>InstanceRequirements</a> in the overrides, the base
  /// capacity is measured in the same unit of measurement as your group's desired
  /// capacity.
  ///
  /// Default: <code>0</code>
  final int? onDemandBaseCapacity;

  /// Controls the percentages of On-Demand Instances and Spot Instances for your
  /// additional capacity beyond <code>OnDemandBaseCapacity</code>. Expressed as a
  /// number (for example, 20 specifies 20% On-Demand Instances, 80% Spot
  /// Instances). If set to 100, only On-Demand Instances are used.
  ///
  /// Default: <code>100</code>
  final int? onDemandPercentageAboveBaseCapacity;

  /// Indicates how to allocate instances across Spot Instance pools.
  ///
  /// If the allocation strategy is <code>lowest-price</code>, the Auto Scaling
  /// group launches instances using the Spot pools with the lowest price, and
  /// evenly allocates your instances across the number of Spot pools that you
  /// specify.
  ///
  /// If the allocation strategy is <code>capacity-optimized</code> (recommended),
  /// the Auto Scaling group launches instances using Spot pools that are
  /// optimally chosen based on the available Spot capacity. Alternatively, you
  /// can use <code>capacity-optimized-prioritized</code> and set the order of
  /// instance types in the list of launch template overrides from highest to
  /// lowest priority (from first to last in the list). Amazon EC2 Auto Scaling
  /// honors the instance type priorities on a best-effort basis but optimizes for
  /// capacity first.
  ///
  /// Default: <code>lowest-price</code>
  ///
  /// Valid values: <code>lowest-price</code> | <code>capacity-optimized</code> |
  /// <code>capacity-optimized-prioritized</code>
  final String? spotAllocationStrategy;

  /// The number of Spot Instance pools across which to allocate your Spot
  /// Instances. The Spot pools are determined from the different instance types
  /// in the overrides. Valid only when the Spot allocation strategy is
  /// <code>lowest-price</code>. Value must be in the range of 1–20.
  ///
  /// Default: <code>2</code>
  final int? spotInstancePools;

  /// The maximum price per unit hour that you are willing to pay for a Spot
  /// Instance. If you keep the value at its default (unspecified), Amazon EC2
  /// Auto Scaling uses the On-Demand price as the maximum Spot price. To remove a
  /// value that you previously set, include the property but specify an empty
  /// string ("") for the value.
  /// <important>
  /// If your maximum price is lower than the Spot price for the instance types
  /// that you selected, your Spot Instances are not launched.
  /// </important>
  /// Valid Range: Minimum value of 0.001
  final String? spotMaxPrice;

  InstancesDistribution({
    this.onDemandAllocationStrategy,
    this.onDemandBaseCapacity,
    this.onDemandPercentageAboveBaseCapacity,
    this.spotAllocationStrategy,
    this.spotInstancePools,
    this.spotMaxPrice,
  });
  factory InstancesDistribution.fromXml(_s.XmlElement elem) {
    return InstancesDistribution(
      onDemandAllocationStrategy:
          _s.extractXmlStringValue(elem, 'OnDemandAllocationStrategy'),
      onDemandBaseCapacity: _s.extractXmlIntValue(elem, 'OnDemandBaseCapacity'),
      onDemandPercentageAboveBaseCapacity:
          _s.extractXmlIntValue(elem, 'OnDemandPercentageAboveBaseCapacity'),
      spotAllocationStrategy:
          _s.extractXmlStringValue(elem, 'SpotAllocationStrategy'),
      spotInstancePools: _s.extractXmlIntValue(elem, 'SpotInstancePools'),
      spotMaxPrice: _s.extractXmlStringValue(elem, 'SpotMaxPrice'),
    );
  }

  Map<String, dynamic> toJson() {
    final onDemandAllocationStrategy = this.onDemandAllocationStrategy;
    final onDemandBaseCapacity = this.onDemandBaseCapacity;
    final onDemandPercentageAboveBaseCapacity =
        this.onDemandPercentageAboveBaseCapacity;
    final spotAllocationStrategy = this.spotAllocationStrategy;
    final spotInstancePools = this.spotInstancePools;
    final spotMaxPrice = this.spotMaxPrice;
    return {
      if (onDemandAllocationStrategy != null)
        'OnDemandAllocationStrategy': onDemandAllocationStrategy,
      if (onDemandBaseCapacity != null)
        'OnDemandBaseCapacity': onDemandBaseCapacity,
      if (onDemandPercentageAboveBaseCapacity != null)
        'OnDemandPercentageAboveBaseCapacity':
            onDemandPercentageAboveBaseCapacity,
      if (spotAllocationStrategy != null)
        'SpotAllocationStrategy': spotAllocationStrategy,
      if (spotInstancePools != null) 'SpotInstancePools': spotInstancePools,
      if (spotMaxPrice != null) 'SpotMaxPrice': spotMaxPrice,
    };
  }
}

/// Describes a launch configuration.
class LaunchConfiguration {
  /// The creation date and time for the launch configuration.
  final DateTime createdTime;

  /// The ID of the Amazon Machine Image (AMI) to use to launch your EC2
  /// instances. For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html">Find
  /// a Linux AMI</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.
  final String imageId;

  /// The instance type for the instances. For information about available
  /// instance types, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#AvailableInstanceTypes">Available
  /// instance types</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.
  final String instanceType;

  /// The name of the launch configuration.
  final String launchConfigurationName;

  /// Specifies whether to assign a public IPv4 address to the group's instances.
  /// If the instance is launched into a default subnet, the default is to assign
  /// a public IPv4 address, unless you disabled the option to assign a public
  /// IPv4 address on the subnet. If the instance is launched into a nondefault
  /// subnet, the default is not to assign a public IPv4 address, unless you
  /// enabled the option to assign a public IPv4 address on the subnet. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-in-vpc.html">Launching
  /// Auto Scaling instances in a VPC</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  final bool? associatePublicIpAddress;

  /// The block device mapping entries that define the block devices to attach to
  /// the instances at launch. By default, the block devices specified in the
  /// block device mapping for the AMI are used. For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html">Block
  /// Device Mapping</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.
  final List<BlockDeviceMapping>? blockDeviceMappings;

  /// <i>EC2-Classic retires on August 15, 2022. This property is not supported
  /// after that date.</i>
  ///
  /// The ID of a ClassicLink-enabled VPC to link your EC2-Classic instances to.
  final String? classicLinkVPCId;

  /// <i>EC2-Classic retires on August 15, 2022. This property is not supported
  /// after that date.</i>
  ///
  /// The IDs of one or more security groups for the VPC specified in
  /// <code>ClassicLinkVPCId</code>.
  final List<String>? classicLinkVPCSecurityGroups;

  /// Specifies whether the launch configuration is optimized for EBS I/O
  /// (<code>true</code>) or not (<code>false</code>). For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSOptimized.html">Amazon
  /// EBS-Optimized Instances</a> in the <i>Amazon EC2 User Guide for Linux
  /// Instances</i>.
  final bool? ebsOptimized;

  /// The name or the Amazon Resource Name (ARN) of the instance profile
  /// associated with the IAM role for the instance. The instance profile contains
  /// the IAM role. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/us-iam-role.html">IAM
  /// role for applications that run on Amazon EC2 instances</a> in the <i>Amazon
  /// EC2 Auto Scaling User Guide</i>.
  final String? iamInstanceProfile;

  /// Controls whether instances in this group are launched with detailed
  /// (<code>true</code>) or basic (<code>false</code>) monitoring.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/latest/userguide/enable-as-instance-metrics.html">Configure
  /// Monitoring for Auto Scaling Instances</a> in the <i>Amazon EC2 Auto Scaling
  /// User Guide</i>.
  final InstanceMonitoring? instanceMonitoring;

  /// The ID of the kernel associated with the AMI.
  final String? kernelId;

  /// The name of the key pair.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html">Amazon
  /// EC2 Key Pairs</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.
  final String? keyName;

  /// The Amazon Resource Name (ARN) of the launch configuration.
  final String? launchConfigurationARN;

  /// The metadata options for the instances. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-launch-config.html#launch-configurations-imds">Configuring
  /// the Instance Metadata Options</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  final InstanceMetadataOptions? metadataOptions;

  /// The tenancy of the instance, either <code>default</code> or
  /// <code>dedicated</code>. An instance with <code>dedicated</code> tenancy runs
  /// on isolated, single-tenant hardware and can only be launched into a VPC.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/auto-scaling-dedicated-instances.html">Configuring
  /// instance tenancy with Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>.
  final String? placementTenancy;

  /// The ID of the RAM disk associated with the AMI.
  final String? ramdiskId;

  /// A list that contains the security groups to assign to the instances in the
  /// Auto Scaling group. For more information, see <a
  /// href="https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html">Security
  /// Groups for Your VPC</a> in the <i>Amazon Virtual Private Cloud User
  /// Guide</i>.
  final List<String>? securityGroups;

  /// The maximum hourly price to be paid for any Spot Instance launched to
  /// fulfill the request. Spot Instances are launched when the price you specify
  /// exceeds the current Spot price. For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-launch-spot-instances.html">Requesting
  /// Spot Instances</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
  final String? spotPrice;

  /// The user data to make available to the launched EC2 instances. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html">Instance
  /// metadata and user data</a> (Linux) and <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ec2-instance-metadata.html">Instance
  /// metadata and user data</a> (Windows). If you are using a command line tool,
  /// base64-encoding is performed for you, and you can load the text from a file.
  /// Otherwise, you must provide base64-encoded text. User data is limited to 16
  /// KB.
  final String? userData;

  LaunchConfiguration({
    required this.createdTime,
    required this.imageId,
    required this.instanceType,
    required this.launchConfigurationName,
    this.associatePublicIpAddress,
    this.blockDeviceMappings,
    this.classicLinkVPCId,
    this.classicLinkVPCSecurityGroups,
    this.ebsOptimized,
    this.iamInstanceProfile,
    this.instanceMonitoring,
    this.kernelId,
    this.keyName,
    this.launchConfigurationARN,
    this.metadataOptions,
    this.placementTenancy,
    this.ramdiskId,
    this.securityGroups,
    this.spotPrice,
    this.userData,
  });
  factory LaunchConfiguration.fromXml(_s.XmlElement elem) {
    return LaunchConfiguration(
      createdTime: _s.extractXmlDateTimeValue(elem, 'CreatedTime')!,
      imageId: _s.extractXmlStringValue(elem, 'ImageId')!,
      instanceType: _s.extractXmlStringValue(elem, 'InstanceType')!,
      launchConfigurationName:
          _s.extractXmlStringValue(elem, 'LaunchConfigurationName')!,
      associatePublicIpAddress:
          _s.extractXmlBoolValue(elem, 'AssociatePublicIpAddress'),
      blockDeviceMappings: _s.extractXmlChild(elem, 'BlockDeviceMappings')?.let(
          (elem) => elem
              .findElements('member')
              .map((c) => BlockDeviceMapping.fromXml(c))
              .toList()),
      classicLinkVPCId: _s.extractXmlStringValue(elem, 'ClassicLinkVPCId'),
      classicLinkVPCSecurityGroups: _s
          .extractXmlChild(elem, 'ClassicLinkVPCSecurityGroups')
          ?.let((elem) => _s.extractXmlStringListValues(elem, 'member')),
      ebsOptimized: _s.extractXmlBoolValue(elem, 'EbsOptimized'),
      iamInstanceProfile: _s.extractXmlStringValue(elem, 'IamInstanceProfile'),
      instanceMonitoring: _s
          .extractXmlChild(elem, 'InstanceMonitoring')
          ?.let((e) => InstanceMonitoring.fromXml(e)),
      kernelId: _s.extractXmlStringValue(elem, 'KernelId'),
      keyName: _s.extractXmlStringValue(elem, 'KeyName'),
      launchConfigurationARN:
          _s.extractXmlStringValue(elem, 'LaunchConfigurationARN'),
      metadataOptions: _s
          .extractXmlChild(elem, 'MetadataOptions')
          ?.let((e) => InstanceMetadataOptions.fromXml(e)),
      placementTenancy: _s.extractXmlStringValue(elem, 'PlacementTenancy'),
      ramdiskId: _s.extractXmlStringValue(elem, 'RamdiskId'),
      securityGroups: _s
          .extractXmlChild(elem, 'SecurityGroups')
          ?.let((elem) => _s.extractXmlStringListValues(elem, 'member')),
      spotPrice: _s.extractXmlStringValue(elem, 'SpotPrice'),
      userData: _s.extractXmlStringValue(elem, 'UserData'),
    );
  }
}

class LaunchConfigurationsType {
  /// The launch configurations.
  final List<LaunchConfiguration> launchConfigurations;

  /// A string that indicates that the response contains more items than can be
  /// returned in a single response. To receive additional items, specify this
  /// string for the <code>NextToken</code> value when requesting the next set of
  /// items. This value is null when there are no more items to return.
  final String? nextToken;

  LaunchConfigurationsType({
    required this.launchConfigurations,
    this.nextToken,
  });
  factory LaunchConfigurationsType.fromXml(_s.XmlElement elem) {
    return LaunchConfigurationsType(
      launchConfigurations: _s
          .extractXmlChild(elem, 'LaunchConfigurations')!
          .findElements('member')
          .map((c) => LaunchConfiguration.fromXml(c))
          .toList(),
      nextToken: _s.extractXmlStringValue(elem, 'NextToken'),
    );
  }
}

/// Describes a launch template and overrides. You specify these properties as
/// part of a mixed instances policy.
class LaunchTemplate {
  /// The launch template to use.
  final LaunchTemplateSpecification? launchTemplateSpecification;

  /// Any properties that you specify override the same properties in the launch
  /// template. If not provided, Amazon EC2 Auto Scaling uses the instance type or
  /// instance type requirements specified in the launch template when it launches
  /// an instance.
  ///
  /// The overrides can include either one or more instance types or a set of
  /// instance requirements, but not both.
  final List<LaunchTemplateOverrides>? overrides;

  LaunchTemplate({
    this.launchTemplateSpecification,
    this.overrides,
  });
  factory LaunchTemplate.fromXml(_s.XmlElement elem) {
    return LaunchTemplate(
      launchTemplateSpecification: _s
          .extractXmlChild(elem, 'LaunchTemplateSpecification')
          ?.let((e) => LaunchTemplateSpecification.fromXml(e)),
      overrides: _s.extractXmlChild(elem, 'Overrides')?.let((elem) => elem
          .findElements('member')
          .map((c) => LaunchTemplateOverrides.fromXml(c))
          .toList()),
    );
  }

  Map<String, dynamic> toJson() {
    final launchTemplateSpecification = this.launchTemplateSpecification;
    final overrides = this.overrides;
    return {
      if (launchTemplateSpecification != null)
        'LaunchTemplateSpecification': launchTemplateSpecification,
      if (overrides != null) 'Overrides': overrides,
    };
  }
}

/// Describes an override for a launch template. For more information, see <a
/// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-configuring-overrides.html">Configuring
/// overrides</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
class LaunchTemplateOverrides {
  /// The instance requirements. When you specify instance requirements, Amazon
  /// EC2 Auto Scaling finds instance types that satisfy your requirements, and
  /// then uses your On-Demand and Spot allocation strategies to launch instances
  /// from these instance types, in the same way as when you specify a list of
  /// specific instance types.
  final InstanceRequirements? instanceRequirements;

  /// The instance type, such as <code>m3.xlarge</code>. You must use an instance
  /// type that is supported in your requested Region and Availability Zones. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html">Instance
  /// types</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.
  final String? instanceType;

  /// Provides a launch template for the specified instance type or instance
  /// requirements. For example, some instance types might require a launch
  /// template with a different AMI. If not provided, Amazon EC2 Auto Scaling uses
  /// the launch template that's defined for your mixed instances policy. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-mixed-instances-groups-launch-template-overrides.html">Specifying
  /// a different launch template for an instance type</a> in the <i>Amazon EC2
  /// Auto Scaling User Guide</i>.
  final LaunchTemplateSpecification? launchTemplateSpecification;

  /// The number of capacity units provided by the instance type specified in
  /// <code>InstanceType</code> in terms of virtual CPUs, memory, storage,
  /// throughput, or other relative performance characteristic. When a Spot or
  /// On-Demand Instance is launched, the capacity units count toward the desired
  /// capacity. Amazon EC2 Auto Scaling launches instances until the desired
  /// capacity is totally fulfilled, even if this results in an overage. For
  /// example, if there are two units remaining to fulfill capacity, and Amazon
  /// EC2 Auto Scaling can only launch an instance with a
  /// <code>WeightedCapacity</code> of five units, the instance is launched, and
  /// the desired capacity is exceeded by three units. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-mixed-instances-groups-instance-weighting.html">Configuring
  /// instance weighting for Amazon EC2 Auto Scaling</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>. Value must be in the range of 1–999.
  final String? weightedCapacity;

  LaunchTemplateOverrides({
    this.instanceRequirements,
    this.instanceType,
    this.launchTemplateSpecification,
    this.weightedCapacity,
  });
  factory LaunchTemplateOverrides.fromXml(_s.XmlElement elem) {
    return LaunchTemplateOverrides(
      instanceRequirements: _s
          .extractXmlChild(elem, 'InstanceRequirements')
          ?.let((e) => InstanceRequirements.fromXml(e)),
      instanceType: _s.extractXmlStringValue(elem, 'InstanceType'),
      launchTemplateSpecification: _s
          .extractXmlChild(elem, 'LaunchTemplateSpecification')
          ?.let((e) => LaunchTemplateSpecification.fromXml(e)),
      weightedCapacity: _s.extractXmlStringValue(elem, 'WeightedCapacity'),
    );
  }

  Map<String, dynamic> toJson() {
    final instanceRequirements = this.instanceRequirements;
    final instanceType = this.instanceType;
    final launchTemplateSpecification = this.launchTemplateSpecification;
    final weightedCapacity = this.weightedCapacity;
    return {
      if (instanceRequirements != null)
        'InstanceRequirements': instanceRequirements,
      if (instanceType != null) 'InstanceType': instanceType,
      if (launchTemplateSpecification != null)
        'LaunchTemplateSpecification': launchTemplateSpecification,
      if (weightedCapacity != null) 'WeightedCapacity': weightedCapacity,
    };
  }
}

/// Describes the launch template and the version of the launch template that
/// Amazon EC2 Auto Scaling uses to launch Amazon EC2 instances. For more
/// information about launch templates, see <a
/// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/LaunchTemplates.html">Launch
/// templates</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
class LaunchTemplateSpecification {
  /// The ID of the launch template. To get the template ID, use the Amazon EC2 <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeLaunchTemplates.html">DescribeLaunchTemplates</a>
  /// API operation. New launch templates can be created using the Amazon EC2 <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateLaunchTemplate.html">CreateLaunchTemplate</a>
  /// API.
  ///
  /// Conditional: You must specify either a <code>LaunchTemplateId</code> or a
  /// <code>LaunchTemplateName</code>.
  final String? launchTemplateId;

  /// The name of the launch template. To get the template name, use the Amazon
  /// EC2 <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeLaunchTemplates.html">DescribeLaunchTemplates</a>
  /// API operation. New launch templates can be created using the Amazon EC2 <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateLaunchTemplate.html">CreateLaunchTemplate</a>
  /// API.
  ///
  /// Conditional: You must specify either a <code>LaunchTemplateId</code> or a
  /// <code>LaunchTemplateName</code>.
  final String? launchTemplateName;

  /// The version number, <code>$Latest</code>, or <code>$Default</code>. To get
  /// the version number, use the Amazon EC2 <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeLaunchTemplateVersions.html">DescribeLaunchTemplateVersions</a>
  /// API operation. New launch template versions can be created using the Amazon
  /// EC2 <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateLaunchTemplateVersion.html">CreateLaunchTemplateVersion</a>
  /// API. If the value is <code>$Latest</code>, Amazon EC2 Auto Scaling selects
  /// the latest version of the launch template when launching instances. If the
  /// value is <code>$Default</code>, Amazon EC2 Auto Scaling selects the default
  /// version of the launch template when launching instances. The default value
  /// is <code>$Default</code>.
  final String? version;

  LaunchTemplateSpecification({
    this.launchTemplateId,
    this.launchTemplateName,
    this.version,
  });
  factory LaunchTemplateSpecification.fromXml(_s.XmlElement elem) {
    return LaunchTemplateSpecification(
      launchTemplateId: _s.extractXmlStringValue(elem, 'LaunchTemplateId'),
      launchTemplateName: _s.extractXmlStringValue(elem, 'LaunchTemplateName'),
      version: _s.extractXmlStringValue(elem, 'Version'),
    );
  }

  Map<String, dynamic> toJson() {
    final launchTemplateId = this.launchTemplateId;
    final launchTemplateName = this.launchTemplateName;
    final version = this.version;
    return {
      if (launchTemplateId != null) 'LaunchTemplateId': launchTemplateId,
      if (launchTemplateName != null) 'LaunchTemplateName': launchTemplateName,
      if (version != null) 'Version': version,
    };
  }
}

/// Describes a lifecycle hook. A lifecycle hook lets you create solutions that
/// are aware of events in the Auto Scaling instance lifecycle, and then perform
/// a custom action on instances when the corresponding lifecycle event occurs.
class LifecycleHook {
  /// The name of the Auto Scaling group for the lifecycle hook.
  final String? autoScalingGroupName;

  /// The action the Auto Scaling group takes when the lifecycle hook timeout
  /// elapses or if an unexpected failure occurs.
  ///
  /// Valid values: <code>CONTINUE</code> | <code>ABANDON</code>
  final String? defaultResult;

  /// The maximum time, in seconds, that an instance can remain in a wait state.
  /// The maximum is 172800 seconds (48 hours) or 100 times
  /// <code>HeartbeatTimeout</code>, whichever is smaller.
  final int? globalTimeout;

  /// The maximum time, in seconds, that can elapse before the lifecycle hook
  /// times out. If the lifecycle hook times out, Amazon EC2 Auto Scaling performs
  /// the action that you specified in the <code>DefaultResult</code> property.
  final int? heartbeatTimeout;

  /// The name of the lifecycle hook.
  final String? lifecycleHookName;

  /// The lifecycle transition.
  ///
  /// Valid values: <code>autoscaling:EC2_INSTANCE_LAUNCHING</code> |
  /// <code>autoscaling:EC2_INSTANCE_TERMINATING</code>
  final String? lifecycleTransition;

  /// Additional information that is included any time Amazon EC2 Auto Scaling
  /// sends a message to the notification target.
  final String? notificationMetadata;

  /// The ARN of the target that Amazon EC2 Auto Scaling sends notifications to
  /// when an instance is in a wait state for the lifecycle hook.
  final String? notificationTargetARN;

  /// The ARN of the IAM role that allows the Auto Scaling group to publish to the
  /// specified notification target (an Amazon SNS topic or an Amazon SQS queue).
  final String? roleARN;

  LifecycleHook({
    this.autoScalingGroupName,
    this.defaultResult,
    this.globalTimeout,
    this.heartbeatTimeout,
    this.lifecycleHookName,
    this.lifecycleTransition,
    this.notificationMetadata,
    this.notificationTargetARN,
    this.roleARN,
  });
  factory LifecycleHook.fromXml(_s.XmlElement elem) {
    return LifecycleHook(
      autoScalingGroupName:
          _s.extractXmlStringValue(elem, 'AutoScalingGroupName'),
      defaultResult: _s.extractXmlStringValue(elem, 'DefaultResult'),
      globalTimeout: _s.extractXmlIntValue(elem, 'GlobalTimeout'),
      heartbeatTimeout: _s.extractXmlIntValue(elem, 'HeartbeatTimeout'),
      lifecycleHookName: _s.extractXmlStringValue(elem, 'LifecycleHookName'),
      lifecycleTransition:
          _s.extractXmlStringValue(elem, 'LifecycleTransition'),
      notificationMetadata:
          _s.extractXmlStringValue(elem, 'NotificationMetadata'),
      notificationTargetARN:
          _s.extractXmlStringValue(elem, 'NotificationTargetARN'),
      roleARN: _s.extractXmlStringValue(elem, 'RoleARN'),
    );
  }
}

/// Describes information used to specify a lifecycle hook for an Auto Scaling
/// group.
///
/// For more information, see <a
/// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/lifecycle-hooks.html">Amazon
/// EC2 Auto Scaling lifecycle hooks</a> in the <i>Amazon EC2 Auto Scaling User
/// Guide</i>.
class LifecycleHookSpecification {
  /// The name of the lifecycle hook.
  final String lifecycleHookName;

  /// The lifecycle transition. For Auto Scaling groups, there are two major
  /// lifecycle transitions.
  ///
  /// <ul>
  /// <li>
  /// To create a lifecycle hook for scale-out events, specify
  /// <code>autoscaling:EC2_INSTANCE_LAUNCHING</code>.
  /// </li>
  /// <li>
  /// To create a lifecycle hook for scale-in events, specify
  /// <code>autoscaling:EC2_INSTANCE_TERMINATING</code>.
  /// </li>
  /// </ul>
  final String lifecycleTransition;

  /// The action the Auto Scaling group takes when the lifecycle hook timeout
  /// elapses or if an unexpected failure occurs. The default value is
  /// <code>ABANDON</code>.
  ///
  /// Valid values: <code>CONTINUE</code> | <code>ABANDON</code>
  final String? defaultResult;

  /// The maximum time, in seconds, that can elapse before the lifecycle hook
  /// times out. The range is from <code>30</code> to <code>7200</code> seconds.
  /// The default value is <code>3600</code> seconds (1 hour).
  final int? heartbeatTimeout;

  /// Additional information that you want to include any time Amazon EC2 Auto
  /// Scaling sends a message to the notification target.
  final String? notificationMetadata;

  /// The Amazon Resource Name (ARN) of the notification target that Amazon EC2
  /// Auto Scaling sends notifications to when an instance is in a wait state for
  /// the lifecycle hook. You can specify an Amazon SNS topic or an Amazon SQS
  /// queue.
  final String? notificationTargetARN;

  /// The ARN of the IAM role that allows the Auto Scaling group to publish to the
  /// specified notification target. For information about creating this role, see
  /// <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/prepare-for-lifecycle-notifications.html#lifecycle-hook-notification-target">Configure
  /// a notification target for a lifecycle hook</a> in the <i>Amazon EC2 Auto
  /// Scaling User Guide</i>.
  ///
  /// Valid only if the notification target is an Amazon SNS topic or an Amazon
  /// SQS queue.
  final String? roleARN;

  LifecycleHookSpecification({
    required this.lifecycleHookName,
    required this.lifecycleTransition,
    this.defaultResult,
    this.heartbeatTimeout,
    this.notificationMetadata,
    this.notificationTargetARN,
    this.roleARN,
  });
  Map<String, dynamic> toJson() {
    final lifecycleHookName = this.lifecycleHookName;
    final lifecycleTransition = this.lifecycleTransition;
    final defaultResult = this.defaultResult;
    final heartbeatTimeout = this.heartbeatTimeout;
    final notificationMetadata = this.notificationMetadata;
    final notificationTargetARN = this.notificationTargetARN;
    final roleARN = this.roleARN;
    return {
      'LifecycleHookName': lifecycleHookName,
      'LifecycleTransition': lifecycleTransition,
      if (defaultResult != null) 'DefaultResult': defaultResult,
      if (heartbeatTimeout != null) 'HeartbeatTimeout': heartbeatTimeout,
      if (notificationMetadata != null)
        'NotificationMetadata': notificationMetadata,
      if (notificationTargetARN != null)
        'NotificationTargetARN': notificationTargetARN,
      if (roleARN != null) 'RoleARN': roleARN,
    };
  }
}

enum LifecycleState {
  pending,
  pendingWait,
  pendingProceed,
  quarantined,
  inService,
  terminating,
  terminatingWait,
  terminatingProceed,
  terminated,
  detaching,
  detached,
  enteringStandby,
  standby,
  warmedPending,
  warmedPendingWait,
  warmedPendingProceed,
  warmedTerminating,
  warmedTerminatingWait,
  warmedTerminatingProceed,
  warmedTerminated,
  warmedStopped,
  warmedRunning,
  warmedHibernated,
}

extension on LifecycleState {
  String toValue() {
    switch (this) {
      case LifecycleState.pending:
        return 'Pending';
      case LifecycleState.pendingWait:
        return 'Pending:Wait';
      case LifecycleState.pendingProceed:
        return 'Pending:Proceed';
      case LifecycleState.quarantined:
        return 'Quarantined';
      case LifecycleState.inService:
        return 'InService';
      case LifecycleState.terminating:
        return 'Terminating';
      case LifecycleState.terminatingWait:
        return 'Terminating:Wait';
      case LifecycleState.terminatingProceed:
        return 'Terminating:Proceed';
      case LifecycleState.terminated:
        return 'Terminated';
      case LifecycleState.detaching:
        return 'Detaching';
      case LifecycleState.detached:
        return 'Detached';
      case LifecycleState.enteringStandby:
        return 'EnteringStandby';
      case LifecycleState.standby:
        return 'Standby';
      case LifecycleState.warmedPending:
        return 'Warmed:Pending';
      case LifecycleState.warmedPendingWait:
        return 'Warmed:Pending:Wait';
      case LifecycleState.warmedPendingProceed:
        return 'Warmed:Pending:Proceed';
      case LifecycleState.warmedTerminating:
        return 'Warmed:Terminating';
      case LifecycleState.warmedTerminatingWait:
        return 'Warmed:Terminating:Wait';
      case LifecycleState.warmedTerminatingProceed:
        return 'Warmed:Terminating:Proceed';
      case LifecycleState.warmedTerminated:
        return 'Warmed:Terminated';
      case LifecycleState.warmedStopped:
        return 'Warmed:Stopped';
      case LifecycleState.warmedRunning:
        return 'Warmed:Running';
      case LifecycleState.warmedHibernated:
        return 'Warmed:Hibernated';
    }
  }
}

extension on String {
  LifecycleState toLifecycleState() {
    switch (this) {
      case 'Pending':
        return LifecycleState.pending;
      case 'Pending:Wait':
        return LifecycleState.pendingWait;
      case 'Pending:Proceed':
        return LifecycleState.pendingProceed;
      case 'Quarantined':
        return LifecycleState.quarantined;
      case 'InService':
        return LifecycleState.inService;
      case 'Terminating':
        return LifecycleState.terminating;
      case 'Terminating:Wait':
        return LifecycleState.terminatingWait;
      case 'Terminating:Proceed':
        return LifecycleState.terminatingProceed;
      case 'Terminated':
        return LifecycleState.terminated;
      case 'Detaching':
        return LifecycleState.detaching;
      case 'Detached':
        return LifecycleState.detached;
      case 'EnteringStandby':
        return LifecycleState.enteringStandby;
      case 'Standby':
        return LifecycleState.standby;
      case 'Warmed:Pending':
        return LifecycleState.warmedPending;
      case 'Warmed:Pending:Wait':
        return LifecycleState.warmedPendingWait;
      case 'Warmed:Pending:Proceed':
        return LifecycleState.warmedPendingProceed;
      case 'Warmed:Terminating':
        return LifecycleState.warmedTerminating;
      case 'Warmed:Terminating:Wait':
        return LifecycleState.warmedTerminatingWait;
      case 'Warmed:Terminating:Proceed':
        return LifecycleState.warmedTerminatingProceed;
      case 'Warmed:Terminated':
        return LifecycleState.warmedTerminated;
      case 'Warmed:Stopped':
        return LifecycleState.warmedStopped;
      case 'Warmed:Running':
        return LifecycleState.warmedRunning;
      case 'Warmed:Hibernated':
        return LifecycleState.warmedHibernated;
    }
    throw Exception('$this is not known in enum LifecycleState');
  }
}

/// Describes the state of a Classic Load Balancer.
class LoadBalancerState {
  /// The name of the load balancer.
  final String? loadBalancerName;

  /// One of the following load balancer states:
  ///
  /// <ul>
  /// <li>
  /// <code>Adding</code> - The Auto Scaling instances are being registered with
  /// the load balancer.
  /// </li>
  /// <li>
  /// <code>Added</code> - All Auto Scaling instances are registered with the load
  /// balancer.
  /// </li>
  /// <li>
  /// <code>InService</code> - At least one Auto Scaling instance passed an
  /// <code>ELB</code> health check.
  /// </li>
  /// <li>
  /// <code>Removing</code> - The Auto Scaling instances are being deregistered
  /// from the load balancer. If connection draining is enabled, Elastic Load
  /// Balancing waits for in-flight requests to complete before deregistering the
  /// instances.
  /// </li>
  /// <li>
  /// <code>Removed</code> - All Auto Scaling instances are deregistered from the
  /// load balancer.
  /// </li>
  /// </ul>
  final String? state;

  LoadBalancerState({
    this.loadBalancerName,
    this.state,
  });
  factory LoadBalancerState.fromXml(_s.XmlElement elem) {
    return LoadBalancerState(
      loadBalancerName: _s.extractXmlStringValue(elem, 'LoadBalancerName'),
      state: _s.extractXmlStringValue(elem, 'State'),
    );
  }
}

/// Describes the state of a target group.
class LoadBalancerTargetGroupState {
  /// The Amazon Resource Name (ARN) of the target group.
  final String? loadBalancerTargetGroupARN;

  /// The state of the target group.
  ///
  /// <ul>
  /// <li>
  /// <code>Adding</code> - The Auto Scaling instances are being registered with
  /// the target group.
  /// </li>
  /// <li>
  /// <code>Added</code> - All Auto Scaling instances are registered with the
  /// target group.
  /// </li>
  /// <li>
  /// <code>InService</code> - At least one Auto Scaling instance passed an
  /// <code>ELB</code> health check.
  /// </li>
  /// <li>
  /// <code>Removing</code> - The Auto Scaling instances are being deregistered
  /// from the target group. If connection draining is enabled, Elastic Load
  /// Balancing waits for in-flight requests to complete before deregistering the
  /// instances.
  /// </li>
  /// <li>
  /// <code>Removed</code> - All Auto Scaling instances are deregistered from the
  /// target group.
  /// </li>
  /// </ul>
  final String? state;

  LoadBalancerTargetGroupState({
    this.loadBalancerTargetGroupARN,
    this.state,
  });
  factory LoadBalancerTargetGroupState.fromXml(_s.XmlElement elem) {
    return LoadBalancerTargetGroupState(
      loadBalancerTargetGroupARN:
          _s.extractXmlStringValue(elem, 'LoadBalancerTargetGroupARN'),
      state: _s.extractXmlStringValue(elem, 'State'),
    );
  }
}

/// A <code>GetPredictiveScalingForecast</code> call returns the load forecast
/// for a predictive scaling policy. This structure includes the data points for
/// that load forecast, along with the timestamps of those data points and the
/// metric specification.
class LoadForecast {
  /// The metric specification for the load forecast.
  final PredictiveScalingMetricSpecification metricSpecification;

  /// The timestamps for the data points, in UTC format.
  final List<DateTime> timestamps;

  /// The values of the data points.
  final List<double> values;

  LoadForecast({
    required this.metricSpecification,
    required this.timestamps,
    required this.values,
  });
  factory LoadForecast.fromXml(_s.XmlElement elem) {
    return LoadForecast(
      metricSpecification: PredictiveScalingMetricSpecification.fromXml(
          _s.extractXmlChild(elem, 'MetricSpecification')!),
      timestamps: _s.extractXmlDateTimeListValues(
          _s.extractXmlChild(elem, 'Timestamps')!, 'member'),
      values: _s.extractXmlDoubleListValues(
          _s.extractXmlChild(elem, 'Values')!, 'member'),
    );
  }
}

enum LocalStorage {
  included,
  excluded,
  required,
}

extension on LocalStorage {
  String toValue() {
    switch (this) {
      case LocalStorage.included:
        return 'included';
      case LocalStorage.excluded:
        return 'excluded';
      case LocalStorage.required:
        return 'required';
    }
  }
}

extension on String {
  LocalStorage toLocalStorage() {
    switch (this) {
      case 'included':
        return LocalStorage.included;
      case 'excluded':
        return LocalStorage.excluded;
      case 'required':
        return LocalStorage.required;
    }
    throw Exception('$this is not known in enum LocalStorage');
  }
}

enum LocalStorageType {
  hdd,
  ssd,
}

extension on LocalStorageType {
  String toValue() {
    switch (this) {
      case LocalStorageType.hdd:
        return 'hdd';
      case LocalStorageType.ssd:
        return 'ssd';
    }
  }
}

extension on String {
  LocalStorageType toLocalStorageType() {
    switch (this) {
      case 'hdd':
        return LocalStorageType.hdd;
      case 'ssd':
        return LocalStorageType.ssd;
    }
    throw Exception('$this is not known in enum LocalStorageType');
  }
}

/// Specifies the minimum and maximum for the <code>MemoryGiBPerVCpu</code>
/// object when you specify <a>InstanceRequirements</a> for an Auto Scaling
/// group.
class MemoryGiBPerVCpuRequest {
  /// The memory maximum in GiB.
  final double? max;

  /// The memory minimum in GiB.
  final double? min;

  MemoryGiBPerVCpuRequest({
    this.max,
    this.min,
  });
  factory MemoryGiBPerVCpuRequest.fromXml(_s.XmlElement elem) {
    return MemoryGiBPerVCpuRequest(
      max: _s.extractXmlDoubleValue(elem, 'Max'),
      min: _s.extractXmlDoubleValue(elem, 'Min'),
    );
  }

  Map<String, dynamic> toJson() {
    final max = this.max;
    final min = this.min;
    return {
      if (max != null) 'Max': max,
      if (min != null) 'Min': min,
    };
  }
}

/// Specifies the minimum and maximum for the <code>MemoryMiB</code> object when
/// you specify <a>InstanceRequirements</a> for an Auto Scaling group.
class MemoryMiBRequest {
  /// The memory minimum in MiB.
  final int min;

  /// The memory maximum in MiB.
  final int? max;

  MemoryMiBRequest({
    required this.min,
    this.max,
  });
  factory MemoryMiBRequest.fromXml(_s.XmlElement elem) {
    return MemoryMiBRequest(
      min: _s.extractXmlIntValue(elem, 'Min')!,
      max: _s.extractXmlIntValue(elem, 'Max'),
    );
  }

  Map<String, dynamic> toJson() {
    final min = this.min;
    final max = this.max;
    return {
      'Min': min,
      if (max != null) 'Max': max,
    };
  }
}

/// Represents a specific metric.
class Metric {
  /// The name of the metric.
  final String metricName;

  /// The namespace of the metric. For more information, see the table in <a
  /// href="https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html">Amazon
  /// Web Services services that publish CloudWatch metrics </a> in the <i>Amazon
  /// CloudWatch User Guide</i>.
  final String namespace;

  /// The dimensions for the metric. For the list of available dimensions, see the
  /// Amazon Web Services documentation available from the table in <a
  /// href="https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html">Amazon
  /// Web Services services that publish CloudWatch metrics </a> in the <i>Amazon
  /// CloudWatch User Guide</i>.
  ///
  /// Conditional: If you published your metric with dimensions, you must specify
  /// the same dimensions in your scaling policy.
  final List<MetricDimension>? dimensions;

  Metric({
    required this.metricName,
    required this.namespace,
    this.dimensions,
  });
  factory Metric.fromXml(_s.XmlElement elem) {
    return Metric(
      metricName: _s.extractXmlStringValue(elem, 'MetricName')!,
      namespace: _s.extractXmlStringValue(elem, 'Namespace')!,
      dimensions: _s.extractXmlChild(elem, 'Dimensions')?.let((elem) => elem
          .findElements('member')
          .map((c) => MetricDimension.fromXml(c))
          .toList()),
    );
  }

  Map<String, dynamic> toJson() {
    final metricName = this.metricName;
    final namespace = this.namespace;
    final dimensions = this.dimensions;
    return {
      'MetricName': metricName,
      'Namespace': namespace,
      if (dimensions != null) 'Dimensions': dimensions,
    };
  }
}

/// Describes a metric.
class MetricCollectionType {
  /// One of the following metrics:
  ///
  /// <ul>
  /// <li>
  /// <code>GroupMinSize</code>
  /// </li>
  /// <li>
  /// <code>GroupMaxSize</code>
  /// </li>
  /// <li>
  /// <code>GroupDesiredCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupInServiceInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupPendingInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupStandbyInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupTerminatingInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupTotalInstances</code>
  /// </li>
  /// <li>
  /// <code>GroupInServiceCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupPendingCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupStandbyCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupTerminatingCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupTotalCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolDesiredCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolWarmedCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolPendingCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolTerminatingCapacity</code>
  /// </li>
  /// <li>
  /// <code>WarmPoolTotalCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupAndWarmPoolDesiredCapacity</code>
  /// </li>
  /// <li>
  /// <code>GroupAndWarmPoolTotalCapacity</code>
  /// </li>
  /// </ul>
  final String? metric;

  MetricCollectionType({
    this.metric,
  });
  factory MetricCollectionType.fromXml(_s.XmlElement elem) {
    return MetricCollectionType(
      metric: _s.extractXmlStringValue(elem, 'Metric'),
    );
  }
}

/// The metric data to return. Also defines whether this call is returning data
/// for one metric only, or whether it is performing a math expression on the
/// values of returned metric statistics to create a new time series. A time
/// series is a series of data points, each of which is associated with a
/// timestamp.
///
/// For more information and examples, see <a
/// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/predictive-scaling-customized-metric-specification.html">Advanced
/// predictive scaling policy configurations using custom metrics</a> in the
/// <i>Amazon EC2 Auto Scaling User Guide</i>.
class MetricDataQuery {
  /// A short name that identifies the object's results in the response. This name
  /// must be unique among all <code>MetricDataQuery</code> objects specified for
  /// a single scaling policy. If you are performing math expressions on this set
  /// of data, this name represents that data and can serve as a variable in the
  /// mathematical expression. The valid characters are letters, numbers, and
  /// underscores. The first character must be a lowercase letter.
  final String id;

  /// The math expression to perform on the returned data, if this object is
  /// performing a math expression. This expression can use the <code>Id</code> of
  /// the other metrics to refer to those metrics, and can also use the
  /// <code>Id</code> of other expressions to use the result of those expressions.
  ///
  /// Conditional: Within each <code>MetricDataQuery</code> object, you must
  /// specify either <code>Expression</code> or <code>MetricStat</code>, but not
  /// both.
  final String? expression;

  /// A human-readable label for this metric or expression. This is especially
  /// useful if this is a math expression, so that you know what the value
  /// represents.
  final String? label;

  /// Information about the metric data to return.
  ///
  /// Conditional: Within each <code>MetricDataQuery</code> object, you must
  /// specify either <code>Expression</code> or <code>MetricStat</code>, but not
  /// both.
  final MetricStat? metricStat;

  /// Indicates whether to return the timestamps and raw data values of this
  /// metric.
  ///
  /// If you use any math expressions, specify <code>true</code> for this value
  /// for only the final math expression that the metric specification is based
  /// on. You must specify <code>false</code> for <code>ReturnData</code> for all
  /// the other metrics and expressions used in the metric specification.
  ///
  /// If you are only retrieving metrics and not performing any math expressions,
  /// do not specify anything for <code>ReturnData</code>. This sets it to its
  /// default (<code>true</code>).
  final bool? returnData;

  MetricDataQuery({
    required this.id,
    this.expression,
    this.label,
    this.metricStat,
    this.returnData,
  });
  factory MetricDataQuery.fromXml(_s.XmlElement elem) {
    return MetricDataQuery(
      id: _s.extractXmlStringValue(elem, 'Id')!,
      expression: _s.extractXmlStringValue(elem, 'Expression'),
      label: _s.extractXmlStringValue(elem, 'Label'),
      metricStat: _s
          .extractXmlChild(elem, 'MetricStat')
          ?.let((e) => MetricStat.fromXml(e)),
      returnData: _s.extractXmlBoolValue(elem, 'ReturnData'),
    );
  }

  Map<String, dynamic> toJson() {
    final id = this.id;
    final expression = this.expression;
    final label = this.label;
    final metricStat = this.metricStat;
    final returnData = this.returnData;
    return {
      'Id': id,
      if (expression != null) 'Expression': expression,
      if (label != null) 'Label': label,
      if (metricStat != null) 'MetricStat': metricStat,
      if (returnData != null) 'ReturnData': returnData,
    };
  }
}

/// Describes the dimension of a metric.
class MetricDimension {
  /// The name of the dimension.
  final String name;

  /// The value of the dimension.
  final String value;

  MetricDimension({
    required this.name,
    required this.value,
  });
  factory MetricDimension.fromXml(_s.XmlElement elem) {
    return MetricDimension(
      name: _s.extractXmlStringValue(elem, 'Name')!,
      value: _s.extractXmlStringValue(elem, 'Value')!,
    );
  }

  Map<String, dynamic> toJson() {
    final name = this.name;
    final value = this.value;
    return {
      'Name': name,
      'Value': value,
    };
  }
}

/// Describes a granularity of a metric.
class MetricGranularityType {
  /// The granularity. The only valid value is <code>1Minute</code>.
  final String? granularity;

  MetricGranularityType({
    this.granularity,
  });
  factory MetricGranularityType.fromXml(_s.XmlElement elem) {
    return MetricGranularityType(
      granularity: _s.extractXmlStringValue(elem, 'Granularity'),
    );
  }
}

/// This structure defines the CloudWatch metric to return, along with the
/// statistic, period, and unit.
///
/// For more information about the CloudWatch terminology below, see <a
/// href="https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html">Amazon
/// CloudWatch concepts</a> in the <i>Amazon CloudWatch User Guide</i>.
class MetricStat {
  /// The CloudWatch metric to return, including the metric name, namespace, and
  /// dimensions. To get the exact metric name, namespace, and dimensions, inspect
  /// the <a
  /// href="https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_Metric.html">Metric</a>
  /// object that is returned by a call to <a
  /// href="https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_ListMetrics.html">ListMetrics</a>.
  final Metric metric;

  /// The statistic to return. It can include any CloudWatch statistic or extended
  /// statistic. For a list of valid values, see the table in <a
  /// href="https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html#Statistic">Statistics</a>
  /// in the <i>Amazon CloudWatch User Guide</i>.
  ///
  /// The most commonly used metrics for predictive scaling are
  /// <code>Average</code> and <code>Sum</code>.
  final String stat;

  /// The unit to use for the returned data points. For a complete list of the
  /// units that CloudWatch supports, see the <a
  /// href="https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_MetricDatum.html">MetricDatum</a>
  /// data type in the <i>Amazon CloudWatch API Reference</i>.
  final String? unit;

  MetricStat({
    required this.metric,
    required this.stat,
    this.unit,
  });
  factory MetricStat.fromXml(_s.XmlElement elem) {
    return MetricStat(
      metric: Metric.fromXml(_s.extractXmlChild(elem, 'Metric')!),
      stat: _s.extractXmlStringValue(elem, 'Stat')!,
      unit: _s.extractXmlStringValue(elem, 'Unit'),
    );
  }

  Map<String, dynamic> toJson() {
    final metric = this.metric;
    final stat = this.stat;
    final unit = this.unit;
    return {
      'Metric': metric,
      'Stat': stat,
      if (unit != null) 'Unit': unit,
    };
  }
}

enum MetricStatistic {
  average,
  minimum,
  maximum,
  sampleCount,
  sum,
}

extension on MetricStatistic {
  String toValue() {
    switch (this) {
      case MetricStatistic.average:
        return 'Average';
      case MetricStatistic.minimum:
        return 'Minimum';
      case MetricStatistic.maximum:
        return 'Maximum';
      case MetricStatistic.sampleCount:
        return 'SampleCount';
      case MetricStatistic.sum:
        return 'Sum';
    }
  }
}

extension on String {
  MetricStatistic toMetricStatistic() {
    switch (this) {
      case 'Average':
        return MetricStatistic.average;
      case 'Minimum':
        return MetricStatistic.minimum;
      case 'Maximum':
        return MetricStatistic.maximum;
      case 'SampleCount':
        return MetricStatistic.sampleCount;
      case 'Sum':
        return MetricStatistic.sum;
    }
    throw Exception('$this is not known in enum MetricStatistic');
  }
}

enum MetricType {
  aSGAverageCPUUtilization,
  aSGAverageNetworkIn,
  aSGAverageNetworkOut,
  aLBRequestCountPerTarget,
}

extension on MetricType {
  String toValue() {
    switch (this) {
      case MetricType.aSGAverageCPUUtilization:
        return 'ASGAverageCPUUtilization';
      case MetricType.aSGAverageNetworkIn:
        return 'ASGAverageNetworkIn';
      case MetricType.aSGAverageNetworkOut:
        return 'ASGAverageNetworkOut';
      case MetricType.aLBRequestCountPerTarget:
        return 'ALBRequestCountPerTarget';
    }
  }
}

extension on String {
  MetricType toMetricType() {
    switch (this) {
      case 'ASGAverageCPUUtilization':
        return MetricType.aSGAverageCPUUtilization;
      case 'ASGAverageNetworkIn':
        return MetricType.aSGAverageNetworkIn;
      case 'ASGAverageNetworkOut':
        return MetricType.aSGAverageNetworkOut;
      case 'ALBRequestCountPerTarget':
        return MetricType.aLBRequestCountPerTarget;
    }
    throw Exception('$this is not known in enum MetricType');
  }
}

/// Describes a mixed instances policy. A mixed instances policy contains the
/// instance types that Amazon EC2 Auto Scaling can launch and other information
/// that Amazon EC2 Auto Scaling can use to launch instances and help optimize
/// your costs. For more information, see <a
/// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-mixed-instances-groups.html">Auto
/// Scaling groups with multiple instance types and purchase options</a> in the
/// <i>Amazon EC2 Auto Scaling User Guide</i>.
class MixedInstancesPolicy {
  /// The instances distribution.
  final InstancesDistribution? instancesDistribution;

  /// One or more launch templates and the instance types (overrides) that are
  /// used to launch EC2 instances to fulfill On-Demand and Spot capacities.
  final LaunchTemplate? launchTemplate;

  MixedInstancesPolicy({
    this.instancesDistribution,
    this.launchTemplate,
  });
  factory MixedInstancesPolicy.fromXml(_s.XmlElement elem) {
    return MixedInstancesPolicy(
      instancesDistribution: _s
          .extractXmlChild(elem, 'InstancesDistribution')
          ?.let((e) => InstancesDistribution.fromXml(e)),
      launchTemplate: _s
          .extractXmlChild(elem, 'LaunchTemplate')
          ?.let((e) => LaunchTemplate.fromXml(e)),
    );
  }

  Map<String, dynamic> toJson() {
    final instancesDistribution = this.instancesDistribution;
    final launchTemplate = this.launchTemplate;
    return {
      if (instancesDistribution != null)
        'InstancesDistribution': instancesDistribution,
      if (launchTemplate != null) 'LaunchTemplate': launchTemplate,
    };
  }
}

/// Specifies the minimum and maximum for the <code>NetworkInterfaceCount</code>
/// object when you specify <a>InstanceRequirements</a> for an Auto Scaling
/// group.
class NetworkInterfaceCountRequest {
  /// The maximum number of network interfaces.
  final int? max;

  /// The minimum number of network interfaces.
  final int? min;

  NetworkInterfaceCountRequest({
    this.max,
    this.min,
  });
  factory NetworkInterfaceCountRequest.fromXml(_s.XmlElement elem) {
    return NetworkInterfaceCountRequest(
      max: _s.extractXmlIntValue(elem, 'Max'),
      min: _s.extractXmlIntValue(elem, 'Min'),
    );
  }

  Map<String, dynamic> toJson() {
    final max = this.max;
    final min = this.min;
    return {
      if (max != null) 'Max': max,
      if (min != null) 'Min': min,
    };
  }
}

/// Describes a notification.
class NotificationConfiguration {
  /// The name of the Auto Scaling group.
  final String? autoScalingGroupName;

  /// One of the following event notification types:
  ///
  /// <ul>
  /// <li>
  /// <code>autoscaling:EC2_INSTANCE_LAUNCH</code>
  /// </li>
  /// <li>
  /// <code>autoscaling:EC2_INSTANCE_LAUNCH_ERROR</code>
  /// </li>
  /// <li>
  /// <code>autoscaling:EC2_INSTANCE_TERMINATE</code>
  /// </li>
  /// <li>
  /// <code>autoscaling:EC2_INSTANCE_TERMINATE_ERROR</code>
  /// </li>
  /// <li>
  /// <code>autoscaling:TEST_NOTIFICATION</code>
  /// </li>
  /// </ul>
  final String? notificationType;

  /// The Amazon Resource Name (ARN) of the Amazon SNS topic.
  final String? topicARN;

  NotificationConfiguration({
    this.autoScalingGroupName,
    this.notificationType,
    this.topicARN,
  });
  factory NotificationConfiguration.fromXml(_s.XmlElement elem) {
    return NotificationConfiguration(
      autoScalingGroupName:
          _s.extractXmlStringValue(elem, 'AutoScalingGroupName'),
      notificationType: _s.extractXmlStringValue(elem, 'NotificationType'),
      topicARN: _s.extractXmlStringValue(elem, 'TopicARN'),
    );
  }
}

class PoliciesType {
  /// A string that indicates that the response contains more items than can be
  /// returned in a single response. To receive additional items, specify this
  /// string for the <code>NextToken</code> value when requesting the next set of
  /// items. This value is null when there are no more items to return.
  final String? nextToken;

  /// The scaling policies.
  final List<ScalingPolicy>? scalingPolicies;

  PoliciesType({
    this.nextToken,
    this.scalingPolicies,
  });
  factory PoliciesType.fromXml(_s.XmlElement elem) {
    return PoliciesType(
      nextToken: _s.extractXmlStringValue(elem, 'NextToken'),
      scalingPolicies: _s.extractXmlChild(elem, 'ScalingPolicies')?.let(
          (elem) => elem
              .findElements('member')
              .map((c) => ScalingPolicy.fromXml(c))
              .toList()),
    );
  }
}

/// Contains the output of PutScalingPolicy.
class PolicyARNType {
  /// The CloudWatch alarms created for the target tracking scaling policy.
  final List<Alarm>? alarms;

  /// The Amazon Resource Name (ARN) of the policy.
  final String? policyARN;

  PolicyARNType({
    this.alarms,
    this.policyARN,
  });
  factory PolicyARNType.fromXml(_s.XmlElement elem) {
    return PolicyARNType(
      alarms: _s.extractXmlChild(elem, 'Alarms')?.let((elem) =>
          elem.findElements('member').map((c) => Alarm.fromXml(c)).toList()),
      policyARN: _s.extractXmlStringValue(elem, 'PolicyARN'),
    );
  }
}

enum PredefinedLoadMetricType {
  aSGTotalCPUUtilization,
  aSGTotalNetworkIn,
  aSGTotalNetworkOut,
  aLBTargetGroupRequestCount,
}

extension on PredefinedLoadMetricType {
  String toValue() {
    switch (this) {
      case PredefinedLoadMetricType.aSGTotalCPUUtilization:
        return 'ASGTotalCPUUtilization';
      case PredefinedLoadMetricType.aSGTotalNetworkIn:
        return 'ASGTotalNetworkIn';
      case PredefinedLoadMetricType.aSGTotalNetworkOut:
        return 'ASGTotalNetworkOut';
      case PredefinedLoadMetricType.aLBTargetGroupRequestCount:
        return 'ALBTargetGroupRequestCount';
    }
  }
}

extension on String {
  PredefinedLoadMetricType toPredefinedLoadMetricType() {
    switch (this) {
      case 'ASGTotalCPUUtilization':
        return PredefinedLoadMetricType.aSGTotalCPUUtilization;
      case 'ASGTotalNetworkIn':
        return PredefinedLoadMetricType.aSGTotalNetworkIn;
      case 'ASGTotalNetworkOut':
        return PredefinedLoadMetricType.aSGTotalNetworkOut;
      case 'ALBTargetGroupRequestCount':
        return PredefinedLoadMetricType.aLBTargetGroupRequestCount;
    }
    throw Exception('$this is not known in enum PredefinedLoadMetricType');
  }
}

enum PredefinedMetricPairType {
  aSGCPUUtilization,
  aSGNetworkIn,
  aSGNetworkOut,
  aLBRequestCount,
}

extension on PredefinedMetricPairType {
  String toValue() {
    switch (this) {
      case PredefinedMetricPairType.aSGCPUUtilization:
        return 'ASGCPUUtilization';
      case PredefinedMetricPairType.aSGNetworkIn:
        return 'ASGNetworkIn';
      case PredefinedMetricPairType.aSGNetworkOut:
        return 'ASGNetworkOut';
      case PredefinedMetricPairType.aLBRequestCount:
        return 'ALBRequestCount';
    }
  }
}

extension on String {
  PredefinedMetricPairType toPredefinedMetricPairType() {
    switch (this) {
      case 'ASGCPUUtilization':
        return PredefinedMetricPairType.aSGCPUUtilization;
      case 'ASGNetworkIn':
        return PredefinedMetricPairType.aSGNetworkIn;
      case 'ASGNetworkOut':
        return PredefinedMetricPairType.aSGNetworkOut;
      case 'ALBRequestCount':
        return PredefinedMetricPairType.aLBRequestCount;
    }
    throw Exception('$this is not known in enum PredefinedMetricPairType');
  }
}

/// Represents a predefined metric for a target tracking scaling policy to use
/// with Amazon EC2 Auto Scaling.
class PredefinedMetricSpecification {
  /// The metric type. The following predefined metrics are available:
  ///
  /// <ul>
  /// <li>
  /// <code>ASGAverageCPUUtilization</code> - Average CPU utilization of the Auto
  /// Scaling group.
  /// </li>
  /// <li>
  /// <code>ASGAverageNetworkIn</code> - Average number of bytes received on all
  /// network interfaces by the Auto Scaling group.
  /// </li>
  /// <li>
  /// <code>ASGAverageNetworkOut</code> - Average number of bytes sent out on all
  /// network interfaces by the Auto Scaling group.
  /// </li>
  /// <li>
  /// <code>ALBRequestCountPerTarget</code> - Average Application Load Balancer
  /// request count per target for your Auto Scaling group.
  /// </li>
  /// </ul>
  final MetricType predefinedMetricType;

  /// A label that uniquely identifies a specific Application Load Balancer target
  /// group from which to determine the average request count served by your Auto
  /// Scaling group. You can't specify a resource label unless the target group is
  /// attached to the Auto Scaling group.
  ///
  /// You create the resource label by appending the final portion of the load
  /// balancer ARN and the final portion of the target group ARN into a single
  /// value, separated by a forward slash (/). The format of the resource label
  /// is:
  ///
  /// <code>app/my-alb/778d41231b141a0f/targetgroup/my-alb-target-group/943f017f100becff</code>.
  ///
  /// Where:
  ///
  /// <ul>
  /// <li>
  /// app/&lt;load-balancer-name&gt;/&lt;load-balancer-id&gt; is the final portion
  /// of the load balancer ARN
  /// </li>
  /// <li>
  /// targetgroup/&lt;target-group-name&gt;/&lt;target-group-id&gt; is the final
  /// portion of the target group ARN.
  /// </li>
  /// </ul>
  /// To find the ARN for an Application Load Balancer, use the <a
  /// href="https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeLoadBalancers.html">DescribeLoadBalancers</a>
  /// API operation. To find the ARN for the target group, use the <a
  /// href="https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeTargetGroups.html">DescribeTargetGroups</a>
  /// API operation.
  final String? resourceLabel;

  PredefinedMetricSpecification({
    required this.predefinedMetricType,
    this.resourceLabel,
  });
  factory PredefinedMetricSpecification.fromXml(_s.XmlElement elem) {
    return PredefinedMetricSpecification(
      predefinedMetricType: _s
          .extractXmlStringValue(elem, 'PredefinedMetricType')!
          .toMetricType(),
      resourceLabel: _s.extractXmlStringValue(elem, 'ResourceLabel'),
    );
  }

  Map<String, dynamic> toJson() {
    final predefinedMetricType = this.predefinedMetricType;
    final resourceLabel = this.resourceLabel;
    return {
      'PredefinedMetricType': predefinedMetricType.toValue(),
      if (resourceLabel != null) 'ResourceLabel': resourceLabel,
    };
  }
}

enum PredefinedScalingMetricType {
  aSGAverageCPUUtilization,
  aSGAverageNetworkIn,
  aSGAverageNetworkOut,
  aLBRequestCountPerTarget,
}

extension on PredefinedScalingMetricType {
  String toValue() {
    switch (this) {
      case PredefinedScalingMetricType.aSGAverageCPUUtilization:
        return 'ASGAverageCPUUtilization';
      case PredefinedScalingMetricType.aSGAverageNetworkIn:
        return 'ASGAverageNetworkIn';
      case PredefinedScalingMetricType.aSGAverageNetworkOut:
        return 'ASGAverageNetworkOut';
      case PredefinedScalingMetricType.aLBRequestCountPerTarget:
        return 'ALBRequestCountPerTarget';
    }
  }
}

extension on String {
  PredefinedScalingMetricType toPredefinedScalingMetricType() {
    switch (this) {
      case 'ASGAverageCPUUtilization':
        return PredefinedScalingMetricType.aSGAverageCPUUtilization;
      case 'ASGAverageNetworkIn':
        return PredefinedScalingMetricType.aSGAverageNetworkIn;
      case 'ASGAverageNetworkOut':
        return PredefinedScalingMetricType.aSGAverageNetworkOut;
      case 'ALBRequestCountPerTarget':
        return PredefinedScalingMetricType.aLBRequestCountPerTarget;
    }
    throw Exception('$this is not known in enum PredefinedScalingMetricType');
  }
}

/// Represents a predictive scaling policy configuration to use with Amazon EC2
/// Auto Scaling.
class PredictiveScalingConfiguration {
  /// This structure includes the metrics and target utilization to use for
  /// predictive scaling.
  ///
  /// This is an array, but we currently only support a single metric
  /// specification. That is, you can specify a target value and a single metric
  /// pair, or a target value and one scaling metric and one load metric.
  final List<PredictiveScalingMetricSpecification> metricSpecifications;

  /// Defines the behavior that should be applied if the forecast capacity
  /// approaches or exceeds the maximum capacity of the Auto Scaling group.
  /// Defaults to <code>HonorMaxCapacity</code> if not specified.
  ///
  /// The following are possible values:
  ///
  /// <ul>
  /// <li>
  /// <code>HonorMaxCapacity</code> - Amazon EC2 Auto Scaling cannot scale out
  /// capacity higher than the maximum capacity. The maximum capacity is enforced
  /// as a hard limit.
  /// </li>
  /// <li>
  /// <code>IncreaseMaxCapacity</code> - Amazon EC2 Auto Scaling can scale out
  /// capacity higher than the maximum capacity when the forecast capacity is
  /// close to or exceeds the maximum capacity. The upper limit is determined by
  /// the forecasted capacity and the value for <code>MaxCapacityBuffer</code>.
  /// </li>
  /// </ul>
  final PredictiveScalingMaxCapacityBreachBehavior? maxCapacityBreachBehavior;

  /// The size of the capacity buffer to use when the forecast capacity is close
  /// to or exceeds the maximum capacity. The value is specified as a percentage
  /// relative to the forecast capacity. For example, if the buffer is 10, this
  /// means a 10 percent buffer, such that if the forecast capacity is 50, and the
  /// maximum capacity is 40, then the effective maximum capacity is 55.
  ///
  /// If set to 0, Amazon EC2 Auto Scaling may scale capacity higher than the
  /// maximum capacity to equal but not exceed forecast capacity.
  ///
  /// Required if the <code>MaxCapacityBreachBehavior</code> property is set to
  /// <code>IncreaseMaxCapacity</code>, and cannot be used otherwise.
  final int? maxCapacityBuffer;

  /// The predictive scaling mode. Defaults to <code>ForecastOnly</code> if not
  /// specified.
  final PredictiveScalingMode? mode;

  /// The amount of time, in seconds, by which the instance launch time can be
  /// advanced. For example, the forecast says to add capacity at 10:00 AM, and
  /// you choose to pre-launch instances by 5 minutes. In that case, the instances
  /// will be launched at 9:55 AM. The intention is to give resources time to be
  /// provisioned. It can take a few minutes to launch an EC2 instance. The actual
  /// amount of time required depends on several factors, such as the size of the
  /// instance and whether there are startup scripts to complete.
  ///
  /// The value must be less than the forecast interval duration of 3600 seconds
  /// (60 minutes). Defaults to 300 seconds if not specified.
  final int? schedulingBufferTime;

  PredictiveScalingConfiguration({
    required this.metricSpecifications,
    this.maxCapacityBreachBehavior,
    this.maxCapacityBuffer,
    this.mode,
    this.schedulingBufferTime,
  });
  factory PredictiveScalingConfiguration.fromXml(_s.XmlElement elem) {
    return PredictiveScalingConfiguration(
      metricSpecifications: _s
          .extractXmlChild(elem, 'MetricSpecifications')!
          .findElements('member')
          .map((c) => PredictiveScalingMetricSpecification.fromXml(c))
          .toList(),
      maxCapacityBreachBehavior: _s
          .extractXmlStringValue(elem, 'MaxCapacityBreachBehavior')
          ?.toPredictiveScalingMaxCapacityBreachBehavior(),
      maxCapacityBuffer: _s.extractXmlIntValue(elem, 'MaxCapacityBuffer'),
      mode: _s.extractXmlStringValue(elem, 'Mode')?.toPredictiveScalingMode(),
      schedulingBufferTime: _s.extractXmlIntValue(elem, 'SchedulingBufferTime'),
    );
  }

  Map<String, dynamic> toJson() {
    final metricSpecifications = this.metricSpecifications;
    final maxCapacityBreachBehavior = this.maxCapacityBreachBehavior;
    final maxCapacityBuffer = this.maxCapacityBuffer;
    final mode = this.mode;
    final schedulingBufferTime = this.schedulingBufferTime;
    return {
      'MetricSpecifications': metricSpecifications,
      if (maxCapacityBreachBehavior != null)
        'MaxCapacityBreachBehavior': maxCapacityBreachBehavior.toValue(),
      if (maxCapacityBuffer != null) 'MaxCapacityBuffer': maxCapacityBuffer,
      if (mode != null) 'Mode': mode.toValue(),
      if (schedulingBufferTime != null)
        'SchedulingBufferTime': schedulingBufferTime,
    };
  }
}

/// Describes a customized capacity metric for a predictive scaling policy.
class PredictiveScalingCustomizedCapacityMetric {
  /// One or more metric data queries to provide the data points for a capacity
  /// metric. Use multiple metric data queries only if you are performing a math
  /// expression on returned data.
  final List<MetricDataQuery> metricDataQueries;

  PredictiveScalingCustomizedCapacityMetric({
    required this.metricDataQueries,
  });
  factory PredictiveScalingCustomizedCapacityMetric.fromXml(
      _s.XmlElement elem) {
    return PredictiveScalingCustomizedCapacityMetric(
      metricDataQueries: _s
          .extractXmlChild(elem, 'MetricDataQueries')!
          .findElements('member')
          .map((c) => MetricDataQuery.fromXml(c))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final metricDataQueries = this.metricDataQueries;
    return {
      'MetricDataQueries': metricDataQueries,
    };
  }
}

/// Describes a custom load metric for a predictive scaling policy.
class PredictiveScalingCustomizedLoadMetric {
  /// One or more metric data queries to provide the data points for a load
  /// metric. Use multiple metric data queries only if you are performing a math
  /// expression on returned data.
  final List<MetricDataQuery> metricDataQueries;

  PredictiveScalingCustomizedLoadMetric({
    required this.metricDataQueries,
  });
  factory PredictiveScalingCustomizedLoadMetric.fromXml(_s.XmlElement elem) {
    return PredictiveScalingCustomizedLoadMetric(
      metricDataQueries: _s
          .extractXmlChild(elem, 'MetricDataQueries')!
          .findElements('member')
          .map((c) => MetricDataQuery.fromXml(c))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final metricDataQueries = this.metricDataQueries;
    return {
      'MetricDataQueries': metricDataQueries,
    };
  }
}

/// Describes a custom scaling metric for a predictive scaling policy.
class PredictiveScalingCustomizedScalingMetric {
  /// One or more metric data queries to provide the data points for a scaling
  /// metric. Use multiple metric data queries only if you are performing a math
  /// expression on returned data.
  final List<MetricDataQuery> metricDataQueries;

  PredictiveScalingCustomizedScalingMetric({
    required this.metricDataQueries,
  });
  factory PredictiveScalingCustomizedScalingMetric.fromXml(_s.XmlElement elem) {
    return PredictiveScalingCustomizedScalingMetric(
      metricDataQueries: _s
          .extractXmlChild(elem, 'MetricDataQueries')!
          .findElements('member')
          .map((c) => MetricDataQuery.fromXml(c))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final metricDataQueries = this.metricDataQueries;
    return {
      'MetricDataQueries': metricDataQueries,
    };
  }
}

enum PredictiveScalingMaxCapacityBreachBehavior {
  honorMaxCapacity,
  increaseMaxCapacity,
}

extension on PredictiveScalingMaxCapacityBreachBehavior {
  String toValue() {
    switch (this) {
      case PredictiveScalingMaxCapacityBreachBehavior.honorMaxCapacity:
        return 'HonorMaxCapacity';
      case PredictiveScalingMaxCapacityBreachBehavior.increaseMaxCapacity:
        return 'IncreaseMaxCapacity';
    }
  }
}

extension on String {
  PredictiveScalingMaxCapacityBreachBehavior
      toPredictiveScalingMaxCapacityBreachBehavior() {
    switch (this) {
      case 'HonorMaxCapacity':
        return PredictiveScalingMaxCapacityBreachBehavior.honorMaxCapacity;
      case 'IncreaseMaxCapacity':
        return PredictiveScalingMaxCapacityBreachBehavior.increaseMaxCapacity;
    }
    throw Exception(
        '$this is not known in enum PredictiveScalingMaxCapacityBreachBehavior');
  }
}

/// This structure specifies the metrics and target utilization settings for a
/// predictive scaling policy.
///
/// You must specify either a metric pair, or a load metric and a scaling metric
/// individually. Specifying a metric pair instead of individual metrics
/// provides a simpler way to configure metrics for a scaling policy. You choose
/// the metric pair, and the policy automatically knows the correct sum and
/// average statistics to use for the load metric and the scaling metric.
///
/// Example
///
/// <ul>
/// <li>
/// You create a predictive scaling policy and specify
/// <code>ALBRequestCount</code> as the value for the metric pair and
/// <code>1000.0</code> as the target value. For this type of metric, you must
/// provide the metric dimension for the corresponding target group, so you also
/// provide a resource label for the Application Load Balancer target group that
/// is attached to your Auto Scaling group.
/// </li>
/// <li>
/// The number of requests the target group receives per minute provides the
/// load metric, and the request count averaged between the members of the
/// target group provides the scaling metric. In CloudWatch, this refers to the
/// <code>RequestCount</code> and <code>RequestCountPerTarget</code> metrics,
/// respectively.
/// </li>
/// <li>
/// For optimal use of predictive scaling, you adhere to the best practice of
/// using a dynamic scaling policy to automatically scale between the minimum
/// capacity and maximum capacity in response to real-time changes in resource
/// utilization.
/// </li>
/// <li>
/// Amazon EC2 Auto Scaling consumes data points for the load metric over the
/// last 14 days and creates an hourly load forecast for predictive scaling. (A
/// minimum of 24 hours of data is required.)
/// </li>
/// <li>
/// After creating the load forecast, Amazon EC2 Auto Scaling determines when to
/// reduce or increase the capacity of your Auto Scaling group in each hour of
/// the forecast period so that the average number of requests received by each
/// instance is as close to 1000 requests per minute as possible at all times.
/// </li>
/// </ul>
/// For information about using custom metrics with predictive scaling, see <a
/// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/predictive-scaling-customized-metric-specification.html">Advanced
/// predictive scaling policy configurations using custom metrics</a> in the
/// <i>Amazon EC2 Auto Scaling User Guide</i>.
class PredictiveScalingMetricSpecification {
  /// Specifies the target utilization.
  /// <note>
  /// Some metrics are based on a count instead of a percentage, such as the
  /// request count for an Application Load Balancer or the number of messages in
  /// an SQS queue. If the scaling policy specifies one of these metrics, specify
  /// the target utilization as the optimal average request or message count per
  /// instance during any one-minute interval.
  /// </note>
  final double targetValue;

  /// The customized capacity metric specification.
  final PredictiveScalingCustomizedCapacityMetric?
      customizedCapacityMetricSpecification;

  /// The customized load metric specification.
  final PredictiveScalingCustomizedLoadMetric?
      customizedLoadMetricSpecification;

  /// The customized scaling metric specification.
  final PredictiveScalingCustomizedScalingMetric?
      customizedScalingMetricSpecification;

  /// The predefined load metric specification.
  final PredictiveScalingPredefinedLoadMetric?
      predefinedLoadMetricSpecification;

  /// The predefined metric pair specification from which Amazon EC2 Auto Scaling
  /// determines the appropriate scaling metric and load metric to use.
  final PredictiveScalingPredefinedMetricPair?
      predefinedMetricPairSpecification;

  /// The predefined scaling metric specification.
  final PredictiveScalingPredefinedScalingMetric?
      predefinedScalingMetricSpecification;

  PredictiveScalingMetricSpecification({
    required this.targetValue,
    this.customizedCapacityMetricSpecification,
    this.customizedLoadMetricSpecification,
    this.customizedScalingMetricSpecification,
    this.predefinedLoadMetricSpecification,
    this.predefinedMetricPairSpecification,
    this.predefinedScalingMetricSpecification,
  });
  factory PredictiveScalingMetricSpecification.fromXml(_s.XmlElement elem) {
    return PredictiveScalingMetricSpecification(
      targetValue: _s.extractXmlDoubleValue(elem, 'TargetValue')!,
      customizedCapacityMetricSpecification: _s
          .extractXmlChild(elem, 'CustomizedCapacityMetricSpecification')
          ?.let((e) => PredictiveScalingCustomizedCapacityMetric.fromXml(e)),
      customizedLoadMetricSpecification: _s
          .extractXmlChild(elem, 'CustomizedLoadMetricSpecification')
          ?.let((e) => PredictiveScalingCustomizedLoadMetric.fromXml(e)),
      customizedScalingMetricSpecification: _s
          .extractXmlChild(elem, 'CustomizedScalingMetricSpecification')
          ?.let((e) => PredictiveScalingCustomizedScalingMetric.fromXml(e)),
      predefinedLoadMetricSpecification: _s
          .extractXmlChild(elem, 'PredefinedLoadMetricSpecification')
          ?.let((e) => PredictiveScalingPredefinedLoadMetric.fromXml(e)),
      predefinedMetricPairSpecification: _s
          .extractXmlChild(elem, 'PredefinedMetricPairSpecification')
          ?.let((e) => PredictiveScalingPredefinedMetricPair.fromXml(e)),
      predefinedScalingMetricSpecification: _s
          .extractXmlChild(elem, 'PredefinedScalingMetricSpecification')
          ?.let((e) => PredictiveScalingPredefinedScalingMetric.fromXml(e)),
    );
  }

  Map<String, dynamic> toJson() {
    final targetValue = this.targetValue;
    final customizedCapacityMetricSpecification =
        this.customizedCapacityMetricSpecification;
    final customizedLoadMetricSpecification =
        this.customizedLoadMetricSpecification;
    final customizedScalingMetricSpecification =
        this.customizedScalingMetricSpecification;
    final predefinedLoadMetricSpecification =
        this.predefinedLoadMetricSpecification;
    final predefinedMetricPairSpecification =
        this.predefinedMetricPairSpecification;
    final predefinedScalingMetricSpecification =
        this.predefinedScalingMetricSpecification;
    return {
      'TargetValue': targetValue,
      if (customizedCapacityMetricSpecification != null)
        'CustomizedCapacityMetricSpecification':
            customizedCapacityMetricSpecification,
      if (customizedLoadMetricSpecification != null)
        'CustomizedLoadMetricSpecification': customizedLoadMetricSpecification,
      if (customizedScalingMetricSpecification != null)
        'CustomizedScalingMetricSpecification':
            customizedScalingMetricSpecification,
      if (predefinedLoadMetricSpecification != null)
        'PredefinedLoadMetricSpecification': predefinedLoadMetricSpecification,
      if (predefinedMetricPairSpecification != null)
        'PredefinedMetricPairSpecification': predefinedMetricPairSpecification,
      if (predefinedScalingMetricSpecification != null)
        'PredefinedScalingMetricSpecification':
            predefinedScalingMetricSpecification,
    };
  }
}

enum PredictiveScalingMode {
  forecastAndScale,
  forecastOnly,
}

extension on PredictiveScalingMode {
  String toValue() {
    switch (this) {
      case PredictiveScalingMode.forecastAndScale:
        return 'ForecastAndScale';
      case PredictiveScalingMode.forecastOnly:
        return 'ForecastOnly';
    }
  }
}

extension on String {
  PredictiveScalingMode toPredictiveScalingMode() {
    switch (this) {
      case 'ForecastAndScale':
        return PredictiveScalingMode.forecastAndScale;
      case 'ForecastOnly':
        return PredictiveScalingMode.forecastOnly;
    }
    throw Exception('$this is not known in enum PredictiveScalingMode');
  }
}

/// Describes a load metric for a predictive scaling policy.
///
/// When returned in the output of <code>DescribePolicies</code>, it indicates
/// that a predictive scaling policy uses individually specified load and
/// scaling metrics instead of a metric pair.
class PredictiveScalingPredefinedLoadMetric {
  /// The metric type.
  final PredefinedLoadMetricType predefinedMetricType;

  /// A label that uniquely identifies a specific Application Load Balancer target
  /// group from which to determine the request count served by your Auto Scaling
  /// group. You can't specify a resource label unless the target group is
  /// attached to the Auto Scaling group.
  ///
  /// You create the resource label by appending the final portion of the load
  /// balancer ARN and the final portion of the target group ARN into a single
  /// value, separated by a forward slash (/). The format of the resource label
  /// is:
  ///
  /// <code>app/my-alb/778d41231b141a0f/targetgroup/my-alb-target-group/943f017f100becff</code>.
  ///
  /// Where:
  ///
  /// <ul>
  /// <li>
  /// app/&lt;load-balancer-name&gt;/&lt;load-balancer-id&gt; is the final portion
  /// of the load balancer ARN
  /// </li>
  /// <li>
  /// targetgroup/&lt;target-group-name&gt;/&lt;target-group-id&gt; is the final
  /// portion of the target group ARN.
  /// </li>
  /// </ul>
  /// To find the ARN for an Application Load Balancer, use the <a
  /// href="https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeLoadBalancers.html">DescribeLoadBalancers</a>
  /// API operation. To find the ARN for the target group, use the <a
  /// href="https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeTargetGroups.html">DescribeTargetGroups</a>
  /// API operation.
  final String? resourceLabel;

  PredictiveScalingPredefinedLoadMetric({
    required this.predefinedMetricType,
    this.resourceLabel,
  });
  factory PredictiveScalingPredefinedLoadMetric.fromXml(_s.XmlElement elem) {
    return PredictiveScalingPredefinedLoadMetric(
      predefinedMetricType: _s
          .extractXmlStringValue(elem, 'PredefinedMetricType')!
          .toPredefinedLoadMetricType(),
      resourceLabel: _s.extractXmlStringValue(elem, 'ResourceLabel'),
    );
  }

  Map<String, dynamic> toJson() {
    final predefinedMetricType = this.predefinedMetricType;
    final resourceLabel = this.resourceLabel;
    return {
      'PredefinedMetricType': predefinedMetricType.toValue(),
      if (resourceLabel != null) 'ResourceLabel': resourceLabel,
    };
  }
}

/// Represents a metric pair for a predictive scaling policy.
class PredictiveScalingPredefinedMetricPair {
  /// Indicates which metrics to use. There are two different types of metrics for
  /// each metric type: one is a load metric and one is a scaling metric. For
  /// example, if the metric type is <code>ASGCPUUtilization</code>, the Auto
  /// Scaling group's total CPU metric is used as the load metric, and the average
  /// CPU metric is used for the scaling metric.
  final PredefinedMetricPairType predefinedMetricType;

  /// A label that uniquely identifies a specific Application Load Balancer target
  /// group from which to determine the total and average request count served by
  /// your Auto Scaling group. You can't specify a resource label unless the
  /// target group is attached to the Auto Scaling group.
  ///
  /// You create the resource label by appending the final portion of the load
  /// balancer ARN and the final portion of the target group ARN into a single
  /// value, separated by a forward slash (/). The format of the resource label
  /// is:
  ///
  /// <code>app/my-alb/778d41231b141a0f/targetgroup/my-alb-target-group/943f017f100becff</code>.
  ///
  /// Where:
  ///
  /// <ul>
  /// <li>
  /// app/&lt;load-balancer-name&gt;/&lt;load-balancer-id&gt; is the final portion
  /// of the load balancer ARN
  /// </li>
  /// <li>
  /// targetgroup/&lt;target-group-name&gt;/&lt;target-group-id&gt; is the final
  /// portion of the target group ARN.
  /// </li>
  /// </ul>
  /// To find the ARN for an Application Load Balancer, use the <a
  /// href="https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeLoadBalancers.html">DescribeLoadBalancers</a>
  /// API operation. To find the ARN for the target group, use the <a
  /// href="https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeTargetGroups.html">DescribeTargetGroups</a>
  /// API operation.
  final String? resourceLabel;

  PredictiveScalingPredefinedMetricPair({
    required this.predefinedMetricType,
    this.resourceLabel,
  });
  factory PredictiveScalingPredefinedMetricPair.fromXml(_s.XmlElement elem) {
    return PredictiveScalingPredefinedMetricPair(
      predefinedMetricType: _s
          .extractXmlStringValue(elem, 'PredefinedMetricType')!
          .toPredefinedMetricPairType(),
      resourceLabel: _s.extractXmlStringValue(elem, 'ResourceLabel'),
    );
  }

  Map<String, dynamic> toJson() {
    final predefinedMetricType = this.predefinedMetricType;
    final resourceLabel = this.resourceLabel;
    return {
      'PredefinedMetricType': predefinedMetricType.toValue(),
      if (resourceLabel != null) 'ResourceLabel': resourceLabel,
    };
  }
}

/// Describes a scaling metric for a predictive scaling policy.
///
/// When returned in the output of <code>DescribePolicies</code>, it indicates
/// that a predictive scaling policy uses individually specified load and
/// scaling metrics instead of a metric pair.
class PredictiveScalingPredefinedScalingMetric {
  /// The metric type.
  final PredefinedScalingMetricType predefinedMetricType;

  /// A label that uniquely identifies a specific Application Load Balancer target
  /// group from which to determine the average request count served by your Auto
  /// Scaling group. You can't specify a resource label unless the target group is
  /// attached to the Auto Scaling group.
  ///
  /// You create the resource label by appending the final portion of the load
  /// balancer ARN and the final portion of the target group ARN into a single
  /// value, separated by a forward slash (/). The format of the resource label
  /// is:
  ///
  /// <code>app/my-alb/778d41231b141a0f/targetgroup/my-alb-target-group/943f017f100becff</code>.
  ///
  /// Where:
  ///
  /// <ul>
  /// <li>
  /// app/&lt;load-balancer-name&gt;/&lt;load-balancer-id&gt; is the final portion
  /// of the load balancer ARN
  /// </li>
  /// <li>
  /// targetgroup/&lt;target-group-name&gt;/&lt;target-group-id&gt; is the final
  /// portion of the target group ARN.
  /// </li>
  /// </ul>
  /// To find the ARN for an Application Load Balancer, use the <a
  /// href="https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeLoadBalancers.html">DescribeLoadBalancers</a>
  /// API operation. To find the ARN for the target group, use the <a
  /// href="https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeTargetGroups.html">DescribeTargetGroups</a>
  /// API operation.
  final String? resourceLabel;

  PredictiveScalingPredefinedScalingMetric({
    required this.predefinedMetricType,
    this.resourceLabel,
  });
  factory PredictiveScalingPredefinedScalingMetric.fromXml(_s.XmlElement elem) {
    return PredictiveScalingPredefinedScalingMetric(
      predefinedMetricType: _s
          .extractXmlStringValue(elem, 'PredefinedMetricType')!
          .toPredefinedScalingMetricType(),
      resourceLabel: _s.extractXmlStringValue(elem, 'ResourceLabel'),
    );
  }

  Map<String, dynamic> toJson() {
    final predefinedMetricType = this.predefinedMetricType;
    final resourceLabel = this.resourceLabel;
    return {
      'PredefinedMetricType': predefinedMetricType.toValue(),
      if (resourceLabel != null) 'ResourceLabel': resourceLabel,
    };
  }
}

/// Describes a process type.
///
/// For more information, see <a
/// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-suspend-resume-processes.html#process-types">Scaling
/// processes</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
class ProcessType {
  /// One of the following processes:
  ///
  /// <ul>
  /// <li>
  /// <code>Launch</code>
  /// </li>
  /// <li>
  /// <code>Terminate</code>
  /// </li>
  /// <li>
  /// <code>AddToLoadBalancer</code>
  /// </li>
  /// <li>
  /// <code>AlarmNotification</code>
  /// </li>
  /// <li>
  /// <code>AZRebalance</code>
  /// </li>
  /// <li>
  /// <code>HealthCheck</code>
  /// </li>
  /// <li>
  /// <code>InstanceRefresh</code>
  /// </li>
  /// <li>
  /// <code>ReplaceUnhealthy</code>
  /// </li>
  /// <li>
  /// <code>ScheduledActions</code>
  /// </li>
  /// </ul>
  final String processName;

  ProcessType({
    required this.processName,
  });
  factory ProcessType.fromXml(_s.XmlElement elem) {
    return ProcessType(
      processName: _s.extractXmlStringValue(elem, 'ProcessName')!,
    );
  }
}

class ProcessesType {
  /// The names of the process types.
  final List<ProcessType>? processes;

  ProcessesType({
    this.processes,
  });
  factory ProcessesType.fromXml(_s.XmlElement elem) {
    return ProcessesType(
      processes: _s.extractXmlChild(elem, 'Processes')?.let((elem) => elem
          .findElements('member')
          .map((c) => ProcessType.fromXml(c))
          .toList()),
    );
  }
}

class PutLifecycleHookAnswer {
  PutLifecycleHookAnswer();
  factory PutLifecycleHookAnswer.fromXml(
      // ignore: avoid_unused_constructor_parameters
      _s.XmlElement elem) {
    return PutLifecycleHookAnswer();
  }
}

class PutWarmPoolAnswer {
  PutWarmPoolAnswer();
  factory PutWarmPoolAnswer.fromXml(
      // ignore: avoid_unused_constructor_parameters
      _s.XmlElement elem) {
    return PutWarmPoolAnswer();
  }
}

class RecordLifecycleActionHeartbeatAnswer {
  RecordLifecycleActionHeartbeatAnswer();
  factory RecordLifecycleActionHeartbeatAnswer.fromXml(
      // ignore: avoid_unused_constructor_parameters
      _s.XmlElement elem) {
    return RecordLifecycleActionHeartbeatAnswer();
  }
}

/// Describes the preferences for an instance refresh.
class RefreshPreferences {
  /// The amount of time, in seconds, to wait after a checkpoint before
  /// continuing. This property is optional, but if you specify a value for it,
  /// you must also specify a value for <code>CheckpointPercentages</code>. If you
  /// specify a value for <code>CheckpointPercentages</code> and not for
  /// <code>CheckpointDelay</code>, the <code>CheckpointDelay</code> defaults to
  /// <code>3600</code> (1 hour).
  final int? checkpointDelay;

  /// Threshold values for each checkpoint in ascending order. Each number must be
  /// unique. To replace all instances in the Auto Scaling group, the last number
  /// in the array must be <code>100</code>.
  ///
  /// For usage examples, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-adding-checkpoints-instance-refresh.html">Adding
  /// checkpoints to an instance refresh</a> in the <i>Amazon EC2 Auto Scaling
  /// User Guide</i>.
  final List<int>? checkpointPercentages;

  /// <i>Not needed if the default instance warmup is defined for the group.</i>
  ///
  /// The duration of the instance warmup, in seconds.
  /// <note>
  /// The default is to use the value for the default instance warmup defined for
  /// the group. If default instance warmup is null, then
  /// <code>InstanceWarmup</code> falls back to the value of the health check
  /// grace period.
  /// </note>
  final int? instanceWarmup;

  /// The amount of capacity in the Auto Scaling group that must pass your group's
  /// health checks to allow the operation to continue. The value is expressed as
  /// a percentage of the desired capacity of the Auto Scaling group (rounded up
  /// to the nearest integer). The default is <code>90</code>.
  ///
  /// Setting the minimum healthy percentage to 100 percent limits the rate of
  /// replacement to one instance at a time. In contrast, setting it to 0 percent
  /// has the effect of replacing all instances at the same time.
  final int? minHealthyPercentage;

  /// A boolean value that indicates whether skip matching is enabled. If true,
  /// then Amazon EC2 Auto Scaling skips replacing instances that match the
  /// desired configuration. If no desired configuration is specified, then it
  /// skips replacing instances that have the same configuration that is already
  /// set on the group. The default is <code>false</code>.
  final bool? skipMatching;

  RefreshPreferences({
    this.checkpointDelay,
    this.checkpointPercentages,
    this.instanceWarmup,
    this.minHealthyPercentage,
    this.skipMatching,
  });
  factory RefreshPreferences.fromXml(_s.XmlElement elem) {
    return RefreshPreferences(
      checkpointDelay: _s.extractXmlIntValue(elem, 'CheckpointDelay'),
      checkpointPercentages: _s
          .extractXmlChild(elem, 'CheckpointPercentages')
          ?.let((elem) => _s.extractXmlIntListValues(elem, 'member')),
      instanceWarmup: _s.extractXmlIntValue(elem, 'InstanceWarmup'),
      minHealthyPercentage: _s.extractXmlIntValue(elem, 'MinHealthyPercentage'),
      skipMatching: _s.extractXmlBoolValue(elem, 'SkipMatching'),
    );
  }

  Map<String, dynamic> toJson() {
    final checkpointDelay = this.checkpointDelay;
    final checkpointPercentages = this.checkpointPercentages;
    final instanceWarmup = this.instanceWarmup;
    final minHealthyPercentage = this.minHealthyPercentage;
    final skipMatching = this.skipMatching;
    return {
      if (checkpointDelay != null) 'CheckpointDelay': checkpointDelay,
      if (checkpointPercentages != null)
        'CheckpointPercentages': checkpointPercentages,
      if (instanceWarmup != null) 'InstanceWarmup': instanceWarmup,
      if (minHealthyPercentage != null)
        'MinHealthyPercentage': minHealthyPercentage,
      if (skipMatching != null) 'SkipMatching': skipMatching,
    };
  }
}

enum RefreshStrategy {
  rolling,
}

extension on RefreshStrategy {
  String toValue() {
    switch (this) {
      case RefreshStrategy.rolling:
        return 'Rolling';
    }
  }
}

extension on String {
  RefreshStrategy toRefreshStrategy() {
    switch (this) {
      case 'Rolling':
        return RefreshStrategy.rolling;
    }
    throw Exception('$this is not known in enum RefreshStrategy');
  }
}

enum ScalingActivityStatusCode {
  pendingSpotBidPlacement,
  waitingForSpotInstanceRequestId,
  waitingForSpotInstanceId,
  waitingForInstanceId,
  preInService,
  inProgress,
  waitingForELBConnectionDraining,
  midLifecycleAction,
  waitingForInstanceWarmup,
  successful,
  failed,
  cancelled,
}

extension on ScalingActivityStatusCode {
  String toValue() {
    switch (this) {
      case ScalingActivityStatusCode.pendingSpotBidPlacement:
        return 'PendingSpotBidPlacement';
      case ScalingActivityStatusCode.waitingForSpotInstanceRequestId:
        return 'WaitingForSpotInstanceRequestId';
      case ScalingActivityStatusCode.waitingForSpotInstanceId:
        return 'WaitingForSpotInstanceId';
      case ScalingActivityStatusCode.waitingForInstanceId:
        return 'WaitingForInstanceId';
      case ScalingActivityStatusCode.preInService:
        return 'PreInService';
      case ScalingActivityStatusCode.inProgress:
        return 'InProgress';
      case ScalingActivityStatusCode.waitingForELBConnectionDraining:
        return 'WaitingForELBConnectionDraining';
      case ScalingActivityStatusCode.midLifecycleAction:
        return 'MidLifecycleAction';
      case ScalingActivityStatusCode.waitingForInstanceWarmup:
        return 'WaitingForInstanceWarmup';
      case ScalingActivityStatusCode.successful:
        return 'Successful';
      case ScalingActivityStatusCode.failed:
        return 'Failed';
      case ScalingActivityStatusCode.cancelled:
        return 'Cancelled';
    }
  }
}

extension on String {
  ScalingActivityStatusCode toScalingActivityStatusCode() {
    switch (this) {
      case 'PendingSpotBidPlacement':
        return ScalingActivityStatusCode.pendingSpotBidPlacement;
      case 'WaitingForSpotInstanceRequestId':
        return ScalingActivityStatusCode.waitingForSpotInstanceRequestId;
      case 'WaitingForSpotInstanceId':
        return ScalingActivityStatusCode.waitingForSpotInstanceId;
      case 'WaitingForInstanceId':
        return ScalingActivityStatusCode.waitingForInstanceId;
      case 'PreInService':
        return ScalingActivityStatusCode.preInService;
      case 'InProgress':
        return ScalingActivityStatusCode.inProgress;
      case 'WaitingForELBConnectionDraining':
        return ScalingActivityStatusCode.waitingForELBConnectionDraining;
      case 'MidLifecycleAction':
        return ScalingActivityStatusCode.midLifecycleAction;
      case 'WaitingForInstanceWarmup':
        return ScalingActivityStatusCode.waitingForInstanceWarmup;
      case 'Successful':
        return ScalingActivityStatusCode.successful;
      case 'Failed':
        return ScalingActivityStatusCode.failed;
      case 'Cancelled':
        return ScalingActivityStatusCode.cancelled;
    }
    throw Exception('$this is not known in enum ScalingActivityStatusCode');
  }
}

/// Describes a scaling policy.
class ScalingPolicy {
  /// Specifies how the scaling adjustment is interpreted (for example, an
  /// absolute number or a percentage). The valid values are
  /// <code>ChangeInCapacity</code>, <code>ExactCapacity</code>, and
  /// <code>PercentChangeInCapacity</code>.
  final String? adjustmentType;

  /// The CloudWatch alarms related to the policy.
  final List<Alarm>? alarms;

  /// The name of the Auto Scaling group.
  final String? autoScalingGroupName;

  /// The duration of the policy's cooldown period, in seconds.
  final int? cooldown;

  /// Indicates whether the policy is enabled (<code>true</code>) or disabled
  /// (<code>false</code>).
  final bool? enabled;

  /// The estimated time, in seconds, until a newly launched instance can
  /// contribute to the CloudWatch metrics.
  final int? estimatedInstanceWarmup;

  /// The aggregation type for the CloudWatch metrics. The valid values are
  /// <code>Minimum</code>, <code>Maximum</code>, and <code>Average</code>.
  final String? metricAggregationType;

  /// The minimum value to scale by when the adjustment type is
  /// <code>PercentChangeInCapacity</code>.
  final int? minAdjustmentMagnitude;

  /// Available for backward compatibility. Use
  /// <code>MinAdjustmentMagnitude</code> instead.
  final int? minAdjustmentStep;

  /// The Amazon Resource Name (ARN) of the policy.
  final String? policyARN;

  /// The name of the scaling policy.
  final String? policyName;

  /// One of the following policy types:
  ///
  /// <ul>
  /// <li>
  /// <code>TargetTrackingScaling</code>
  /// </li>
  /// <li>
  /// <code>StepScaling</code>
  /// </li>
  /// <li>
  /// <code>SimpleScaling</code> (default)
  /// </li>
  /// <li>
  /// <code>PredictiveScaling</code>
  /// </li>
  /// </ul>
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-target-tracking.html">Target
  /// tracking scaling policies</a> and <a
  /// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-simple-step.html">Step
  /// and simple scaling policies</a> in the <i>Amazon EC2 Auto Scaling User
  /// Guide</i>.
  final String? policyType;

  /// A predictive scaling policy.
  final PredictiveScalingConfiguration? predictiveScalingConfiguration;

  /// The amount by which to scale, based on the specified adjustment type. A
  /// positive value adds to the current capacity while a negative number removes
  /// from the current capacity.
  final int? scalingAdjustment;

  /// A set of adjustments that enable you to scale based on the size of the alarm
  /// breach.
  final List<StepAdjustment>? stepAdjustments;

  /// A target tracking scaling policy.
  final TargetTrackingConfiguration? targetTrackingConfiguration;

  ScalingPolicy({
    this.adjustmentType,
    this.alarms,
    this.autoScalingGroupName,
    this.cooldown,
    this.enabled,
    this.estimatedInstanceWarmup,
    this.metricAggregationType,
    this.minAdjustmentMagnitude,
    this.minAdjustmentStep,
    this.policyARN,
    this.policyName,
    this.policyType,
    this.predictiveScalingConfiguration,
    this.scalingAdjustment,
    this.stepAdjustments,
    this.targetTrackingConfiguration,
  });
  factory ScalingPolicy.fromXml(_s.XmlElement elem) {
    return ScalingPolicy(
      adjustmentType: _s.extractXmlStringValue(elem, 'AdjustmentType'),
      alarms: _s.extractXmlChild(elem, 'Alarms')?.let((elem) =>
          elem.findElements('member').map((c) => Alarm.fromXml(c)).toList()),
      autoScalingGroupName:
          _s.extractXmlStringValue(elem, 'AutoScalingGroupName'),
      cooldown: _s.extractXmlIntValue(elem, 'Cooldown'),
      enabled: _s.extractXmlBoolValue(elem, 'Enabled'),
      estimatedInstanceWarmup:
          _s.extractXmlIntValue(elem, 'EstimatedInstanceWarmup'),
      metricAggregationType:
          _s.extractXmlStringValue(elem, 'MetricAggregationType'),
      minAdjustmentMagnitude:
          _s.extractXmlIntValue(elem, 'MinAdjustmentMagnitude'),
      minAdjustmentStep: _s.extractXmlIntValue(elem, 'MinAdjustmentStep'),
      policyARN: _s.extractXmlStringValue(elem, 'PolicyARN'),
      policyName: _s.extractXmlStringValue(elem, 'PolicyName'),
      policyType: _s.extractXmlStringValue(elem, 'PolicyType'),
      predictiveScalingConfiguration: _s
          .extractXmlChild(elem, 'PredictiveScalingConfiguration')
          ?.let((e) => PredictiveScalingConfiguration.fromXml(e)),
      scalingAdjustment: _s.extractXmlIntValue(elem, 'ScalingAdjustment'),
      stepAdjustments: _s.extractXmlChild(elem, 'StepAdjustments')?.let(
          (elem) => elem
              .findElements('member')
              .map((c) => StepAdjustment.fromXml(c))
              .toList()),
      targetTrackingConfiguration: _s
          .extractXmlChild(elem, 'TargetTrackingConfiguration')
          ?.let((e) => TargetTrackingConfiguration.fromXml(e)),
    );
  }
}

class ScheduledActionsType {
  /// A string that indicates that the response contains more items than can be
  /// returned in a single response. To receive additional items, specify this
  /// string for the <code>NextToken</code> value when requesting the next set of
  /// items. This value is null when there are no more items to return.
  final String? nextToken;

  /// The scheduled actions.
  final List<ScheduledUpdateGroupAction>? scheduledUpdateGroupActions;

  ScheduledActionsType({
    this.nextToken,
    this.scheduledUpdateGroupActions,
  });
  factory ScheduledActionsType.fromXml(_s.XmlElement elem) {
    return ScheduledActionsType(
      nextToken: _s.extractXmlStringValue(elem, 'NextToken'),
      scheduledUpdateGroupActions: _s
          .extractXmlChild(elem, 'ScheduledUpdateGroupActions')
          ?.let((elem) => elem
              .findElements('member')
              .map((c) => ScheduledUpdateGroupAction.fromXml(c))
              .toList()),
    );
  }
}

/// Describes a scheduled scaling action.
class ScheduledUpdateGroupAction {
  /// The name of the Auto Scaling group.
  final String? autoScalingGroupName;

  /// The desired capacity is the initial capacity of the Auto Scaling group after
  /// the scheduled action runs and the capacity it attempts to maintain.
  final int? desiredCapacity;

  /// The date and time in UTC for the recurring schedule to end. For example,
  /// <code>"2019-06-01T00:00:00Z"</code>.
  final DateTime? endTime;

  /// The maximum size of the Auto Scaling group.
  final int? maxSize;

  /// The minimum size of the Auto Scaling group.
  final int? minSize;

  /// The recurring schedule for the action, in Unix cron syntax format.
  ///
  /// When <code>StartTime</code> and <code>EndTime</code> are specified with
  /// <code>Recurrence</code>, they form the boundaries of when the recurring
  /// action starts and stops.
  final String? recurrence;

  /// The Amazon Resource Name (ARN) of the scheduled action.
  final String? scheduledActionARN;

  /// The name of the scheduled action.
  final String? scheduledActionName;

  /// The date and time in UTC for this action to start. For example,
  /// <code>"2019-06-01T00:00:00Z"</code>.
  final DateTime? startTime;

  /// This property is no longer used.
  final DateTime? time;

  /// The time zone for the cron expression.
  final String? timeZone;

  ScheduledUpdateGroupAction({
    this.autoScalingGroupName,
    this.desiredCapacity,
    this.endTime,
    this.maxSize,
    this.minSize,
    this.recurrence,
    this.scheduledActionARN,
    this.scheduledActionName,
    this.startTime,
    this.time,
    this.timeZone,
  });
  factory ScheduledUpdateGroupAction.fromXml(_s.XmlElement elem) {
    return ScheduledUpdateGroupAction(
      autoScalingGroupName:
          _s.extractXmlStringValue(elem, 'AutoScalingGroupName'),
      desiredCapacity: _s.extractXmlIntValue(elem, 'DesiredCapacity'),
      endTime: _s.extractXmlDateTimeValue(elem, 'EndTime'),
      maxSize: _s.extractXmlIntValue(elem, 'MaxSize'),
      minSize: _s.extractXmlIntValue(elem, 'MinSize'),
      recurrence: _s.extractXmlStringValue(elem, 'Recurrence'),
      scheduledActionARN: _s.extractXmlStringValue(elem, 'ScheduledActionARN'),
      scheduledActionName:
          _s.extractXmlStringValue(elem, 'ScheduledActionName'),
      startTime: _s.extractXmlDateTimeValue(elem, 'StartTime'),
      time: _s.extractXmlDateTimeValue(elem, 'Time'),
      timeZone: _s.extractXmlStringValue(elem, 'TimeZone'),
    );
  }
}

/// Describes information used for one or more scheduled scaling action updates
/// in a <a>BatchPutScheduledUpdateGroupAction</a> operation.
class ScheduledUpdateGroupActionRequest {
  /// The name of the scaling action.
  final String scheduledActionName;

  /// The desired capacity is the initial capacity of the Auto Scaling group after
  /// the scheduled action runs and the capacity it attempts to maintain.
  final int? desiredCapacity;

  /// The date and time for the recurring schedule to end, in UTC.
  final DateTime? endTime;

  /// The maximum size of the Auto Scaling group.
  final int? maxSize;

  /// The minimum size of the Auto Scaling group.
  final int? minSize;

  /// The recurring schedule for the action, in Unix cron syntax format. This
  /// format consists of five fields separated by white spaces: [Minute] [Hour]
  /// [Day_of_Month] [Month_of_Year] [Day_of_Week]. The value must be in quotes
  /// (for example, <code>"30 0 1 1,6,12 *"</code>). For more information about
  /// this format, see <a href="http://crontab.org">Crontab</a>.
  ///
  /// When <code>StartTime</code> and <code>EndTime</code> are specified with
  /// <code>Recurrence</code>, they form the boundaries of when the recurring
  /// action starts and stops.
  ///
  /// Cron expressions use Universal Coordinated Time (UTC) by default.
  final String? recurrence;

  /// The date and time for the action to start, in YYYY-MM-DDThh:mm:ssZ format in
  /// UTC/GMT only and in quotes (for example,
  /// <code>"2019-06-01T00:00:00Z"</code>).
  ///
  /// If you specify <code>Recurrence</code> and <code>StartTime</code>, Amazon
  /// EC2 Auto Scaling performs the action at this time, and then performs the
  /// action based on the specified recurrence.
  ///
  /// If you try to schedule the action in the past, Amazon EC2 Auto Scaling
  /// returns an error message.
  final DateTime? startTime;

  /// Specifies the time zone for a cron expression. If a time zone is not
  /// provided, UTC is used by default.
  ///
  /// Valid values are the canonical names of the IANA time zones, derived from
  /// the IANA Time Zone Database (such as <code>Etc/GMT+9</code> or
  /// <code>Pacific/Tahiti</code>). For more information, see <a
  /// href="https://en.wikipedia.org/wiki/List_of_tz_database_time_zones">https://en.wikipedia.org/wiki/List_of_tz_database_time_zones</a>.
  final String? timeZone;

  ScheduledUpdateGroupActionRequest({
    required this.scheduledActionName,
    this.desiredCapacity,
    this.endTime,
    this.maxSize,
    this.minSize,
    this.recurrence,
    this.startTime,
    this.timeZone,
  });
  Map<String, dynamic> toJson() {
    final scheduledActionName = this.scheduledActionName;
    final desiredCapacity = this.desiredCapacity;
    final endTime = this.endTime;
    final maxSize = this.maxSize;
    final minSize = this.minSize;
    final recurrence = this.recurrence;
    final startTime = this.startTime;
    final timeZone = this.timeZone;
    return {
      'ScheduledActionName': scheduledActionName,
      if (desiredCapacity != null) 'DesiredCapacity': desiredCapacity,
      if (endTime != null) 'EndTime': unixTimestampToJson(endTime),
      if (maxSize != null) 'MaxSize': maxSize,
      if (minSize != null) 'MinSize': minSize,
      if (recurrence != null) 'Recurrence': recurrence,
      if (startTime != null) 'StartTime': unixTimestampToJson(startTime),
      if (timeZone != null) 'TimeZone': timeZone,
    };
  }
}

class SetInstanceProtectionAnswer {
  SetInstanceProtectionAnswer();
  factory SetInstanceProtectionAnswer.fromXml(
      // ignore: avoid_unused_constructor_parameters
      _s.XmlElement elem) {
    return SetInstanceProtectionAnswer();
  }
}

class StartInstanceRefreshAnswer {
  /// A unique ID for tracking the progress of the request.
  final String? instanceRefreshId;

  StartInstanceRefreshAnswer({
    this.instanceRefreshId,
  });
  factory StartInstanceRefreshAnswer.fromXml(_s.XmlElement elem) {
    return StartInstanceRefreshAnswer(
      instanceRefreshId: _s.extractXmlStringValue(elem, 'InstanceRefreshId'),
    );
  }
}

/// Describes information used to create a step adjustment for a step scaling
/// policy.
///
/// For the following examples, suppose that you have an alarm with a breach
/// threshold of 50:
///
/// <ul>
/// <li>
/// To trigger the adjustment when the metric is greater than or equal to 50 and
/// less than 60, specify a lower bound of 0 and an upper bound of 10.
/// </li>
/// <li>
/// To trigger the adjustment when the metric is greater than 40 and less than
/// or equal to 50, specify a lower bound of -10 and an upper bound of 0.
/// </li>
/// </ul>
/// There are a few rules for the step adjustments for your step policy:
///
/// <ul>
/// <li>
/// The ranges of your step adjustments can't overlap or have a gap.
/// </li>
/// <li>
/// At most, one step adjustment can have a null lower bound. If one step
/// adjustment has a negative lower bound, then there must be a step adjustment
/// with a null lower bound.
/// </li>
/// <li>
/// At most, one step adjustment can have a null upper bound. If one step
/// adjustment has a positive upper bound, then there must be a step adjustment
/// with a null upper bound.
/// </li>
/// <li>
/// The upper and lower bound can't be null in the same step adjustment.
/// </li>
/// </ul>
/// For more information, see <a
/// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-simple-step.html#as-scaling-steps">Step
/// adjustments</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
class StepAdjustment {
  /// The amount by which to scale, based on the specified adjustment type. A
  /// positive value adds to the current capacity while a negative number removes
  /// from the current capacity.
  ///
  /// The amount by which to scale. The adjustment is based on the value that you
  /// specified in the <code>AdjustmentType</code> property (either an absolute
  /// number or a percentage). A positive value adds to the current capacity and a
  /// negative number subtracts from the current capacity.
  final int scalingAdjustment;

  /// The lower bound for the difference between the alarm threshold and the
  /// CloudWatch metric. If the metric value is above the breach threshold, the
  /// lower bound is inclusive (the metric must be greater than or equal to the
  /// threshold plus the lower bound). Otherwise, it is exclusive (the metric must
  /// be greater than the threshold plus the lower bound). A null value indicates
  /// negative infinity.
  final double? metricIntervalLowerBound;

  /// The upper bound for the difference between the alarm threshold and the
  /// CloudWatch metric. If the metric value is above the breach threshold, the
  /// upper bound is exclusive (the metric must be less than the threshold plus
  /// the upper bound). Otherwise, it is inclusive (the metric must be less than
  /// or equal to the threshold plus the upper bound). A null value indicates
  /// positive infinity.
  ///
  /// The upper bound must be greater than the lower bound.
  final double? metricIntervalUpperBound;

  StepAdjustment({
    required this.scalingAdjustment,
    this.metricIntervalLowerBound,
    this.metricIntervalUpperBound,
  });
  factory StepAdjustment.fromXml(_s.XmlElement elem) {
    return StepAdjustment(
      scalingAdjustment: _s.extractXmlIntValue(elem, 'ScalingAdjustment')!,
      metricIntervalLowerBound:
          _s.extractXmlDoubleValue(elem, 'MetricIntervalLowerBound'),
      metricIntervalUpperBound:
          _s.extractXmlDoubleValue(elem, 'MetricIntervalUpperBound'),
    );
  }

  Map<String, dynamic> toJson() {
    final scalingAdjustment = this.scalingAdjustment;
    final metricIntervalLowerBound = this.metricIntervalLowerBound;
    final metricIntervalUpperBound = this.metricIntervalUpperBound;
    return {
      'ScalingAdjustment': scalingAdjustment,
      if (metricIntervalLowerBound != null)
        'MetricIntervalLowerBound': metricIntervalLowerBound,
      if (metricIntervalUpperBound != null)
        'MetricIntervalUpperBound': metricIntervalUpperBound,
    };
  }
}

/// Describes an auto scaling process that has been suspended.
///
/// For more information, see <a
/// href="https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-suspend-resume-processes.html#process-types">Scaling
/// processes</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.
class SuspendedProcess {
  /// The name of the suspended process.
  final String? processName;

  /// The reason that the process was suspended.
  final String? suspensionReason;

  SuspendedProcess({
    this.processName,
    this.suspensionReason,
  });
  factory SuspendedProcess.fromXml(_s.XmlElement elem) {
    return SuspendedProcess(
      processName: _s.extractXmlStringValue(elem, 'ProcessName'),
      suspensionReason: _s.extractXmlStringValue(elem, 'SuspensionReason'),
    );
  }
}

/// Describes a tag for an Auto Scaling group.
class Tag {
  /// The tag key.
  final String key;

  /// Determines whether the tag is added to new instances as they are launched in
  /// the group.
  final bool? propagateAtLaunch;

  /// The name of the Auto Scaling group.
  final String? resourceId;

  /// The type of resource. The only supported value is
  /// <code>auto-scaling-group</code>.
  final String? resourceType;

  /// The tag value.
  final String? value;

  Tag({
    required this.key,
    this.propagateAtLaunch,
    this.resourceId,
    this.resourceType,
    this.value,
  });
  Map<String, dynamic> toJson() {
    final key = this.key;
    final propagateAtLaunch = this.propagateAtLaunch;
    final resourceId = this.resourceId;
    final resourceType = this.resourceType;
    final value = this.value;
    return {
      'Key': key,
      if (propagateAtLaunch != null) 'PropagateAtLaunch': propagateAtLaunch,
      if (resourceId != null) 'ResourceId': resourceId,
      if (resourceType != null) 'ResourceType': resourceType,
      if (value != null) 'Value': value,
    };
  }
}

/// Describes a tag for an Auto Scaling group.
class TagDescription {
  /// The tag key.
  final String? key;

  /// Determines whether the tag is added to new instances as they are launched in
  /// the group.
  final bool? propagateAtLaunch;

  /// The name of the group.
  final String? resourceId;

  /// The type of resource. The only supported value is
  /// <code>auto-scaling-group</code>.
  final String? resourceType;

  /// The tag value.
  final String? value;

  TagDescription({
    this.key,
    this.propagateAtLaunch,
    this.resourceId,
    this.resourceType,
    this.value,
  });
  factory TagDescription.fromXml(_s.XmlElement elem) {
    return TagDescription(
      key: _s.extractXmlStringValue(elem, 'Key'),
      propagateAtLaunch: _s.extractXmlBoolValue(elem, 'PropagateAtLaunch'),
      resourceId: _s.extractXmlStringValue(elem, 'ResourceId'),
      resourceType: _s.extractXmlStringValue(elem, 'ResourceType'),
      value: _s.extractXmlStringValue(elem, 'Value'),
    );
  }
}

class TagsType {
  /// A string that indicates that the response contains more items than can be
  /// returned in a single response. To receive additional items, specify this
  /// string for the <code>NextToken</code> value when requesting the next set of
  /// items. This value is null when there are no more items to return.
  final String? nextToken;

  /// One or more tags.
  final List<TagDescription>? tags;

  TagsType({
    this.nextToken,
    this.tags,
  });
  factory TagsType.fromXml(_s.XmlElement elem) {
    return TagsType(
      nextToken: _s.extractXmlStringValue(elem, 'NextToken'),
      tags: _s.extractXmlChild(elem, 'Tags')?.let((elem) => elem
          .findElements('member')
          .map((c) => TagDescription.fromXml(c))
          .toList()),
    );
  }
}

/// Represents a target tracking scaling policy configuration to use with Amazon
/// EC2 Auto Scaling.
class TargetTrackingConfiguration {
  /// The target value for the metric.
  /// <note>
  /// Some metrics are based on a count instead of a percentage, such as the
  /// request count for an Application Load Balancer or the number of messages in
  /// an SQS queue. If the scaling policy specifies one of these metrics, specify
  /// the target utilization as the optimal average request or message count per
  /// instance during any one-minute interval.
  /// </note>
  final double targetValue;

  /// A customized metric. You must specify either a predefined metric or a
  /// customized metric.
  final CustomizedMetricSpecification? customizedMetricSpecification;

  /// Indicates whether scaling in by the target tracking scaling policy is
  /// disabled. If scaling in is disabled, the target tracking scaling policy
  /// doesn't remove instances from the Auto Scaling group. Otherwise, the target
  /// tracking scaling policy can remove instances from the Auto Scaling group.
  /// The default is <code>false</code>.
  final bool? disableScaleIn;

  /// A predefined metric. You must specify either a predefined metric or a
  /// customized metric.
  final PredefinedMetricSpecification? predefinedMetricSpecification;

  TargetTrackingConfiguration({
    required this.targetValue,
    this.customizedMetricSpecification,
    this.disableScaleIn,
    this.predefinedMetricSpecification,
  });
  factory TargetTrackingConfiguration.fromXml(_s.XmlElement elem) {
    return TargetTrackingConfiguration(
      targetValue: _s.extractXmlDoubleValue(elem, 'TargetValue')!,
      customizedMetricSpecification: _s
          .extractXmlChild(elem, 'CustomizedMetricSpecification')
          ?.let((e) => CustomizedMetricSpecification.fromXml(e)),
      disableScaleIn: _s.extractXmlBoolValue(elem, 'DisableScaleIn'),
      predefinedMetricSpecification: _s
          .extractXmlChild(elem, 'PredefinedMetricSpecification')
          ?.let((e) => PredefinedMetricSpecification.fromXml(e)),
    );
  }

  Map<String, dynamic> toJson() {
    final targetValue = this.targetValue;
    final customizedMetricSpecification = this.customizedMetricSpecification;
    final disableScaleIn = this.disableScaleIn;
    final predefinedMetricSpecification = this.predefinedMetricSpecification;
    return {
      'TargetValue': targetValue,
      if (customizedMetricSpecification != null)
        'CustomizedMetricSpecification': customizedMetricSpecification,
      if (disableScaleIn != null) 'DisableScaleIn': disableScaleIn,
      if (predefinedMetricSpecification != null)
        'PredefinedMetricSpecification': predefinedMetricSpecification,
    };
  }
}

/// Specifies the minimum and maximum for the <code>TotalLocalStorageGB</code>
/// object when you specify <a>InstanceRequirements</a> for an Auto Scaling
/// group.
class TotalLocalStorageGBRequest {
  /// The storage maximum in GB.
  final double? max;

  /// The storage minimum in GB.
  final double? min;

  TotalLocalStorageGBRequest({
    this.max,
    this.min,
  });
  factory TotalLocalStorageGBRequest.fromXml(_s.XmlElement elem) {
    return TotalLocalStorageGBRequest(
      max: _s.extractXmlDoubleValue(elem, 'Max'),
      min: _s.extractXmlDoubleValue(elem, 'Min'),
    );
  }

  Map<String, dynamic> toJson() {
    final max = this.max;
    final min = this.min;
    return {
      if (max != null) 'Max': max,
      if (min != null) 'Min': min,
    };
  }
}

/// Specifies the minimum and maximum for the <code>VCpuCount</code> object when
/// you specify <a>InstanceRequirements</a> for an Auto Scaling group.
class VCpuCountRequest {
  /// The minimum number of vCPUs.
  final int min;

  /// The maximum number of vCPUs.
  final int? max;

  VCpuCountRequest({
    required this.min,
    this.max,
  });
  factory VCpuCountRequest.fromXml(_s.XmlElement elem) {
    return VCpuCountRequest(
      min: _s.extractXmlIntValue(elem, 'Min')!,
      max: _s.extractXmlIntValue(elem, 'Max'),
    );
  }

  Map<String, dynamic> toJson() {
    final min = this.min;
    final max = this.max;
    return {
      'Min': min,
      if (max != null) 'Max': max,
    };
  }
}

/// Describes a warm pool configuration.
class WarmPoolConfiguration {
  /// The instance reuse policy.
  final InstanceReusePolicy? instanceReusePolicy;

  /// The maximum number of instances that are allowed to be in the warm pool or
  /// in any state except <code>Terminated</code> for the Auto Scaling group.
  final int? maxGroupPreparedCapacity;

  /// The minimum number of instances to maintain in the warm pool.
  final int? minSize;

  /// The instance state to transition to after the lifecycle actions are
  /// complete.
  final WarmPoolState? poolState;

  /// The status of a warm pool that is marked for deletion.
  final WarmPoolStatus? status;

  WarmPoolConfiguration({
    this.instanceReusePolicy,
    this.maxGroupPreparedCapacity,
    this.minSize,
    this.poolState,
    this.status,
  });
  factory WarmPoolConfiguration.fromXml(_s.XmlElement elem) {
    return WarmPoolConfiguration(
      instanceReusePolicy: _s
          .extractXmlChild(elem, 'InstanceReusePolicy')
          ?.let((e) => InstanceReusePolicy.fromXml(e)),
      maxGroupPreparedCapacity:
          _s.extractXmlIntValue(elem, 'MaxGroupPreparedCapacity'),
      minSize: _s.extractXmlIntValue(elem, 'MinSize'),
      poolState: _s.extractXmlStringValue(elem, 'PoolState')?.toWarmPoolState(),
      status: _s.extractXmlStringValue(elem, 'Status')?.toWarmPoolStatus(),
    );
  }
}

enum WarmPoolState {
  stopped,
  running,
  hibernated,
}

extension on WarmPoolState {
  String toValue() {
    switch (this) {
      case WarmPoolState.stopped:
        return 'Stopped';
      case WarmPoolState.running:
        return 'Running';
      case WarmPoolState.hibernated:
        return 'Hibernated';
    }
  }
}

extension on String {
  WarmPoolState toWarmPoolState() {
    switch (this) {
      case 'Stopped':
        return WarmPoolState.stopped;
      case 'Running':
        return WarmPoolState.running;
      case 'Hibernated':
        return WarmPoolState.hibernated;
    }
    throw Exception('$this is not known in enum WarmPoolState');
  }
}

enum WarmPoolStatus {
  pendingDelete,
}

extension on WarmPoolStatus {
  String toValue() {
    switch (this) {
      case WarmPoolStatus.pendingDelete:
        return 'PendingDelete';
    }
  }
}

extension on String {
  WarmPoolStatus toWarmPoolStatus() {
    switch (this) {
      case 'PendingDelete':
        return WarmPoolStatus.pendingDelete;
    }
    throw Exception('$this is not known in enum WarmPoolStatus');
  }
}

class ActiveInstanceRefreshNotFoundFault extends _s.GenericAwsException {
  ActiveInstanceRefreshNotFoundFault({String? type, String? message})
      : super(
            type: type,
            code: 'ActiveInstanceRefreshNotFoundFault',
            message: message);
}

class AlreadyExistsFault extends _s.GenericAwsException {
  AlreadyExistsFault({String? type, String? message})
      : super(type: type, code: 'AlreadyExistsFault', message: message);
}

class InstanceRefreshInProgressFault extends _s.GenericAwsException {
  InstanceRefreshInProgressFault({String? type, String? message})
      : super(
            type: type,
            code: 'InstanceRefreshInProgressFault',
            message: message);
}

class InvalidNextToken extends _s.GenericAwsException {
  InvalidNextToken({String? type, String? message})
      : super(type: type, code: 'InvalidNextToken', message: message);
}

class LimitExceededFault extends _s.GenericAwsException {
  LimitExceededFault({String? type, String? message})
      : super(type: type, code: 'LimitExceededFault', message: message);
}

class ResourceContentionFault extends _s.GenericAwsException {
  ResourceContentionFault({String? type, String? message})
      : super(type: type, code: 'ResourceContentionFault', message: message);
}

class ResourceInUseFault extends _s.GenericAwsException {
  ResourceInUseFault({String? type, String? message})
      : super(type: type, code: 'ResourceInUseFault', message: message);
}

class ScalingActivityInProgressFault extends _s.GenericAwsException {
  ScalingActivityInProgressFault({String? type, String? message})
      : super(
            type: type,
            code: 'ScalingActivityInProgressFault',
            message: message);
}

class ServiceLinkedRoleFailure extends _s.GenericAwsException {
  ServiceLinkedRoleFailure({String? type, String? message})
      : super(type: type, code: 'ServiceLinkedRoleFailure', message: message);
}

final _exceptionFns = <String, _s.AwsExceptionFn>{
  'ActiveInstanceRefreshNotFoundFault': (type, message) =>
      ActiveInstanceRefreshNotFoundFault(type: type, message: message),
  'AlreadyExistsFault': (type, message) =>
      AlreadyExistsFault(type: type, message: message),
  'InstanceRefreshInProgressFault': (type, message) =>
      InstanceRefreshInProgressFault(type: type, message: message),
  'InvalidNextToken': (type, message) =>
      InvalidNextToken(type: type, message: message),
  'LimitExceededFault': (type, message) =>
      LimitExceededFault(type: type, message: message),
  'ResourceContentionFault': (type, message) =>
      ResourceContentionFault(type: type, message: message),
  'ResourceInUseFault': (type, message) =>
      ResourceInUseFault(type: type, message: message),
  'ScalingActivityInProgressFault': (type, message) =>
      ScalingActivityInProgressFault(type: type, message: message),
  'ServiceLinkedRoleFailure': (type, message) =>
      ServiceLinkedRoleFailure(type: type, message: message),
};
