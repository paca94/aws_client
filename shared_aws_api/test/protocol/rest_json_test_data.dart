// ignore_for_file: prefer_single_quotes
const List<Map<String, dynamic>> testSuites = [
  {
    "description": "No parameters",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": <String, String>{},
    "cases": [
      {
        "given": {
          "http": {"method": "GET", "requestUri": "/2014-01-01/jobs"},
          "name": "OperationName"
        },
        "serialized": {"body": "", "uri": "/2014-01-01/jobs", "headers": {}}
      }
    ]
  },
  {
    "description": "URI parameter only with no location name",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "PipelineId": {"shape": "StringType", "location": "uri"}
        }
      },
      "StringType": {"type": "string"}
    },
    "cases": [
      {
        "given": {
          "http": {
            "method": "GET",
            "requestUri": "/2014-01-01/jobsByPipeline/{PipelineId}"
          },
          "input": {"shape": "InputShape"},
          "name": "OperationName"
        },
        "params": {"PipelineId": "foo"},
        "serialized": {
          "body": "",
          "uri": "/2014-01-01/jobsByPipeline/foo",
          "headers": {}
        }
      }
    ]
  },
  {
    "description": "URI parameter only with location name",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "Foo": {
            "shape": "StringType",
            "location": "uri",
            "locationName": "PipelineId"
          }
        }
      },
      "StringType": {"type": "string"}
    },
    "cases": [
      {
        "given": {
          "http": {
            "method": "GET",
            "requestUri": "/2014-01-01/jobsByPipeline/{PipelineId}"
          },
          "input": {"shape": "InputShape"},
          "name": "OperationName"
        },
        "params": {"Foo": "bar"},
        "serialized": {
          "body": "",
          "uri": "/2014-01-01/jobsByPipeline/bar",
          "headers": {}
        }
      }
    ]
  },
  {
    "description": "Querystring list of strings",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "Items": {
            "shape": "StringList",
            "location": "querystring",
            "locationName": "item"
          }
        }
      },
      "StringList": {
        "type": "list",
        "member": {"shape": "String"}
      },
      "String": {"type": "string"}
    },
    "cases": [
      {
        "given": {
          "http": {"method": "GET", "requestUri": "/path"},
          "input": {"shape": "InputShape"},
          "name": "OperationName"
        },
        "params": {
          "Items": ["value1", "value2"]
        },
        "serialized": {
          "body": "",
          "uri": "/path?item=value1&item=value2",
          "headers": {}
        }
      }
    ]
  },
  {
    "description": "String to string maps in querystring",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "PipelineId": {"shape": "StringType", "location": "uri"},
          "QueryDoc": {
            "shape": "MapStringStringType",
            "location": "querystring"
          }
        }
      },
      "MapStringStringType": {
        "type": "map",
        "key": {"shape": "StringType"},
        "value": {"shape": "StringType"}
      },
      "StringType": {"type": "string"}
    },
    "cases": [
      {
        "given": {
          "http": {
            "method": "GET",
            "requestUri": "/2014-01-01/jobsByPipeline/{PipelineId}"
          },
          "input": {"shape": "InputShape"},
          "name": "OperationName"
        },
        "params": {
          "PipelineId": "foo",
          "QueryDoc": {"bar": "baz", "fizz": "buzz"}
        },
        "serialized": {
          "body": "",
          "uri": "/2014-01-01/jobsByPipeline/foo?bar=baz&fizz=buzz",
          "headers": {}
        }
      }
    ]
  },
  {
    "description": "String to string list maps in querystring",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "PipelineId": {"shape": "StringType", "location": "uri"},
          "QueryDoc": {
            "shape": "MapStringStringListType",
            "location": "querystring"
          }
        }
      },
      "MapStringStringListType": {
        "type": "map",
        "key": {"shape": "StringType"},
        "value": {"shape": "StringListType"}
      },
      "StringListType": {
        "type": "list",
        "member": {"shape": "StringType"}
      },
      "StringType": {"type": "string"}
    },
    "cases": [
      {
        "given": {
          "http": {
            "method": "GET",
            "requestUri": "/2014-01-01/jobsByPipeline/{PipelineId}"
          },
          "input": {"shape": "InputShape"},
          "name": "OperationName"
        },
        "params": {
          "PipelineId": "id",
          "QueryDoc": {
            "foo": ["bar", "baz"],
            "fizz": ["buzz", "pop"]
          }
        },
        "serialized": {
          "body": "",
          "uri":
              "/2014-01-01/jobsByPipeline/id?foo=bar&foo=baz&fizz=buzz&fizz=pop",
          "headers": {}
        }
      }
    ]
  },
  {
    "description": "Boolean in querystring",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "BoolQuery": {
            "shape": "BoolType",
            "location": "querystring",
            "locationName": "bool-query"
          }
        }
      },
      "BoolType": {"type": "boolean"}
    },
    "cases": [
      {
        "given": {
          "http": {"method": "GET", "requestUri": "/path"},
          "input": {"shape": "InputShape"},
          "name": "OperationName"
        },
        "params": {"BoolQuery": true},
        "serialized": {
          "body": "",
          "uri": "/path?bool-query=true",
          "headers": {}
        }
      },
      {
        "given": {
          "http": {"method": "GET", "requestUri": "/path"},
          "input": {"shape": "InputShape"},
          "name": "OperationName"
        },
        "params": {"BoolQuery": false},
        "serialized": {
          "body": "",
          "uri": "/path?bool-query=false",
          "headers": {}
        }
      }
    ]
  },
  {
    "description": "URI parameter and querystring params",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "PipelineId": {
            "shape": "StringType",
            "location": "uri",
            "locationName": "PipelineId"
          },
          "Ascending": {
            "shape": "StringType",
            "location": "querystring",
            "locationName": "Ascending"
          },
          "PageToken": {
            "shape": "StringType",
            "location": "querystring",
            "locationName": "PageToken"
          }
        }
      },
      "StringType": {"type": "string"}
    },
    "cases": [
      {
        "given": {
          "http": {
            "method": "GET",
            "requestUri": "/2014-01-01/jobsByPipeline/{PipelineId}"
          },
          "input": {"shape": "InputShape"},
          "name": "OperationName"
        },
        "params": {
          "PipelineId": "foo",
          "Ascending": "true",
          "PageToken": "bar"
        },
        "serialized": {
          "body": "",
          "uri": "/2014-01-01/jobsByPipeline/foo?Ascending=true&PageToken=bar",
          "headers": {}
        }
      }
    ]
  },
  {
    "description": "URI parameter, querystring params and JSON body",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "PipelineId": {
            "shape": "StringType",
            "location": "uri",
            "locationName": "PipelineId"
          },
          "Ascending": {
            "shape": "StringType",
            "location": "querystring",
            "locationName": "Ascending"
          },
          "PageToken": {
            "shape": "StringType",
            "location": "querystring",
            "locationName": "PageToken"
          },
          "Config": {"shape": "StructType"}
        }
      },
      "StringType": {"type": "string"},
      "StructType": {
        "type": "structure",
        "members": {
          "A": {"shape": "StringType"},
          "B": {"shape": "StringType"}
        }
      }
    },
    "cases": [
      {
        "given": {
          "http": {
            "method": "POST",
            "requestUri": "/2014-01-01/jobsByPipeline/{PipelineId}"
          },
          "input": {"shape": "InputShape"},
          "name": "OperationName"
        },
        "params": {
          "PipelineId": "foo",
          "Ascending": "true",
          "PageToken": "bar",
          "Config": {"A": "one", "B": "two"}
        },
        "serialized": {
          "body": "{\"Config\": {\"A\": \"one\", \"B\": \"two\"}}",
          "uri": "/2014-01-01/jobsByPipeline/foo?Ascending=true&PageToken=bar",
          "headers": {}
        }
      }
    ]
  },
  {
    "description": "URI parameter, querystring params, headers and JSON body",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "PipelineId": {
            "shape": "StringType",
            "location": "uri",
            "locationName": "PipelineId"
          },
          "Ascending": {
            "shape": "StringType",
            "location": "querystring",
            "locationName": "Ascending"
          },
          "Checksum": {
            "shape": "StringType",
            "location": "header",
            "locationName": "x-amz-checksum"
          },
          "PageToken": {
            "shape": "StringType",
            "location": "querystring",
            "locationName": "PageToken"
          },
          "Config": {"shape": "StructType"}
        }
      },
      "StringType": {"type": "string"},
      "StructType": {
        "type": "structure",
        "members": {
          "A": {"shape": "StringType"},
          "B": {"shape": "StringType"}
        }
      }
    },
    "cases": [
      {
        "given": {
          "http": {
            "method": "POST",
            "requestUri": "/2014-01-01/jobsByPipeline/{PipelineId}"
          },
          "input": {"shape": "InputShape"},
          "name": "OperationName"
        },
        "params": {
          "PipelineId": "foo",
          "Ascending": "true",
          "Checksum": "12345",
          "PageToken": "bar",
          "Config": {"A": "one", "B": "two"}
        },
        "serialized": {
          "body": "{\"Config\": {\"A\": \"one\", \"B\": \"two\"}}",
          "uri": "/2014-01-01/jobsByPipeline/foo?Ascending=true&PageToken=bar",
          "headers": {"x-amz-checksum": "12345"}
        }
      }
    ]
  },
  {
    "description": "Streaming payload",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "vaultName": {
            "shape": "StringType",
            "location": "uri",
            "locationName": "vaultName"
          },
          "checksum": {
            "shape": "StringType",
            "location": "header",
            "locationName": "x-amz-sha256-tree-hash"
          },
          "body": {"shape": "Stream"}
        },
        "required": ["vaultName"],
        "payload": "body"
      },
      "StringType": {"type": "string"},
      "Stream": {"type": "blob", "streaming": true}
    },
    "cases": [
      {
        "given": {
          "http": {
            "method": "POST",
            "requestUri": "/2014-01-01/vaults/{vaultName}/archives"
          },
          "input": {"shape": "InputShape"},
          "name": "OperationName"
        },
        "params": {"vaultName": "name", "checksum": "foo", "body": "contents"},
        "serialized": {
          "body": "contents",
          "uri": "/2014-01-01/vaults/name/archives",
          "headers": {"x-amz-sha256-tree-hash": "foo"}
        }
      }
    ]
  },
  {
    "description": "Serialize blobs in body",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "Foo": {
            "shape": "StringType",
            "location": "uri",
            "locationName": "Foo"
          },
          "Bar": {"shape": "BlobType"}
        },
        "required": ["Foo"]
      },
      "StringType": {"type": "string"},
      "BlobType": {"type": "blob"}
    },
    "cases": [
      {
        "given": {
          "http": {"method": "POST", "requestUri": "/2014-01-01/{Foo}"},
          "input": {"shape": "InputShape"},
          "name": "OperationName"
        },
        "params": {"Foo": "foo_name", "Bar": "Blob param"},
        "serialized": {
          "body": "{\"Bar\": \"QmxvYiBwYXJhbQ==\"}",
          "uri": "/2014-01-01/foo_name"
        }
      }
    ]
  },
  {
    "description": "Blob payload",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "foo": {"shape": "FooShape"}
        }
      },
      "FooShape": {"type": "blob"}
    },
    "cases": [
      {
        "given": {
          "http": {"method": "POST", "requestUri": "/"},
          "input": {"shape": "InputShape", "payload": "foo"},
          "name": "OperationName"
        },
        "params": {"foo": "bar"},
        "serialized": {"method": "POST", "body": "bar", "uri": "/"}
      },
      {
        "given": {
          "http": {"method": "POST", "requestUri": "/"},
          "input": {"shape": "InputShape", "payload": "foo"},
          "name": "OperationName"
        },
        "params": {},
        "serialized": {"method": "POST", "body": "", "uri": "/"}
      }
    ]
  },
  {
    "description": "Structure payload",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "foo": {"shape": "FooShape"}
        }
      },
      "FooShape": {
        "locationName": "foo",
        "type": "structure",
        "members": {
          "baz": {"shape": "BazShape"}
        }
      },
      "BazShape": {"type": "string"}
    },
    "cases": [
      {
        "given": {
          "http": {"method": "POST", "requestUri": "/"},
          "input": {"shape": "InputShape", "payload": "foo"},
          "name": "OperationName"
        },
        "params": {
          "foo": {"baz": "bar"}
        },
        "serialized": {
          "method": "POST",
          "body": "{\"baz\": \"bar\"}",
          "uri": "/"
        }
      },
      {
        "given": {
          "http": {"method": "POST", "requestUri": "/"},
          "input": {"shape": "InputShape", "payload": "foo"},
          "name": "OperationName"
        },
        "params": {},
        "serialized": {"method": "POST", "body": "", "uri": "/"}
      }
    ]
  },
  {
    "description": "Omits null query params, but serializes empty strings",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "foo": {
            "location": "querystring",
            "locationName": "param-name",
            "shape": "Foo"
          }
        }
      },
      "Foo": {"type": "string"}
    },
    "cases": [
      {
        "given": {
          "name": "OperationName",
          "http": {"method": "POST", "requestUri": "/path"},
          "input": {"shape": "InputShape"}
        },
        "params": {"foo": null},
        "serialized": {"method": "POST", "body": "", "uri": "/path"}
      },
      {
        "given": {
          "name": "OperationName",
          "http": {"method": "POST", "requestUri": "/path?abc=mno"},
          "input": {"shape": "InputShape"}
        },
        "params": {"foo": ""},
        "serialized": {
          "method": "POST",
          "body": "",
          "uri": "/path?abc=mno&param-name="
        }
      }
    ]
  },
  {
    "description": "Recursive shapes",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "RecursiveStruct": {"shape": "RecursiveStructType"}
        }
      },
      "RecursiveStructType": {
        "type": "structure",
        "members": {
          "NoRecurse": {"shape": "StringType"},
          "RecursiveStruct": {"shape": "RecursiveStructType"},
          "RecursiveList": {"shape": "RecursiveListType"},
          "RecursiveMap": {"shape": "RecursiveMapType"}
        }
      },
      "RecursiveListType": {
        "type": "list",
        "member": {"shape": "RecursiveStructType"}
      },
      "RecursiveMapType": {
        "type": "map",
        "key": {"shape": "StringType"},
        "value": {"shape": "RecursiveStructType"}
      },
      "StringType": {"type": "string"}
    },
    "cases": [
      {
        "given": {
          "input": {"shape": "InputShape"},
          "http": {"method": "POST", "requestUri": "/path"},
          "name": "OperationName"
        },
        "params": {
          "RecursiveStruct": {"NoRecurse": "foo"}
        },
        "serialized": {
          "uri": "/path",
          "headers": {},
          "body": "{\"RecursiveStruct\": {\"NoRecurse\": \"foo\"}}"
        }
      },
      {
        "given": {
          "input": {"shape": "InputShape"},
          "http": {"method": "POST", "requestUri": "/path"},
          "name": "OperationName"
        },
        "params": {
          "RecursiveStruct": {
            "RecursiveStruct": {"NoRecurse": "foo"}
          }
        },
        "serialized": {
          "uri": "/path",
          "headers": {},
          "body":
              "{\"RecursiveStruct\": {\"RecursiveStruct\": {\"NoRecurse\": \"foo\"}}}"
        }
      },
      {
        "given": {
          "input": {"shape": "InputShape"},
          "http": {"method": "POST", "requestUri": "/path"},
          "name": "OperationName"
        },
        "params": {
          "RecursiveStruct": {
            "RecursiveStruct": {
              "RecursiveStruct": {
                "RecursiveStruct": {"NoRecurse": "foo"}
              }
            }
          }
        },
        "serialized": {
          "uri": "/path",
          "headers": {},
          "body":
              "{\"RecursiveStruct\": {\"RecursiveStruct\": {\"RecursiveStruct\": {\"RecursiveStruct\": {\"NoRecurse\": \"foo\"}}}}}"
        }
      },
      {
        "given": {
          "input": {"shape": "InputShape"},
          "http": {"method": "POST", "requestUri": "/path"},
          "name": "OperationName"
        },
        "params": {
          "RecursiveStruct": {
            "RecursiveList": [
              {"NoRecurse": "foo"},
              {"NoRecurse": "bar"}
            ]
          }
        },
        "serialized": {
          "uri": "/path",
          "headers": {},
          "body":
              "{\"RecursiveStruct\": {\"RecursiveList\": [{\"NoRecurse\": \"foo\"}, {\"NoRecurse\": \"bar\"}]}}"
        }
      },
      {
        "given": {
          "input": {"shape": "InputShape"},
          "http": {"method": "POST", "requestUri": "/path"},
          "name": "OperationName"
        },
        "params": {
          "RecursiveStruct": {
            "RecursiveList": [
              {"NoRecurse": "foo"},
              {
                "RecursiveStruct": {"NoRecurse": "bar"}
              }
            ]
          }
        },
        "serialized": {
          "uri": "/path",
          "headers": {},
          "body":
              "{\"RecursiveStruct\": {\"RecursiveList\": [{\"NoRecurse\": \"foo\"}, {\"RecursiveStruct\": {\"NoRecurse\": \"bar\"}}]}}"
        }
      },
      {
        "given": {
          "input": {"shape": "InputShape"},
          "http": {"method": "POST", "requestUri": "/path"},
          "name": "OperationName"
        },
        "params": {
          "RecursiveStruct": {
            "RecursiveMap": {
              "foo": {"NoRecurse": "foo"},
              "bar": {"NoRecurse": "bar"}
            }
          }
        },
        "serialized": {
          "uri": "/path",
          "headers": {},
          "body":
              "{\"RecursiveStruct\": {\"RecursiveMap\": {\"foo\": {\"NoRecurse\": \"foo\"}, \"bar\": {\"NoRecurse\": \"bar\"}}}}"
        }
      }
    ]
  },
  {
    "description": "Timestamp values",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "TimeArg": {"shape": "TimestampType"},
          "TimeArgInHeader": {
            "shape": "TimestampType",
            "location": "header",
            "locationName": "x-amz-timearg"
          },
          "TimeArgInQuery": {
            "shape": "TimestampType",
            "location": "querystring",
            "locationName": "TimeQuery"
          },
          "TimeCustom": {
            "timestampFormat": "iso8601",
            "shape": "TimestampType"
          },
          "TimeCustomInHeader": {
            "timestampFormat": "unixTimestamp",
            "shape": "TimestampType",
            "location": "header",
            "locationName": "x-amz-timecustom-header"
          },
          "TimeCustomInQuery": {
            "timestampFormat": "unixTimestamp",
            "shape": "TimestampType",
            "location": "querystring",
            "locationName": "TimeCustomQuery"
          },
          "TimeFormat": {"shape": "TimestampFormatRfcType"},
          "TimeFormatInHeader": {
            "shape": "TimestampFormatUnixType",
            "location": "header",
            "locationName": "x-amz-timeformat-header"
          },
          "TimeFormatInQuery": {
            "shape": "TimestampFormatUnixType",
            "location": "querystring",
            "locationName": "TimeFormatQuery"
          }
        }
      },
      "TimestampFormatRfcType": {
        "timestampFormat": "rfc822",
        "type": "timestamp"
      },
      "TimestampFormatUnixType": {
        "timestampFormat": "unixTimestamp",
        "type": "timestamp"
      },
      "TimestampType": {"type": "timestamp"}
    },
    "cases": [
      {
        "given": {
          "input": {"shape": "InputShape"},
          "http": {"method": "POST", "requestUri": "/path"},
          "name": "OperationName"
        },
        "params": {
          "TimeArg": 1422172800,
          "TimeArgInQuery": 1422172800,
          "TimeArgInHeader": 1422172800,
          "TimeCustom": 1422172800,
          "TimeCustomInQuery": 1422172800,
          "TimeCustomInHeader": 1422172800,
          "TimeFormat": 1422172800,
          "TimeFormatInQuery": 1422172800,
          "TimeFormatInHeader": 1422172800
        },
        "serialized": {
          "uri":
              "/path?TimeQuery=2015-01-25T08%3A00%3A00Z&TimeCustomQuery=1422172800&TimeFormatQuery=1422172800",
          "headers": {
            "x-amz-timearg": "Sun, 25 Jan 2015 08:00:00 GMT",
            "x-amz-timecustom-header": "1422172800",
            "x-amz-timeformat-header": "1422172800"
          },
          "body":
              "{\"TimeArg\": 1422172800, \"TimeCustom\": \"2015-01-25T08:00:00Z\", \"TimeFormat\": \"Sun, 25 Jan 2015 08:00:00 GMT\"}"
        }
      }
    ]
  },
  {
    "description": "Named locations in JSON body",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "TimeArg": {
            "shape": "TimestampType",
            "locationName": "timestamp_location"
          }
        }
      },
      "TimestampType": {"type": "timestamp"}
    },
    "cases": [
      {
        "given": {
          "input": {"shape": "InputShape"},
          "http": {"method": "POST", "requestUri": "/path"},
          "name": "OperationName"
        },
        "params": {"TimeArg": 1422172800},
        "serialized": {
          "uri": "/path",
          "headers": {},
          "body": "{\"timestamp_location\": 1422172800}"
        }
      }
    ]
  },
  {
    "description": "String payload",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "foo": {"shape": "FooShape"}
        }
      },
      "FooShape": {"type": "string"}
    },
    "cases": [
      {
        "given": {
          "http": {"method": "POST", "requestUri": "/"},
          "input": {"shape": "InputShape", "payload": "foo"},
          "name": "OperationName"
        },
        "params": {"foo": "bar"},
        "serialized": {"method": "POST", "body": "bar", "uri": "/"}
      }
    ]
  },
  {
    "description": "Idempotency token auto fill",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "Token": {"shape": "StringType", "idempotencyToken": true}
        }
      },
      "StringType": {"type": "string"}
    },
    "cases": [
      {
        "given": {
          "input": {"shape": "InputShape"},
          "http": {"method": "POST", "requestUri": "/path"},
          "name": "OperationName"
        },
        "params": {"Token": "abc123"},
        "serialized": {
          "uri": "/path",
          "headers": {},
          "body": "{\"Token\": \"abc123\"}"
        }
      },
      {
        "given": {
          "input": {"shape": "InputShape"},
          "http": {"method": "POST", "requestUri": "/path"},
          "name": "OperationName"
        },
        "params": {},
        "serialized": {
          "uri": "/path",
          "headers": {},
          "body": "{\"Token\": \"00000000-0000-4000-8000-000000000000\"}"
        }
      }
    ]
  },
  {
    "description": "JSON value trait",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "payload": "Body",
        "members": {
          "HeaderField": {
            "shape": "StringType",
            "jsonvalue": true,
            "location": "header",
            "locationName": "X-Amz-Foo"
          },
          "QueryField": {
            "shape": "StringType",
            "jsonvalue": true,
            "location": "querystring",
            "locationName": "Bar"
          },
          "Body": {"shape": "BodyStructure"}
        }
      },
      "StringType": {"type": "string"},
      "ListType": {
        "type": "list",
        "member": {"shape": "StringType", "jsonvalue": true}
      },
      "BodyStructure": {
        "type": "structure",
        "members": {
          "BodyField": {"shape": "StringType", "jsonvalue": true},
          "BodyListField": {"shape": "ListType"}
        }
      }
    },
    "cases": [
      {
        "given": {
          "input": {"shape": "InputShape"},
          "http": {"method": "POST"},
          "name": "OperationName"
        },
        "params": {
          "HeaderField": {"Foo": "Bar"},
          "QueryField": {"Foo": "Bar"},
          "Body": {
            "BodyField": {"Foo": "Bar"}
          }
        },
        "serialized": {
          "uri": "/?Bar=%7B%22Foo%22%3A%22Bar%22%7D",
          "headers": {"X-Amz-Foo": "eyJGb28iOiJCYXIifQ=="},
          "body": "{\"BodyField\":\"{\\\"Foo\\\":\\\"Bar\\\"}\"}"
        }
      },
      {
        "given": {
          "input": {"shape": "InputShape"},
          "http": {"method": "POST"},
          "name": "OperationName"
        },
        "params": {
          "Body": {
            "BodyListField": [
              {"Foo": "Bar"}
            ]
          }
        },
        "serialized": {
          "uri": "/",
          "headers": {},
          "body": "{\"BodyListField\":[\"{\\\"Foo\\\":\\\"Bar\\\"}\"]}"
        }
      },
      {
        "given": {
          "input": {"shape": "InputShape"},
          "http": {"method": "POST"},
          "name": "OperationName"
        },
        "params": {},
        "serialized": {"uri": "/", "headers": {}, "body": ""}
      }
    ]
  },
  {
    "description": "Enum",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "shapes": {
      "InputShape": {
        "type": "structure",
        "members": {
          "HeaderEnum": {
            "shape": "EnumType",
            "location": "header",
            "locationName": "x-amz-enum"
          },
          "FooEnum": {"shape": "EnumType"},
          "QueryFooEnum": {
            "shape": "EnumType",
            "location": "querystring",
            "locationName": "Enum"
          },
          "ListEnums": {"shape": "EnumList"},
          "QueryListEnums": {
            "shape": "EnumList",
            "location": "querystring",
            "locationName": "List"
          }
        }
      },
      "EnumType": {
        "type": "string",
        "enum": ["foo", "bar", "0", "1"]
      },
      "EnumList": {
        "type": "list",
        "member": {"shape": "EnumType"}
      }
    },
    "cases": [
      {
        "given": {
          "input": {"shape": "InputShape"},
          "http": {"method": "POST", "requestUri": "/path"},
          "name": "OperationName"
        },
        "params": {
          "HeaderEnum": "baz",
          "FooEnum": "foo",
          "QueryFooEnum": "bar",
          "ListEnums": ["foo", "", "bar"],
          "QueryListEnums": ["0", "1", ""]
        },
        "serialized": {
          "uri": "/path?Enum=bar&List=0&List=1&List=",
          "headers": {"x-amz-enum": "baz"},
          "body":
              "{\"FooEnum\": \"foo\", \"ListEnums\": [\"foo\", \"\", \"bar\"]}"
        }
      },
      {
        "given": {
          "input": {"shape": "InputShape"},
          "http": {"method": "POST", "requestUri": "/path"},
          "name": "OperationName"
        },
        "params": {},
        "serialized": {"uri": "/path", "headers": {}}
      }
    ]
  },
  {
    "description": "Endpoint host trait",
    "metadata": {"protocol": "rest-json", "apiVersion": "2014-01-01"},
    "clientEndpoint": "https://service.region.amazonaws.com",
    "shapes": {
      "StaticInputShape": {
        "type": "structure",
        "members": {
          "Name": {"shape": "StringType"}
        }
      },
      "MemberRefInputShape": {
        "type": "structure",
        "members": {
          "Name": {"shape": "StringType", "hostLabel": true}
        }
      },
      "StringType": {"type": "string"}
    },
    "cases": [
      {
        "given": {
          "name": "StaticOp",
          "input": {"shape": "StaticInputShape"},
          "http": {"method": "POST", "requestUri": "/path"},
          "endpoint": {"hostPrefix": "data-"}
        },
        "params": {"Name": "myname"},
        "serialized": {
          "uri": "/path",
          "body": "{\"Name\": \"myname\"}",
          "host": "data-service.region.amazonaws.com"
        }
      },
      {
        "given": {
          "name": "MemberRefOp",
          "input": {"shape": "MemberRefInputShape"},
          "http": {"method": "POST", "requestUri": "/path"},
          "endpoint": {"hostPrefix": "foo-{Name}."}
        },
        "params": {"Name": "myname"},
        "serialized": {
          "uri": "/path",
          "body": "{\"Name\": \"myname\"}",
          "host": "foo-myname.service.region.amazonaws.com"
        }
      }
    ]
  }
];
