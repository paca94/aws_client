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

/// Provides translation between one source language and another of the same set
/// of languages.
class Translate {
  final _s.JsonProtocol _protocol;
  Translate({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.AwsClientCredentialsProvider? credentialsProvider,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.JsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'translate',
            signingName: 'translate',
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

  /// Creates a parallel data resource in Amazon Translate by importing an input
  /// file from Amazon S3. Parallel data files contain examples that show how
  /// you want segments of text to be translated. By adding parallel data, you
  /// can influence the style, tone, and word choice in your translation output.
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [InvalidRequestException].
  /// May throw [LimitExceededException].
  /// May throw [TooManyRequestsException].
  /// May throw [ConflictException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [name] :
  /// A custom name for the parallel data resource in Amazon Translate. You must
  /// assign a name that is unique in the account and region.
  ///
  /// Parameter [parallelDataConfig] :
  /// Specifies the format and S3 location of the parallel data input file.
  ///
  /// Parameter [clientToken] :
  /// A unique identifier for the request. This token is automatically generated
  /// when you use Amazon Translate through an AWS SDK.
  ///
  /// Parameter [description] :
  /// A custom description for the parallel data resource in Amazon Translate.
  Future<CreateParallelDataResponse> createParallelData({
    required String name,
    required ParallelDataConfig parallelDataConfig,
    String? clientToken,
    String? description,
    EncryptionKey? encryptionKey,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      256,
      isRequired: true,
    );
    ArgumentError.checkNotNull(parallelDataConfig, 'parallelDataConfig');
    _s.validateStringLength(
      'clientToken',
      clientToken,
      1,
      64,
    );
    _s.validateStringLength(
      'description',
      description,
      0,
      256,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSShineFrontendService_20170701.CreateParallelData'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
        'ParallelDataConfig': parallelDataConfig,
        'ClientToken': clientToken ?? _s.generateIdempotencyToken(),
        if (description != null) 'Description': description,
        if (encryptionKey != null) 'EncryptionKey': encryptionKey,
      },
    );

    return CreateParallelDataResponse.fromJson(jsonResponse.body);
  }

  /// Deletes a parallel data resource in Amazon Translate.
  ///
  /// May throw [ConcurrentModificationException].
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [name] :
  /// The name of the parallel data resource that is being deleted.
  Future<DeleteParallelDataResponse> deleteParallelData({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      256,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSShineFrontendService_20170701.DeleteParallelData'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
      },
    );

    return DeleteParallelDataResponse.fromJson(jsonResponse.body);
  }

