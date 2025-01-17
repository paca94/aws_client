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

/// Use the AWS Elemental MediaTailor SDKs and CLI to configure scalable ad
/// insertion and linear channels. With MediaTailor, you can assemble existing
/// content into a linear stream and serve targeted ads to viewers while
/// maintaining broadcast quality in over-the-top (OTT) video applications. For
/// information about using the service, including detailed information about
/// the settings covered in this guide, see the <a
/// href="https://docs.aws.amazon.com/mediatailor/latest/ug/">AWS Elemental
/// MediaTailor User Guide</a>.
///
/// Through the SDKs and the CLI you manage AWS Elemental MediaTailor
/// configurations and channels the same as you do through the console. For
/// example, you specify ad insertion behavior and mapping information for the
/// origin server and the ad decision server (ADS).
class MediaTailor {
  final _s.RestJsonProtocol _protocol;
  MediaTailor({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.AwsClientCredentialsProvider? credentialsProvider,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.RestJsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'api.mediatailor',
            signingName: 'mediatailor',
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

  /// Configures Amazon CloudWatch log settings for a playback configuration.
  ///
  /// Parameter [percentEnabled] :
  /// The percentage of session logs that MediaTailor sends to your Cloudwatch
  /// Logs account. For example, if your playback configuration has 1000
  /// sessions and percentEnabled is set to 60, MediaTailor sends logs for 600
  /// of the sessions to CloudWatch Logs. MediaTailor decides at random which of
  /// the playback configuration sessions to send logs for. If you want to view
  /// logs for a specific session, you can use the <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/debug-log-mode.html">debug
  /// log mode</a>.
  ///
  /// Valid values: 0 - 100
  ///
  /// Parameter [playbackConfigurationName] :
  /// The name of the playback configuration.
  Future<ConfigureLogsForPlaybackConfigurationResponse>
      configureLogsForPlaybackConfiguration({
    required int percentEnabled,
    required String playbackConfigurationName,
  }) async {
    ArgumentError.checkNotNull(percentEnabled, 'percentEnabled');
    ArgumentError.checkNotNull(
        playbackConfigurationName, 'playbackConfigurationName');
    final $payload = <String, dynamic>{
      'PercentEnabled': percentEnabled,
      'PlaybackConfigurationName': playbackConfigurationName,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/configureLogs/playbackConfiguration',
      exceptionFnMap: _exceptionFns,
    );
    return ConfigureLogsForPlaybackConfigurationResponse.fromJson(response);
  }

  /// Creates a channel.
  ///
  /// Parameter [channelName] :
  /// The identifier for the channel you are working on.
  ///
  /// Parameter [outputs] :
  /// The channel's output properties.
  ///
  /// Parameter [playbackMode] :
  /// The type of playback mode to use for this channel.
  ///
  /// LINEAR - The programs in the schedule play once back-to-back in the
  /// schedule.
  ///
  /// LOOP - The programs in the schedule play back-to-back in an endless loop.
  /// When the last program in the schedule stops playing, playback loops back
  /// to the first program in the schedule.
  ///
  /// Parameter [fillerSlate] :
  /// The slate used to fill gaps between programs in the schedule. You must
  /// configure filler slate if your channel uses the LINEAR PlaybackMode.
  /// MediaTailor doesn't support filler slate for channels using the LOOP
  /// PlaybackMode.
  ///
  /// Parameter [tags] :
  /// The tags to assign to the channel.
  ///
  /// Parameter [tier] :
  /// The tier of the channel.
  Future<CreateChannelResponse> createChannel({
    required String channelName,
    required List<RequestOutputItem> outputs,
    required PlaybackMode playbackMode,
    SlateSource? fillerSlate,
    Map<String, String>? tags,
    Tier? tier,
  }) async {
    ArgumentError.checkNotNull(channelName, 'channelName');
    ArgumentError.checkNotNull(outputs, 'outputs');
    ArgumentError.checkNotNull(playbackMode, 'playbackMode');
    final $payload = <String, dynamic>{
      'Outputs': outputs,
      'PlaybackMode': playbackMode.toValue(),
      if (fillerSlate != null) 'FillerSlate': fillerSlate,
      if (tags != null) 'tags': tags,
      if (tier != null) 'Tier': tier.toValue(),
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/channel/${Uri.encodeComponent(channelName)}',
      exceptionFnMap: _exceptionFns,
    );
    return CreateChannelResponse.fromJson(response);
  }

  /// Creates name for a specific live source in a source location.
  ///
  /// Parameter [httpPackageConfigurations] :
  /// A list of HTTP package configuration parameters for this live source.
  ///
  /// Parameter [liveSourceName] :
  /// The identifier for the live source you are working on.
  ///
  /// Parameter [sourceLocationName] :
  /// The identifier for the source location you are working on.
  ///
  /// Parameter [tags] :
  /// The tags to assign to the live source.
  Future<CreateLiveSourceResponse> createLiveSource({
    required List<HttpPackageConfiguration> httpPackageConfigurations,
    required String liveSourceName,
    required String sourceLocationName,
    Map<String, String>? tags,
  }) async {
    ArgumentError.checkNotNull(
        httpPackageConfigurations, 'httpPackageConfigurations');
    ArgumentError.checkNotNull(liveSourceName, 'liveSourceName');
    ArgumentError.checkNotNull(sourceLocationName, 'sourceLocationName');
    final $payload = <String, dynamic>{
      'HttpPackageConfigurations': httpPackageConfigurations,
      if (tags != null) 'tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/sourceLocation/${Uri.encodeComponent(sourceLocationName)}/liveSource/${Uri.encodeComponent(liveSourceName)}',
      exceptionFnMap: _exceptionFns,
    );
    return CreateLiveSourceResponse.fromJson(response);
  }

  /// Creates a new prefetch schedule for the specified playback configuration.
  ///
  /// Parameter [consumption] :
  /// The configuration settings for MediaTailor's <i>consumption</i> of the
  /// prefetched ads from the ad decision server. Each consumption configuration
  /// contains an end time and an optional start time that define the
  /// <i>consumption window</i>. Prefetch schedules automatically expire no
  /// earlier than seven days after the end time.
  ///
  /// Parameter [name] :
  /// The identifier for the playback configuration.
  ///
  /// Parameter [playbackConfigurationName] :
  /// The name of the playback configuration.
  ///
  /// Parameter [retrieval] :
  /// The configuration settings for retrieval of prefetched ads from the ad
  /// decision server. Only one set of prefetched ads will be retrieved and
  /// subsequently consumed for each ad break.
  ///
  /// Parameter [streamId] :
  /// An optional stream identifier that MediaTailor uses to prefetch ads for
  /// multiple streams that use the same playback configuration. If StreamId is
  /// specified, MediaTailor returns all of the prefetch schedules with an exact
  /// match on StreamId. If not specified, MediaTailor returns all of the
  /// prefetch schedules for the playback configuration, regardless of StreamId.
  Future<CreatePrefetchScheduleResponse> createPrefetchSchedule({
    required PrefetchConsumption consumption,
    required String name,
    required String playbackConfigurationName,
    required PrefetchRetrieval retrieval,
    String? streamId,
  }) async {
    ArgumentError.checkNotNull(consumption, 'consumption');
    ArgumentError.checkNotNull(name, 'name');
    ArgumentError.checkNotNull(
        playbackConfigurationName, 'playbackConfigurationName');
    ArgumentError.checkNotNull(retrieval, 'retrieval');
    final $payload = <String, dynamic>{
      'Consumption': consumption,
      'Retrieval': retrieval,
      if (streamId != null) 'StreamId': streamId,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/prefetchSchedule/${Uri.encodeComponent(playbackConfigurationName)}/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return CreatePrefetchScheduleResponse.fromJson(response);
  }

  /// Creates a program.
  ///
  /// Parameter [channelName] :
  /// The identifier for the channel you are working on.
  ///
  /// Parameter [programName] :
  /// The identifier for the program you are working on.
  ///
  /// Parameter [scheduleConfiguration] :
  /// The schedule configuration settings.
  ///
  /// Parameter [sourceLocationName] :
  /// The name of the source location.
  ///
  /// Parameter [adBreaks] :
  /// The ad break configuration settings.
  ///
  /// Parameter [liveSourceName] :
  /// The name of the LiveSource for this Program.
  ///
  /// Parameter [vodSourceName] :
  /// The name that's used to refer to a VOD source.
  Future<CreateProgramResponse> createProgram({
    required String channelName,
    required String programName,
    required ScheduleConfiguration scheduleConfiguration,
    required String sourceLocationName,
    List<AdBreak>? adBreaks,
    String? liveSourceName,
    String? vodSourceName,
  }) async {
    ArgumentError.checkNotNull(channelName, 'channelName');
    ArgumentError.checkNotNull(programName, 'programName');
    ArgumentError.checkNotNull(scheduleConfiguration, 'scheduleConfiguration');
    ArgumentError.checkNotNull(sourceLocationName, 'sourceLocationName');
    final $payload = <String, dynamic>{
      'ScheduleConfiguration': scheduleConfiguration,
      'SourceLocationName': sourceLocationName,
      if (adBreaks != null) 'AdBreaks': adBreaks,
      if (liveSourceName != null) 'LiveSourceName': liveSourceName,
      if (vodSourceName != null) 'VodSourceName': vodSourceName,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/channel/${Uri.encodeComponent(channelName)}/program/${Uri.encodeComponent(programName)}',
      exceptionFnMap: _exceptionFns,
    );
    return CreateProgramResponse.fromJson(response);
  }

  /// Creates a source location on a specific channel.
  ///
  /// Parameter [httpConfiguration] :
  /// The source's HTTP package configurations.
  ///
  /// Parameter [sourceLocationName] :
  /// The identifier for the source location you are working on.
  ///
  /// Parameter [accessConfiguration] :
  /// Access configuration parameters. Configures the type of authentication
  /// used to access content from your source location.
  ///
  /// Parameter [defaultSegmentDeliveryConfiguration] :
  /// The optional configuration for the server that serves segments.
  ///
  /// Parameter [segmentDeliveryConfigurations] :
  /// A list of the segment delivery configurations associated with this
  /// resource.
  ///
  /// Parameter [tags] :
  /// The tags to assign to the source location.
  Future<CreateSourceLocationResponse> createSourceLocation({
    required HttpConfiguration httpConfiguration,
    required String sourceLocationName,
    AccessConfiguration? accessConfiguration,
    DefaultSegmentDeliveryConfiguration? defaultSegmentDeliveryConfiguration,
    List<SegmentDeliveryConfiguration>? segmentDeliveryConfigurations,
    Map<String, String>? tags,
  }) async {
    ArgumentError.checkNotNull(httpConfiguration, 'httpConfiguration');
    ArgumentError.checkNotNull(sourceLocationName, 'sourceLocationName');
    final $payload = <String, dynamic>{
      'HttpConfiguration': httpConfiguration,
      if (accessConfiguration != null)
        'AccessConfiguration': accessConfiguration,
      if (defaultSegmentDeliveryConfiguration != null)
        'DefaultSegmentDeliveryConfiguration':
            defaultSegmentDeliveryConfiguration,
      if (segmentDeliveryConfigurations != null)
        'SegmentDeliveryConfigurations': segmentDeliveryConfigurations,
      if (tags != null) 'tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/sourceLocation/${Uri.encodeComponent(sourceLocationName)}',
      exceptionFnMap: _exceptionFns,
    );
    return CreateSourceLocationResponse.fromJson(response);
  }

  /// Creates name for a specific VOD source in a source location.
  ///
  /// Parameter [httpPackageConfigurations] :
  /// A list of HTTP package configuration parameters for this VOD source.
  ///
  /// Parameter [sourceLocationName] :
  /// The identifier for the source location you are working on.
  ///
  /// Parameter [vodSourceName] :
  /// The identifier for the VOD source you are working on.
  ///
  /// Parameter [tags] :
  /// The tags to assign to the VOD source.
  Future<CreateVodSourceResponse> createVodSource({
    required List<HttpPackageConfiguration> httpPackageConfigurations,
    required String sourceLocationName,
    required String vodSourceName,
    Map<String, String>? tags,
  }) async {
    ArgumentError.checkNotNull(
        httpPackageConfigurations, 'httpPackageConfigurations');
    ArgumentError.checkNotNull(sourceLocationName, 'sourceLocationName');
    ArgumentError.checkNotNull(vodSourceName, 'vodSourceName');
    final $payload = <String, dynamic>{
      'HttpPackageConfigurations': httpPackageConfigurations,
      if (tags != null) 'tags': tags,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/sourceLocation/${Uri.encodeComponent(sourceLocationName)}/vodSource/${Uri.encodeComponent(vodSourceName)}',
      exceptionFnMap: _exceptionFns,
    );
    return CreateVodSourceResponse.fromJson(response);
  }

  /// Deletes a channel. You must stop the channel before it can be deleted.
  ///
  /// Parameter [channelName] :
  /// The identifier for the channel you are working on.
  Future<void> deleteChannel({
    required String channelName,
  }) async {
    ArgumentError.checkNotNull(channelName, 'channelName');
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/channel/${Uri.encodeComponent(channelName)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes a channel's IAM policy.
  ///
  /// Parameter [channelName] :
  /// The identifier for the channel you are working on.
  Future<void> deleteChannelPolicy({
    required String channelName,
  }) async {
    ArgumentError.checkNotNull(channelName, 'channelName');
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/channel/${Uri.encodeComponent(channelName)}/policy',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes a specific live source in a specific source location.
  ///
  /// Parameter [liveSourceName] :
  /// The identifier for the live source you are working on.
  ///
  /// Parameter [sourceLocationName] :
  /// The identifier for the source location you are working on.
  Future<void> deleteLiveSource({
    required String liveSourceName,
    required String sourceLocationName,
  }) async {
    ArgumentError.checkNotNull(liveSourceName, 'liveSourceName');
    ArgumentError.checkNotNull(sourceLocationName, 'sourceLocationName');
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri:
          '/sourceLocation/${Uri.encodeComponent(sourceLocationName)}/liveSource/${Uri.encodeComponent(liveSourceName)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes the playback configuration for the specified name.
  ///
  /// Parameter [name] :
  /// The identifier for the playback configuration.
  Future<void> deletePlaybackConfiguration({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/playbackConfiguration/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes a prefetch schedule for a specific playback configuration. If you
  /// call DeletePrefetchSchedule on an expired prefetch schedule, MediaTailor
  /// returns an HTTP 404 status code.
  ///
  /// Parameter [name] :
  /// The identifier for the playback configuration.
  ///
  /// Parameter [playbackConfigurationName] :
  /// The name of the playback configuration.
  Future<void> deletePrefetchSchedule({
    required String name,
    required String playbackConfigurationName,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    ArgumentError.checkNotNull(
        playbackConfigurationName, 'playbackConfigurationName');
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri:
          '/prefetchSchedule/${Uri.encodeComponent(playbackConfigurationName)}/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes a specific program on a specific channel.
  ///
  /// Parameter [channelName] :
  /// The identifier for the channel you are working on.
  ///
  /// Parameter [programName] :
  /// The identifier for the program you are working on.
  Future<void> deleteProgram({
    required String channelName,
    required String programName,
  }) async {
    ArgumentError.checkNotNull(channelName, 'channelName');
    ArgumentError.checkNotNull(programName, 'programName');
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri:
          '/channel/${Uri.encodeComponent(channelName)}/program/${Uri.encodeComponent(programName)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes a source location on a specific channel.
  ///
  /// Parameter [sourceLocationName] :
  /// The identifier for the source location you are working on.
  Future<void> deleteSourceLocation({
    required String sourceLocationName,
  }) async {
    ArgumentError.checkNotNull(sourceLocationName, 'sourceLocationName');
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/sourceLocation/${Uri.encodeComponent(sourceLocationName)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Deletes a specific VOD source in a specific source location.
  ///
  /// Parameter [sourceLocationName] :
  /// The identifier for the source location you are working on.
  ///
  /// Parameter [vodSourceName] :
  /// The identifier for the VOD source you are working on.
  Future<void> deleteVodSource({
    required String sourceLocationName,
    required String vodSourceName,
  }) async {
    ArgumentError.checkNotNull(sourceLocationName, 'sourceLocationName');
    ArgumentError.checkNotNull(vodSourceName, 'vodSourceName');
    final response = await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri:
          '/sourceLocation/${Uri.encodeComponent(sourceLocationName)}/vodSource/${Uri.encodeComponent(vodSourceName)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Describes the properties of a specific channel.
  ///
  /// Parameter [channelName] :
  /// The identifier for the channel you are working on.
  Future<DescribeChannelResponse> describeChannel({
    required String channelName,
  }) async {
    ArgumentError.checkNotNull(channelName, 'channelName');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/channel/${Uri.encodeComponent(channelName)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeChannelResponse.fromJson(response);
  }

  /// Provides details about a specific live source in a specific source
  /// location.
  ///
  /// Parameter [liveSourceName] :
  /// The identifier for the live source you are working on.
  ///
  /// Parameter [sourceLocationName] :
  /// The identifier for the source location you are working on.
  Future<DescribeLiveSourceResponse> describeLiveSource({
    required String liveSourceName,
    required String sourceLocationName,
  }) async {
    ArgumentError.checkNotNull(liveSourceName, 'liveSourceName');
    ArgumentError.checkNotNull(sourceLocationName, 'sourceLocationName');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/sourceLocation/${Uri.encodeComponent(sourceLocationName)}/liveSource/${Uri.encodeComponent(liveSourceName)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeLiveSourceResponse.fromJson(response);
  }

  /// Retrieves the properties of the requested program.
  ///
  /// Parameter [channelName] :
  /// The identifier for the channel you are working on.
  ///
  /// Parameter [programName] :
  /// The identifier for the program you are working on.
  Future<DescribeProgramResponse> describeProgram({
    required String channelName,
    required String programName,
  }) async {
    ArgumentError.checkNotNull(channelName, 'channelName');
    ArgumentError.checkNotNull(programName, 'programName');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/channel/${Uri.encodeComponent(channelName)}/program/${Uri.encodeComponent(programName)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeProgramResponse.fromJson(response);
  }

  /// Retrieves the properties of the requested source location.
  ///
  /// Parameter [sourceLocationName] :
  /// The identifier for the source location you are working on.
  Future<DescribeSourceLocationResponse> describeSourceLocation({
    required String sourceLocationName,
  }) async {
    ArgumentError.checkNotNull(sourceLocationName, 'sourceLocationName');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/sourceLocation/${Uri.encodeComponent(sourceLocationName)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeSourceLocationResponse.fromJson(response);
  }

  /// Provides details about a specific VOD source in a specific source
  /// location.
  ///
  /// Parameter [sourceLocationName] :
  /// The identifier for the source location you are working on.
  ///
  /// Parameter [vodSourceName] :
  /// The identifier for the VOD source you are working on.
  Future<DescribeVodSourceResponse> describeVodSource({
    required String sourceLocationName,
    required String vodSourceName,
  }) async {
    ArgumentError.checkNotNull(sourceLocationName, 'sourceLocationName');
    ArgumentError.checkNotNull(vodSourceName, 'vodSourceName');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/sourceLocation/${Uri.encodeComponent(sourceLocationName)}/vodSource/${Uri.encodeComponent(vodSourceName)}',
      exceptionFnMap: _exceptionFns,
    );
    return DescribeVodSourceResponse.fromJson(response);
  }

  /// Retrieves information about a channel's IAM policy.
  ///
  /// Parameter [channelName] :
  /// The identifier for the channel you are working on.
  Future<GetChannelPolicyResponse> getChannelPolicy({
    required String channelName,
  }) async {
    ArgumentError.checkNotNull(channelName, 'channelName');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/channel/${Uri.encodeComponent(channelName)}/policy',
      exceptionFnMap: _exceptionFns,
    );
    return GetChannelPolicyResponse.fromJson(response);
  }

  /// Retrieves information about your channel's schedule.
  ///
  /// Parameter [channelName] :
  /// The identifier for the channel you are working on.
  ///
  /// Parameter [durationMinutes] :
  /// The schedule duration in minutes. The maximum duration is 4320 minutes
  /// (three days).
  ///
  /// Parameter [maxResults] :
  /// Upper bound on number of records to return. The maximum number of results
  /// is 100.
  ///
  /// Parameter [nextToken] :
  /// Pagination token from the GET list request. Use the token to fetch the
  /// next page of results.
  Future<GetChannelScheduleResponse> getChannelSchedule({
    required String channelName,
    String? durationMinutes,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(channelName, 'channelName');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    final $query = <String, List<String>>{
      if (durationMinutes != null) 'durationMinutes': [durationMinutes],
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/channel/${Uri.encodeComponent(channelName)}/schedule',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return GetChannelScheduleResponse.fromJson(response);
  }

  /// Returns the playback configuration for the specified name.
  ///
  /// Parameter [name] :
  /// The identifier for the playback configuration.
  Future<GetPlaybackConfigurationResponse> getPlaybackConfiguration({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/playbackConfiguration/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return GetPlaybackConfigurationResponse.fromJson(response);
  }

  /// Returns information about the prefetch schedule for a specific playback
  /// configuration. If you call GetPrefetchSchedule on an expired prefetch
  /// schedule, MediaTailor returns an HTTP 404 status code.
  ///
  /// Parameter [name] :
  /// The identifier for the playback configuration.
  ///
  /// Parameter [playbackConfigurationName] :
  /// The name of the playback configuration.
  Future<GetPrefetchScheduleResponse> getPrefetchSchedule({
    required String name,
    required String playbackConfigurationName,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    ArgumentError.checkNotNull(
        playbackConfigurationName, 'playbackConfigurationName');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/prefetchSchedule/${Uri.encodeComponent(playbackConfigurationName)}/${Uri.encodeComponent(name)}',
      exceptionFnMap: _exceptionFns,
    );
    return GetPrefetchScheduleResponse.fromJson(response);
  }

  /// Returns a list of alerts for the given resource.
  ///
  /// Parameter [resourceArn] :
  /// The Amazon Resource Name (ARN) of the resource.
  ///
  /// Parameter [maxResults] :
  /// Upper bound on number of records to return. The maximum number of results
  /// is 100.
  ///
  /// Parameter [nextToken] :
  /// Pagination token from the GET list request. Use the token to fetch the
  /// next page of results.
  Future<ListAlertsResponse> listAlerts({
    required String resourceArn,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    final $query = <String, List<String>>{
      'resourceArn': [resourceArn],
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/alerts',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListAlertsResponse.fromJson(response);
  }

  /// Retrieves a list of channels that are associated with this account.
  ///
  /// Parameter [maxResults] :
  /// Upper bound on number of records to return. The maximum number of results
  /// is 100.
  ///
  /// Parameter [nextToken] :
  /// Pagination token from the GET list request. Use the token to fetch the
  /// next page of results.
  Future<ListChannelsResponse> listChannels({
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/channels',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListChannelsResponse.fromJson(response);
  }

  /// lists all the live sources in a source location.
  ///
  /// Parameter [sourceLocationName] :
  /// The identifier for the source location you are working on.
  ///
  /// Parameter [maxResults] :
  /// Upper bound on number of records to return. The maximum number of results
  /// is 100.
  ///
  /// Parameter [nextToken] :
  /// Pagination token from the GET list request. Use the token to fetch the
  /// next page of results.
  Future<ListLiveSourcesResponse> listLiveSources({
    required String sourceLocationName,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(sourceLocationName, 'sourceLocationName');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/sourceLocation/${Uri.encodeComponent(sourceLocationName)}/liveSources',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListLiveSourcesResponse.fromJson(response);
  }

  /// Returns a list of the playback configurations defined in AWS Elemental
  /// MediaTailor. You can specify a maximum number of configurations to return
  /// at a time. The default maximum is 50. Results are returned in pagefuls. If
  /// MediaTailor has more configurations than the specified maximum, it
  /// provides parameters in the response that you can use to retrieve the next
  /// pageful.
  ///
  /// Parameter [maxResults] :
  /// Maximum number of records to return.
  ///
  /// Parameter [nextToken] :
  /// Pagination token returned by the GET list request when results exceed the
  /// maximum allowed. Use the token to fetch the next page of results.
  Future<ListPlaybackConfigurationsResponse> listPlaybackConfigurations({
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'MaxResults': [maxResults.toString()],
      if (nextToken != null) 'NextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/playbackConfigurations',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListPlaybackConfigurationsResponse.fromJson(response);
  }

  /// Creates a new prefetch schedule.
  ///
  /// Parameter [playbackConfigurationName] :
  /// The name of the playback configuration.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of prefetch schedules that you want MediaTailor to
  /// return in response to the current request. If the playback configuration
  /// has more than MaxResults prefetch schedules, use the value of NextToken in
  /// the response to get the next page of results.
  ///
  /// Parameter [nextToken] :
  /// (Optional) If the playback configuration has more than MaxResults prefetch
  /// schedules, use NextToken to get the second and subsequent pages of
  /// results.
  ///
  /// For the first ListPrefetchSchedulesRequest request, omit this value.
  ///
  /// For the second and subsequent requests, get the value of NextToken from
  /// the previous response and specify that value for NextToken in the request.
  ///
  /// If the previous response didn't include a NextToken element, there are no
  /// more prefetch schedules to get.
  ///
  /// Parameter [streamId] :
  /// An optional filtering parameter whereby MediaTailor filters the prefetch
  /// schedules to include only specific streams.
  Future<ListPrefetchSchedulesResponse> listPrefetchSchedules({
    required String playbackConfigurationName,
    int? maxResults,
    String? nextToken,
    String? streamId,
  }) async {
    ArgumentError.checkNotNull(
        playbackConfigurationName, 'playbackConfigurationName');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    final $payload = <String, dynamic>{
      if (maxResults != null) 'MaxResults': maxResults,
      if (nextToken != null) 'NextToken': nextToken,
      if (streamId != null) 'StreamId': streamId,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri:
          '/prefetchSchedule/${Uri.encodeComponent(playbackConfigurationName)}',
      exceptionFnMap: _exceptionFns,
    );
    return ListPrefetchSchedulesResponse.fromJson(response);
  }

  /// Retrieves a list of source locations.
  ///
  /// Parameter [maxResults] :
  /// Upper bound on number of records to return. The maximum number of results
  /// is 100.
  ///
  /// Parameter [nextToken] :
  /// Pagination token from the GET list request. Use the token to fetch the
  /// next page of results.
  Future<ListSourceLocationsResponse> listSourceLocations({
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/sourceLocations',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListSourceLocationsResponse.fromJson(response);
  }

  /// Returns a list of the tags assigned to the specified playback
  /// configuration resource.
  ///
  /// May throw [BadRequestException].
  ///
  /// Parameter [resourceArn] :
  /// The Amazon Resource Name (ARN) for the playback configuration. You can get
  /// this from the response to any playback configuration request.
  Future<ListTagsForResourceResponse> listTagsForResource({
    required String resourceArn,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri: '/tags/${Uri.encodeComponent(resourceArn)}',
      exceptionFnMap: _exceptionFns,
    );
    return ListTagsForResourceResponse.fromJson(response);
  }

  /// Lists all the VOD sources in a source location.
  ///
  /// Parameter [sourceLocationName] :
  /// The identifier for the source location you are working on.
  ///
  /// Parameter [maxResults] :
  /// Upper bound on number of records to return. The maximum number of results
  /// is 100.
  ///
  /// Parameter [nextToken] :
  /// Pagination token from the GET list request. Use the token to fetch the
  /// next page of results.
  Future<ListVodSourcesResponse> listVodSources({
    required String sourceLocationName,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(sourceLocationName, 'sourceLocationName');
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      100,
    );
    final $query = <String, List<String>>{
      if (maxResults != null) 'maxResults': [maxResults.toString()],
      if (nextToken != null) 'nextToken': [nextToken],
    };
    final response = await _protocol.send(
      payload: null,
      method: 'GET',
      requestUri:
          '/sourceLocation/${Uri.encodeComponent(sourceLocationName)}/vodSources',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
    return ListVodSourcesResponse.fromJson(response);
  }

  /// Creates an IAM policy for the channel.
  ///
  /// Parameter [channelName] :
  /// The identifier for the channel you are working on.
  ///
  /// Parameter [policy] :
  /// Adds an IAM role that determines the permissions of your channel.
  Future<void> putChannelPolicy({
    required String channelName,
    required String policy,
  }) async {
    ArgumentError.checkNotNull(channelName, 'channelName');
    ArgumentError.checkNotNull(policy, 'policy');
    final $payload = <String, dynamic>{
      'Policy': policy,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/channel/${Uri.encodeComponent(channelName)}/policy',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Adds a new playback configuration to AWS Elemental MediaTailor.
  ///
  /// Parameter [adDecisionServerUrl] :
  /// The URL for the ad decision server (ADS). This includes the specification
  /// of static parameters and placeholders for dynamic parameters. AWS
  /// Elemental MediaTailor substitutes player-specific and session-specific
  /// parameters as needed when calling the ADS. Alternately, for testing you
  /// can provide a static VAST URL. The maximum length is 25,000 characters.
  ///
  /// Parameter [availSuppression] :
  /// The configuration for avail suppression, also known as ad suppression. For
  /// more information about ad suppression, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/ad-behavior.html">Ad
  /// Suppression</a>.
  ///
  /// Parameter [bumper] :
  /// The configuration for bumpers. Bumpers are short audio or video clips that
  /// play at the start or before the end of an ad break. To learn more about
  /// bumpers, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/bumpers.html">Bumpers</a>.
  ///
  /// Parameter [cdnConfiguration] :
  /// The configuration for using a content delivery network (CDN), like Amazon
  /// CloudFront, for content and ad segment management.
  ///
  /// Parameter [configurationAliases] :
  /// The player parameters and aliases used as dynamic variables during session
  /// initialization. For more information, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/variables-domain.html">Domain
  /// Variables</a>.
  ///
  /// Parameter [dashConfiguration] :
  /// The configuration for DASH content.
  ///
  /// Parameter [livePreRollConfiguration] :
  /// The configuration for pre-roll ad insertion.
  ///
  /// Parameter [manifestProcessingRules] :
  /// The configuration for manifest processing rules. Manifest processing rules
  /// enable customization of the personalized manifests created by MediaTailor.
  ///
  /// Parameter [name] :
  /// The identifier for the playback configuration.
  ///
  /// Parameter [personalizationThresholdSeconds] :
  /// Defines the maximum duration of underfilled ad time (in seconds) allowed
  /// in an ad break. If the duration of underfilled ad time exceeds the
  /// personalization threshold, then the personalization of the ad break is
  /// abandoned and the underlying content is shown. This feature applies to
  /// <i>ad replacement</i> in live and VOD streams, rather than ad insertion,
  /// because it relies on an underlying content stream. For more information
  /// about ad break behavior, including ad replacement and insertion, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/ad-behavior.html">Ad
  /// Behavior in AWS Elemental MediaTailor</a>.
  ///
  /// Parameter [slateAdUrl] :
  /// The URL for a high-quality video asset to transcode and use to fill in
  /// time that's not used by ads. AWS Elemental MediaTailor shows the slate to
  /// fill in gaps in media content. Configuring the slate is optional for
  /// non-VPAID configurations. For VPAID, the slate is required because
  /// MediaTailor provides it in the slots that are designated for dynamic ad
  /// content. The slate must be a high-quality asset that contains both audio
  /// and video.
  ///
  /// Parameter [tags] :
  /// The tags to assign to the playback configuration.
  ///
  /// Parameter [transcodeProfileName] :
  /// The name that is used to associate this playback configuration with a
  /// custom transcode profile. This overrides the dynamic transcoding defaults
  /// of MediaTailor. Use this only if you have already set up custom profiles
  /// with the help of AWS Support.
  ///
  /// Parameter [videoContentSourceUrl] :
  /// The URL prefix for the parent manifest for the stream, minus the asset ID.
  /// The maximum length is 512 characters.
  Future<PutPlaybackConfigurationResponse> putPlaybackConfiguration({
    String? adDecisionServerUrl,
    AvailSuppression? availSuppression,
    Bumper? bumper,
    CdnConfiguration? cdnConfiguration,
    Map<String, Map<String, String>>? configurationAliases,
    DashConfigurationForPut? dashConfiguration,
    LivePreRollConfiguration? livePreRollConfiguration,
    ManifestProcessingRules? manifestProcessingRules,
    String? name,
    int? personalizationThresholdSeconds,
    String? slateAdUrl,
    Map<String, String>? tags,
    String? transcodeProfileName,
    String? videoContentSourceUrl,
  }) async {
    _s.validateNumRange(
      'personalizationThresholdSeconds',
      personalizationThresholdSeconds,
      1,
      1152921504606846976,
    );
    final $payload = <String, dynamic>{
      if (adDecisionServerUrl != null)
        'AdDecisionServerUrl': adDecisionServerUrl,
      if (availSuppression != null) 'AvailSuppression': availSuppression,
      if (bumper != null) 'Bumper': bumper,
      if (cdnConfiguration != null) 'CdnConfiguration': cdnConfiguration,
      if (configurationAliases != null)
        'ConfigurationAliases': configurationAliases,
      if (dashConfiguration != null) 'DashConfiguration': dashConfiguration,
      if (livePreRollConfiguration != null)
        'LivePreRollConfiguration': livePreRollConfiguration,
      if (manifestProcessingRules != null)
        'ManifestProcessingRules': manifestProcessingRules,
      if (name != null) 'Name': name,
      if (personalizationThresholdSeconds != null)
        'PersonalizationThresholdSeconds': personalizationThresholdSeconds,
      if (slateAdUrl != null) 'SlateAdUrl': slateAdUrl,
      if (tags != null) 'tags': tags,
      if (transcodeProfileName != null)
        'TranscodeProfileName': transcodeProfileName,
      if (videoContentSourceUrl != null)
        'VideoContentSourceUrl': videoContentSourceUrl,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/playbackConfiguration',
      exceptionFnMap: _exceptionFns,
    );
    return PutPlaybackConfigurationResponse.fromJson(response);
  }

  /// Starts a specific channel.
  ///
  /// Parameter [channelName] :
  /// The identifier for the channel you are working on.
  Future<void> startChannel({
    required String channelName,
  }) async {
    ArgumentError.checkNotNull(channelName, 'channelName');
    final response = await _protocol.send(
      payload: null,
      method: 'PUT',
      requestUri: '/channel/${Uri.encodeComponent(channelName)}/start',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Stops a specific channel.
  ///
  /// Parameter [channelName] :
  /// The identifier for the channel you are working on.
  Future<void> stopChannel({
    required String channelName,
  }) async {
    ArgumentError.checkNotNull(channelName, 'channelName');
    final response = await _protocol.send(
      payload: null,
      method: 'PUT',
      requestUri: '/channel/${Uri.encodeComponent(channelName)}/stop',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Adds tags to the specified playback configuration resource. You can
  /// specify one or more tags to add.
  ///
  /// May throw [BadRequestException].
  ///
  /// Parameter [resourceArn] :
  /// The Amazon Resource Name (ARN) for the playback configuration. You can get
  /// this from the response to any playback configuration request.
  ///
  /// Parameter [tags] :
  /// A comma-separated list of tag key:value pairs.
  Future<void> tagResource({
    required String resourceArn,
    required Map<String, String> tags,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    ArgumentError.checkNotNull(tags, 'tags');
    final $payload = <String, dynamic>{
      'tags': tags,
    };
    await _protocol.send(
      payload: $payload,
      method: 'POST',
      requestUri: '/tags/${Uri.encodeComponent(resourceArn)}',
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Removes tags from the specified playback configuration resource. You can
  /// specify one or more tags to remove.
  ///
  /// May throw [BadRequestException].
  ///
  /// Parameter [resourceArn] :
  /// The Amazon Resource Name (ARN) for the playback configuration. You can get
  /// this from the response to any playback configuration request.
  ///
  /// Parameter [tagKeys] :
  /// A comma-separated list of the tag keys to remove from the playback
  /// configuration.
  Future<void> untagResource({
    required String resourceArn,
    required List<String> tagKeys,
  }) async {
    ArgumentError.checkNotNull(resourceArn, 'resourceArn');
    ArgumentError.checkNotNull(tagKeys, 'tagKeys');
    final $query = <String, List<String>>{
      'tagKeys': tagKeys,
    };
    await _protocol.send(
      payload: null,
      method: 'DELETE',
      requestUri: '/tags/${Uri.encodeComponent(resourceArn)}',
      queryParams: $query,
      exceptionFnMap: _exceptionFns,
    );
  }

  /// Updates an existing channel.
  ///
  /// Parameter [channelName] :
  /// The identifier for the channel you are working on.
  ///
  /// Parameter [outputs] :
  /// The channel's output properties.
  ///
  /// Parameter [fillerSlate] :
  /// The slate used to fill gaps between programs in the schedule. You must
  /// configure filler slate if your channel uses the LINEAR PlaybackMode.
  /// MediaTailor doesn't support filler slate for channels using the LOOP
  /// PlaybackMode.
  Future<UpdateChannelResponse> updateChannel({
    required String channelName,
    required List<RequestOutputItem> outputs,
    SlateSource? fillerSlate,
  }) async {
    ArgumentError.checkNotNull(channelName, 'channelName');
    ArgumentError.checkNotNull(outputs, 'outputs');
    final $payload = <String, dynamic>{
      'Outputs': outputs,
      if (fillerSlate != null) 'FillerSlate': fillerSlate,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/channel/${Uri.encodeComponent(channelName)}',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateChannelResponse.fromJson(response);
  }

  /// Updates a specific live source in a specific source location.
  ///
  /// Parameter [httpPackageConfigurations] :
  /// A list of HTTP package configurations for the live source on this account.
  ///
  /// Parameter [liveSourceName] :
  /// The identifier for the live source you are working on.
  ///
  /// Parameter [sourceLocationName] :
  /// The identifier for the source location you are working on.
  Future<UpdateLiveSourceResponse> updateLiveSource({
    required List<HttpPackageConfiguration> httpPackageConfigurations,
    required String liveSourceName,
    required String sourceLocationName,
  }) async {
    ArgumentError.checkNotNull(
        httpPackageConfigurations, 'httpPackageConfigurations');
    ArgumentError.checkNotNull(liveSourceName, 'liveSourceName');
    ArgumentError.checkNotNull(sourceLocationName, 'sourceLocationName');
    final $payload = <String, dynamic>{
      'HttpPackageConfigurations': httpPackageConfigurations,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri:
          '/sourceLocation/${Uri.encodeComponent(sourceLocationName)}/liveSource/${Uri.encodeComponent(liveSourceName)}',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateLiveSourceResponse.fromJson(response);
  }

  /// Updates a source location on a specific channel.
  ///
  /// Parameter [httpConfiguration] :
  /// The HTTP configuration for the source location.
  ///
  /// Parameter [sourceLocationName] :
  /// The identifier for the source location you are working on.
  ///
  /// Parameter [accessConfiguration] :
  /// Access configuration parameters. Configures the type of authentication
  /// used to access content from your source location.
  ///
  /// Parameter [defaultSegmentDeliveryConfiguration] :
  /// The optional configuration for the host server that serves segments.
  ///
  /// Parameter [segmentDeliveryConfigurations] :
  /// A list of the segment delivery configurations associated with this
  /// resource.
  Future<UpdateSourceLocationResponse> updateSourceLocation({
    required HttpConfiguration httpConfiguration,
    required String sourceLocationName,
    AccessConfiguration? accessConfiguration,
    DefaultSegmentDeliveryConfiguration? defaultSegmentDeliveryConfiguration,
    List<SegmentDeliveryConfiguration>? segmentDeliveryConfigurations,
  }) async {
    ArgumentError.checkNotNull(httpConfiguration, 'httpConfiguration');
    ArgumentError.checkNotNull(sourceLocationName, 'sourceLocationName');
    final $payload = <String, dynamic>{
      'HttpConfiguration': httpConfiguration,
      if (accessConfiguration != null)
        'AccessConfiguration': accessConfiguration,
      if (defaultSegmentDeliveryConfiguration != null)
        'DefaultSegmentDeliveryConfiguration':
            defaultSegmentDeliveryConfiguration,
      if (segmentDeliveryConfigurations != null)
        'SegmentDeliveryConfigurations': segmentDeliveryConfigurations,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri: '/sourceLocation/${Uri.encodeComponent(sourceLocationName)}',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateSourceLocationResponse.fromJson(response);
  }

  /// Updates a specific VOD source in a specific source location.
  ///
  /// Parameter [httpPackageConfigurations] :
  /// A list of HTTP package configurations for the VOD source on this account.
  ///
  /// Parameter [sourceLocationName] :
  /// The identifier for the source location you are working on.
  ///
  /// Parameter [vodSourceName] :
  /// The identifier for the VOD source you are working on.
  Future<UpdateVodSourceResponse> updateVodSource({
    required List<HttpPackageConfiguration> httpPackageConfigurations,
    required String sourceLocationName,
    required String vodSourceName,
  }) async {
    ArgumentError.checkNotNull(
        httpPackageConfigurations, 'httpPackageConfigurations');
    ArgumentError.checkNotNull(sourceLocationName, 'sourceLocationName');
    ArgumentError.checkNotNull(vodSourceName, 'vodSourceName');
    final $payload = <String, dynamic>{
      'HttpPackageConfigurations': httpPackageConfigurations,
    };
    final response = await _protocol.send(
      payload: $payload,
      method: 'PUT',
      requestUri:
          '/sourceLocation/${Uri.encodeComponent(sourceLocationName)}/vodSource/${Uri.encodeComponent(vodSourceName)}',
      exceptionFnMap: _exceptionFns,
    );
    return UpdateVodSourceResponse.fromJson(response);
  }
}

/// Access configuration parameters.
class AccessConfiguration {
  /// The type of authentication used to access content from
  /// HttpConfiguration::BaseUrl on your source location. Accepted value:
  /// S3_SIGV4.
  ///
  /// S3_SIGV4 - AWS Signature Version 4 authentication for Amazon S3 hosted
  /// virtual-style access. If your source location base URL is an Amazon S3
  /// bucket, MediaTailor can use AWS Signature Version 4 (SigV4) authentication
  /// to access the bucket where your source content is stored. Your MediaTailor
  /// source location baseURL must follow the S3 virtual hosted-style request URL
  /// format. For example, https://bucket-name.s3.Region.amazonaws.com/key-name.
  ///
  /// Before you can use S3_SIGV4, you must meet these requirements:
  ///
  /// • You must allow MediaTailor to access your S3 bucket by granting
  /// mediatailor.amazonaws.com principal access in IAM. For information about
  /// configuring access in IAM, see Access management in the IAM User Guide.
  ///
  /// • The mediatailor.amazonaws.com service principal must have permissions to
  /// read all top level manifests referenced by the VodSource packaging
  /// configurations.
  ///
  /// • The caller of the API must have s3:GetObject IAM permissions to read all
  /// top level manifests referenced by your MediaTailor VodSource packaging
  /// configurations.
  final AccessType? accessType;

  /// AWS Secrets Manager access token configuration parameters.
  final SecretsManagerAccessTokenConfiguration?
      secretsManagerAccessTokenConfiguration;

  AccessConfiguration({
    this.accessType,
    this.secretsManagerAccessTokenConfiguration,
  });
  factory AccessConfiguration.fromJson(Map<String, dynamic> json) {
    return AccessConfiguration(
      accessType: (json['AccessType'] as String?)?.toAccessType(),
      secretsManagerAccessTokenConfiguration:
          json['SecretsManagerAccessTokenConfiguration'] != null
              ? SecretsManagerAccessTokenConfiguration.fromJson(
                  json['SecretsManagerAccessTokenConfiguration']
                      as Map<String, dynamic>)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    final accessType = this.accessType;
    final secretsManagerAccessTokenConfiguration =
        this.secretsManagerAccessTokenConfiguration;
    return {
      if (accessType != null) 'AccessType': accessType.toValue(),
      if (secretsManagerAccessTokenConfiguration != null)
        'SecretsManagerAccessTokenConfiguration':
            secretsManagerAccessTokenConfiguration,
    };
  }
}

enum AccessType {
  s3Sigv4,
  secretsManagerAccessToken,
}

extension on AccessType {
  String toValue() {
    switch (this) {
      case AccessType.s3Sigv4:
        return 'S3_SIGV4';
      case AccessType.secretsManagerAccessToken:
        return 'SECRETS_MANAGER_ACCESS_TOKEN';
    }
  }
}

extension on String {
  AccessType toAccessType() {
    switch (this) {
      case 'S3_SIGV4':
        return AccessType.s3Sigv4;
      case 'SECRETS_MANAGER_ACCESS_TOKEN':
        return AccessType.secretsManagerAccessToken;
    }
    throw Exception('$this is not known in enum AccessType');
  }
}

/// Ad break configuration parameters.
class AdBreak {
  /// The SCTE-35 ad insertion type. Accepted value: SPLICE_INSERT.
  final MessageType? messageType;

  /// How long (in milliseconds) after the beginning of the program that an ad
  /// starts. This value must fall within 100ms of a segment boundary, otherwise
  /// the ad break will be skipped.
  final int? offsetMillis;

  /// Ad break slate configuration.
  final SlateSource? slate;

  /// This defines the SCTE-35 splice_insert() message inserted around the ad. For
  /// information about using splice_insert(), see the SCTE-35 specficiaiton,
  /// section 9.7.3.1.
  final SpliceInsertMessage? spliceInsertMessage;

  AdBreak({
    this.messageType,
    this.offsetMillis,
    this.slate,
    this.spliceInsertMessage,
  });
  factory AdBreak.fromJson(Map<String, dynamic> json) {
    return AdBreak(
      messageType: (json['MessageType'] as String?)?.toMessageType(),
      offsetMillis: json['OffsetMillis'] as int?,
      slate: json['Slate'] != null
          ? SlateSource.fromJson(json['Slate'] as Map<String, dynamic>)
          : null,
      spliceInsertMessage: json['SpliceInsertMessage'] != null
          ? SpliceInsertMessage.fromJson(
              json['SpliceInsertMessage'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final messageType = this.messageType;
    final offsetMillis = this.offsetMillis;
    final slate = this.slate;
    final spliceInsertMessage = this.spliceInsertMessage;
    return {
      if (messageType != null) 'MessageType': messageType.toValue(),
      if (offsetMillis != null) 'OffsetMillis': offsetMillis,
      if (slate != null) 'Slate': slate,
      if (spliceInsertMessage != null)
        'SpliceInsertMessage': spliceInsertMessage,
    };
  }
}

/// For HLS, when set to true, MediaTailor passes through EXT-X-CUE-IN,
/// EXT-X-CUE-OUT, and EXT-X-SPLICEPOINT-SCTE35 ad markers from the origin
/// manifest to the MediaTailor personalized manifest.
///
/// No logic is applied to these ad markers. For example, if EXT-X-CUE-OUT has a
/// value of 60, but no ads are filled for that ad break, MediaTailor will not
/// set the value to 0.
class AdMarkerPassthrough {
  /// Enables ad marker passthrough for your configuration.
  final bool? enabled;

  AdMarkerPassthrough({
    this.enabled,
  });
  factory AdMarkerPassthrough.fromJson(Map<String, dynamic> json) {
    return AdMarkerPassthrough(
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

/// Alert configuration parameters.
class Alert {
  /// The code for the alert. For example, NOT_PROCESSED.
  final String alertCode;

  /// If an alert is generated for a resource, an explanation of the reason for
  /// the alert.
  final String alertMessage;

  /// The timestamp when the alert was last modified.
  final DateTime lastModifiedTime;

  /// The Amazon Resource Names (ARNs) related to this alert.
  final List<String> relatedResourceArns;

  /// The Amazon Resource Name (ARN) of the resource.
  final String resourceArn;

  Alert({
    required this.alertCode,
    required this.alertMessage,
    required this.lastModifiedTime,
    required this.relatedResourceArns,
    required this.resourceArn,
  });
  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      alertCode: json['AlertCode'] as String,
      alertMessage: json['AlertMessage'] as String,
      lastModifiedTime:
          nonNullableTimeStampFromJson(json['LastModifiedTime'] as Object),
      relatedResourceArns: (json['RelatedResourceArns'] as List)
          .whereNotNull()
          .map((e) => e as String)
          .toList(),
      resourceArn: json['ResourceArn'] as String,
    );
  }
}

/// MediaTailor only places (consumes) prefetched ads if the ad break meets the
/// criteria defined by the dynamic variables. This gives you granular control
/// over which ad break to place the prefetched ads into.
///
/// As an example, let's say that you set DynamicVariable to scte.event_id and
/// Operator to EQUALS, and your playback configuration has an ADS URL of
/// https://my.ads.server.com/path?&amp;podId=[scte.avail_num]&amp;event=[scte.event_id]&amp;duration=[session.avail_duration_secs].
/// And the prefetch request to the ADS contains these values
/// https://my.ads.server.com/path?&amp;podId=3&amp;event=my-awesome-event&amp;duration=30.
/// MediaTailor will only insert the prefetched ads into the ad break if has a
/// SCTE marker with an event id of my-awesome-event, since it must match the
/// event id that MediaTailor uses to query the ADS.
///
/// You can specify up to five AvailMatchingCriteria. If you specify multiple
/// AvailMatchingCriteria, MediaTailor combines them to match using a logical
/// AND. You can model logical OR combinations by creating multiple prefetch
/// schedules.
class AvailMatchingCriteria {
  /// The dynamic variable(s) that MediaTailor should use as avail matching
  /// criteria. MediaTailor only places the prefetched ads into the avail if the
  /// avail matches the criteria defined by the dynamic variable. For information
  /// about dynamic variables, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/variables.html">Using
  /// dynamic ad variables</a> in the <i>MediaTailor User Guide</i>.
  ///
  /// You can include up to 100 dynamic variables.
  final String dynamicVariable;

  /// For the DynamicVariable specified in AvailMatchingCriteria, the Operator
  /// that is used for the comparison.
  final Operator operator;

  AvailMatchingCriteria({
    required this.dynamicVariable,
    required this.operator,
  });
  factory AvailMatchingCriteria.fromJson(Map<String, dynamic> json) {
    return AvailMatchingCriteria(
      dynamicVariable: json['DynamicVariable'] as String,
      operator: (json['Operator'] as String).toOperator(),
    );
  }

  Map<String, dynamic> toJson() {
    final dynamicVariable = this.dynamicVariable;
    final operator = this.operator;
    return {
      'DynamicVariable': dynamicVariable,
      'Operator': operator.toValue(),
    };
  }
}

/// The configuration for avail suppression, also known as ad suppression. For
/// more information about ad suppression, see <a
/// href="https://docs.aws.amazon.com/mediatailor/latest/ug/ad-behavior.html">Ad
/// Suppression</a>.
class AvailSuppression {
  /// Sets the ad suppression mode. By default, ad suppression is off and all ad
  /// breaks are filled with ads or slate. When Mode is set to BEHIND_LIVE_EDGE,
  /// ad suppression is active and MediaTailor won't fill ad breaks on or behind
  /// the ad suppression Value time in the manifest lookback window.
  final Mode? mode;

  /// A live edge offset time in HH:MM:SS. MediaTailor won't fill ad breaks on or
  /// behind this time in the manifest lookback window. If Value is set to
  /// 00:00:00, it is in sync with the live edge, and MediaTailor won't fill any
  /// ad breaks on or behind the live edge. If you set a Value time, MediaTailor
  /// won't fill any ad breaks on or behind this time in the manifest lookback
  /// window. For example, if you set 00:45:00, then MediaTailor will fill ad
  /// breaks that occur within 45 minutes behind the live edge, but won't fill ad
  /// breaks on or behind 45 minutes behind the live edge.
  final String? value;

  AvailSuppression({
    this.mode,
    this.value,
  });
  factory AvailSuppression.fromJson(Map<String, dynamic> json) {
    return AvailSuppression(
      mode: (json['Mode'] as String?)?.toMode(),
      value: json['Value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final mode = this.mode;
    final value = this.value;
    return {
      if (mode != null) 'Mode': mode.toValue(),
      if (value != null) 'Value': value,
    };
  }
}

/// The configuration for bumpers. Bumpers are short audio or video clips that
/// play at the start or before the end of an ad break. To learn more about
/// bumpers, see <a
/// href="https://docs.aws.amazon.com/mediatailor/latest/ug/bumpers.html">Bumpers</a>.
class Bumper {
  /// The URL for the end bumper asset.
  final String? endUrl;

  /// The URL for the start bumper asset.
  final String? startUrl;

  Bumper({
    this.endUrl,
    this.startUrl,
  });
  factory Bumper.fromJson(Map<String, dynamic> json) {
    return Bumper(
      endUrl: json['EndUrl'] as String?,
      startUrl: json['StartUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final endUrl = this.endUrl;
    final startUrl = this.startUrl;
    return {
      if (endUrl != null) 'EndUrl': endUrl,
      if (startUrl != null) 'StartUrl': startUrl,
    };
  }
}

/// The configuration for using a content delivery network (CDN), like Amazon
/// CloudFront, for content and ad segment management.
class CdnConfiguration {
  /// A non-default content delivery network (CDN) to serve ad segments. By
  /// default, AWS Elemental MediaTailor uses Amazon CloudFront with default cache
  /// settings as its CDN for ad segments. To set up an alternate CDN, create a
  /// rule in your CDN for the origin
  /// ads.mediatailor.&amp;lt;region>.amazonaws.com. Then specify the rule's name
  /// in this AdSegmentUrlPrefix. When AWS Elemental MediaTailor serves a
  /// manifest, it reports your CDN as the source for ad segments.
  final String? adSegmentUrlPrefix;

  /// A content delivery network (CDN) to cache content segments, so that content
  /// requests don’t always have to go to the origin server. First, create a rule
  /// in your CDN for the content segment origin server. Then specify the rule's
  /// name in this ContentSegmentUrlPrefix. When AWS Elemental MediaTailor serves
  /// a manifest, it reports your CDN as the source for content segments.
  final String? contentSegmentUrlPrefix;

  CdnConfiguration({
    this.adSegmentUrlPrefix,
    this.contentSegmentUrlPrefix,
  });
  factory CdnConfiguration.fromJson(Map<String, dynamic> json) {
    return CdnConfiguration(
      adSegmentUrlPrefix: json['AdSegmentUrlPrefix'] as String?,
      contentSegmentUrlPrefix: json['ContentSegmentUrlPrefix'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final adSegmentUrlPrefix = this.adSegmentUrlPrefix;
    final contentSegmentUrlPrefix = this.contentSegmentUrlPrefix;
    return {
      if (adSegmentUrlPrefix != null) 'AdSegmentUrlPrefix': adSegmentUrlPrefix,
      if (contentSegmentUrlPrefix != null)
        'ContentSegmentUrlPrefix': contentSegmentUrlPrefix,
    };
  }
}

/// The configuration parameters for a channel.
class Channel {
  /// The ARN of the channel.
  final String arn;

  /// The name of the channel.
  final String channelName;

  /// Returns the state whether the channel is running or not.
  final String channelState;

  /// The channel's output properties.
  final List<ResponseOutputItem> outputs;

  /// The type of playback mode for this channel.
  ///
  /// LINEAR - Programs play back-to-back only once.
  ///
  /// LOOP - Programs play back-to-back in an endless loop. When the last program
  /// in the schedule plays, playback loops back to the first program in the
  /// schedule.
  final String playbackMode;

  /// The tier for this channel. STANDARD tier channels can contain live programs.
  final String tier;

  /// The timestamp of when the channel was created.
  final DateTime? creationTime;

  /// The slate used to fill gaps between programs in the schedule. You must
  /// configure filler slate if your channel uses the LINEAR PlaybackMode.
  /// MediaTailor doesn't support filler slate for channels using the LOOP
  /// PlaybackMode.
  final SlateSource? fillerSlate;

  /// The timestamp of when the channel was last modified.
  final DateTime? lastModifiedTime;

  /// The tags to assign to the channel.
  final Map<String, String>? tags;

  Channel({
    required this.arn,
    required this.channelName,
    required this.channelState,
    required this.outputs,
    required this.playbackMode,
    required this.tier,
    this.creationTime,
    this.fillerSlate,
    this.lastModifiedTime,
    this.tags,
  });
  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      arn: json['Arn'] as String,
      channelName: json['ChannelName'] as String,
      channelState: json['ChannelState'] as String,
      outputs: (json['Outputs'] as List)
          .whereNotNull()
          .map((e) => ResponseOutputItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      playbackMode: json['PlaybackMode'] as String,
      tier: json['Tier'] as String,
      creationTime: timeStampFromJson(json['CreationTime']),
      fillerSlate: json['FillerSlate'] != null
          ? SlateSource.fromJson(json['FillerSlate'] as Map<String, dynamic>)
          : null,
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

enum ChannelState {
  running,
  stopped,
}

extension on ChannelState {
  String toValue() {
    switch (this) {
      case ChannelState.running:
        return 'RUNNING';
      case ChannelState.stopped:
        return 'STOPPED';
    }
  }
}

extension on String {
  ChannelState toChannelState() {
    switch (this) {
      case 'RUNNING':
        return ChannelState.running;
      case 'STOPPED':
        return ChannelState.stopped;
    }
    throw Exception('$this is not known in enum ChannelState');
  }
}

class ConfigureLogsForPlaybackConfigurationResponse {
  /// The percentage of session logs that MediaTailor sends to your Cloudwatch
  /// Logs account.
  final int? percentEnabled;

  /// The name of the playback configuration.
  final String? playbackConfigurationName;

  ConfigureLogsForPlaybackConfigurationResponse({
    this.percentEnabled,
    this.playbackConfigurationName,
  });
  factory ConfigureLogsForPlaybackConfigurationResponse.fromJson(
      Map<String, dynamic> json) {
    return ConfigureLogsForPlaybackConfigurationResponse(
      percentEnabled: json['PercentEnabled'] as int?,
      playbackConfigurationName: json['PlaybackConfigurationName'] as String?,
    );
  }
}

class CreateChannelResponse {
  /// The ARN of the channel.
  final String? arn;

  /// The name of the channel.
  final String? channelName;

  /// Indicates whether the channel is in a running state or not.
  final ChannelState? channelState;

  /// The timestamp of when the channel was created.
  final DateTime? creationTime;

  /// Contains information about the slate used to fill gaps between programs in
  /// the schedule.
  final SlateSource? fillerSlate;

  /// The timestamp of when the channel was last modified.
  final DateTime? lastModifiedTime;

  /// The channel's output properties.
  final List<ResponseOutputItem>? outputs;

  /// The channel's playback mode.
  final String? playbackMode;

  /// The tags assigned to the channel.
  final Map<String, String>? tags;

  /// The channel's tier.
  final String? tier;

  CreateChannelResponse({
    this.arn,
    this.channelName,
    this.channelState,
    this.creationTime,
    this.fillerSlate,
    this.lastModifiedTime,
    this.outputs,
    this.playbackMode,
    this.tags,
    this.tier,
  });
  factory CreateChannelResponse.fromJson(Map<String, dynamic> json) {
    return CreateChannelResponse(
      arn: json['Arn'] as String?,
      channelName: json['ChannelName'] as String?,
      channelState: (json['ChannelState'] as String?)?.toChannelState(),
      creationTime: timeStampFromJson(json['CreationTime']),
      fillerSlate: json['FillerSlate'] != null
          ? SlateSource.fromJson(json['FillerSlate'] as Map<String, dynamic>)
          : null,
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      outputs: (json['Outputs'] as List?)
          ?.whereNotNull()
          .map((e) => ResponseOutputItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      playbackMode: json['PlaybackMode'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      tier: json['Tier'] as String?,
    );
  }
}

class CreateLiveSourceResponse {
  /// The ARN of the live source.
  final String? arn;

  /// The timestamp that indicates when the live source was created.
  final DateTime? creationTime;

  /// The HTTP package configurations.
  final List<HttpPackageConfiguration>? httpPackageConfigurations;

  /// The timestamp that indicates when the live source was modified.
  final DateTime? lastModifiedTime;

  /// The name of the live source.
  final String? liveSourceName;

  /// The name of the source location associated with the VOD source.
  final String? sourceLocationName;

  /// The tags assigned to the live source.
  final Map<String, String>? tags;

  CreateLiveSourceResponse({
    this.arn,
    this.creationTime,
    this.httpPackageConfigurations,
    this.lastModifiedTime,
    this.liveSourceName,
    this.sourceLocationName,
    this.tags,
  });
  factory CreateLiveSourceResponse.fromJson(Map<String, dynamic> json) {
    return CreateLiveSourceResponse(
      arn: json['Arn'] as String?,
      creationTime: timeStampFromJson(json['CreationTime']),
      httpPackageConfigurations: (json['HttpPackageConfigurations'] as List?)
          ?.whereNotNull()
          .map((e) =>
              HttpPackageConfiguration.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      liveSourceName: json['LiveSourceName'] as String?,
      sourceLocationName: json['SourceLocationName'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class CreatePrefetchScheduleResponse {
  /// The Amazon Resource Name (ARN) of the prefetch schedule.
  final String? arn;

  /// Consumption settings determine how, and when, MediaTailor places the
  /// prefetched ads into ad breaks. Ad consumption occurs within a span of time
  /// that you define, called a <i>consumption window</i>. You can designate which
  /// ad breaks that MediaTailor fills with prefetch ads by setting avail matching
  /// criteria.
  final PrefetchConsumption? consumption;

  /// The name of the prefetch schedule. The name must be unique among all
  /// prefetch schedules that are associated with the specified playback
  /// configuration.
  final String? name;

  /// The name of the playback configuration to create the prefetch schedule for.
  final String? playbackConfigurationName;

  /// A complex type that contains settings for prefetch retrieval from the ad
  /// decision server (ADS).
  final PrefetchRetrieval? retrieval;

  /// An optional stream identifier that you can specify in order to prefetch for
  /// multiple streams that use the same playback configuration.
  final String? streamId;

  CreatePrefetchScheduleResponse({
    this.arn,
    this.consumption,
    this.name,
    this.playbackConfigurationName,
    this.retrieval,
    this.streamId,
  });
  factory CreatePrefetchScheduleResponse.fromJson(Map<String, dynamic> json) {
    return CreatePrefetchScheduleResponse(
      arn: json['Arn'] as String?,
      consumption: json['Consumption'] != null
          ? PrefetchConsumption.fromJson(
              json['Consumption'] as Map<String, dynamic>)
          : null,
      name: json['Name'] as String?,
      playbackConfigurationName: json['PlaybackConfigurationName'] as String?,
      retrieval: json['Retrieval'] != null
          ? PrefetchRetrieval.fromJson(
              json['Retrieval'] as Map<String, dynamic>)
          : null,
      streamId: json['StreamId'] as String?,
    );
  }
}

class CreateProgramResponse {
  /// The ad break configuration settings.
  final List<AdBreak>? adBreaks;

  /// The ARN of the program.
  final String? arn;

  /// The name of the channel that the program belongs to.
  final String? channelName;

  /// The timestamp of when the program was created.
  final DateTime? creationTime;

  /// The name of the LiveSource for this Program.
  final String? liveSourceName;

  /// The name of the program.
  final String? programName;

  /// The date and time that the program is scheduled to start in ISO 8601 format
  /// and Coordinated Universal Time (UTC). For example, the value
  /// 2021-03-27T17:48:16.751Z represents March 27, 2021 at 17:48:16.751 UTC.
  final DateTime? scheduledStartTime;

  /// The source location name.
  final String? sourceLocationName;

  /// The name that's used to refer to a VOD source.
  final String? vodSourceName;

  CreateProgramResponse({
    this.adBreaks,
    this.arn,
    this.channelName,
    this.creationTime,
    this.liveSourceName,
    this.programName,
    this.scheduledStartTime,
    this.sourceLocationName,
    this.vodSourceName,
  });
  factory CreateProgramResponse.fromJson(Map<String, dynamic> json) {
    return CreateProgramResponse(
      adBreaks: (json['AdBreaks'] as List?)
          ?.whereNotNull()
          .map((e) => AdBreak.fromJson(e as Map<String, dynamic>))
          .toList(),
      arn: json['Arn'] as String?,
      channelName: json['ChannelName'] as String?,
      creationTime: timeStampFromJson(json['CreationTime']),
      liveSourceName: json['LiveSourceName'] as String?,
      programName: json['ProgramName'] as String?,
      scheduledStartTime: timeStampFromJson(json['ScheduledStartTime']),
      sourceLocationName: json['SourceLocationName'] as String?,
      vodSourceName: json['VodSourceName'] as String?,
    );
  }
}

class CreateSourceLocationResponse {
  /// The access configuration for the source location.
  final AccessConfiguration? accessConfiguration;

  /// The ARN of the source location.
  final String? arn;

  /// The timestamp that indicates when the source location was created.
  final DateTime? creationTime;

  /// The default segment delivery configuration settings.
  final DefaultSegmentDeliveryConfiguration?
      defaultSegmentDeliveryConfiguration;

  /// The HTTP package configuration settings for the source location.
  final HttpConfiguration? httpConfiguration;

  /// The timestamp that indicates when the source location was last modified.
  final DateTime? lastModifiedTime;

  /// A list of the segment delivery configurations associated with this resource.
  final List<SegmentDeliveryConfiguration>? segmentDeliveryConfigurations;

  /// The name of the source location.
  final String? sourceLocationName;

  /// The tags assigned to the source location.
  final Map<String, String>? tags;

  CreateSourceLocationResponse({
    this.accessConfiguration,
    this.arn,
    this.creationTime,
    this.defaultSegmentDeliveryConfiguration,
    this.httpConfiguration,
    this.lastModifiedTime,
    this.segmentDeliveryConfigurations,
    this.sourceLocationName,
    this.tags,
  });
  factory CreateSourceLocationResponse.fromJson(Map<String, dynamic> json) {
    return CreateSourceLocationResponse(
      accessConfiguration: json['AccessConfiguration'] != null
          ? AccessConfiguration.fromJson(
              json['AccessConfiguration'] as Map<String, dynamic>)
          : null,
      arn: json['Arn'] as String?,
      creationTime: timeStampFromJson(json['CreationTime']),
      defaultSegmentDeliveryConfiguration:
          json['DefaultSegmentDeliveryConfiguration'] != null
              ? DefaultSegmentDeliveryConfiguration.fromJson(
                  json['DefaultSegmentDeliveryConfiguration']
                      as Map<String, dynamic>)
              : null,
      httpConfiguration: json['HttpConfiguration'] != null
          ? HttpConfiguration.fromJson(
              json['HttpConfiguration'] as Map<String, dynamic>)
          : null,
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      segmentDeliveryConfigurations: (json['SegmentDeliveryConfigurations']
              as List?)
          ?.whereNotNull()
          .map((e) =>
              SegmentDeliveryConfiguration.fromJson(e as Map<String, dynamic>))
          .toList(),
      sourceLocationName: json['SourceLocationName'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class CreateVodSourceResponse {
  /// The ARN of the VOD source.
  final String? arn;

  /// The timestamp that indicates when the VOD source was created.
  final DateTime? creationTime;

  /// The HTTP package configurations.
  final List<HttpPackageConfiguration>? httpPackageConfigurations;

  /// The last modified time of the VOD source.
  final DateTime? lastModifiedTime;

  /// The name of the source location associated with the VOD source.
  final String? sourceLocationName;

  /// The tags assigned to the VOD source.
  final Map<String, String>? tags;

  /// The name of the VOD source.
  final String? vodSourceName;

  CreateVodSourceResponse({
    this.arn,
    this.creationTime,
    this.httpPackageConfigurations,
    this.lastModifiedTime,
    this.sourceLocationName,
    this.tags,
    this.vodSourceName,
  });
  factory CreateVodSourceResponse.fromJson(Map<String, dynamic> json) {
    return CreateVodSourceResponse(
      arn: json['Arn'] as String?,
      creationTime: timeStampFromJson(json['CreationTime']),
      httpPackageConfigurations: (json['HttpPackageConfigurations'] as List?)
          ?.whereNotNull()
          .map((e) =>
              HttpPackageConfiguration.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      sourceLocationName: json['SourceLocationName'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      vodSourceName: json['VodSourceName'] as String?,
    );
  }
}

/// The configuration for DASH content.
class DashConfiguration {
  /// The URL generated by MediaTailor to initiate a playback session. The session
  /// uses server-side reporting. This setting is ignored in PUT operations.
  final String? manifestEndpointPrefix;

  /// The setting that controls whether MediaTailor includes the Location tag in
  /// DASH manifests. MediaTailor populates the Location tag with the URL for
  /// manifest update requests, to be used by players that don't support sticky
  /// redirects. Disable this if you have CDN routing rules set up for accessing
  /// MediaTailor manifests, and you are either using client-side reporting or
  /// your players support sticky HTTP redirects. Valid values are DISABLED and
  /// EMT_DEFAULT. The EMT_DEFAULT setting enables the inclusion of the tag and is
  /// the default value.
  final String? mpdLocation;

  /// The setting that controls whether MediaTailor handles manifests from the
  /// origin server as multi-period manifests or single-period manifests. If your
  /// origin server produces single-period manifests, set this to SINGLE_PERIOD.
  /// The default setting is MULTI_PERIOD. For multi-period manifests, omit this
  /// setting or set it to MULTI_PERIOD.
  final OriginManifestType? originManifestType;

  DashConfiguration({
    this.manifestEndpointPrefix,
    this.mpdLocation,
    this.originManifestType,
  });
  factory DashConfiguration.fromJson(Map<String, dynamic> json) {
    return DashConfiguration(
      manifestEndpointPrefix: json['ManifestEndpointPrefix'] as String?,
      mpdLocation: json['MpdLocation'] as String?,
      originManifestType:
          (json['OriginManifestType'] as String?)?.toOriginManifestType(),
    );
  }
}

/// The configuration for DASH PUT operations.
class DashConfigurationForPut {
  /// The setting that controls whether MediaTailor includes the Location tag in
  /// DASH manifests. MediaTailor populates the Location tag with the URL for
  /// manifest update requests, to be used by players that don't support sticky
  /// redirects. Disable this if you have CDN routing rules set up for accessing
  /// MediaTailor manifests, and you are either using client-side reporting or
  /// your players support sticky HTTP redirects. Valid values are DISABLED and
  /// EMT_DEFAULT. The EMT_DEFAULT setting enables the inclusion of the tag and is
  /// the default value.
  final String? mpdLocation;

  /// The setting that controls whether MediaTailor handles manifests from the
  /// origin server as multi-period manifests or single-period manifests. If your
  /// origin server produces single-period manifests, set this to SINGLE_PERIOD.
  /// The default setting is MULTI_PERIOD. For multi-period manifests, omit this
  /// setting or set it to MULTI_PERIOD.
  final OriginManifestType? originManifestType;

  DashConfigurationForPut({
    this.mpdLocation,
    this.originManifestType,
  });
  Map<String, dynamic> toJson() {
    final mpdLocation = this.mpdLocation;
    final originManifestType = this.originManifestType;
    return {
      if (mpdLocation != null) 'MpdLocation': mpdLocation,
      if (originManifestType != null)
        'OriginManifestType': originManifestType.toValue(),
    };
  }
}

/// Dash manifest configuration parameters.
class DashPlaylistSettings {
  /// The total duration (in seconds) of each manifest. Minimum value: 30 seconds.
  /// Maximum value: 3600 seconds.
  final int? manifestWindowSeconds;

  /// Minimum amount of content (measured in seconds) that a player must keep
  /// available in the buffer. Minimum value: 2 seconds. Maximum value: 60
  /// seconds.
  final int? minBufferTimeSeconds;

  /// Minimum amount of time (in seconds) that the player should wait before
  /// requesting updates to the manifest. Minimum value: 2 seconds. Maximum value:
  /// 60 seconds.
  final int? minUpdatePeriodSeconds;

  /// Amount of time (in seconds) that the player should be from the live point at
  /// the end of the manifest. Minimum value: 2 seconds. Maximum value: 60
  /// seconds.
  final int? suggestedPresentationDelaySeconds;

  DashPlaylistSettings({
    this.manifestWindowSeconds,
    this.minBufferTimeSeconds,
    this.minUpdatePeriodSeconds,
    this.suggestedPresentationDelaySeconds,
  });
  factory DashPlaylistSettings.fromJson(Map<String, dynamic> json) {
    return DashPlaylistSettings(
      manifestWindowSeconds: json['ManifestWindowSeconds'] as int?,
      minBufferTimeSeconds: json['MinBufferTimeSeconds'] as int?,
      minUpdatePeriodSeconds: json['MinUpdatePeriodSeconds'] as int?,
      suggestedPresentationDelaySeconds:
          json['SuggestedPresentationDelaySeconds'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final manifestWindowSeconds = this.manifestWindowSeconds;
    final minBufferTimeSeconds = this.minBufferTimeSeconds;
    final minUpdatePeriodSeconds = this.minUpdatePeriodSeconds;
    final suggestedPresentationDelaySeconds =
        this.suggestedPresentationDelaySeconds;
    return {
      if (manifestWindowSeconds != null)
        'ManifestWindowSeconds': manifestWindowSeconds,
      if (minBufferTimeSeconds != null)
        'MinBufferTimeSeconds': minBufferTimeSeconds,
      if (minUpdatePeriodSeconds != null)
        'MinUpdatePeriodSeconds': minUpdatePeriodSeconds,
      if (suggestedPresentationDelaySeconds != null)
        'SuggestedPresentationDelaySeconds': suggestedPresentationDelaySeconds,
    };
  }
}

/// The optional configuration for a server that serves segments. Use this if
/// you want the segment delivery server to be different from the source
/// location server. For example, you can configure your source location server
/// to be an origination server, such as MediaPackage, and the segment delivery
/// server to be a content delivery network (CDN), such as CloudFront. If you
/// don't specify a segment delivery server, then the source location server is
/// used.
class DefaultSegmentDeliveryConfiguration {
  /// The hostname of the server that will be used to serve segments. This string
  /// must include the protocol, such as <b>https://</b>.
  final String? baseUrl;

  DefaultSegmentDeliveryConfiguration({
    this.baseUrl,
  });
  factory DefaultSegmentDeliveryConfiguration.fromJson(
      Map<String, dynamic> json) {
    return DefaultSegmentDeliveryConfiguration(
      baseUrl: json['BaseUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final baseUrl = this.baseUrl;
    return {
      if (baseUrl != null) 'BaseUrl': baseUrl,
    };
  }
}

class DeleteChannelPolicyResponse {
  DeleteChannelPolicyResponse();
  factory DeleteChannelPolicyResponse.fromJson(Map<String, dynamic> _) {
    return DeleteChannelPolicyResponse();
  }
}

class DeleteChannelResponse {
  DeleteChannelResponse();
  factory DeleteChannelResponse.fromJson(Map<String, dynamic> _) {
    return DeleteChannelResponse();
  }
}

class DeleteLiveSourceResponse {
  DeleteLiveSourceResponse();
  factory DeleteLiveSourceResponse.fromJson(Map<String, dynamic> _) {
    return DeleteLiveSourceResponse();
  }
}

class DeletePlaybackConfigurationResponse {
  DeletePlaybackConfigurationResponse();
  factory DeletePlaybackConfigurationResponse.fromJson(Map<String, dynamic> _) {
    return DeletePlaybackConfigurationResponse();
  }
}

class DeletePrefetchScheduleResponse {
  DeletePrefetchScheduleResponse();
  factory DeletePrefetchScheduleResponse.fromJson(Map<String, dynamic> _) {
    return DeletePrefetchScheduleResponse();
  }
}

class DeleteProgramResponse {
  DeleteProgramResponse();
  factory DeleteProgramResponse.fromJson(Map<String, dynamic> _) {
    return DeleteProgramResponse();
  }
}

class DeleteSourceLocationResponse {
  DeleteSourceLocationResponse();
  factory DeleteSourceLocationResponse.fromJson(Map<String, dynamic> _) {
    return DeleteSourceLocationResponse();
  }
}

class DeleteVodSourceResponse {
  DeleteVodSourceResponse();
  factory DeleteVodSourceResponse.fromJson(Map<String, dynamic> _) {
    return DeleteVodSourceResponse();
  }
}

class DescribeChannelResponse {
  /// The ARN of the channel.
  final String? arn;

  /// The name of the channel.
  final String? channelName;

  /// Indicates whether the channel is in a running state or not.
  final ChannelState? channelState;

  /// The timestamp of when the channel was created.
  final DateTime? creationTime;

  /// Contains information about the slate used to fill gaps between programs in
  /// the schedule.
  final SlateSource? fillerSlate;

  /// The timestamp of when the channel was last modified.
  final DateTime? lastModifiedTime;

  /// The channel's output properties.
  final List<ResponseOutputItem>? outputs;

  /// The channel's playback mode.
  final String? playbackMode;

  /// The tags assigned to the channel.
  final Map<String, String>? tags;

  /// The channel's tier.
  final String? tier;

  DescribeChannelResponse({
    this.arn,
    this.channelName,
    this.channelState,
    this.creationTime,
    this.fillerSlate,
    this.lastModifiedTime,
    this.outputs,
    this.playbackMode,
    this.tags,
    this.tier,
  });
  factory DescribeChannelResponse.fromJson(Map<String, dynamic> json) {
    return DescribeChannelResponse(
      arn: json['Arn'] as String?,
      channelName: json['ChannelName'] as String?,
      channelState: (json['ChannelState'] as String?)?.toChannelState(),
      creationTime: timeStampFromJson(json['CreationTime']),
      fillerSlate: json['FillerSlate'] != null
          ? SlateSource.fromJson(json['FillerSlate'] as Map<String, dynamic>)
          : null,
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      outputs: (json['Outputs'] as List?)
          ?.whereNotNull()
          .map((e) => ResponseOutputItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      playbackMode: json['PlaybackMode'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      tier: json['Tier'] as String?,
    );
  }
}

class DescribeLiveSourceResponse {
  /// The ARN of the live source.
  final String? arn;

  /// The timestamp that indicates when the live source was created.
  final DateTime? creationTime;

  /// The HTTP package configurations.
  final List<HttpPackageConfiguration>? httpPackageConfigurations;

  /// The timestamp that indicates when the live source was modified.
  final DateTime? lastModifiedTime;

  /// The name of the live source.
  final String? liveSourceName;

  /// The name of the source location associated with the VOD source.
  final String? sourceLocationName;

  /// The tags assigned to the live source.
  final Map<String, String>? tags;

  DescribeLiveSourceResponse({
    this.arn,
    this.creationTime,
    this.httpPackageConfigurations,
    this.lastModifiedTime,
    this.liveSourceName,
    this.sourceLocationName,
    this.tags,
  });
  factory DescribeLiveSourceResponse.fromJson(Map<String, dynamic> json) {
    return DescribeLiveSourceResponse(
      arn: json['Arn'] as String?,
      creationTime: timeStampFromJson(json['CreationTime']),
      httpPackageConfigurations: (json['HttpPackageConfigurations'] as List?)
          ?.whereNotNull()
          .map((e) =>
              HttpPackageConfiguration.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      liveSourceName: json['LiveSourceName'] as String?,
      sourceLocationName: json['SourceLocationName'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class DescribeProgramResponse {
  /// The ad break configuration settings.
  final List<AdBreak>? adBreaks;

  /// The ARN of the program.
  final String? arn;

  /// The name of the channel that the program belongs to.
  final String? channelName;

  /// The timestamp of when the program was created.
  final DateTime? creationTime;

  /// The name of the LiveSource for this Program.
  final String? liveSourceName;

  /// The name of the program.
  final String? programName;

  /// The date and time that the program is scheduled to start in ISO 8601 format
  /// and Coordinated Universal Time (UTC). For example, the value
  /// 2021-03-27T17:48:16.751Z represents March 27, 2021 at 17:48:16.751 UTC.
  final DateTime? scheduledStartTime;

  /// The source location name.
  final String? sourceLocationName;

  /// The name that's used to refer to a VOD source.
  final String? vodSourceName;

  DescribeProgramResponse({
    this.adBreaks,
    this.arn,
    this.channelName,
    this.creationTime,
    this.liveSourceName,
    this.programName,
    this.scheduledStartTime,
    this.sourceLocationName,
    this.vodSourceName,
  });
  factory DescribeProgramResponse.fromJson(Map<String, dynamic> json) {
    return DescribeProgramResponse(
      adBreaks: (json['AdBreaks'] as List?)
          ?.whereNotNull()
          .map((e) => AdBreak.fromJson(e as Map<String, dynamic>))
          .toList(),
      arn: json['Arn'] as String?,
      channelName: json['ChannelName'] as String?,
      creationTime: timeStampFromJson(json['CreationTime']),
      liveSourceName: json['LiveSourceName'] as String?,
      programName: json['ProgramName'] as String?,
      scheduledStartTime: timeStampFromJson(json['ScheduledStartTime']),
      sourceLocationName: json['SourceLocationName'] as String?,
      vodSourceName: json['VodSourceName'] as String?,
    );
  }
}

class DescribeSourceLocationResponse {
  /// The access configuration for the source location.
  final AccessConfiguration? accessConfiguration;

  /// The ARN of the source location.
  final String? arn;

  /// The timestamp that indicates when the source location was created.
  final DateTime? creationTime;

  /// The default segment delivery configuration settings.
  final DefaultSegmentDeliveryConfiguration?
      defaultSegmentDeliveryConfiguration;

  /// The HTTP package configuration settings for the source location.
  final HttpConfiguration? httpConfiguration;

  /// The timestamp that indicates when the source location was last modified.
  final DateTime? lastModifiedTime;

  /// A list of the segment delivery configurations associated with this resource.
  final List<SegmentDeliveryConfiguration>? segmentDeliveryConfigurations;

  /// The name of the source location.
  final String? sourceLocationName;

  /// The tags assigned to the source location.
  final Map<String, String>? tags;

  DescribeSourceLocationResponse({
    this.accessConfiguration,
    this.arn,
    this.creationTime,
    this.defaultSegmentDeliveryConfiguration,
    this.httpConfiguration,
    this.lastModifiedTime,
    this.segmentDeliveryConfigurations,
    this.sourceLocationName,
    this.tags,
  });
  factory DescribeSourceLocationResponse.fromJson(Map<String, dynamic> json) {
    return DescribeSourceLocationResponse(
      accessConfiguration: json['AccessConfiguration'] != null
          ? AccessConfiguration.fromJson(
              json['AccessConfiguration'] as Map<String, dynamic>)
          : null,
      arn: json['Arn'] as String?,
      creationTime: timeStampFromJson(json['CreationTime']),
      defaultSegmentDeliveryConfiguration:
          json['DefaultSegmentDeliveryConfiguration'] != null
              ? DefaultSegmentDeliveryConfiguration.fromJson(
                  json['DefaultSegmentDeliveryConfiguration']
                      as Map<String, dynamic>)
              : null,
      httpConfiguration: json['HttpConfiguration'] != null
          ? HttpConfiguration.fromJson(
              json['HttpConfiguration'] as Map<String, dynamic>)
          : null,
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      segmentDeliveryConfigurations: (json['SegmentDeliveryConfigurations']
              as List?)
          ?.whereNotNull()
          .map((e) =>
              SegmentDeliveryConfiguration.fromJson(e as Map<String, dynamic>))
          .toList(),
      sourceLocationName: json['SourceLocationName'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class DescribeVodSourceResponse {
  /// The ARN of the VOD source.
  final String? arn;

  /// The timestamp that indicates when the VOD source was created.
  final DateTime? creationTime;

  /// The HTTP package configurations.
  final List<HttpPackageConfiguration>? httpPackageConfigurations;

  /// The last modified time of the VOD source.
  final DateTime? lastModifiedTime;

  /// The name of the source location associated with the VOD source.
  final String? sourceLocationName;

  /// The tags assigned to the VOD source.
  final Map<String, String>? tags;

  /// The name of the VOD source.
  final String? vodSourceName;

  DescribeVodSourceResponse({
    this.arn,
    this.creationTime,
    this.httpPackageConfigurations,
    this.lastModifiedTime,
    this.sourceLocationName,
    this.tags,
    this.vodSourceName,
  });
  factory DescribeVodSourceResponse.fromJson(Map<String, dynamic> json) {
    return DescribeVodSourceResponse(
      arn: json['Arn'] as String?,
      creationTime: timeStampFromJson(json['CreationTime']),
      httpPackageConfigurations: (json['HttpPackageConfigurations'] as List?)
          ?.whereNotNull()
          .map((e) =>
              HttpPackageConfiguration.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      sourceLocationName: json['SourceLocationName'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      vodSourceName: json['VodSourceName'] as String?,
    );
  }
}

class GetChannelPolicyResponse {
  /// The IAM policy for the channel.
  final String? policy;

  GetChannelPolicyResponse({
    this.policy,
  });
  factory GetChannelPolicyResponse.fromJson(Map<String, dynamic> json) {
    return GetChannelPolicyResponse(
      policy: json['Policy'] as String?,
    );
  }
}

class GetChannelScheduleResponse {
  /// A list of schedule entries for the channel.
  final List<ScheduleEntry>? items;

  /// Pagination token from the GET list request. Use the token to fetch the next
  /// page of results.
  final String? nextToken;

  GetChannelScheduleResponse({
    this.items,
    this.nextToken,
  });
  factory GetChannelScheduleResponse.fromJson(Map<String, dynamic> json) {
    return GetChannelScheduleResponse(
      items: (json['Items'] as List?)
          ?.whereNotNull()
          .map((e) => ScheduleEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class GetPlaybackConfigurationResponse {
  /// The URL for the ad decision server (ADS). This includes the specification of
  /// static parameters and placeholders for dynamic parameters. AWS Elemental
  /// MediaTailor substitutes player-specific and session-specific parameters as
  /// needed when calling the ADS. Alternately, for testing, you can provide a
  /// static VAST URL. The maximum length is 25,000 characters.
  final String? adDecisionServerUrl;

  /// The configuration for avail suppression, also known as ad suppression. For
  /// more information about ad suppression, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/ad-behavior.html">Ad
  /// Suppression</a>.
  final AvailSuppression? availSuppression;

  /// The configuration for bumpers. Bumpers are short audio or video clips that
  /// play at the start or before the end of an ad break. To learn more about
  /// bumpers, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/bumpers.html">Bumpers</a>.
  final Bumper? bumper;

  /// The configuration for using a content delivery network (CDN), like Amazon
  /// CloudFront, for content and ad segment management.
  final CdnConfiguration? cdnConfiguration;

  /// The player parameters and aliases used as dynamic variables during session
  /// initialization. For more information, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/variables-domain.html">Domain
  /// Variables</a>.
  final Map<String, Map<String, String>>? configurationAliases;

  /// The configuration for DASH content.
  final DashConfiguration? dashConfiguration;

  /// The configuration for HLS content.
  final HlsConfiguration? hlsConfiguration;

  /// The configuration for pre-roll ad insertion.
  final LivePreRollConfiguration? livePreRollConfiguration;

  /// The Amazon CloudWatch log settings for a playback configuration.
  final LogConfiguration? logConfiguration;

  /// The configuration for manifest processing rules. Manifest processing rules
  /// enable customization of the personalized manifests created by MediaTailor.
  final ManifestProcessingRules? manifestProcessingRules;

  /// The identifier for the playback configuration.
  final String? name;

  /// Defines the maximum duration of underfilled ad time (in seconds) allowed in
  /// an ad break. If the duration of underfilled ad time exceeds the
  /// personalization threshold, then the personalization of the ad break is
  /// abandoned and the underlying content is shown. This feature applies to <i>ad
  /// replacement</i> in live and VOD streams, rather than ad insertion, because
  /// it relies on an underlying content stream. For more information about ad
  /// break behavior, including ad replacement and insertion, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/ad-behavior.html">Ad
  /// Behavior in AWS Elemental MediaTailor</a>.
  final int? personalizationThresholdSeconds;

  /// The Amazon Resource Name (ARN) for the playback configuration.
  final String? playbackConfigurationArn;

  /// The URL that the player accesses to get a manifest from AWS Elemental
  /// MediaTailor. This session will use server-side reporting.
  final String? playbackEndpointPrefix;

  /// The URL that the player uses to initialize a session that uses client-side
  /// reporting.
  final String? sessionInitializationEndpointPrefix;

  /// The URL for a high-quality video asset to transcode and use to fill in time
  /// that's not used by ads. AWS Elemental MediaTailor shows the slate to fill in
  /// gaps in media content. Configuring the slate is optional for non-VPAID
  /// playback configurations. For VPAID, the slate is required because
  /// MediaTailor provides it in the slots designated for dynamic ad content. The
  /// slate must be a high-quality asset that contains both audio and video.
  final String? slateAdUrl;

  /// The tags assigned to the playback configuration.
  final Map<String, String>? tags;

  /// The name that is used to associate this playback configuration with a custom
  /// transcode profile. This overrides the dynamic transcoding defaults of
  /// MediaTailor. Use this only if you have already set up custom profiles with
  /// the help of AWS Support.
  final String? transcodeProfileName;

  /// The URL prefix for the parent manifest for the stream, minus the asset ID.
  /// The maximum length is 512 characters.
  final String? videoContentSourceUrl;

  GetPlaybackConfigurationResponse({
    this.adDecisionServerUrl,
    this.availSuppression,
    this.bumper,
    this.cdnConfiguration,
    this.configurationAliases,
    this.dashConfiguration,
    this.hlsConfiguration,
    this.livePreRollConfiguration,
    this.logConfiguration,
    this.manifestProcessingRules,
    this.name,
    this.personalizationThresholdSeconds,
    this.playbackConfigurationArn,
    this.playbackEndpointPrefix,
    this.sessionInitializationEndpointPrefix,
    this.slateAdUrl,
    this.tags,
    this.transcodeProfileName,
    this.videoContentSourceUrl,
  });
  factory GetPlaybackConfigurationResponse.fromJson(Map<String, dynamic> json) {
    return GetPlaybackConfigurationResponse(
      adDecisionServerUrl: json['AdDecisionServerUrl'] as String?,
      availSuppression: json['AvailSuppression'] != null
          ? AvailSuppression.fromJson(
              json['AvailSuppression'] as Map<String, dynamic>)
          : null,
      bumper: json['Bumper'] != null
          ? Bumper.fromJson(json['Bumper'] as Map<String, dynamic>)
          : null,
      cdnConfiguration: json['CdnConfiguration'] != null
          ? CdnConfiguration.fromJson(
              json['CdnConfiguration'] as Map<String, dynamic>)
          : null,
      configurationAliases:
          (json['ConfigurationAliases'] as Map<String, dynamic>?)?.map((k, e) =>
              MapEntry(
                  k,
                  (e as Map<String, dynamic>)
                      .map((k, e) => MapEntry(k, e as String)))),
      dashConfiguration: json['DashConfiguration'] != null
          ? DashConfiguration.fromJson(
              json['DashConfiguration'] as Map<String, dynamic>)
          : null,
      hlsConfiguration: json['HlsConfiguration'] != null
          ? HlsConfiguration.fromJson(
              json['HlsConfiguration'] as Map<String, dynamic>)
          : null,
      livePreRollConfiguration: json['LivePreRollConfiguration'] != null
          ? LivePreRollConfiguration.fromJson(
              json['LivePreRollConfiguration'] as Map<String, dynamic>)
          : null,
      logConfiguration: json['LogConfiguration'] != null
          ? LogConfiguration.fromJson(
              json['LogConfiguration'] as Map<String, dynamic>)
          : null,
      manifestProcessingRules: json['ManifestProcessingRules'] != null
          ? ManifestProcessingRules.fromJson(
              json['ManifestProcessingRules'] as Map<String, dynamic>)
          : null,
      name: json['Name'] as String?,
      personalizationThresholdSeconds:
          json['PersonalizationThresholdSeconds'] as int?,
      playbackConfigurationArn: json['PlaybackConfigurationArn'] as String?,
      playbackEndpointPrefix: json['PlaybackEndpointPrefix'] as String?,
      sessionInitializationEndpointPrefix:
          json['SessionInitializationEndpointPrefix'] as String?,
      slateAdUrl: json['SlateAdUrl'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      transcodeProfileName: json['TranscodeProfileName'] as String?,
      videoContentSourceUrl: json['VideoContentSourceUrl'] as String?,
    );
  }
}

class GetPrefetchScheduleResponse {
  /// The Amazon Resource Name (ARN) of the prefetch schedule.
  final String? arn;

  /// Consumption settings determine how, and when, MediaTailor places the
  /// prefetched ads into ad breaks. Ad consumption occurs within a span of time
  /// that you define, called a <i>consumption window</i>. You can designate which
  /// ad breaks that MediaTailor fills with prefetch ads by setting avail matching
  /// criteria.
  final PrefetchConsumption? consumption;

  /// The name of the prefetch schedule. The name must be unique among all
  /// prefetch schedules that are associated with the specified playback
  /// configuration.
  final String? name;

  /// The name of the playback configuration to create the prefetch schedule for.
  final String? playbackConfigurationName;

  /// A complex type that contains settings for prefetch retrieval from the ad
  /// decision server (ADS).
  final PrefetchRetrieval? retrieval;

  /// An optional stream identifier that you can specify in order to prefetch for
  /// multiple streams that use the same playback configuration.
  final String? streamId;

  GetPrefetchScheduleResponse({
    this.arn,
    this.consumption,
    this.name,
    this.playbackConfigurationName,
    this.retrieval,
    this.streamId,
  });
  factory GetPrefetchScheduleResponse.fromJson(Map<String, dynamic> json) {
    return GetPrefetchScheduleResponse(
      arn: json['Arn'] as String?,
      consumption: json['Consumption'] != null
          ? PrefetchConsumption.fromJson(
              json['Consumption'] as Map<String, dynamic>)
          : null,
      name: json['Name'] as String?,
      playbackConfigurationName: json['PlaybackConfigurationName'] as String?,
      retrieval: json['Retrieval'] != null
          ? PrefetchRetrieval.fromJson(
              json['Retrieval'] as Map<String, dynamic>)
          : null,
      streamId: json['StreamId'] as String?,
    );
  }
}

/// The configuration for HLS content.
class HlsConfiguration {
  /// The URL that is used to initiate a playback session for devices that support
  /// Apple HLS. The session uses server-side reporting.
  final String? manifestEndpointPrefix;

  HlsConfiguration({
    this.manifestEndpointPrefix,
  });
  factory HlsConfiguration.fromJson(Map<String, dynamic> json) {
    return HlsConfiguration(
      manifestEndpointPrefix: json['ManifestEndpointPrefix'] as String?,
    );
  }
}

/// HLS playlist configuration parameters.
class HlsPlaylistSettings {
  /// The total duration (in seconds) of each manifest. Minimum value: 30 seconds.
  /// Maximum value: 3600 seconds.
  final int? manifestWindowSeconds;

  HlsPlaylistSettings({
    this.manifestWindowSeconds,
  });
  factory HlsPlaylistSettings.fromJson(Map<String, dynamic> json) {
    return HlsPlaylistSettings(
      manifestWindowSeconds: json['ManifestWindowSeconds'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final manifestWindowSeconds = this.manifestWindowSeconds;
    return {
      if (manifestWindowSeconds != null)
        'ManifestWindowSeconds': manifestWindowSeconds,
    };
  }
}

/// The HTTP configuration for the source location.
class HttpConfiguration {
  /// The base URL for the source location host server. This string must include
  /// the protocol, such as <b>https://</b>.
  final String baseUrl;

  HttpConfiguration({
    required this.baseUrl,
  });
  factory HttpConfiguration.fromJson(Map<String, dynamic> json) {
    return HttpConfiguration(
      baseUrl: json['BaseUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final baseUrl = this.baseUrl;
    return {
      'BaseUrl': baseUrl,
    };
  }
}

/// The HTTP package configuration properties for the requested VOD source.
class HttpPackageConfiguration {
  /// The relative path to the URL for this VOD source. This is combined with
  /// SourceLocation::HttpConfiguration::BaseUrl to form a valid URL.
  final String path;

  /// The name of the source group. This has to match one of the
  /// Channel::Outputs::SourceGroup.
  final String sourceGroup;

  /// The streaming protocol for this package configuration. Supported values are
  /// HLS and DASH.
  final Type type;

  HttpPackageConfiguration({
    required this.path,
    required this.sourceGroup,
    required this.type,
  });
  factory HttpPackageConfiguration.fromJson(Map<String, dynamic> json) {
    return HttpPackageConfiguration(
      path: json['Path'] as String,
      sourceGroup: json['SourceGroup'] as String,
      type: (json['Type'] as String).toType(),
    );
  }

  Map<String, dynamic> toJson() {
    final path = this.path;
    final sourceGroup = this.sourceGroup;
    final type = this.type;
    return {
      'Path': path,
      'SourceGroup': sourceGroup,
      'Type': type.toValue(),
    };
  }
}

class ListAlertsResponse {
  /// A list of alerts that are associated with this resource.
  final List<Alert>? items;

  /// Pagination token from the list request. Use the token to fetch the next page
  /// of results.
  final String? nextToken;

  ListAlertsResponse({
    this.items,
    this.nextToken,
  });
  factory ListAlertsResponse.fromJson(Map<String, dynamic> json) {
    return ListAlertsResponse(
      items: (json['Items'] as List?)
          ?.whereNotNull()
          .map((e) => Alert.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListChannelsResponse {
  /// A list of channels that are associated with this account.
  final List<Channel>? items;

  /// Pagination token returned by the list request when results exceed the
  /// maximum allowed. Use the token to fetch the next page of results.
  final String? nextToken;

  ListChannelsResponse({
    this.items,
    this.nextToken,
  });
  factory ListChannelsResponse.fromJson(Map<String, dynamic> json) {
    return ListChannelsResponse(
      items: (json['Items'] as List?)
          ?.whereNotNull()
          .map((e) => Channel.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListLiveSourcesResponse {
  /// Lists the live sources.
  final List<LiveSource>? items;

  /// Pagination token from the list request. Use the token to fetch the next page
  /// of results.
  final String? nextToken;

  ListLiveSourcesResponse({
    this.items,
    this.nextToken,
  });
  factory ListLiveSourcesResponse.fromJson(Map<String, dynamic> json) {
    return ListLiveSourcesResponse(
      items: (json['Items'] as List?)
          ?.whereNotNull()
          .map((e) => LiveSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListPlaybackConfigurationsResponse {
  /// Array of playback configurations. This might be all the available
  /// configurations or a subset, depending on the settings that you provide and
  /// the total number of configurations stored.
  final List<PlaybackConfiguration>? items;

  /// Pagination token returned by the GET list request when results exceed the
  /// maximum allowed. Use the token to fetch the next page of results.
  final String? nextToken;

  ListPlaybackConfigurationsResponse({
    this.items,
    this.nextToken,
  });
  factory ListPlaybackConfigurationsResponse.fromJson(
      Map<String, dynamic> json) {
    return ListPlaybackConfigurationsResponse(
      items: (json['Items'] as List?)
          ?.whereNotNull()
          .map((e) => PlaybackConfiguration.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListPrefetchSchedulesResponse {
  /// Lists the prefetch schedules. An empty Items list doesn't mean there aren't
  /// more items to fetch, just that that page was empty.
  final List<PrefetchSchedule>? items;

  /// The value that you will use forNextToken in the next
  /// ListPrefetchSchedulesRequest request.
  final String? nextToken;

  ListPrefetchSchedulesResponse({
    this.items,
    this.nextToken,
  });
  factory ListPrefetchSchedulesResponse.fromJson(Map<String, dynamic> json) {
    return ListPrefetchSchedulesResponse(
      items: (json['Items'] as List?)
          ?.whereNotNull()
          .map((e) => PrefetchSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListSourceLocationsResponse {
  /// A list of source locations.
  final List<SourceLocation>? items;

  /// Pagination token from the list request. Use the token to fetch the next page
  /// of results.
  final String? nextToken;

  ListSourceLocationsResponse({
    this.items,
    this.nextToken,
  });
  factory ListSourceLocationsResponse.fromJson(Map<String, dynamic> json) {
    return ListSourceLocationsResponse(
      items: (json['Items'] as List?)
          ?.whereNotNull()
          .map((e) => SourceLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListTagsForResourceResponse {
  /// A comma-separated list of tag key:value pairs.
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

class ListVodSourcesResponse {
  /// Lists the VOD sources.
  final List<VodSource>? items;

  /// Pagination token from the list request. Use the token to fetch the next page
  /// of results.
  final String? nextToken;

  ListVodSourcesResponse({
    this.items,
    this.nextToken,
  });
  factory ListVodSourcesResponse.fromJson(Map<String, dynamic> json) {
    return ListVodSourcesResponse(
      items: (json['Items'] as List?)
          ?.whereNotNull()
          .map((e) => VodSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

/// The configuration for pre-roll ad insertion.
class LivePreRollConfiguration {
  /// The URL for the ad decision server (ADS) for pre-roll ads. This includes the
  /// specification of static parameters and placeholders for dynamic parameters.
  /// AWS Elemental MediaTailor substitutes player-specific and session-specific
  /// parameters as needed when calling the ADS. Alternately, for testing, you can
  /// provide a static VAST URL. The maximum length is 25,000 characters.
  final String? adDecisionServerUrl;

  /// The maximum allowed duration for the pre-roll ad avail. AWS Elemental
  /// MediaTailor won't play pre-roll ads to exceed this duration, regardless of
  /// the total duration of ads that the ADS returns.
  final int? maxDurationSeconds;

  LivePreRollConfiguration({
    this.adDecisionServerUrl,
    this.maxDurationSeconds,
  });
  factory LivePreRollConfiguration.fromJson(Map<String, dynamic> json) {
    return LivePreRollConfiguration(
      adDecisionServerUrl: json['AdDecisionServerUrl'] as String?,
      maxDurationSeconds: json['MaxDurationSeconds'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final adDecisionServerUrl = this.adDecisionServerUrl;
    final maxDurationSeconds = this.maxDurationSeconds;
    return {
      if (adDecisionServerUrl != null)
        'AdDecisionServerUrl': adDecisionServerUrl,
      if (maxDurationSeconds != null) 'MaxDurationSeconds': maxDurationSeconds,
    };
  }
}

/// Live source configuration parameters.
class LiveSource {
  /// The ARN for the live source.
  final String arn;

  /// The HTTP package configurations for the live source.
  final List<HttpPackageConfiguration> httpPackageConfigurations;

  /// The name that's used to refer to a live source.
  final String liveSourceName;

  /// The name of the source location.
  final String sourceLocationName;

  /// The timestamp that indicates when the live source was created.
  final DateTime? creationTime;

  /// The timestamp that indicates when the live source was last modified.
  final DateTime? lastModifiedTime;

  /// The tags assigned to the live source.
  final Map<String, String>? tags;

  LiveSource({
    required this.arn,
    required this.httpPackageConfigurations,
    required this.liveSourceName,
    required this.sourceLocationName,
    this.creationTime,
    this.lastModifiedTime,
    this.tags,
  });
  factory LiveSource.fromJson(Map<String, dynamic> json) {
    return LiveSource(
      arn: json['Arn'] as String,
      httpPackageConfigurations: (json['HttpPackageConfigurations'] as List)
          .whereNotNull()
          .map((e) =>
              HttpPackageConfiguration.fromJson(e as Map<String, dynamic>))
          .toList(),
      liveSourceName: json['LiveSourceName'] as String,
      sourceLocationName: json['SourceLocationName'] as String,
      creationTime: timeStampFromJson(json['CreationTime']),
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

/// Returns Amazon CloudWatch log settings for a playback configuration.
class LogConfiguration {
  /// The percentage of session logs that MediaTailor sends to your Cloudwatch
  /// Logs account. For example, if your playback configuration has 1000 sessions
  /// and percentEnabled is set to 60, MediaTailor sends logs for 600 of the
  /// sessions to CloudWatch Logs. MediaTailor decides at random which of the
  /// playback configuration sessions to send logs for. If you want to view logs
  /// for a specific session, you can use the <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/debug-log-mode.html">debug
  /// log mode</a>.
  ///
  /// Valid values: 0 - 100
  final int percentEnabled;

  LogConfiguration({
    required this.percentEnabled,
  });
  factory LogConfiguration.fromJson(Map<String, dynamic> json) {
    return LogConfiguration(
      percentEnabled: json['PercentEnabled'] as int,
    );
  }
}

/// The configuration for manifest processing rules. Manifest processing rules
/// enable customization of the personalized manifests created by MediaTailor.
class ManifestProcessingRules {
  /// For HLS, when set to true, MediaTailor passes through EXT-X-CUE-IN,
  /// EXT-X-CUE-OUT, and EXT-X-SPLICEPOINT-SCTE35 ad markers from the origin
  /// manifest to the MediaTailor personalized manifest.
  ///
  /// No logic is applied to these ad markers. For example, if EXT-X-CUE-OUT has a
  /// value of 60, but no ads are filled for that ad break, MediaTailor will not
  /// set the value to 0.
  final AdMarkerPassthrough? adMarkerPassthrough;

  ManifestProcessingRules({
    this.adMarkerPassthrough,
  });
  factory ManifestProcessingRules.fromJson(Map<String, dynamic> json) {
    return ManifestProcessingRules(
      adMarkerPassthrough: json['AdMarkerPassthrough'] != null
          ? AdMarkerPassthrough.fromJson(
              json['AdMarkerPassthrough'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final adMarkerPassthrough = this.adMarkerPassthrough;
    return {
      if (adMarkerPassthrough != null)
        'AdMarkerPassthrough': adMarkerPassthrough,
    };
  }
}

enum MessageType {
  spliceInsert,
}

extension on MessageType {
  String toValue() {
    switch (this) {
      case MessageType.spliceInsert:
        return 'SPLICE_INSERT';
    }
  }
}

extension on String {
  MessageType toMessageType() {
    switch (this) {
      case 'SPLICE_INSERT':
        return MessageType.spliceInsert;
    }
    throw Exception('$this is not known in enum MessageType');
  }
}

enum Mode {
  off,
  behindLiveEdge,
}

extension on Mode {
  String toValue() {
    switch (this) {
      case Mode.off:
        return 'OFF';
      case Mode.behindLiveEdge:
        return 'BEHIND_LIVE_EDGE';
    }
  }
}

extension on String {
  Mode toMode() {
    switch (this) {
      case 'OFF':
        return Mode.off;
      case 'BEHIND_LIVE_EDGE':
        return Mode.behindLiveEdge;
    }
    throw Exception('$this is not known in enum Mode');
  }
}

enum Operator {
  equals,
}

extension on Operator {
  String toValue() {
    switch (this) {
      case Operator.equals:
        return 'EQUALS';
    }
  }
}

extension on String {
  Operator toOperator() {
    switch (this) {
      case 'EQUALS':
        return Operator.equals;
    }
    throw Exception('$this is not known in enum Operator');
  }
}

enum OriginManifestType {
  singlePeriod,
  multiPeriod,
}

extension on OriginManifestType {
  String toValue() {
    switch (this) {
      case OriginManifestType.singlePeriod:
        return 'SINGLE_PERIOD';
      case OriginManifestType.multiPeriod:
        return 'MULTI_PERIOD';
    }
  }
}

extension on String {
  OriginManifestType toOriginManifestType() {
    switch (this) {
      case 'SINGLE_PERIOD':
        return OriginManifestType.singlePeriod;
      case 'MULTI_PERIOD':
        return OriginManifestType.multiPeriod;
    }
    throw Exception('$this is not known in enum OriginManifestType');
  }
}

/// Creates a playback configuration. For information about MediaTailor
/// configurations, see <a
/// href="https://docs.aws.amazon.com/mediatailor/latest/ug/configurations.html">Working
/// with configurations in AWS Elemental MediaTailor</a>.
class PlaybackConfiguration {
  /// The URL for the ad decision server (ADS). This includes the specification of
  /// static parameters and placeholders for dynamic parameters. AWS Elemental
  /// MediaTailor substitutes player-specific and session-specific parameters as
  /// needed when calling the ADS. Alternately, for testing you can provide a
  /// static VAST URL. The maximum length is 25,000 characters.
  final String? adDecisionServerUrl;

  /// The configuration for avail suppression, also known as ad suppression. For
  /// more information about ad suppression, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/ad-behavior.html">Ad
  /// Suppression</a>.
  final AvailSuppression? availSuppression;

  /// The configuration for bumpers. Bumpers are short audio or video clips that
  /// play at the start or before the end of an ad break. To learn more about
  /// bumpers, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/bumpers.html">Bumpers</a>.
  final Bumper? bumper;

  /// The configuration for using a content delivery network (CDN), like Amazon
  /// CloudFront, for content and ad segment management.
  final CdnConfiguration? cdnConfiguration;

  /// The player parameters and aliases used as dynamic variables during session
  /// initialization. For more information, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/variables-domain.html">Domain
  /// Variables</a>.
  final Map<String, Map<String, String>>? configurationAliases;

  /// The configuration for a DASH source.
  final DashConfiguration? dashConfiguration;

  /// The configuration for HLS content.
  final HlsConfiguration? hlsConfiguration;

  /// The configuration for pre-roll ad insertion.
  final LivePreRollConfiguration? livePreRollConfiguration;

  /// The Amazon CloudWatch log settings for a playback configuration.
  final LogConfiguration? logConfiguration;

  /// The configuration for manifest processing rules. Manifest processing rules
  /// enable customization of the personalized manifests created by MediaTailor.
  final ManifestProcessingRules? manifestProcessingRules;

  /// The identifier for the playback configuration.
  final String? name;

  /// Defines the maximum duration of underfilled ad time (in seconds) allowed in
  /// an ad break. If the duration of underfilled ad time exceeds the
  /// personalization threshold, then the personalization of the ad break is
  /// abandoned and the underlying content is shown. This feature applies to <i>ad
  /// replacement</i> in live and VOD streams, rather than ad insertion, because
  /// it relies on an underlying content stream. For more information about ad
  /// break behavior, including ad replacement and insertion, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/ad-behavior.html">Ad
  /// Behavior in AWS Elemental MediaTailor</a>.
  final int? personalizationThresholdSeconds;

  /// The Amazon Resource Name (ARN) for the playback configuration.
  final String? playbackConfigurationArn;

  /// The URL that the player accesses to get a manifest from AWS Elemental
  /// MediaTailor.
  final String? playbackEndpointPrefix;

  /// The URL that the player uses to initialize a session that uses client-side
  /// reporting.
  final String? sessionInitializationEndpointPrefix;

  /// The URL for a video asset to transcode and use to fill in time that's not
  /// used by ads. AWS Elemental MediaTailor shows the slate to fill in gaps in
  /// media content. Configuring the slate is optional for non-VPAID playback
  /// configurations. For VPAID, the slate is required because MediaTailor
  /// provides it in the slots designated for dynamic ad content. The slate must
  /// be a high-quality asset that contains both audio and video.
  final String? slateAdUrl;

  /// The tags to assign to the playback configuration.
  final Map<String, String>? tags;

  /// The name that is used to associate this playback configuration with a custom
  /// transcode profile. This overrides the dynamic transcoding defaults of
  /// MediaTailor. Use this only if you have already set up custom profiles with
  /// the help of AWS Support.
  final String? transcodeProfileName;

  /// The URL prefix for the parent manifest for the stream, minus the asset ID.
  /// The maximum length is 512 characters.
  final String? videoContentSourceUrl;

  PlaybackConfiguration({
    this.adDecisionServerUrl,
    this.availSuppression,
    this.bumper,
    this.cdnConfiguration,
    this.configurationAliases,
    this.dashConfiguration,
    this.hlsConfiguration,
    this.livePreRollConfiguration,
    this.logConfiguration,
    this.manifestProcessingRules,
    this.name,
    this.personalizationThresholdSeconds,
    this.playbackConfigurationArn,
    this.playbackEndpointPrefix,
    this.sessionInitializationEndpointPrefix,
    this.slateAdUrl,
    this.tags,
    this.transcodeProfileName,
    this.videoContentSourceUrl,
  });
  factory PlaybackConfiguration.fromJson(Map<String, dynamic> json) {
    return PlaybackConfiguration(
      adDecisionServerUrl: json['AdDecisionServerUrl'] as String?,
      availSuppression: json['AvailSuppression'] != null
          ? AvailSuppression.fromJson(
              json['AvailSuppression'] as Map<String, dynamic>)
          : null,
      bumper: json['Bumper'] != null
          ? Bumper.fromJson(json['Bumper'] as Map<String, dynamic>)
          : null,
      cdnConfiguration: json['CdnConfiguration'] != null
          ? CdnConfiguration.fromJson(
              json['CdnConfiguration'] as Map<String, dynamic>)
          : null,
      configurationAliases:
          (json['ConfigurationAliases'] as Map<String, dynamic>?)?.map((k, e) =>
              MapEntry(
                  k,
                  (e as Map<String, dynamic>)
                      .map((k, e) => MapEntry(k, e as String)))),
      dashConfiguration: json['DashConfiguration'] != null
          ? DashConfiguration.fromJson(
              json['DashConfiguration'] as Map<String, dynamic>)
          : null,
      hlsConfiguration: json['HlsConfiguration'] != null
          ? HlsConfiguration.fromJson(
              json['HlsConfiguration'] as Map<String, dynamic>)
          : null,
      livePreRollConfiguration: json['LivePreRollConfiguration'] != null
          ? LivePreRollConfiguration.fromJson(
              json['LivePreRollConfiguration'] as Map<String, dynamic>)
          : null,
      logConfiguration: json['LogConfiguration'] != null
          ? LogConfiguration.fromJson(
              json['LogConfiguration'] as Map<String, dynamic>)
          : null,
      manifestProcessingRules: json['ManifestProcessingRules'] != null
          ? ManifestProcessingRules.fromJson(
              json['ManifestProcessingRules'] as Map<String, dynamic>)
          : null,
      name: json['Name'] as String?,
      personalizationThresholdSeconds:
          json['PersonalizationThresholdSeconds'] as int?,
      playbackConfigurationArn: json['PlaybackConfigurationArn'] as String?,
      playbackEndpointPrefix: json['PlaybackEndpointPrefix'] as String?,
      sessionInitializationEndpointPrefix:
          json['SessionInitializationEndpointPrefix'] as String?,
      slateAdUrl: json['SlateAdUrl'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      transcodeProfileName: json['TranscodeProfileName'] as String?,
      videoContentSourceUrl: json['VideoContentSourceUrl'] as String?,
    );
  }
}

enum PlaybackMode {
  loop,
  linear,
}

extension on PlaybackMode {
  String toValue() {
    switch (this) {
      case PlaybackMode.loop:
        return 'LOOP';
      case PlaybackMode.linear:
        return 'LINEAR';
    }
  }
}

extension on String {
  PlaybackMode toPlaybackMode() {
    switch (this) {
      case 'LOOP':
        return PlaybackMode.loop;
      case 'LINEAR':
        return PlaybackMode.linear;
    }
    throw Exception('$this is not known in enum PlaybackMode');
  }
}

/// A complex type that contains settings that determine how and when that
/// MediaTailor places prefetched ads into upcoming ad breaks.
class PrefetchConsumption {
  /// The time when MediaTailor no longer considers the prefetched ads for use in
  /// an ad break. MediaTailor automatically deletes prefetch schedules no less
  /// than seven days after the end time. If you'd like to manually delete the
  /// prefetch schedule, you can call DeletePrefetchSchedule.
  final DateTime endTime;

  /// If you only want MediaTailor to insert prefetched ads into avails (ad
  /// breaks) that match specific dynamic variables, such as scte.event_id, set
  /// the avail matching criteria.
  final List<AvailMatchingCriteria>? availMatchingCriteria;

  /// The time when prefetched ads are considered for use in an ad break. If you
  /// don't specify StartTime, the prefetched ads are available after MediaTailor
  /// retrives them from the ad decision server.
  final DateTime? startTime;

  PrefetchConsumption({
    required this.endTime,
    this.availMatchingCriteria,
    this.startTime,
  });
  factory PrefetchConsumption.fromJson(Map<String, dynamic> json) {
    return PrefetchConsumption(
      endTime: nonNullableTimeStampFromJson(json['EndTime'] as Object),
      availMatchingCriteria: (json['AvailMatchingCriteria'] as List?)
          ?.whereNotNull()
          .map((e) => AvailMatchingCriteria.fromJson(e as Map<String, dynamic>))
          .toList(),
      startTime: timeStampFromJson(json['StartTime']),
    );
  }

  Map<String, dynamic> toJson() {
    final endTime = this.endTime;
    final availMatchingCriteria = this.availMatchingCriteria;
    final startTime = this.startTime;
    return {
      'EndTime': unixTimestampToJson(endTime),
      if (availMatchingCriteria != null)
        'AvailMatchingCriteria': availMatchingCriteria,
      if (startTime != null) 'StartTime': unixTimestampToJson(startTime),
    };
  }
}

/// A complex type that contains settings governing when MediaTailor prefetches
/// ads, and which dynamic variables that MediaTailor includes in the request to
/// the ad decision server.
class PrefetchRetrieval {
  /// The time when prefetch retrieval ends for the ad break. Prefetching will be
  /// attempted for manifest requests that occur at or before this time.
  final DateTime endTime;

  /// The dynamic variables to use for substitution during prefetch requests to
  /// the ad decision server (ADS).
  ///
  /// You intially configure <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/variables.html">dynamic
  /// variables</a> for the ADS URL when you set up your playback configuration.
  /// When you specify DynamicVariables for prefetch retrieval, MediaTailor
  /// includes the dynamic variables in the request to the ADS.
  final Map<String, String>? dynamicVariables;

  /// The time when prefetch retrievals can start for this break. Ad prefetching
  /// will be attempted for manifest requests that occur at or after this time.
  /// Defaults to the current time. If not specified, the prefetch retrieval
  /// starts as soon as possible.
  final DateTime? startTime;

  PrefetchRetrieval({
    required this.endTime,
    this.dynamicVariables,
    this.startTime,
  });
  factory PrefetchRetrieval.fromJson(Map<String, dynamic> json) {
    return PrefetchRetrieval(
      endTime: nonNullableTimeStampFromJson(json['EndTime'] as Object),
      dynamicVariables: (json['DynamicVariables'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      startTime: timeStampFromJson(json['StartTime']),
    );
  }

  Map<String, dynamic> toJson() {
    final endTime = this.endTime;
    final dynamicVariables = this.dynamicVariables;
    final startTime = this.startTime;
    return {
      'EndTime': unixTimestampToJson(endTime),
      if (dynamicVariables != null) 'DynamicVariables': dynamicVariables,
      if (startTime != null) 'StartTime': unixTimestampToJson(startTime),
    };
  }
}

/// A complex type that contains prefetch schedule information.
class PrefetchSchedule {
  /// The Amazon Resource Name (ARN) of the prefetch schedule.
  final String arn;

  /// Consumption settings determine how, and when, MediaTailor places the
  /// prefetched ads into ad breaks. Ad consumption occurs within a span of time
  /// that you define, called a <i>consumption window</i>. You can designate which
  /// ad breaks that MediaTailor fills with prefetch ads by setting avail matching
  /// criteria.
  final PrefetchConsumption consumption;

  /// The name of the prefetch schedule. The name must be unique among all
  /// prefetch schedules that are associated with the specified playback
  /// configuration.
  final String name;

  /// The name of the playback configuration to create the prefetch schedule for.
  final String playbackConfigurationName;

  /// A complex type that contains settings for prefetch retrieval from the ad
  /// decision server (ADS).
  final PrefetchRetrieval retrieval;

  /// An optional stream identifier that you can specify in order to prefetch for
  /// multiple streams that use the same playback configuration.
  final String? streamId;

  PrefetchSchedule({
    required this.arn,
    required this.consumption,
    required this.name,
    required this.playbackConfigurationName,
    required this.retrieval,
    this.streamId,
  });
  factory PrefetchSchedule.fromJson(Map<String, dynamic> json) {
    return PrefetchSchedule(
      arn: json['Arn'] as String,
      consumption: PrefetchConsumption.fromJson(
          json['Consumption'] as Map<String, dynamic>),
      name: json['Name'] as String,
      playbackConfigurationName: json['PlaybackConfigurationName'] as String,
      retrieval:
          PrefetchRetrieval.fromJson(json['Retrieval'] as Map<String, dynamic>),
      streamId: json['StreamId'] as String?,
    );
  }
}

class PutChannelPolicyResponse {
  PutChannelPolicyResponse();
  factory PutChannelPolicyResponse.fromJson(Map<String, dynamic> _) {
    return PutChannelPolicyResponse();
  }
}

class PutPlaybackConfigurationResponse {
  /// The URL for the ad decision server (ADS). This includes the specification of
  /// static parameters and placeholders for dynamic parameters. AWS Elemental
  /// MediaTailor substitutes player-specific and session-specific parameters as
  /// needed when calling the ADS. Alternately, for testing, you can provide a
  /// static VAST URL. The maximum length is 25,000 characters.
  final String? adDecisionServerUrl;

  /// The configuration for avail suppression, also known as ad suppression. For
  /// more information about ad suppression, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/ad-behavior.html">Ad
  /// Suppression</a>.
  final AvailSuppression? availSuppression;

  /// The configuration for bumpers. Bumpers are short audio or video clips that
  /// play at the start or before the end of an ad break. To learn more about
  /// bumpers, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/bumpers.html">Bumpers</a>.
  final Bumper? bumper;

  /// The configuration for using a content delivery network (CDN), like Amazon
  /// CloudFront, for content and ad segment management.
  final CdnConfiguration? cdnConfiguration;

  /// The player parameters and aliases used as dynamic variables during session
  /// initialization. For more information, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/variables-domain.html">Domain
  /// Variables</a>.
  final Map<String, Map<String, String>>? configurationAliases;

  /// The configuration for DASH content.
  final DashConfiguration? dashConfiguration;

  /// The configuration for HLS content.
  final HlsConfiguration? hlsConfiguration;

  /// The configuration for pre-roll ad insertion.
  final LivePreRollConfiguration? livePreRollConfiguration;

  /// The Amazon CloudWatch log settings for a playback configuration.
  final LogConfiguration? logConfiguration;

  /// The configuration for manifest processing rules. Manifest processing rules
  /// enable customization of the personalized manifests created by MediaTailor.
  final ManifestProcessingRules? manifestProcessingRules;

  /// The identifier for the playback configuration.
  final String? name;

  /// Defines the maximum duration of underfilled ad time (in seconds) allowed in
  /// an ad break. If the duration of underfilled ad time exceeds the
  /// personalization threshold, then the personalization of the ad break is
  /// abandoned and the underlying content is shown. This feature applies to <i>ad
  /// replacement</i> in live and VOD streams, rather than ad insertion, because
  /// it relies on an underlying content stream. For more information about ad
  /// break behavior, including ad replacement and insertion, see <a
  /// href="https://docs.aws.amazon.com/mediatailor/latest/ug/ad-behavior.html">Ad
  /// Behavior in AWS Elemental MediaTailor</a>.
  final int? personalizationThresholdSeconds;

  /// The Amazon Resource Name (ARN) for the playback configuration.
  final String? playbackConfigurationArn;

  /// The URL that the player accesses to get a manifest from AWS Elemental
  /// MediaTailor. This session will use server-side reporting.
  final String? playbackEndpointPrefix;

  /// The URL that the player uses to initialize a session that uses client-side
  /// reporting.
  final String? sessionInitializationEndpointPrefix;

  /// The URL for a high-quality video asset to transcode and use to fill in time
  /// that's not used by ads. AWS Elemental MediaTailor shows the slate to fill in
  /// gaps in media content. Configuring the slate is optional for non-VPAID
  /// playback configurations. For VPAID, the slate is required because
  /// MediaTailor provides it in the slots designated for dynamic ad content. The
  /// slate must be a high-quality asset that contains both audio and video.
  final String? slateAdUrl;

  /// The tags assigned to the playback configuration.
  final Map<String, String>? tags;

  /// The name that is used to associate this playback configuration with a custom
  /// transcode profile. This overrides the dynamic transcoding defaults of
  /// MediaTailor. Use this only if you have already set up custom profiles with
  /// the help of AWS Support.
  final String? transcodeProfileName;

  /// The URL prefix for the parent manifest for the stream, minus the asset ID.
  /// The maximum length is 512 characters.
  final String? videoContentSourceUrl;

  PutPlaybackConfigurationResponse({
    this.adDecisionServerUrl,
    this.availSuppression,
    this.bumper,
    this.cdnConfiguration,
    this.configurationAliases,
    this.dashConfiguration,
    this.hlsConfiguration,
    this.livePreRollConfiguration,
    this.logConfiguration,
    this.manifestProcessingRules,
    this.name,
    this.personalizationThresholdSeconds,
    this.playbackConfigurationArn,
    this.playbackEndpointPrefix,
    this.sessionInitializationEndpointPrefix,
    this.slateAdUrl,
    this.tags,
    this.transcodeProfileName,
    this.videoContentSourceUrl,
  });
  factory PutPlaybackConfigurationResponse.fromJson(Map<String, dynamic> json) {
    return PutPlaybackConfigurationResponse(
      adDecisionServerUrl: json['AdDecisionServerUrl'] as String?,
      availSuppression: json['AvailSuppression'] != null
          ? AvailSuppression.fromJson(
              json['AvailSuppression'] as Map<String, dynamic>)
          : null,
      bumper: json['Bumper'] != null
          ? Bumper.fromJson(json['Bumper'] as Map<String, dynamic>)
          : null,
      cdnConfiguration: json['CdnConfiguration'] != null
          ? CdnConfiguration.fromJson(
              json['CdnConfiguration'] as Map<String, dynamic>)
          : null,
      configurationAliases:
          (json['ConfigurationAliases'] as Map<String, dynamic>?)?.map((k, e) =>
              MapEntry(
                  k,
                  (e as Map<String, dynamic>)
                      .map((k, e) => MapEntry(k, e as String)))),
      dashConfiguration: json['DashConfiguration'] != null
          ? DashConfiguration.fromJson(
              json['DashConfiguration'] as Map<String, dynamic>)
          : null,
      hlsConfiguration: json['HlsConfiguration'] != null
          ? HlsConfiguration.fromJson(
              json['HlsConfiguration'] as Map<String, dynamic>)
          : null,
      livePreRollConfiguration: json['LivePreRollConfiguration'] != null
          ? LivePreRollConfiguration.fromJson(
              json['LivePreRollConfiguration'] as Map<String, dynamic>)
          : null,
      logConfiguration: json['LogConfiguration'] != null
          ? LogConfiguration.fromJson(
              json['LogConfiguration'] as Map<String, dynamic>)
          : null,
      manifestProcessingRules: json['ManifestProcessingRules'] != null
          ? ManifestProcessingRules.fromJson(
              json['ManifestProcessingRules'] as Map<String, dynamic>)
          : null,
      name: json['Name'] as String?,
      personalizationThresholdSeconds:
          json['PersonalizationThresholdSeconds'] as int?,
      playbackConfigurationArn: json['PlaybackConfigurationArn'] as String?,
      playbackEndpointPrefix: json['PlaybackEndpointPrefix'] as String?,
      sessionInitializationEndpointPrefix:
          json['SessionInitializationEndpointPrefix'] as String?,
      slateAdUrl: json['SlateAdUrl'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      transcodeProfileName: json['TranscodeProfileName'] as String?,
      videoContentSourceUrl: json['VideoContentSourceUrl'] as String?,
    );
  }
}

enum RelativePosition {
  beforeProgram,
  afterProgram,
}

extension on RelativePosition {
  String toValue() {
    switch (this) {
      case RelativePosition.beforeProgram:
        return 'BEFORE_PROGRAM';
      case RelativePosition.afterProgram:
        return 'AFTER_PROGRAM';
    }
  }
}

extension on String {
  RelativePosition toRelativePosition() {
    switch (this) {
      case 'BEFORE_PROGRAM':
        return RelativePosition.beforeProgram;
      case 'AFTER_PROGRAM':
        return RelativePosition.afterProgram;
    }
    throw Exception('$this is not known in enum RelativePosition');
  }
}

/// The output configuration for this channel.
class RequestOutputItem {
  /// The name of the manifest for the channel. The name appears in the
  /// PlaybackUrl.
  final String manifestName;

  /// A string used to match which HttpPackageConfiguration is used for each
  /// VodSource.
  final String sourceGroup;

  /// DASH manifest configuration parameters.
  final DashPlaylistSettings? dashPlaylistSettings;

  /// HLS playlist configuration parameters.
  final HlsPlaylistSettings? hlsPlaylistSettings;

  RequestOutputItem({
    required this.manifestName,
    required this.sourceGroup,
    this.dashPlaylistSettings,
    this.hlsPlaylistSettings,
  });
  Map<String, dynamic> toJson() {
    final manifestName = this.manifestName;
    final sourceGroup = this.sourceGroup;
    final dashPlaylistSettings = this.dashPlaylistSettings;
    final hlsPlaylistSettings = this.hlsPlaylistSettings;
    return {
      'ManifestName': manifestName,
      'SourceGroup': sourceGroup,
      if (dashPlaylistSettings != null)
        'DashPlaylistSettings': dashPlaylistSettings,
      if (hlsPlaylistSettings != null)
        'HlsPlaylistSettings': hlsPlaylistSettings,
    };
  }
}

/// This response includes only the "property" : "type" property.
class ResponseOutputItem {
  /// The name of the manifest for the channel that will appear in the channel
  /// output's playback URL.
  final String manifestName;

  /// The URL used for playback by content players.
  final String playbackUrl;

  /// A string used to associate a package configuration source group with a
  /// channel output.
  final String sourceGroup;

  /// DASH manifest configuration settings.
  final DashPlaylistSettings? dashPlaylistSettings;

  /// HLS manifest configuration settings.
  final HlsPlaylistSettings? hlsPlaylistSettings;

  ResponseOutputItem({
    required this.manifestName,
    required this.playbackUrl,
    required this.sourceGroup,
    this.dashPlaylistSettings,
    this.hlsPlaylistSettings,
  });
  factory ResponseOutputItem.fromJson(Map<String, dynamic> json) {
    return ResponseOutputItem(
      manifestName: json['ManifestName'] as String,
      playbackUrl: json['PlaybackUrl'] as String,
      sourceGroup: json['SourceGroup'] as String,
      dashPlaylistSettings: json['DashPlaylistSettings'] != null
          ? DashPlaylistSettings.fromJson(
              json['DashPlaylistSettings'] as Map<String, dynamic>)
          : null,
      hlsPlaylistSettings: json['HlsPlaylistSettings'] != null
          ? HlsPlaylistSettings.fromJson(
              json['HlsPlaylistSettings'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// The schedule's ad break properties.
class ScheduleAdBreak {
  /// The approximate duration of the ad break, in seconds.
  final int? approximateDurationSeconds;

  /// The approximate time that the ad will start playing.
  final DateTime? approximateStartTime;

  /// The name of the source location containing the VOD source used for the ad
  /// break.
  final String? sourceLocationName;

  /// The name of the VOD source used for the ad break.
  final String? vodSourceName;

  ScheduleAdBreak({
    this.approximateDurationSeconds,
    this.approximateStartTime,
    this.sourceLocationName,
    this.vodSourceName,
  });
  factory ScheduleAdBreak.fromJson(Map<String, dynamic> json) {
    return ScheduleAdBreak(
      approximateDurationSeconds: json['ApproximateDurationSeconds'] as int?,
      approximateStartTime: timeStampFromJson(json['ApproximateStartTime']),
      sourceLocationName: json['SourceLocationName'] as String?,
      vodSourceName: json['VodSourceName'] as String?,
    );
  }
}

/// Schedule configuration parameters. A channel must be stopped before changes
/// can be made to the schedule.
class ScheduleConfiguration {
  /// Program transition configurations.
  final Transition transition;

  ScheduleConfiguration({
    required this.transition,
  });
  Map<String, dynamic> toJson() {
    final transition = this.transition;
    return {
      'Transition': transition,
    };
  }
}

/// The properties for a schedule.
class ScheduleEntry {
  /// The ARN of the program.
  final String arn;

  /// The name of the channel that uses this schedule.
  final String channelName;

  /// The name of the program.
  final String programName;

  /// The name of the source location.
  final String sourceLocationName;

  /// The approximate duration of this program, in seconds.
  final int? approximateDurationSeconds;

  /// The approximate time that the program will start playing.
  final DateTime? approximateStartTime;

  /// The name of the live source used for the program.
  final String? liveSourceName;

  /// The schedule's ad break properties.
  final List<ScheduleAdBreak>? scheduleAdBreaks;

  /// The type of schedule entry.
  ///
  /// Valid values: PROGRAM or FILLER_SLATE.
  final ScheduleEntryType? scheduleEntryType;

  /// The name of the VOD source.
  final String? vodSourceName;

  ScheduleEntry({
    required this.arn,
    required this.channelName,
    required this.programName,
    required this.sourceLocationName,
    this.approximateDurationSeconds,
    this.approximateStartTime,
    this.liveSourceName,
    this.scheduleAdBreaks,
    this.scheduleEntryType,
    this.vodSourceName,
  });
  factory ScheduleEntry.fromJson(Map<String, dynamic> json) {
    return ScheduleEntry(
      arn: json['Arn'] as String,
      channelName: json['ChannelName'] as String,
      programName: json['ProgramName'] as String,
      sourceLocationName: json['SourceLocationName'] as String,
      approximateDurationSeconds: json['ApproximateDurationSeconds'] as int?,
      approximateStartTime: timeStampFromJson(json['ApproximateStartTime']),
      liveSourceName: json['LiveSourceName'] as String?,
      scheduleAdBreaks: (json['ScheduleAdBreaks'] as List?)
          ?.whereNotNull()
          .map((e) => ScheduleAdBreak.fromJson(e as Map<String, dynamic>))
          .toList(),
      scheduleEntryType:
          (json['ScheduleEntryType'] as String?)?.toScheduleEntryType(),
      vodSourceName: json['VodSourceName'] as String?,
    );
  }
}

enum ScheduleEntryType {
  program,
  fillerSlate,
}

extension on ScheduleEntryType {
  String toValue() {
    switch (this) {
      case ScheduleEntryType.program:
        return 'PROGRAM';
      case ScheduleEntryType.fillerSlate:
        return 'FILLER_SLATE';
    }
  }
}

extension on String {
  ScheduleEntryType toScheduleEntryType() {
    switch (this) {
      case 'PROGRAM':
        return ScheduleEntryType.program;
      case 'FILLER_SLATE':
        return ScheduleEntryType.fillerSlate;
    }
    throw Exception('$this is not known in enum ScheduleEntryType');
  }
}

/// AWS Secrets Manager access token configuration parameters. For information
/// about Secrets Manager access token authentication, see <a
/// href="https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-access-configuration-access-token.html">Working
/// with AWS Secrets Manager access token authentication</a>.
class SecretsManagerAccessTokenConfiguration {
  /// The name of the HTTP header used to supply the access token in requests to
  /// the source location.
  final String? headerName;

  /// The Amazon Resource Name (ARN) of the AWS Secrets Manager secret that
  /// contains the access token.
  final String? secretArn;

  /// The AWS Secrets Manager <a
  /// href="https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_CreateSecret.html#SecretsManager-CreateSecret-request-SecretString.html">SecretString</a>
  /// key associated with the access token. MediaTailor uses the key to look up
  /// SecretString key and value pair containing the access token.
  final String? secretStringKey;

  SecretsManagerAccessTokenConfiguration({
    this.headerName,
    this.secretArn,
    this.secretStringKey,
  });
  factory SecretsManagerAccessTokenConfiguration.fromJson(
      Map<String, dynamic> json) {
    return SecretsManagerAccessTokenConfiguration(
      headerName: json['HeaderName'] as String?,
      secretArn: json['SecretArn'] as String?,
      secretStringKey: json['SecretStringKey'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final headerName = this.headerName;
    final secretArn = this.secretArn;
    final secretStringKey = this.secretStringKey;
    return {
      if (headerName != null) 'HeaderName': headerName,
      if (secretArn != null) 'SecretArn': secretArn,
      if (secretStringKey != null) 'SecretStringKey': secretStringKey,
    };
  }
}

/// The base URL of the host or path of the segment delivery server that you're
/// using to serve segments. This is typically a content delivery network (CDN).
/// The URL can be absolute or relative. To use an absolute URL include the
/// protocol, such as https://example.com/some/path. To use a relative URL
/// specify the relative path, such as /some/path*.
class SegmentDeliveryConfiguration {
  /// The base URL of the host or path of the segment delivery server that you're
  /// using to serve segments. This is typically a content delivery network (CDN).
  /// The URL can be absolute or relative. To use an absolute URL include the
  /// protocol, such as https://example.com/some/path. To use a relative URL
  /// specify the relative path, such as /some/path*.
  final String? baseUrl;

  /// A unique identifier used to distinguish between multiple segment delivery
  /// configurations in a source location.
  final String? name;

  SegmentDeliveryConfiguration({
    this.baseUrl,
    this.name,
  });
  factory SegmentDeliveryConfiguration.fromJson(Map<String, dynamic> json) {
    return SegmentDeliveryConfiguration(
      baseUrl: json['BaseUrl'] as String?,
      name: json['Name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final baseUrl = this.baseUrl;
    final name = this.name;
    return {
      if (baseUrl != null) 'BaseUrl': baseUrl,
      if (name != null) 'Name': name,
    };
  }
}

/// Slate VOD source configuration.
class SlateSource {
  /// The name of the source location where the slate VOD source is stored.
  final String? sourceLocationName;

  /// The slate VOD source name. The VOD source must already exist in a source
  /// location before it can be used for slate.
  final String? vodSourceName;

  SlateSource({
    this.sourceLocationName,
    this.vodSourceName,
  });
  factory SlateSource.fromJson(Map<String, dynamic> json) {
    return SlateSource(
      sourceLocationName: json['SourceLocationName'] as String?,
      vodSourceName: json['VodSourceName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final sourceLocationName = this.sourceLocationName;
    final vodSourceName = this.vodSourceName;
    return {
      if (sourceLocationName != null) 'SourceLocationName': sourceLocationName,
      if (vodSourceName != null) 'VodSourceName': vodSourceName,
    };
  }
}

/// This response includes only the "type" : "object" property.
class SourceLocation {
  /// The ARN of the SourceLocation.
  final String arn;

  /// The HTTP configuration for the source location.
  final HttpConfiguration httpConfiguration;

  /// The name of the source location.
  final String sourceLocationName;

  /// The access configuration for the source location.
  final AccessConfiguration? accessConfiguration;

  /// The timestamp that indicates when the source location was created.
  final DateTime? creationTime;

  /// The default segment delivery configuration.
  final DefaultSegmentDeliveryConfiguration?
      defaultSegmentDeliveryConfiguration;

  /// The timestamp that indicates when the source location was last modified.
  final DateTime? lastModifiedTime;

  /// The segment delivery configurations for the source location.
  final List<SegmentDeliveryConfiguration>? segmentDeliveryConfigurations;

  /// The tags assigned to the source location.
  final Map<String, String>? tags;

  SourceLocation({
    required this.arn,
    required this.httpConfiguration,
    required this.sourceLocationName,
    this.accessConfiguration,
    this.creationTime,
    this.defaultSegmentDeliveryConfiguration,
    this.lastModifiedTime,
    this.segmentDeliveryConfigurations,
    this.tags,
  });
  factory SourceLocation.fromJson(Map<String, dynamic> json) {
    return SourceLocation(
      arn: json['Arn'] as String,
      httpConfiguration: HttpConfiguration.fromJson(
          json['HttpConfiguration'] as Map<String, dynamic>),
      sourceLocationName: json['SourceLocationName'] as String,
      accessConfiguration: json['AccessConfiguration'] != null
          ? AccessConfiguration.fromJson(
              json['AccessConfiguration'] as Map<String, dynamic>)
          : null,
      creationTime: timeStampFromJson(json['CreationTime']),
      defaultSegmentDeliveryConfiguration:
          json['DefaultSegmentDeliveryConfiguration'] != null
              ? DefaultSegmentDeliveryConfiguration.fromJson(
                  json['DefaultSegmentDeliveryConfiguration']
                      as Map<String, dynamic>)
              : null,
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      segmentDeliveryConfigurations: (json['SegmentDeliveryConfigurations']
              as List?)
          ?.whereNotNull()
          .map((e) =>
              SegmentDeliveryConfiguration.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

/// Splice insert message configuration.
class SpliceInsertMessage {
  /// This is written to splice_insert.avail_num, as defined in section 9.7.3.1 of
  /// the SCTE-35 specification. The default value is 0. Values must be between 0
  /// and 256, inclusive.
  final int? availNum;

  /// This is written to splice_insert.avails_expected, as defined in section
  /// 9.7.3.1 of the SCTE-35 specification. The default value is 0. Values must be
  /// between 0 and 256, inclusive.
  final int? availsExpected;

  /// This is written to splice_insert.splice_event_id, as defined in section
  /// 9.7.3.1 of the SCTE-35 specification. The default value is 1.
  final int? spliceEventId;

  /// This is written to splice_insert.unique_program_id, as defined in section
  /// 9.7.3.1 of the SCTE-35 specification. The default value is 0. Values must be
  /// between 0 and 256, inclusive.
  final int? uniqueProgramId;

  SpliceInsertMessage({
    this.availNum,
    this.availsExpected,
    this.spliceEventId,
    this.uniqueProgramId,
  });
  factory SpliceInsertMessage.fromJson(Map<String, dynamic> json) {
    return SpliceInsertMessage(
      availNum: json['AvailNum'] as int?,
      availsExpected: json['AvailsExpected'] as int?,
      spliceEventId: json['SpliceEventId'] as int?,
      uniqueProgramId: json['UniqueProgramId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final availNum = this.availNum;
    final availsExpected = this.availsExpected;
    final spliceEventId = this.spliceEventId;
    final uniqueProgramId = this.uniqueProgramId;
    return {
      if (availNum != null) 'AvailNum': availNum,
      if (availsExpected != null) 'AvailsExpected': availsExpected,
      if (spliceEventId != null) 'SpliceEventId': spliceEventId,
      if (uniqueProgramId != null) 'UniqueProgramId': uniqueProgramId,
    };
  }
}

class StartChannelResponse {
  StartChannelResponse();
  factory StartChannelResponse.fromJson(Map<String, dynamic> _) {
    return StartChannelResponse();
  }
}

class StopChannelResponse {
  StopChannelResponse();
  factory StopChannelResponse.fromJson(Map<String, dynamic> _) {
    return StopChannelResponse();
  }
}

enum Tier {
  basic,
  standard,
}

extension on Tier {
  String toValue() {
    switch (this) {
      case Tier.basic:
        return 'BASIC';
      case Tier.standard:
        return 'STANDARD';
    }
  }
}

extension on String {
  Tier toTier() {
    switch (this) {
      case 'BASIC':
        return Tier.basic;
      case 'STANDARD':
        return Tier.standard;
    }
    throw Exception('$this is not known in enum Tier');
  }
}

/// Program transition configuration.
class Transition {
  /// The position where this program will be inserted relative to the
  /// RelativePosition.
  final RelativePosition relativePosition;

  /// Defines when the program plays in the schedule. You can set the value to
  /// ABSOLUTE or RELATIVE.
  ///
  /// ABSOLUTE - The program plays at a specific wall clock time. This setting can
  /// only be used for channels using the LINEAR PlaybackMode.
  ///
  /// Note the following considerations when using ABSOLUTE transitions:
  ///
  /// If the preceding program in the schedule has a duration that extends past
  /// the wall clock time, MediaTailor truncates the preceding program on a common
  /// segment boundary.
  ///
  /// If there are gaps in playback, MediaTailor plays the FillerSlate you
  /// configured for your linear channel.
  ///
  /// RELATIVE - The program is inserted into the schedule either before or after
  /// a program that you specify via RelativePosition.
  final String type;

  /// The duration of the live program in seconds.
  final int? durationMillis;

  /// The name of the program that this program will be inserted next to, as
  /// defined by RelativePosition.
  final String? relativeProgram;

  /// The date and time that the program is scheduled to start, in epoch
  /// milliseconds.
  final int? scheduledStartTimeMillis;

  Transition({
    required this.relativePosition,
    required this.type,
    this.durationMillis,
    this.relativeProgram,
    this.scheduledStartTimeMillis,
  });
  Map<String, dynamic> toJson() {
    final relativePosition = this.relativePosition;
    final type = this.type;
    final durationMillis = this.durationMillis;
    final relativeProgram = this.relativeProgram;
    final scheduledStartTimeMillis = this.scheduledStartTimeMillis;
    return {
      'RelativePosition': relativePosition.toValue(),
      'Type': type,
      if (durationMillis != null) 'DurationMillis': durationMillis,
      if (relativeProgram != null) 'RelativeProgram': relativeProgram,
      if (scheduledStartTimeMillis != null)
        'ScheduledStartTimeMillis': scheduledStartTimeMillis,
    };
  }
}

enum Type {
  dash,
  hls,
}

extension on Type {
  String toValue() {
    switch (this) {
      case Type.dash:
        return 'DASH';
      case Type.hls:
        return 'HLS';
    }
  }
}

extension on String {
  Type toType() {
    switch (this) {
      case 'DASH':
        return Type.dash;
      case 'HLS':
        return Type.hls;
    }
    throw Exception('$this is not known in enum Type');
  }
}

class UpdateChannelResponse {
  /// The ARN of the channel.
  final String? arn;

  /// The name of the channel.
  final String? channelName;

  /// Indicates whether the channel is in a running state or not.
  final ChannelState? channelState;

  /// The timestamp of when the channel was created.
  final DateTime? creationTime;

  /// Contains information about the slate used to fill gaps between programs in
  /// the schedule.
  final SlateSource? fillerSlate;

  /// The timestamp of when the channel was last modified.
  final DateTime? lastModifiedTime;

  /// The channel's output properties.
  final List<ResponseOutputItem>? outputs;

  /// The channel's playback mode.
  final String? playbackMode;

  /// The tags assigned to the channel.
  final Map<String, String>? tags;

  /// The channel's tier.
  final String? tier;

  UpdateChannelResponse({
    this.arn,
    this.channelName,
    this.channelState,
    this.creationTime,
    this.fillerSlate,
    this.lastModifiedTime,
    this.outputs,
    this.playbackMode,
    this.tags,
    this.tier,
  });
  factory UpdateChannelResponse.fromJson(Map<String, dynamic> json) {
    return UpdateChannelResponse(
      arn: json['Arn'] as String?,
      channelName: json['ChannelName'] as String?,
      channelState: (json['ChannelState'] as String?)?.toChannelState(),
      creationTime: timeStampFromJson(json['CreationTime']),
      fillerSlate: json['FillerSlate'] != null
          ? SlateSource.fromJson(json['FillerSlate'] as Map<String, dynamic>)
          : null,
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      outputs: (json['Outputs'] as List?)
          ?.whereNotNull()
          .map((e) => ResponseOutputItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      playbackMode: json['PlaybackMode'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      tier: json['Tier'] as String?,
    );
  }
}

class UpdateLiveSourceResponse {
  /// The ARN of the live source.
  final String? arn;

  /// The timestamp that indicates when the live source was created.
  final DateTime? creationTime;

  /// The HTTP package configurations.
  final List<HttpPackageConfiguration>? httpPackageConfigurations;

  /// The timestamp that indicates when the live source was modified.
  final DateTime? lastModifiedTime;

  /// The name of the live source.
  final String? liveSourceName;

  /// The name of the source location associated with the VOD source.
  final String? sourceLocationName;

  /// The tags assigned to the live source.
  final Map<String, String>? tags;

  UpdateLiveSourceResponse({
    this.arn,
    this.creationTime,
    this.httpPackageConfigurations,
    this.lastModifiedTime,
    this.liveSourceName,
    this.sourceLocationName,
    this.tags,
  });
  factory UpdateLiveSourceResponse.fromJson(Map<String, dynamic> json) {
    return UpdateLiveSourceResponse(
      arn: json['Arn'] as String?,
      creationTime: timeStampFromJson(json['CreationTime']),
      httpPackageConfigurations: (json['HttpPackageConfigurations'] as List?)
          ?.whereNotNull()
          .map((e) =>
              HttpPackageConfiguration.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      liveSourceName: json['LiveSourceName'] as String?,
      sourceLocationName: json['SourceLocationName'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class UpdateSourceLocationResponse {
  /// The access configuration for the source location.
  final AccessConfiguration? accessConfiguration;

  /// The ARN of the source location.
  final String? arn;

  /// The timestamp that indicates when the source location was created.
  final DateTime? creationTime;

  /// The default segment delivery configuration settings.
  final DefaultSegmentDeliveryConfiguration?
      defaultSegmentDeliveryConfiguration;

  /// The HTTP package configuration settings for the source location.
  final HttpConfiguration? httpConfiguration;

  /// The timestamp that indicates when the source location was last modified.
  final DateTime? lastModifiedTime;

  /// A list of the segment delivery configurations associated with this resource.
  final List<SegmentDeliveryConfiguration>? segmentDeliveryConfigurations;

  /// The name of the source location.
  final String? sourceLocationName;

  /// The tags assigned to the source location.
  final Map<String, String>? tags;

  UpdateSourceLocationResponse({
    this.accessConfiguration,
    this.arn,
    this.creationTime,
    this.defaultSegmentDeliveryConfiguration,
    this.httpConfiguration,
    this.lastModifiedTime,
    this.segmentDeliveryConfigurations,
    this.sourceLocationName,
    this.tags,
  });
  factory UpdateSourceLocationResponse.fromJson(Map<String, dynamic> json) {
    return UpdateSourceLocationResponse(
      accessConfiguration: json['AccessConfiguration'] != null
          ? AccessConfiguration.fromJson(
              json['AccessConfiguration'] as Map<String, dynamic>)
          : null,
      arn: json['Arn'] as String?,
      creationTime: timeStampFromJson(json['CreationTime']),
      defaultSegmentDeliveryConfiguration:
          json['DefaultSegmentDeliveryConfiguration'] != null
              ? DefaultSegmentDeliveryConfiguration.fromJson(
                  json['DefaultSegmentDeliveryConfiguration']
                      as Map<String, dynamic>)
              : null,
      httpConfiguration: json['HttpConfiguration'] != null
          ? HttpConfiguration.fromJson(
              json['HttpConfiguration'] as Map<String, dynamic>)
          : null,
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      segmentDeliveryConfigurations: (json['SegmentDeliveryConfigurations']
              as List?)
          ?.whereNotNull()
          .map((e) =>
              SegmentDeliveryConfiguration.fromJson(e as Map<String, dynamic>))
          .toList(),
      sourceLocationName: json['SourceLocationName'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class UpdateVodSourceResponse {
  /// The ARN of the VOD source.
  final String? arn;

  /// The timestamp that indicates when the VOD source was created.
  final DateTime? creationTime;

  /// The HTTP package configurations.
  final List<HttpPackageConfiguration>? httpPackageConfigurations;

  /// The last modified time of the VOD source.
  final DateTime? lastModifiedTime;

  /// The name of the source location associated with the VOD source.
  final String? sourceLocationName;

  /// The tags assigned to the VOD source.
  final Map<String, String>? tags;

  /// The name of the VOD source.
  final String? vodSourceName;

  UpdateVodSourceResponse({
    this.arn,
    this.creationTime,
    this.httpPackageConfigurations,
    this.lastModifiedTime,
    this.sourceLocationName,
    this.tags,
    this.vodSourceName,
  });
  factory UpdateVodSourceResponse.fromJson(Map<String, dynamic> json) {
    return UpdateVodSourceResponse(
      arn: json['Arn'] as String?,
      creationTime: timeStampFromJson(json['CreationTime']),
      httpPackageConfigurations: (json['HttpPackageConfigurations'] as List?)
          ?.whereNotNull()
          .map((e) =>
              HttpPackageConfiguration.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      sourceLocationName: json['SourceLocationName'] as String?,
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      vodSourceName: json['VodSourceName'] as String?,
    );
  }
}

/// VOD source configuration parameters.
class VodSource {
  /// The ARN for the VOD source.
  final String arn;

  /// The HTTP package configurations for the VOD source.
  final List<HttpPackageConfiguration> httpPackageConfigurations;

  /// The name of the source location that the VOD source is associated with.
  final String sourceLocationName;

  /// The name of the VOD source.
  final String vodSourceName;

  /// The timestamp that indicates when the VOD source was created.
  final DateTime? creationTime;

  /// The timestamp that indicates when the VOD source was last modified.
  final DateTime? lastModifiedTime;

  /// The tags assigned to the VOD source.
  final Map<String, String>? tags;

  VodSource({
    required this.arn,
    required this.httpPackageConfigurations,
    required this.sourceLocationName,
    required this.vodSourceName,
    this.creationTime,
    this.lastModifiedTime,
    this.tags,
  });
  factory VodSource.fromJson(Map<String, dynamic> json) {
    return VodSource(
      arn: json['Arn'] as String,
      httpPackageConfigurations: (json['HttpPackageConfigurations'] as List)
          .whereNotNull()
          .map((e) =>
              HttpPackageConfiguration.fromJson(e as Map<String, dynamic>))
          .toList(),
      sourceLocationName: json['SourceLocationName'] as String,
      vodSourceName: json['VodSourceName'] as String,
      creationTime: timeStampFromJson(json['CreationTime']),
      lastModifiedTime: timeStampFromJson(json['LastModifiedTime']),
      tags: (json['tags'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
  }
}

class BadRequestException extends _s.GenericAwsException {
  BadRequestException({String? type, String? message})
      : super(type: type, code: 'BadRequestException', message: message);
}

final _exceptionFns = <String, _s.AwsExceptionFn>{
  'BadRequestException': (type, message) =>
      BadRequestException(type: type, message: message),
};
