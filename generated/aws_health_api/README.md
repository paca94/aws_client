# AWS API client for AWS Health APIs and Notifications

**Generated Dart library from API specification**

*About the service:*
The Health API provides programmatic access to the Health information that
appears in the <a href="https://phd.aws.amazon.com/phd/home#/">Personal
Health Dashboard</a>. You can use the API operations to get information
about events that might affect your Amazon Web Services services and
resources.
<note>
<ul>
<li>
You must have a Business, Enterprise On-Ramp, or Enterprise Support plan
from <a href="https://aws.amazon.com/premiumsupport/">Amazon Web Services
Support</a> to use the Health API. If you call the Health API from an Amazon
Web Services account that doesn't have a Business, Enterprise On-Ramp, or
Enterprise Support plan, you receive a
<code>SubscriptionRequiredException</code> error.
</li>
<li>
You can use the Health endpoint health.us-east-1.amazonaws.com (HTTPS) to
call the Health API operations. Health supports a multi-Region application
architecture and has two regional endpoints in an active-passive
configuration. You can use the high availability endpoint example to
determine which Amazon Web Services Region is active, so that you can get
the latest information from the API. For more information, see <a
href="https://docs.aws.amazon.com/health/latest/ug/health-api.html">Accessing
the Health API</a> in the <i>Health User Guide</i>.
</li>
</ul> </note>
For authentication of requests, Health uses the <a
href="https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html">Signature
Version 4 Signing Process</a>.

## Links

- [Other AWS libraries](https://github.com/agilord/aws_client/tree/master/generated).
- [Issue tracker](https://github.com/agilord/aws_client/issues).
- [AWS API definitions](https://github.com/aws/aws-sdk-js/tree/master/apis).