  /// A synchronous action that deletes a custom terminology.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [InvalidParameterValueException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [name] :
  /// The name of the custom terminology being deleted.
  Future<void> deleteTerminology({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      256,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSShineFrontendService_20170701.DeleteTerminology'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
      },
    );
  }

  /// Gets the properties associated with an asynchronous batch translation job
  /// including name, ID, status, source and target languages, input/output S3
  /// buckets, and so on.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [jobId] :
  /// The identifier that Amazon Translate generated for the job. The
  /// <a>StartTextTranslationJob</a> operation returns this identifier in its
  /// response.
  Future<DescribeTextTranslationJobResponse> describeTextTranslationJob({
    required String jobId,
  }) async {
    ArgumentError.checkNotNull(jobId, 'jobId');
    _s.validateStringLength(
      'jobId',
      jobId,
      1,
      32,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSShineFrontendService_20170701.DescribeTextTranslationJob'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'JobId': jobId,
      },
    );

    return DescribeTextTranslationJobResponse.fromJson(jsonResponse.body);
  }

  /// Provides information about a parallel data resource.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [name] :
  /// The name of the parallel data resource that is being retrieved.
  Future<GetParallelDataResponse> getParallelData({
    required String name,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      256,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSShineFrontendService_20170701.GetParallelData'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
      },
    );

    return GetParallelDataResponse.fromJson(jsonResponse.body);
  }

  /// Retrieves a custom terminology.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [name] :
  /// The name of the custom terminology being retrieved.
  ///
  /// Parameter [terminologyDataFormat] :
  /// The data format of the custom terminology being retrieved.
  ///
  /// If you don't specify this parameter, Amazon Translate returns a file with
  /// the same format as the file that was imported to create the terminology.
  ///
  /// If you specify this parameter when you retrieve a multi-directional
  /// terminology resource, you must specify the same format as the input file
  /// that was imported to create it. Otherwise, Amazon Translate throws an
  /// error.
  Future<GetTerminologyResponse> getTerminology({
    required String name,
    TerminologyDataFormat? terminologyDataFormat,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      256,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSShineFrontendService_20170701.GetTerminology'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
        if (terminologyDataFormat != null)
          'TerminologyDataFormat': terminologyDataFormat.toValue(),
      },
    );

    return GetTerminologyResponse.fromJson(jsonResponse.body);
  }

  /// Creates or updates a custom terminology, depending on whether one already
  /// exists for the given terminology name. Importing a terminology with the
  /// same name as an existing one will merge the terminologies based on the
  /// chosen merge strategy. The only supported merge strategy is OVERWRITE,
  /// where the imported terminology overwrites the existing terminology of the
  /// same name.
  ///
  /// If you import a terminology that overwrites an existing one, the new
  /// terminology takes up to 10 minutes to fully propagate. After that,
  /// translations have access to the new terminology.
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [LimitExceededException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [mergeStrategy] :
  /// The merge strategy of the custom terminology being imported. Currently,
  /// only the OVERWRITE merge strategy is supported. In this case, the imported
  /// terminology will overwrite an existing terminology of the same name.
  ///
  /// Parameter [name] :
  /// The name of the custom terminology being imported.
  ///
  /// Parameter [terminologyData] :
  /// The terminology data for the custom terminology being imported.
  ///
  /// Parameter [description] :
  /// The description of the custom terminology being imported.
  ///
  /// Parameter [encryptionKey] :
  /// The encryption key for the custom terminology being imported.
  Future<ImportTerminologyResponse> importTerminology({
    required MergeStrategy mergeStrategy,
    required String name,
    required TerminologyData terminologyData,
    String? description,
    EncryptionKey? encryptionKey,
  }) async {
    ArgumentError.checkNotNull(mergeStrategy, 'mergeStrategy');
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      256,
      isRequired: true,
    );
    ArgumentError.checkNotNull(terminologyData, 'terminologyData');
    _s.validateStringLength(
      'description',
      description,
      0,
      256,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSShineFrontendService_20170701.ImportTerminology'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'MergeStrategy': mergeStrategy.toValue(),
        'Name': name,
        'TerminologyData': terminologyData,
        if (description != null) 'Description': description,
        if (encryptionKey != null) 'EncryptionKey': encryptionKey,
      },
    );

    return ImportTerminologyResponse.fromJson(jsonResponse.body);
  }

  /// Provides a list of languages (RFC-5646 codes and names) that Amazon
  /// Translate supports.
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [TooManyRequestsException].
  /// May throw [UnsupportedDisplayLanguageCodeException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [displayLanguageCode] :
  /// The language code for the language to use to display the language names in
  /// the response. The language code is <code>en</code> by default.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of results to return in each response.
  ///
  /// Parameter [nextToken] :
  /// Include the NextToken value to fetch the next group of supported
  /// languages.
  Future<ListLanguagesResponse> listLanguages({
    DisplayLanguageCode? displayLanguageCode,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      500,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      0,
      8192,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSShineFrontendService_20170701.ListLanguages'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (displayLanguageCode != null)
          'DisplayLanguageCode': displayLanguageCode.toValue(),
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListLanguagesResponse.fromJson(jsonResponse.body);
  }

  /// Provides a list of your parallel data resources in Amazon Translate.
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [maxResults] :
  /// The maximum number of parallel data resources returned for each request.
  ///
  /// Parameter [nextToken] :
  /// A string that specifies the next page of results to return in a paginated
  /// response.
  Future<ListParallelDataResponse> listParallelData({
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      500,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      0,
      8192,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSShineFrontendService_20170701.ListParallelData'
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

    return ListParallelDataResponse.fromJson(jsonResponse.body);
  }

  /// Provides a list of custom terminologies associated with your account.
  ///
  /// May throw [InvalidParameterValueException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [maxResults] :
  /// The maximum number of custom terminologies returned per list request.
  ///
  /// Parameter [nextToken] :
  /// If the result of the request to ListTerminologies was truncated, include
  /// the NextToken to fetch the next group of custom terminologies.
  Future<ListTerminologiesResponse> listTerminologies({
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      500,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      0,
      8192,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSShineFrontendService_20170701.ListTerminologies'
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

    return ListTerminologiesResponse.fromJson(jsonResponse.body);
  }

  /// Gets a list of the batch translation jobs that you have submitted.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [TooManyRequestsException].
  /// May throw [InvalidFilterException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [filter] :
  /// The parameters that specify which batch translation jobs to retrieve.
  /// Filters include job name, job status, and submission time. You can only
  /// set one filter at a time.
  ///
  /// Parameter [maxResults] :
  /// The maximum number of results to return in each page. The default value is
  /// 100.
  ///
  /// Parameter [nextToken] :
  /// The token to request the next page of results.
  Future<ListTextTranslationJobsResponse> listTextTranslationJobs({
    TextTranslationJobFilter? filter,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      500,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      0,
      8192,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSShineFrontendService_20170701.ListTextTranslationJobs'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filter != null) 'Filter': filter,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListTextTranslationJobsResponse.fromJson(jsonResponse.body);
  }

  /// Starts an asynchronous batch translation job. Batch translation jobs can
  /// be used to translate large volumes of text across multiple documents at
  /// once. For more information, see <a>async</a>.
  ///
  /// Batch translation jobs can be described with the
  /// <a>DescribeTextTranslationJob</a> operation, listed with the
  /// <a>ListTextTranslationJobs</a> operation, and stopped with the
  /// <a>StopTextTranslationJob</a> operation.
  /// <note>
  /// Amazon Translate does not support batch translation of multiple source
  /// languages at once.
  /// </note>
  ///
  /// May throw [TooManyRequestsException].
  /// May throw [UnsupportedLanguagePairException].
  /// May throw [InvalidRequestException].
  /// May throw [ResourceNotFoundException].
  /// May throw [InvalidParameterValueException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [dataAccessRoleArn] :
  /// The Amazon Resource Name (ARN) of an AWS Identity Access and Management
  /// (IAM) role that grants Amazon Translate read access to your input data.
  /// For more information, see <a>identity-and-access-management</a>.
  ///
  /// Parameter [inputDataConfig] :
  /// Specifies the format and location of the input documents for the
  /// translation job.
  ///
  /// Parameter [outputDataConfig] :
  /// Specifies the S3 folder to which your job output will be saved.
  ///
  /// Parameter [sourceLanguageCode] :
  /// The language code of the input language. For a list of language codes, see
  /// <a>what-is-languages</a>.
  ///
  /// Amazon Translate does not automatically detect a source language during
  /// batch translation jobs.
  ///
  /// Parameter [targetLanguageCodes] :
  /// The language code of the output language.
  ///
  /// Parameter [clientToken] :
  /// A unique identifier for the request. This token is generated for you when
  /// using the Amazon Translate SDK.
  ///
  /// Parameter [jobName] :
  /// The name of the batch translation job to be performed.
  ///
  /// Parameter [parallelDataNames] :
  /// The name of a parallel data resource to add to the translation job. This
  /// resource consists of examples that show how you want segments of text to
  /// be translated. When you add parallel data to a translation job, you create
  /// an <i>Active Custom Translation</i> job.
  ///
  /// This parameter accepts only one parallel data resource.
  /// <note>
  /// Active Custom Translation jobs are priced at a higher rate than other jobs
  /// that don't use parallel data. For more information, see <a
  /// href="http://aws.amazon.com/translate/pricing/">Amazon Translate
  /// pricing</a>.
  /// </note>
  /// For a list of available parallel data resources, use the
  /// <a>ListParallelData</a> operation.
  ///
  /// For more information, see <a>customizing-translations-parallel-data</a>.
  ///
  /// Parameter [settings] :
  /// Settings to configure your translation output, including the option to
  /// mask profane words and phrases. <code>StartTextTranslationJob</code> does
  /// not support the formality setting.
  ///
  /// Parameter [terminologyNames] :
  /// The name of a custom terminology resource to add to the translation job.
  /// This resource lists examples source terms and the desired translation for
  /// each term.
  ///
  /// This parameter accepts only one custom terminology resource.
  ///
  /// For a list of available custom terminology resources, use the
  /// <a>ListTerminologies</a> operation.
  ///
  /// For more information, see <a>how-custom-terminology</a>.
  Future<StartTextTranslationJobResponse> startTextTranslationJob({
    required String dataAccessRoleArn,
    required InputDataConfig inputDataConfig,
    required OutputDataConfig outputDataConfig,
    required String sourceLanguageCode,
    required List<String> targetLanguageCodes,
    String? clientToken,
    String? jobName,
    List<String>? parallelDataNames,
    TranslationSettings? settings,
    List<String>? terminologyNames,
  }) async {
    ArgumentError.checkNotNull(dataAccessRoleArn, 'dataAccessRoleArn');
    _s.validateStringLength(
      'dataAccessRoleArn',
      dataAccessRoleArn,
      20,
      2048,
      isRequired: true,
    );
    ArgumentError.checkNotNull(inputDataConfig, 'inputDataConfig');
    ArgumentError.checkNotNull(outputDataConfig, 'outputDataConfig');
    ArgumentError.checkNotNull(sourceLanguageCode, 'sourceLanguageCode');
    _s.validateStringLength(
      'sourceLanguageCode',
      sourceLanguageCode,
      2,
      5,
      isRequired: true,
    );
    ArgumentError.checkNotNull(targetLanguageCodes, 'targetLanguageCodes');
    _s.validateStringLength(
      'clientToken',
      clientToken,
      1,
      64,
    );
    _s.validateStringLength(
      'jobName',
      jobName,
      1,
      256,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSShineFrontendService_20170701.StartTextTranslationJob'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'DataAccessRoleArn': dataAccessRoleArn,
        'InputDataConfig': inputDataConfig,
        'OutputDataConfig': outputDataConfig,
        'SourceLanguageCode': sourceLanguageCode,
        'TargetLanguageCodes': targetLanguageCodes,
        'ClientToken': clientToken ?? _s.generateIdempotencyToken(),
        if (jobName != null) 'JobName': jobName,
        if (parallelDataNames != null) 'ParallelDataNames': parallelDataNames,
        if (settings != null) 'Settings': settings,
        if (terminologyNames != null) 'TerminologyNames': terminologyNames,
      },
    );

    return StartTextTranslationJobResponse.fromJson(jsonResponse.body);
  }

  /// Stops an asynchronous batch translation job that is in progress.
  ///
  /// If the job's state is <code>IN_PROGRESS</code>, the job will be marked for
  /// termination and put into the <code>STOP_REQUESTED</code> state. If the job
  /// completes before it can be stopped, it is put into the
  /// <code>COMPLETED</code> state. Otherwise, the job is put into the
  /// <code>STOPPED</code> state.
  ///
  /// Asynchronous batch translation jobs are started with the
  /// <a>StartTextTranslationJob</a> operation. You can use the
  /// <a>DescribeTextTranslationJob</a> or <a>ListTextTranslationJobs</a>
  /// operations to get a batch translation job's <code>JobId</code>.
  ///
  /// May throw [ResourceNotFoundException].
  /// May throw [TooManyRequestsException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [jobId] :
  /// The job ID of the job to be stopped.
  Future<StopTextTranslationJobResponse> stopTextTranslationJob({
    required String jobId,
  }) async {
    ArgumentError.checkNotNull(jobId, 'jobId');
    _s.validateStringLength(
      'jobId',
      jobId,
      1,
      32,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSShineFrontendService_20170701.StopTextTranslationJob'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'JobId': jobId,
      },
    );

    return StopTextTranslationJobResponse.fromJson(jsonResponse.body);
  }

  /// Translates input text from the source language to the target language. For
  /// a list of available languages and language codes, see
  /// <a>what-is-languages</a>.
  ///
  /// May throw [InvalidRequestException].
  /// May throw [TextSizeLimitExceededException].
  /// May throw [TooManyRequestsException].
  /// May throw [UnsupportedLanguagePairException].
  /// May throw [DetectedLanguageLowConfidenceException].
  /// May throw [ResourceNotFoundException].
  /// May throw [InternalServerException].
  /// May throw [ServiceUnavailableException].
  ///
  /// Parameter [sourceLanguageCode] :
  /// The language code for the language of the source text. The language must
  /// be a language supported by Amazon Translate. For a list of language codes,
  /// see <a>what-is-languages</a>.
  ///
  /// To have Amazon Translate determine the source language of your text, you
  /// can specify <code>auto</code> in the <code>SourceLanguageCode</code>
  /// field. If you specify <code>auto</code>, Amazon Translate will call <a
  /// href="https://docs.aws.amazon.com/comprehend/latest/dg/comprehend-general.html">Amazon
  /// Comprehend</a> to determine the source language.
  /// <note>
  /// If you specify <code>auto</code>, you must send the
  /// <code>TranslateText</code> request in a region that supports Amazon
  /// Comprehend. Otherwise, the request returns an error indicating that
  /// autodetect is not supported.
  /// </note>
  ///
  /// Parameter [targetLanguageCode] :
  /// The language code requested for the language of the target text. The
  /// language must be a language supported by Amazon Translate.
  ///
  /// Parameter [text] :
  /// The text to translate. The text string can be a maximum of 5,000 bytes
  /// long. Depending on your character set, this may be fewer than 5,000
  /// characters.
  ///
  /// Parameter [settings] :
  /// Settings to configure your translation output, including the option to set
  /// the formality level of the output text and the option to mask profane
  /// words and phrases.
  ///
  /// Parameter [terminologyNames] :
  /// The name of the terminology list file to be used in the TranslateText
  /// request. You can use 1 terminology list at most in a
  /// <code>TranslateText</code> request. Terminology lists can contain a
  /// maximum of 256 terms.
  Future<TranslateTextResponse> translateText({
    required String sourceLanguageCode,
    required String targetLanguageCode,
    required String text,
    TranslationSettings? settings,
    List<String>? terminologyNames,
  }) async {
    ArgumentError.checkNotNull(sourceLanguageCode, 'sourceLanguageCode');
    _s.validateStringLength(
      'sourceLanguageCode',
      sourceLanguageCode,
      2,
      5,
      isRequired: true,
    );
    ArgumentError.checkNotNull(targetLanguageCode, 'targetLanguageCode');
    _s.validateStringLength(
      'targetLanguageCode',
      targetLanguageCode,
      2,
      5,
      isRequired: true,
    );
    ArgumentError.checkNotNull(text, 'text');
    _s.validateStringLength(
      'text',
      text,
      1,
      5000,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSShineFrontendService_20170701.TranslateText'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'SourceLanguageCode': sourceLanguageCode,
        'TargetLanguageCode': targetLanguageCode,
        'Text': text,
        if (settings != null) 'Settings': settings,
        if (terminologyNames != null) 'TerminologyNames': terminologyNames,
      },
    );

    return TranslateTextResponse.fromJson(jsonResponse.body);
  }

  /// Updates a previously created parallel data resource by importing a new
  /// input file from Amazon S3.
  ///
  /// May throw [ConcurrentModificationException].
  /// May throw [InvalidParameterValueException].
  /// May throw [InvalidRequestException].
  /// May throw [LimitExceededException].
  /// May throw [TooManyRequestsException].
  /// May throw [ConflictException].
  /// May throw [ResourceNotFoundException].
  /// May throw [InternalServerException].
  ///
  /// Parameter [name] :
  /// The name of the parallel data resource being updated.
  ///
  /// Parameter [parallelDataConfig] :
  /// Specifies the format and S3 location of the parallel data input file.
  ///
  /// Parameter [clientToken] :
  /// A unique identifier for the request. This token is automatically generated
  /// when you use Amazon Translate through an AWS SDK.
  ///
  /// Parameter [description] :
  /// A custom description for the parallel data resource in Amazon Translate.
  Future<UpdateParallelDataResponse> updateParallelData({
    required String name,
    required ParallelDataConfig parallelDataConfig,
    String? clientToken,
    String? description,
  }) async {
    ArgumentError.checkNotNull(name, 'name');
    _s.validateStringLength(
      'name',
      name,
      1,
      256,
      isRequired: true,
    );
    ArgumentError.checkNotNull(parallelDataConfig, 'parallelDataConfig');
    _s.validateStringLength(
      'clientToken',
      clientToken,
      1,
      64,
    );
    _s.validateStringLength(
      'description',
      description,
      0,
      256,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSShineFrontendService_20170701.UpdateParallelData'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Name': name,
        'ParallelDataConfig': parallelDataConfig,
        'ClientToken': clientToken ?? _s.generateIdempotencyToken(),
        if (description != null) 'Description': description,
      },
    );

    return UpdateParallelDataResponse.fromJson(jsonResponse.body);
  }
}

