exports.handler = (event, context, callback) => {
    // (1)
    const request = event.Records[0].cf.request;
    const requestHost = request.headers.host[0].value;
    // (2)
    if (requestHost.startsWith('www.')) {
      const response = {
        status: 302,
        statusDescription: 'Found',
        headers: {
          location: [{
            key: 'Location',
            value: 'https://' + requestHost.replace(/^(www\.)/, '') + request.uri
          }],
          // (3)
          'cache-control': [{
            key: 'Cache-Control',
            value: 'max-age=31536000'
          }]
        }
      };
      // (4)
      callback(null, response);
    }
    else {
      // (5)
      callback(null, request);
    }
  };