/// The custom terminology applied to the input text by Amazon Translate for the
/// translated text response. This is optional in the response and will only be
/// present if you specified terminology input in the request. Currently, only
/// one terminology can be applied per TranslateText request.
class AppliedTerminology {
  /// The name of the custom terminology applied to the input text by Amazon
  /// Translate for the translated text response.
  final String? name;

  /// The specific terms of the custom terminology applied to the input text by
  /// Amazon Translate for the translated text response. A maximum of 250 terms
  /// will be returned, and the specific terms applied will be the first 250 terms
  /// in the source text.
  final List<Term>? terms;

  AppliedTerminology({
    this.name,
    this.terms,
  });
  factory AppliedTerminology.fromJson(Map<String, dynamic> json) {
    return AppliedTerminology(
      name: json['Name'] as String?,
      terms: (json['Terms'] as List?)
          ?.whereNotNull()
          .map((e) => Term.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CreateParallelDataResponse {
  /// The custom name that you assigned to the parallel data resource.
  final String? name;

  /// The status of the parallel data resource. When the resource is ready for you
  /// to use, the status is <code>ACTIVE</code>.
  final ParallelDataStatus? status;

  CreateParallelDataResponse({
    this.name,
    this.status,
  });
  factory CreateParallelDataResponse.fromJson(Map<String, dynamic> json) {
    return CreateParallelDataResponse(
      name: json['Name'] as String?,
      status: (json['Status'] as String?)?.toParallelDataStatus(),
    );
  }
}

class DeleteParallelDataResponse {
  /// The name of the parallel data resource that is being deleted.
  final String? name;

  /// The status of the parallel data deletion.
  final ParallelDataStatus? status;

  DeleteParallelDataResponse({
    this.name,
    this.status,
  });
  factory DeleteParallelDataResponse.fromJson(Map<String, dynamic> json) {
    return DeleteParallelDataResponse(
      name: json['Name'] as String?,
      status: (json['Status'] as String?)?.toParallelDataStatus(),
    );
  }
}

class DescribeTextTranslationJobResponse {
  /// An object that contains the properties associated with an asynchronous batch
  /// translation job.
  final TextTranslationJobProperties? textTranslationJobProperties;

  DescribeTextTranslationJobResponse({
    this.textTranslationJobProperties,
  });
  factory DescribeTextTranslationJobResponse.fromJson(
      Map<String, dynamic> json) {
    return DescribeTextTranslationJobResponse(
      textTranslationJobProperties: json['TextTranslationJobProperties'] != null
          ? TextTranslationJobProperties.fromJson(
              json['TextTranslationJobProperties'] as Map<String, dynamic>)
          : null,
    );
  }
}

enum Directionality {
  uni,
  multi,
}

extension on Directionality {
  String toValue() {
    switch (this) {
      case Directionality.uni:
        return 'UNI';
      case Directionality.multi:
        return 'MULTI';
    }
  }
}

extension on String {
  Directionality toDirectionality() {
    switch (this) {
      case 'UNI':
        return Directionality.uni;
      case 'MULTI':
        return Directionality.multi;
    }
    throw Exception('$this is not known in enum Directionality');
  }
}

enum DisplayLanguageCode {
  de,
  en,
  es,
  fr,
  it,
  ja,
  ko,
  pt,
  zh,
  zhTw,
}

extension on DisplayLanguageCode {
  String toValue() {
    switch (this) {
      case DisplayLanguageCode.de:
        return 'de';
      case DisplayLanguageCode.en:
        return 'en';
      case DisplayLanguageCode.es:
        return 'es';
      case DisplayLanguageCode.fr:
        return 'fr';
      case DisplayLanguageCode.it:
        return 'it';
      case DisplayLanguageCode.ja:
        return 'ja';
      case DisplayLanguageCode.ko:
        return 'ko';
      case DisplayLanguageCode.pt:
        return 'pt';
      case DisplayLanguageCode.zh:
        return 'zh';
      case DisplayLanguageCode.zhTw:
        return 'zh-TW';
    }
  }
}

extension on String {
  DisplayLanguageCode toDisplayLanguageCode() {
    switch (this) {
      case 'de':
        return DisplayLanguageCode.de;
      case 'en':
        return DisplayLanguageCode.en;
      case 'es':
        return DisplayLanguageCode.es;
      case 'fr':
        return DisplayLanguageCode.fr;
      case 'it':
        return DisplayLanguageCode.it;
      case 'ja':
        return DisplayLanguageCode.ja;
      case 'ko':
        return DisplayLanguageCode.ko;
      case 'pt':
        return DisplayLanguageCode.pt;
      case 'zh':
        return DisplayLanguageCode.zh;
      case 'zh-TW':
        return DisplayLanguageCode.zhTw;
    }
    throw Exception('$this is not known in enum DisplayLanguageCode');
  }
}

/// The encryption key used to encrypt this object.
class EncryptionKey {
  /// The Amazon Resource Name (ARN) of the encryption key being used to encrypt
  /// this object.
  final String id;

  /// The type of encryption key used by Amazon Translate to encrypt this object.
  final EncryptionKeyType type;

  EncryptionKey({
    required this.id,
    required this.type,
  });
  factory EncryptionKey.fromJson(Map<String, dynamic> json) {
    return EncryptionKey(
      id: json['Id'] as String,
      type: (json['Type'] as String).toEncryptionKeyType(),
    );
  }

  Map<String, dynamic> toJson() {
    final id = this.id;
    final type = this.type;
    return {
      'Id': id,
      'Type': type.toValue(),
    };
  }
}

enum EncryptionKeyType {
  kms,
}

extension on EncryptionKeyType {
  String toValue() {
    switch (this) {
      case EncryptionKeyType.kms:
        return 'KMS';
    }
  }
}

extension on String {
  EncryptionKeyType toEncryptionKeyType() {
    switch (this) {
      case 'KMS':
        return EncryptionKeyType.kms;
    }
    throw Exception('$this is not known in enum EncryptionKeyType');
  }
}

enum Formality {
  formal,
  informal,
}

extension on Formality {
  String toValue() {
    switch (this) {
      case Formality.formal:
        return 'FORMAL';
      case Formality.informal:
        return 'INFORMAL';
    }
  }
}

extension on String {
  Formality toFormality() {
    switch (this) {
      case 'FORMAL':
        return Formality.formal;
      case 'INFORMAL':
        return Formality.informal;
    }
    throw Exception('$this is not known in enum Formality');
  }
}

class GetParallelDataResponse {
  /// The Amazon S3 location of a file that provides any errors or warnings that
  /// were produced by your input file. This file was created when Amazon
  /// Translate attempted to create a parallel data resource. The location is
  /// returned as a presigned URL to that has a 30-minute expiration.
  final ParallelDataDataLocation? auxiliaryDataLocation;

  /// The Amazon S3 location of the most recent parallel data input file that was
  /// successfully imported into Amazon Translate. The location is returned as a
  /// presigned URL that has a 30-minute expiration.
  /// <important>
  /// Amazon Translate doesn't scan all input files for the risk of CSV injection
  /// attacks.
  ///
  /// CSV injection occurs when a .csv or .tsv file is altered so that a record
  /// contains malicious code. The record begins with a special character, such as
  /// =, +, -, or @. When the file is opened in a spreadsheet program, the program
  /// might interpret the record as a formula and run the code within it.
  ///
  /// Before you download an input file from Amazon S3, ensure that you recognize
  /// the file and trust its creator.
  /// </important>
  final ParallelDataDataLocation? dataLocation;

  /// The Amazon S3 location of a file that provides any errors or warnings that
  /// were produced by your input file. This file was created when Amazon
  /// Translate attempted to update a parallel data resource. The location is
  /// returned as a presigned URL to that has a 30-minute expiration.
  final ParallelDataDataLocation? latestUpdateAttemptAuxiliaryDataLocation;

  /// The properties of the parallel data resource that is being retrieved.
  final ParallelDataProperties? parallelDataProperties;

  GetParallelDataResponse({
    this.auxiliaryDataLocation,
    this.dataLocation,
    this.latestUpdateAttemptAuxiliaryDataLocation,
    this.parallelDataProperties,
  });
  factory GetParallelDataResponse.fromJson(Map<String, dynamic> json) {
    return GetParallelDataResponse(
      auxiliaryDataLocation: json['AuxiliaryDataLocation'] != null
          ? ParallelDataDataLocation.fromJson(
              json['AuxiliaryDataLocation'] as Map<String, dynamic>)
          : null,
      dataLocation: json['DataLocation'] != null
          ? ParallelDataDataLocation.fromJson(
              json['DataLocation'] as Map<String, dynamic>)
          : null,
      latestUpdateAttemptAuxiliaryDataLocation:
          json['LatestUpdateAttemptAuxiliaryDataLocation'] != null
              ? ParallelDataDataLocation.fromJson(
                  json['LatestUpdateAttemptAuxiliaryDataLocation']
                      as Map<String, dynamic>)
              : null,
      parallelDataProperties: json['ParallelDataProperties'] != null
          ? ParallelDataProperties.fromJson(
              json['ParallelDataProperties'] as Map<String, dynamic>)
          : null,
    );
  }
}

class GetTerminologyResponse {
  /// The Amazon S3 location of a file that provides any errors or warnings that
  /// were produced by your input file. This file was created when Amazon
  /// Translate attempted to create a terminology resource. The location is
  /// returned as a presigned URL to that has a 30-minute expiration.
  final TerminologyDataLocation? auxiliaryDataLocation;

  /// The Amazon S3 location of the most recent custom terminology input file that
  /// was successfully imported into Amazon Translate. The location is returned as
  /// a presigned URL that has a 30-minute expiration.
  /// <important>
  /// Amazon Translate doesn't scan all input files for the risk of CSV injection
  /// attacks.
  ///
  /// CSV injection occurs when a .csv or .tsv file is altered so that a record
  /// contains malicious code. The record begins with a special character, such as
  /// =, +, -, or @. When the file is opened in a spreadsheet program, the program
  /// might interpret the record as a formula and run the code within it.
  ///
  /// Before you download an input file from Amazon S3, ensure that you recognize
  /// the file and trust its creator.
  /// </important>
  final TerminologyDataLocation? terminologyDataLocation;

  /// The properties of the custom terminology being retrieved.
  final TerminologyProperties? terminologyProperties;

  GetTerminologyResponse({
    this.auxiliaryDataLocation,
    this.terminologyDataLocation,
    this.terminologyProperties,
  });
  factory GetTerminologyResponse.fromJson(Map<String, dynamic> json) {
    return GetTerminologyResponse(
      auxiliaryDataLocation: json['AuxiliaryDataLocation'] != null
          ? TerminologyDataLocation.fromJson(
              json['AuxiliaryDataLocation'] as Map<String, dynamic>)
          : null,
      terminologyDataLocation: json['TerminologyDataLocation'] != null
          ? TerminologyDataLocation.fromJson(
              json['TerminologyDataLocation'] as Map<String, dynamic>)
          : null,
      terminologyProperties: json['TerminologyProperties'] != null
          ? TerminologyProperties.fromJson(
              json['TerminologyProperties'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ImportTerminologyResponse {
  /// The Amazon S3 location of a file that provides any errors or warnings that
  /// were produced by your input file. This file was created when Amazon
  /// Translate attempted to create a terminology resource. The location is
  /// returned as a presigned URL to that has a 30 minute expiration.
  final TerminologyDataLocation? auxiliaryDataLocation;

  /// The properties of the custom terminology being imported.
  final TerminologyProperties? terminologyProperties;

  ImportTerminologyResponse({
    this.auxiliaryDataLocation,
    this.terminologyProperties,
  });
  factory ImportTerminologyResponse.fromJson(Map<String, dynamic> json) {
    return ImportTerminologyResponse(
      auxiliaryDataLocation: json['AuxiliaryDataLocation'] != null
          ? TerminologyDataLocation.fromJson(
              json['AuxiliaryDataLocation'] as Map<String, dynamic>)
          : null,
      terminologyProperties: json['TerminologyProperties'] != null
          ? TerminologyProperties.fromJson(
              json['TerminologyProperties'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// The input configuration properties for requesting a batch translation job.
class InputDataConfig {
  /// Describes the format of the data that you submit to Amazon Translate as
  /// input. You can specify one of the following multipurpose internet mail
  /// extension (MIME) types:
  ///
  /// <ul>
  /// <li>
  /// <code>text/html</code>: The input data consists of one or more HTML files.
  /// Amazon Translate translates only the text that resides in the
  /// <code>html</code> element in each file.
  /// </li>
  /// <li>
  /// <code>text/plain</code>: The input data consists of one or more unformatted
  /// text files. Amazon Translate translates every character in this type of
  /// input.
  /// </li>
  /// <li>
  /// <code>application/vnd.openxmlformats-officedocument.wordprocessingml.document</code>:
  /// The input data consists of one or more Word documents (.docx).
  /// </li>
  /// <li>
  /// <code>application/vnd.openxmlformats-officedocument.presentationml.presentation</code>:
  /// The input data consists of one or more PowerPoint Presentation files
  /// (.pptx).
  /// </li>
  /// <li>
  /// <code>application/vnd.openxmlformats-officedocument.spreadsheetml.sheet</code>:
  /// The input data consists of one or more Excel Workbook files (.xlsx).
  /// </li>
  /// <li>
  /// <code>application/x-xliff+xml</code>: The input data consists of one or more
  /// XML Localization Interchange File Format (XLIFF) files (.xlf). Amazon
  /// Translate supports only XLIFF version 1.2.
  /// </li>
  /// </ul> <important>
  /// If you structure your input data as HTML, ensure that you set this parameter
  /// to <code>text/html</code>. By doing so, you cut costs by limiting the
  /// translation to the contents of the <code>html</code> element in each file.
  /// Otherwise, if you set this parameter to <code>text/plain</code>, your costs
  /// will cover the translation of every character.
  /// </important>
  final String contentType;

  /// The URI of the AWS S3 folder that contains the input files. Amazon Translate
  /// translates all the files in the folder. The folder must be in the same
  /// Region as the API endpoint you are calling.
  /// <note>
  /// The URI can also point to a single input document, or it can provide the
  /// prefix for a collection of input documents. For example. if you use the URI
  /// <code>S3://bucketName/prefix</code> and the prefix is a single file, Amazon
  /// Translate uses that files as input. If more than one file begins with the
  /// prefix, Amazon Translate uses all of them as input.
  /// </note>
  final String s3Uri;

  InputDataConfig({
    required this.contentType,
    required this.s3Uri,
  });
  factory InputDataConfig.fromJson(Map<String, dynamic> json) {
    return InputDataConfig(
      contentType: json['ContentType'] as String,
      s3Uri: json['S3Uri'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final contentType = this.contentType;
    final s3Uri = this.s3Uri;
    return {
      'ContentType': contentType,
      'S3Uri': s3Uri,
    };
  }
}

/// The number of documents successfully and unsuccessfully processed during a
/// translation job.
class JobDetails {
  /// The number of documents that could not be processed during a translation
  /// job.
  final int? documentsWithErrorsCount;

  /// The number of documents used as input in a translation job.
  final int? inputDocumentsCount;

  /// The number of documents successfully processed during a translation job.
  final int? translatedDocumentsCount;

  JobDetails({
    this.documentsWithErrorsCount,
    this.inputDocumentsCount,
    this.translatedDocumentsCount,
  });
  factory JobDetails.fromJson(Map<String, dynamic> json) {
    return JobDetails(
      documentsWithErrorsCount: json['DocumentsWithErrorsCount'] as int?,
      inputDocumentsCount: json['InputDocumentsCount'] as int?,
      translatedDocumentsCount: json['TranslatedDocumentsCount'] as int?,
    );
  }
}

enum JobStatus {
  submitted,
  inProgress,
  completed,
  completedWithError,
  failed,
  stopRequested,
  stopped,
}

extension on JobStatus {
  String toValue() {
    switch (this) {
      case JobStatus.submitted:
        return 'SUBMITTED';
      case JobStatus.inProgress:
        return 'IN_PROGRESS';
      case JobStatus.completed:
        return 'COMPLETED';
      case JobStatus.completedWithError:
        return 'COMPLETED_WITH_ERROR';
      case JobStatus.failed:
        return 'FAILED';
      case JobStatus.stopRequested:
        return 'STOP_REQUESTED';
      case JobStatus.stopped:
        return 'STOPPED';
    }
  }
}

extension on String {
  JobStatus toJobStatus() {
    switch (this) {
      case 'SUBMITTED':
        return JobStatus.submitted;
      case 'IN_PROGRESS':
        return JobStatus.inProgress;
      case 'COMPLETED':
        return JobStatus.completed;
      case 'COMPLETED_WITH_ERROR':
        return JobStatus.completedWithError;
      case 'FAILED':
        return JobStatus.failed;
      case 'STOP_REQUESTED':
        return JobStatus.stopRequested;
      case 'STOPPED':
        return JobStatus.stopped;
    }
    throw Exception('$this is not known in enum JobStatus');
  }
}

/// A supported language.
class Language {
  /// Language code for the supported language.
  final String languageCode;

  /// Language name of the supported language.
  final String languageName;

  Language({
    required this.languageCode,
    required this.languageName,
  });
  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      languageCode: json['LanguageCode'] as String,
      languageName: json['LanguageName'] as String,
    );
  }
}

class ListLanguagesResponse {
  /// The language code passed in with the request.
  final DisplayLanguageCode? displayLanguageCode;

  /// The list of supported languages.
  final List<Language>? languages;

  /// If the response does not include all remaining results, use the NextToken in
  /// the next request to fetch the next group of supported languages.
  final String? nextToken;

  ListLanguagesResponse({
    this.displayLanguageCode,
    this.languages,
    this.nextToken,
  });
  factory ListLanguagesResponse.fromJson(Map<String, dynamic> json) {
    return ListLanguagesResponse(
      displayLanguageCode:
          (json['DisplayLanguageCode'] as String?)?.toDisplayLanguageCode(),
      languages: (json['Languages'] as List?)
          ?.whereNotNull()
          .map((e) => Language.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class ListParallelDataResponse {
  /// The string to use in a subsequent request to get the next page of results in
  /// a paginated response. This value is null if there are no additional pages.
  final String? nextToken;

  /// The properties of the parallel data resources returned by this request.
  final List<ParallelDataProperties>? parallelDataPropertiesList;

  ListParallelDataResponse({
    this.nextToken,
    this.parallelDataPropertiesList,
  });
  factory ListParallelDataResponse.fromJson(Map<String, dynamic> json) {
    return ListParallelDataResponse(
      nextToken: json['NextToken'] as String?,
      parallelDataPropertiesList: (json['ParallelDataPropertiesList'] as List?)
          ?.whereNotNull()
          .map(
              (e) => ParallelDataProperties.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListTerminologiesResponse {
  /// If the response to the ListTerminologies was truncated, the NextToken
  /// fetches the next group of custom terminologies.
  final String? nextToken;

  /// The properties list of the custom terminologies returned on the list
  /// request.
  final List<TerminologyProperties>? terminologyPropertiesList;

  ListTerminologiesResponse({
    this.nextToken,
    this.terminologyPropertiesList,
  });
  factory ListTerminologiesResponse.fromJson(Map<String, dynamic> json) {
    return ListTerminologiesResponse(
      nextToken: json['NextToken'] as String?,
      terminologyPropertiesList: (json['TerminologyPropertiesList'] as List?)
          ?.whereNotNull()
          .map((e) => TerminologyProperties.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ListTextTranslationJobsResponse {
  /// The token to use to retrieve the next page of results. This value is
  /// <code>null</code> when there are no more results to return.
  final String? nextToken;

  /// A list containing the properties of each job that is returned.
  final List<TextTranslationJobProperties>? textTranslationJobPropertiesList;

  ListTextTranslationJobsResponse({
    this.nextToken,
    this.textTranslationJobPropertiesList,
  });
  factory ListTextTranslationJobsResponse.fromJson(Map<String, dynamic> json) {
    return ListTextTranslationJobsResponse(
      nextToken: json['NextToken'] as String?,
      textTranslationJobPropertiesList:
          (json['TextTranslationJobPropertiesList'] as List?)
              ?.whereNotNull()
              .map((e) => TextTranslationJobProperties.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
    );
  }
}

enum MergeStrategy {
  overwrite,
}

extension on MergeStrategy {
  String toValue() {
    switch (this) {
      case MergeStrategy.overwrite:
        return 'OVERWRITE';
    }
  }
}

extension on String {
  MergeStrategy toMergeStrategy() {
    switch (this) {
      case 'OVERWRITE':
        return MergeStrategy.overwrite;
    }
    throw Exception('$this is not known in enum MergeStrategy');
  }
}

/// The output configuration properties for a batch translation job.
class OutputDataConfig {
  /// The URI of the S3 folder that contains a translation job's output file. The
  /// folder must be in the same Region as the API endpoint that you are calling.
  final String s3Uri;
  final EncryptionKey? encryptionKey;

  OutputDataConfig({
    required this.s3Uri,
    this.encryptionKey,
  });
  factory OutputDataConfig.fromJson(Map<String, dynamic> json) {
    return OutputDataConfig(
      s3Uri: json['S3Uri'] as String,
      encryptionKey: json['EncryptionKey'] != null
          ? EncryptionKey.fromJson(
              json['EncryptionKey'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final s3Uri = this.s3Uri;
    final encryptionKey = this.encryptionKey;
    return {
      'S3Uri': s3Uri,
      if (encryptionKey != null) 'EncryptionKey': encryptionKey,
    };
  }
}

/// Specifies the format and S3 location of the parallel data input file.
class ParallelDataConfig {
  /// The format of the parallel data input file.
  final ParallelDataFormat format;

  /// The URI of the Amazon S3 folder that contains the parallel data input file.
  /// The folder must be in the same Region as the API endpoint you are calling.
  final String s3Uri;

  ParallelDataConfig({
    required this.format,
    required this.s3Uri,
  });
  factory ParallelDataConfig.fromJson(Map<String, dynamic> json) {
    return ParallelDataConfig(
      format: (json['Format'] as String).toParallelDataFormat(),
      s3Uri: json['S3Uri'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final format = this.format;
    final s3Uri = this.s3Uri;
    return {
      'Format': format.toValue(),
      'S3Uri': s3Uri,
    };
  }
}

/// The location of the most recent parallel data input file that was
/// successfully imported into Amazon Translate.
class ParallelDataDataLocation {
  /// The Amazon S3 location of the parallel data input file. The location is
  /// returned as a presigned URL to that has a 30-minute expiration.
  /// <important>
  /// Amazon Translate doesn't scan all input files for the risk of CSV injection
  /// attacks.
  ///
  /// CSV injection occurs when a .csv or .tsv file is altered so that a record
  /// contains malicious code. The record begins with a special character, such as
  /// =, +, -, or @. When the file is opened in a spreadsheet program, the program
  /// might interpret the record as a formula and run the code within it.
  ///
  /// Before you download an input file from Amazon S3, ensure that you recognize
  /// the file and trust its creator.
  /// </important>
  final String location;

  /// Describes the repository that contains the parallel data input file.
  final String repositoryType;

  ParallelDataDataLocation({
    required this.location,
    required this.repositoryType,
  });
  factory ParallelDataDataLocation.fromJson(Map<String, dynamic> json) {
    return ParallelDataDataLocation(
      location: json['Location'] as String,
      repositoryType: json['RepositoryType'] as String,
    );
  }
}

enum ParallelDataFormat {
  tsv,
  csv,
  tmx,
}

extension on ParallelDataFormat {
  String toValue() {
    switch (this) {
      case ParallelDataFormat.tsv:
        return 'TSV';
      case ParallelDataFormat.csv:
        return 'CSV';
      case ParallelDataFormat.tmx:
        return 'TMX';
    }
  }
}

extension on String {
  ParallelDataFormat toParallelDataFormat() {
    switch (this) {
      case 'TSV':
        return ParallelDataFormat.tsv;
      case 'CSV':
        return ParallelDataFormat.csv;
      case 'TMX':
        return ParallelDataFormat.tmx;
    }
    throw Exception('$this is not known in enum ParallelDataFormat');
  }
}

/// The properties of a parallel data resource.
class ParallelDataProperties {
  /// The Amazon Resource Name (ARN) of the parallel data resource.
  final String? arn;

  /// The time at which the parallel data resource was created.
  final DateTime? createdAt;

  /// The description assigned to the parallel data resource.
  final String? description;
  final EncryptionKey? encryptionKey;

  /// The number of records unsuccessfully imported from the parallel data input
  /// file.
  final int? failedRecordCount;

  /// The number of UTF-8 characters that Amazon Translate imported from the
  /// parallel data input file. This number includes only the characters in your
  /// translation examples. It does not include characters that are used to format
  /// your file. For example, if you provided a Translation Memory Exchange (.tmx)
  /// file, this number does not include the tags.
  final int? importedDataSize;

  /// The number of records successfully imported from the parallel data input
  /// file.
  final int? importedRecordCount;

  /// The time at which the parallel data resource was last updated.
  final DateTime? lastUpdatedAt;

  /// The time that the most recent update was attempted.
  final DateTime? latestUpdateAttemptAt;

  /// The status of the most recent update attempt for the parallel data resource.
  final ParallelDataStatus? latestUpdateAttemptStatus;

  /// Additional information from Amazon Translate about the parallel data
  /// resource.
  final String? message;

  /// The custom name assigned to the parallel data resource.
  final String? name;

  /// Specifies the format and S3 location of the parallel data input file.
  final ParallelDataConfig? parallelDataConfig;

  /// The number of items in the input file that Amazon Translate skipped when you
  /// created or updated the parallel data resource. For example, Amazon Translate
  /// skips empty records, empty target texts, and empty lines.
  final int? skippedRecordCount;

  /// The source language of the translations in the parallel data file.
  final String? sourceLanguageCode;

  /// The status of the parallel data resource. When the parallel data is ready
  /// for you to use, the status is <code>ACTIVE</code>.
  final ParallelDataStatus? status;

  /// The language codes for the target languages available in the parallel data
  /// file. All possible target languages are returned as an array.
  final List<String>? targetLanguageCodes;

  ParallelDataProperties({
    this.arn,
    this.createdAt,
    this.description,
    this.encryptionKey,
    this.failedRecordCount,
    this.importedDataSize,
    this.importedRecordCount,
    this.lastUpdatedAt,
    this.latestUpdateAttemptAt,
    this.latestUpdateAttemptStatus,
    this.message,
    this.name,
    this.parallelDataConfig,
    this.skippedRecordCount,
    this.sourceLanguageCode,
    this.status,
    this.targetLanguageCodes,
  });
  factory ParallelDataProperties.fromJson(Map<String, dynamic> json) {
    return ParallelDataProperties(
      arn: json['Arn'] as String?,
      createdAt: timeStampFromJson(json['CreatedAt']),
      description: json['Description'] as String?,
      encryptionKey: json['EncryptionKey'] != null
          ? EncryptionKey.fromJson(
              json['EncryptionKey'] as Map<String, dynamic>)
          : null,
      failedRecordCount: json['FailedRecordCount'] as int?,
      importedDataSize: json['ImportedDataSize'] as int?,
      importedRecordCount: json['ImportedRecordCount'] as int?,
      lastUpdatedAt: timeStampFromJson(json['LastUpdatedAt']),
      latestUpdateAttemptAt: timeStampFromJson(json['LatestUpdateAttemptAt']),
      latestUpdateAttemptStatus: (json['LatestUpdateAttemptStatus'] as String?)
          ?.toParallelDataStatus(),
      message: json['Message'] as String?,
      name: json['Name'] as String?,
      parallelDataConfig: json['ParallelDataConfig'] != null
          ? ParallelDataConfig.fromJson(
              json['ParallelDataConfig'] as Map<String, dynamic>)
          : null,
      skippedRecordCount: json['SkippedRecordCount'] as int?,
      sourceLanguageCode: json['SourceLanguageCode'] as String?,
      status: (json['Status'] as String?)?.toParallelDataStatus(),
      targetLanguageCodes: (json['TargetLanguageCodes'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }
}

enum ParallelDataStatus {
  creating,
  updating,
  active,
  deleting,
  failed,
}

extension on ParallelDataStatus {
  String toValue() {
    switch (this) {
      case ParallelDataStatus.creating:
        return 'CREATING';
      case ParallelDataStatus.updating:
        return 'UPDATING';
      case ParallelDataStatus.active:
        return 'ACTIVE';
      case ParallelDataStatus.deleting:
        return 'DELETING';
      case ParallelDataStatus.failed:
        return 'FAILED';
    }
  }
}

extension on String {
  ParallelDataStatus toParallelDataStatus() {
    switch (this) {
      case 'CREATING':
        return ParallelDataStatus.creating;
      case 'UPDATING':
        return ParallelDataStatus.updating;
      case 'ACTIVE':
        return ParallelDataStatus.active;
      case 'DELETING':
        return ParallelDataStatus.deleting;
      case 'FAILED':
        return ParallelDataStatus.failed;
    }
    throw Exception('$this is not known in enum ParallelDataStatus');
  }
}

enum Profanity {
  mask,
}

extension on Profanity {
  String toValue() {
    switch (this) {
      case Profanity.mask:
        return 'MASK';
    }
  }
}

extension on String {
  Profanity toProfanity() {
    switch (this) {
      case 'MASK':
        return Profanity.mask;
    }
    throw Exception('$this is not known in enum Profanity');
  }
}

class StartTextTranslationJobResponse {
  /// The identifier generated for the job. To get the status of a job, use this
  /// ID with the <a>DescribeTextTranslationJob</a> operation.
  final String? jobId;

  /// The status of the job. Possible values include:
  ///
  /// <ul>
  /// <li>
  /// <code>SUBMITTED</code> - The job has been received and is queued for
  /// processing.
  /// </li>
  /// <li>
  /// <code>IN_PROGRESS</code> - Amazon Translate is processing the job.
  /// </li>
  /// <li>
  /// <code>COMPLETED</code> - The job was successfully completed and the output
  /// is available.
  /// </li>
  /// <li>
  /// <code>COMPLETED_WITH_ERROR</code> - The job was completed with errors. The
  /// errors can be analyzed in the job's output.
  /// </li>
  /// <li>
  /// <code>FAILED</code> - The job did not complete. To get details, use the
  /// <a>DescribeTextTranslationJob</a> operation.
  /// </li>
  /// <li>
  /// <code>STOP_REQUESTED</code> - The user who started the job has requested
  /// that it be stopped.
  /// </li>
  /// <li>
  /// <code>STOPPED</code> - The job has been stopped.
  /// </li>
  /// </ul>
  final JobStatus? jobStatus;

  StartTextTranslationJobResponse({
    this.jobId,
    this.jobStatus,
  });
  factory StartTextTranslationJobResponse.fromJson(Map<String, dynamic> json) {
    return StartTextTranslationJobResponse(
      jobId: json['JobId'] as String?,
      jobStatus: (json['JobStatus'] as String?)?.toJobStatus(),
    );
  }
}

class StopTextTranslationJobResponse {
  /// The job ID of the stopped batch translation job.
  final String? jobId;

  /// The status of the designated job. Upon successful completion, the job's
  /// status will be <code>STOPPED</code>.
  final JobStatus? jobStatus;

  StopTextTranslationJobResponse({
    this.jobId,
    this.jobStatus,
  });
  factory StopTextTranslationJobResponse.fromJson(Map<String, dynamic> json) {
    return StopTextTranslationJobResponse(
      jobId: json['JobId'] as String?,
      jobStatus: (json['JobStatus'] as String?)?.toJobStatus(),
    );
  }
}

/// The term being translated by the custom terminology.
class Term {
  /// The source text of the term being translated by the custom terminology.
  final String? sourceText;

  /// The target text of the term being translated by the custom terminology.
  final String? targetText;

  Term({
    this.sourceText,
    this.targetText,
  });
  factory Term.fromJson(Map<String, dynamic> json) {
    return Term(
      sourceText: json['SourceText'] as String?,
      targetText: json['TargetText'] as String?,
    );
  }
}

/// The data associated with the custom terminology. For information about the
/// custom terminology file, see <a
/// href="https://docs.aws.amazon.com/translate/latest/dg/creating-custom-terminology.html">
/// Creating a Custom Terminology</a>.
class TerminologyData {
  /// The file containing the custom terminology data. Your version of the AWS SDK
  /// performs a Base64-encoding on this field before sending a request to the AWS
  /// service. Users of the SDK should not perform Base64-encoding themselves.
  final Uint8List file;

  /// The data format of the custom terminology.
  final TerminologyDataFormat format;

  /// The directionality of your terminology resource indicates whether it has one
  /// source language (uni-directional) or multiple (multi-directional).
  /// <dl> <dt>UNI</dt> <dd>
  /// The terminology resource has one source language (for example, the first
  /// column in a CSV file), and all of its other languages are target languages.
  /// </dd> <dt>MULTI</dt> <dd>
  /// Any language in the terminology resource can be the source language or a
  /// target language. A single multi-directional terminology resource can be used
  /// for jobs that translate different language pairs. For example, if the
  /// terminology contains English and Spanish terms, it can be used for jobs that
  /// translate English to Spanish and Spanish to English.
  /// </dd> </dl>
  /// When you create a custom terminology resource without specifying the
  /// directionality, it behaves as uni-directional terminology, although this
  /// parameter will have a null value.
  final Directionality? directionality;

  TerminologyData({
    required this.file,
    required this.format,
    this.directionality,
  });
  Map<String, dynamic> toJson() {
    final file = this.file;
    final format = this.format;
    final directionality = this.directionality;
    return {
      'File': base64Encode(file),
      'Format': format.toValue(),
      if (directionality != null) 'Directionality': directionality.toValue(),
    };
  }
}

enum TerminologyDataFormat {
  csv,
  tmx,
  tsv,
}

extension on TerminologyDataFormat {
  String toValue() {
    switch (this) {
      case TerminologyDataFormat.csv:
        return 'CSV';
      case TerminologyDataFormat.tmx:
        return 'TMX';
      case TerminologyDataFormat.tsv:
        return 'TSV';
    }
  }
}

extension on String {
  TerminologyDataFormat toTerminologyDataFormat() {
    switch (this) {
      case 'CSV':
        return TerminologyDataFormat.csv;
      case 'TMX':
        return TerminologyDataFormat.tmx;
      case 'TSV':
        return TerminologyDataFormat.tsv;
    }
    throw Exception('$this is not known in enum TerminologyDataFormat');
  }
}

/// The location of the custom terminology data.
class TerminologyDataLocation {
  /// The Amazon S3 location of the most recent custom terminology input file that
  /// was successfully imported into Amazon Translate. The location is returned as
  /// a presigned URL that has a 30-minute expiration .
  /// <important>
  /// Amazon Translate doesn't scan all input files for the risk of CSV injection
  /// attacks.
  ///
  /// CSV injection occurs when a .csv or .tsv file is altered so that a record
  /// contains malicious code. The record begins with a special character, such as
  /// =, +, -, or @. When the file is opened in a spreadsheet program, the program
  /// might interpret the record as a formula and run the code within it.
  ///
  /// Before you download an input file from Amazon S3, ensure that you recognize
  /// the file and trust its creator.
  /// </important>
  final String location;

  /// The repository type for the custom terminology data.
  final String repositoryType;

  TerminologyDataLocation({
    required this.location,
    required this.repositoryType,
  });
  factory TerminologyDataLocation.fromJson(Map<String, dynamic> json) {
    return TerminologyDataLocation(
      location: json['Location'] as String,
      repositoryType: json['RepositoryType'] as String,
    );
  }
}

/// The properties of the custom terminology.
class TerminologyProperties {
  /// The Amazon Resource Name (ARN) of the custom terminology.
  final String? arn;

  /// The time at which the custom terminology was created, based on the
  /// timestamp.
  final DateTime? createdAt;

  /// The description of the custom terminology properties.
  final String? description;

  /// The directionality of your terminology resource indicates whether it has one
  /// source language (uni-directional) or multiple (multi-directional).
  /// <dl> <dt>UNI</dt> <dd>
  /// The terminology resource has one source language (the first column in a CSV
  /// file), and all of its other languages are target languages.
  /// </dd> <dt>MULTI</dt> <dd>
  /// Any language in the terminology resource can be the source language.
  /// </dd> </dl>
  final Directionality? directionality;

  /// The encryption key for the custom terminology.
  final EncryptionKey? encryptionKey;

  /// The format of the custom terminology input file.
  final TerminologyDataFormat? format;

  /// The time at which the custom terminology was last update, based on the
  /// timestamp.
  final DateTime? lastUpdatedAt;

  /// Additional information from Amazon Translate about the terminology resource.
  final String? message;

  /// The name of the custom terminology.
  final String? name;

  /// The size of the file used when importing a custom terminology.
  final int? sizeBytes;

  /// The number of terms in the input file that Amazon Translate skipped when you
  /// created or updated the terminology resource.
  final int? skippedTermCount;

  /// The language code for the source text of the translation request for which
  /// the custom terminology is being used.
  final String? sourceLanguageCode;

  /// The language codes for the target languages available with the custom
  /// terminology resource. All possible target languages are returned in array.
  final List<String>? targetLanguageCodes;

  /// The number of terms included in the custom terminology.
  final int? termCount;

  TerminologyProperties({
    this.arn,
    this.createdAt,
    this.description,
    this.directionality,
    this.encryptionKey,
    this.format,
    this.lastUpdatedAt,
    this.message,
    this.name,
    this.sizeBytes,
    this.skippedTermCount,
    this.sourceLanguageCode,
    this.targetLanguageCodes,
    this.termCount,
  });
  factory TerminologyProperties.fromJson(Map<String, dynamic> json) {
    return TerminologyProperties(
      arn: json['Arn'] as String?,
      createdAt: timeStampFromJson(json['CreatedAt']),
      description: json['Description'] as String?,
      directionality: (json['Directionality'] as String?)?.toDirectionality(),
      encryptionKey: json['EncryptionKey'] != null
          ? EncryptionKey.fromJson(
              json['EncryptionKey'] as Map<String, dynamic>)
          : null,
      format: (json['Format'] as String?)?.toTerminologyDataFormat(),
      lastUpdatedAt: timeStampFromJson(json['LastUpdatedAt']),
      message: json['Message'] as String?,
      name: json['Name'] as String?,
      sizeBytes: json['SizeBytes'] as int?,
      skippedTermCount: json['SkippedTermCount'] as int?,
      sourceLanguageCode: json['SourceLanguageCode'] as String?,
      targetLanguageCodes: (json['TargetLanguageCodes'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      termCount: json['TermCount'] as int?,
    );
  }
}

/// Provides information for filtering a list of translation jobs. For more
/// information, see <a>ListTextTranslationJobs</a>.
class TextTranslationJobFilter {
  /// Filters the list of jobs by name.
  final String? jobName;

  /// Filters the list of jobs based by job status.
  final JobStatus? jobStatus;

  /// Filters the list of jobs based on the time that the job was submitted for
  /// processing and returns only the jobs submitted after the specified time.
  /// Jobs are returned in descending order, newest to oldest.
  final DateTime? submittedAfterTime;

  /// Filters the list of jobs based on the time that the job was submitted for
  /// processing and returns only the jobs submitted before the specified time.
  /// Jobs are returned in ascending order, oldest to newest.
  final DateTime? submittedBeforeTime;

  TextTranslationJobFilter({
    this.jobName,
    this.jobStatus,
    this.submittedAfterTime,
    this.submittedBeforeTime,
  });
  Map<String, dynamic> toJson() {
    final jobName = this.jobName;
    final jobStatus = this.jobStatus;
    final submittedAfterTime = this.submittedAfterTime;
    final submittedBeforeTime = this.submittedBeforeTime;
    return {
      if (jobName != null) 'JobName': jobName,
      if (jobStatus != null) 'JobStatus': jobStatus.toValue(),
      if (submittedAfterTime != null)
        'SubmittedAfterTime': unixTimestampToJson(submittedAfterTime),
      if (submittedBeforeTime != null)
        'SubmittedBeforeTime': unixTimestampToJson(submittedBeforeTime),
    };
  }
}

/// Provides information about a translation job.
class TextTranslationJobProperties {
  /// The Amazon Resource Name (ARN) of an AWS Identity Access and Management
  /// (IAM) role that granted Amazon Translate read access to the job's input
  /// data.
  final String? dataAccessRoleArn;

  /// The time at which the translation job ended.
  final DateTime? endTime;

  /// The input configuration properties that were specified when the job was
  /// requested.
  final InputDataConfig? inputDataConfig;

  /// The number of documents successfully and unsuccessfully processed during the
  /// translation job.
  final JobDetails? jobDetails;

  /// The ID of the translation job.
  final String? jobId;

  /// The user-defined name of the translation job.
  final String? jobName;

  /// The status of the translation job.
  final JobStatus? jobStatus;

  /// An explanation of any errors that may have occurred during the translation
  /// job.
  final String? message;

  /// The output configuration properties that were specified when the job was
  /// requested.
  final OutputDataConfig? outputDataConfig;

  /// A list containing the names of the parallel data resources applied to the
  /// translation job.
  final List<String>? parallelDataNames;

  /// Settings that configure the translation output.
  final TranslationSettings? settings;

  /// The language code of the language of the source text. The language must be a
  /// language supported by Amazon Translate.
  final String? sourceLanguageCode;

  /// The time at which the translation job was submitted.
  final DateTime? submittedTime;

  /// The language code of the language of the target text. The language must be a
  /// language supported by Amazon Translate.
  final List<String>? targetLanguageCodes;

  /// A list containing the names of the terminologies applied to a translation
  /// job. Only one terminology can be applied per <a>StartTextTranslationJob</a>
  /// request at this time.
  final List<String>? terminologyNames;

  TextTranslationJobProperties({
    this.dataAccessRoleArn,
    this.endTime,
    this.inputDataConfig,
    this.jobDetails,
    this.jobId,
    this.jobName,
    this.jobStatus,
    this.message,
    this.outputDataConfig,
    this.parallelDataNames,
    this.settings,
    this.sourceLanguageCode,
    this.submittedTime,
    this.targetLanguageCodes,
    this.terminologyNames,
  });
  factory TextTranslationJobProperties.fromJson(Map<String, dynamic> json) {
    return TextTranslationJobProperties(
      dataAccessRoleArn: json['DataAccessRoleArn'] as String?,
      endTime: timeStampFromJson(json['EndTime']),
      inputDataConfig: json['InputDataConfig'] != null
          ? InputDataConfig.fromJson(
              json['InputDataConfig'] as Map<String, dynamic>)
          : null,
      jobDetails: json['JobDetails'] != null
          ? JobDetails.fromJson(json['JobDetails'] as Map<String, dynamic>)
          : null,
      jobId: json['JobId'] as String?,
      jobName: json['JobName'] as String?,
      jobStatus: (json['JobStatus'] as String?)?.toJobStatus(),
      message: json['Message'] as String?,
      outputDataConfig: json['OutputDataConfig'] != null
          ? OutputDataConfig.fromJson(
              json['OutputDataConfig'] as Map<String, dynamic>)
          : null,
      parallelDataNames: (json['ParallelDataNames'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      settings: json['Settings'] != null
          ? TranslationSettings.fromJson(
              json['Settings'] as Map<String, dynamic>)
          : null,
      sourceLanguageCode: json['SourceLanguageCode'] as String?,
      submittedTime: timeStampFromJson(json['SubmittedTime']),
      targetLanguageCodes: (json['TargetLanguageCodes'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      terminologyNames: (json['TerminologyNames'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
    );
  }
}

class TranslateTextResponse {
  /// The language code for the language of the source text.
  final String sourceLanguageCode;

  /// The language code for the language of the target text.
  final String targetLanguageCode;

  /// The translated text.
  final String translatedText;

  /// Settings that configure the translation output.
  final TranslationSettings? appliedSettings;

  /// The names of the custom terminologies applied to the input text by Amazon
  /// Translate for the translated text response.
  final List<AppliedTerminology>? appliedTerminologies;

  TranslateTextResponse({
    required this.sourceLanguageCode,
    required this.targetLanguageCode,
    required this.translatedText,
    this.appliedSettings,
    this.appliedTerminologies,
  });
  factory TranslateTextResponse.fromJson(Map<String, dynamic> json) {
    return TranslateTextResponse(
      sourceLanguageCode: json['SourceLanguageCode'] as String,
      targetLanguageCode: json['TargetLanguageCode'] as String,
      translatedText: json['TranslatedText'] as String,
      appliedSettings: json['AppliedSettings'] != null
          ? TranslationSettings.fromJson(
              json['AppliedSettings'] as Map<String, dynamic>)
          : null,
      appliedTerminologies: (json['AppliedTerminologies'] as List?)
          ?.whereNotNull()
          .map((e) => AppliedTerminology.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Settings that configure the translation output.
class TranslationSettings {
  /// You can optionally specify the desired level of formality for real-time
  /// translations to supported target languages. The formality setting controls
  /// the level of formal language usage (also known as <a
  /// href="https://en.wikipedia.org/wiki/Register_(sociolinguistics)">register</a>)
  /// in the translation output. You can set the value to informal or formal. If
  /// you don't specify a value for formality, or if the target language doesn't
  /// support formality, the translation will ignore the formality setting.
  ///
  /// Note that asynchronous translation jobs don't support formality. If you
  /// provide a value for formality, the <code>StartTextTranslationJob</code> API
  /// throws an exception (InvalidRequestException).
  ///
  /// For target languages that support formality, see <a
  /// href="https://docs.aws.amazon.com/translate/latest/dg/what-is.html">Supported
  /// Languages and Language Codes in the Amazon Translate Developer Guide</a>.
  final Formality? formality;

  /// Enable the profanity setting if you want Amazon Translate to mask profane
  /// words and phrases in your translation output.
  ///
  /// To mask profane words and phrases, Amazon Translate replaces them with the
  /// grawlix string “?$#@$“. This 5-character sequence is used for each profane
  /// word or phrase, regardless of the length or number of words.
  ///
  /// Amazon Translate doesn't detect profanity in all of its supported languages.
  /// For languages that support profanity detection, see <a
  /// href="https://docs.aws.amazon.com/translate/latest/dg/what-is.html">Supported
  /// Languages and Language Codes in the Amazon Translate Developer Guide</a>.
  final Profanity? profanity;

  TranslationSettings({
    this.formality,
    this.profanity,
  });
  factory TranslationSettings.fromJson(Map<String, dynamic> json) {
    return TranslationSettings(
      formality: (json['Formality'] as String?)?.toFormality(),
      profanity: (json['Profanity'] as String?)?.toProfanity(),
    );
  }

  Map<String, dynamic> toJson() {
    final formality = this.formality;
    final profanity = this.profanity;
    return {
      if (formality != null) 'Formality': formality.toValue(),
      if (profanity != null) 'Profanity': profanity.toValue(),
    };
  }
}

class UpdateParallelDataResponse {
  /// The time that the most recent update was attempted.
  final DateTime? latestUpdateAttemptAt;

  /// The status of the parallel data update attempt. When the updated parallel
  /// data resource is ready for you to use, the status is <code>ACTIVE</code>.
  final ParallelDataStatus? latestUpdateAttemptStatus;

  /// The name of the parallel data resource being updated.
  final String? name;

  /// The status of the parallel data resource that you are attempting to update.
  /// Your update request is accepted only if this status is either
  /// <code>ACTIVE</code> or <code>FAILED</code>.
  final ParallelDataStatus? status;

  UpdateParallelDataResponse({
    this.latestUpdateAttemptAt,
    this.latestUpdateAttemptStatus,
    this.name,
    this.status,
  });
  factory UpdateParallelDataResponse.fromJson(Map<String, dynamic> json) {
    return UpdateParallelDataResponse(
      latestUpdateAttemptAt: timeStampFromJson(json['LatestUpdateAttemptAt']),
      latestUpdateAttemptStatus: (json['LatestUpdateAttemptStatus'] as String?)
          ?.toParallelDataStatus(),
      name: json['Name'] as String?,
      status: (json['Status'] as String?)?.toParallelDataStatus(),
    );
  }
}

class ConcurrentModificationException extends _s.GenericAwsException {
  ConcurrentModificationException({String? type, String? message})
      : super(
            type: type,
            code: 'ConcurrentModificationException',
            message: message);
}

class ConflictException extends _s.GenericAwsException {
  ConflictException({String? type, String? message})
      : super(type: type, code: 'ConflictException', message: message);
}

class DetectedLanguageLowConfidenceException extends _s.GenericAwsException {
  DetectedLanguageLowConfidenceException({String? type, String? message})
      : super(
            type: type,
            code: 'DetectedLanguageLowConfidenceException',
            message: message);
}

class InternalServerException extends _s.GenericAwsException {
  InternalServerException({String? type, String? message})
      : super(type: type, code: 'InternalServerException', message: message);
}

class InvalidFilterException extends _s.GenericAwsException {
  InvalidFilterException({String? type, String? message})
      : super(type: type, code: 'InvalidFilterException', message: message);
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

class LimitExceededException extends _s.GenericAwsException {
  LimitExceededException({String? type, String? message})
      : super(type: type, code: 'LimitExceededException', message: message);
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

class TextSizeLimitExceededException extends _s.GenericAwsException {
  TextSizeLimitExceededException({String? type, String? message})
      : super(
            type: type,
            code: 'TextSizeLimitExceededException',
            message: message);
}

class TooManyRequestsException extends _s.GenericAwsException {
  TooManyRequestsException({String? type, String? message})
      : super(type: type, code: 'TooManyRequestsException', message: message);
}

class UnsupportedDisplayLanguageCodeException extends _s.GenericAwsException {
  UnsupportedDisplayLanguageCodeException({String? type, String? message})
      : super(
            type: type,
            code: 'UnsupportedDisplayLanguageCodeException',
            message: message);
}

class UnsupportedLanguagePairException extends _s.GenericAwsException {
  UnsupportedLanguagePairException({String? type, String? message})
      : super(
            type: type,
            code: 'UnsupportedLanguagePairException',
            message: message);
}

final _exceptionFns = <String, _s.AwsExceptionFn>{
  'ConcurrentModificationException': (type, message) =>
      ConcurrentModificationException(type: type, message: message),
  'ConflictException': (type, message) =>
      ConflictException(type: type, message: message),
  'DetectedLanguageLowConfidenceException': (type, message) =>
      DetectedLanguageLowConfidenceException(type: type, message: message),
  'InternalServerException': (type, message) =>
      InternalServerException(type: type, message: message),
  'InvalidFilterException': (type, message) =>
      InvalidFilterException(type: type, message: message),
  'InvalidParameterValueException': (type, message) =>
      InvalidParameterValueException(type: type, message: message),
  'InvalidRequestException': (type, message) =>
      InvalidRequestException(type: type, message: message),
  'LimitExceededException': (type, message) =>
      LimitExceededException(type: type, message: message),
  'ResourceNotFoundException': (type, message) =>
      ResourceNotFoundException(type: type, message: message),
  'ServiceUnavailableException': (type, message) =>
      ServiceUnavailableException(type: type, message: message),
  'TextSizeLimitExceededException': (type, message) =>
      TextSizeLimitExceededException(type: type, message: message),
  'TooManyRequestsException': (type, message) =>
      TooManyRequestsException(type: type, message: message),
  'UnsupportedDisplayLanguageCodeException': (type, message) =>
      UnsupportedDisplayLanguageCodeException(type: type, message: message),
  'UnsupportedLanguagePairException': (type, message) =>
      UnsupportedLanguagePairException(type: type, message: message),
};
