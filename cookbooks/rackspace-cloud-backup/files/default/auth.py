#!/usr/bin/env python
#Copyright 2013 Rackspace Hosting, Inc.

#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.


"""
exit codes:
  0 - success
  1 - generic failure
  2 - auth failure
  3 - backup api error
"""


import argparse
import json
import httplib
from sys import exit as sysexit


def cloud_auth(args):
    """
    Authenticate and return authentication details via returned dict
    """
    token = ""
    authurl = 'identity.api.rackspacecloud.com'
    jsonreq = json.dumps({'auth': {'RAX-KSKEY:apiKeyCredentials':
                                       {'username': args.apiuser,
                                        'apiKey': args.apikey}}})
    if args.verbose:
        print 'JSON REQUEST: ' + jsonreq

    #make the request
    connection = httplib.HTTPSConnection(authurl, 443)
    if args.verbose:
        connection.set_debuglevel(1)
    headers = {'Content-type': 'application/json'}
    connection.request('POST', '/v2.0/tokens', jsonreq, headers)
    json_response = json.loads(connection.getresponse().read())
    connection.close()

    #process the request
    if args.verbose:
        print 'JSON decoded and pretty'
        print json.dumps(json_response, indent=2)
    try:
        token = json_response['access']['token']['id']
        if args.verbose:
            print 'Token:\t\t', token
    except(KeyError, IndexError):
        #print 'Error while getting answers from auth server.'
        #print 'Check the endpoint and auth credentials.'
        sysexit(2)
    finally:
        return token

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Gets auth data via json')
    parser.add_argument('--apiuser', '-u', required=True, help='Api username')
    parser.add_argument('--apikey', '-a', required=True, help='Account api key')
    parser.add_argument('--verbose', '-v', action='store_true', help='Turn up verbosity to 10')

    #populate needed variables
    args = parser.parse_args()
    print cloud_auth(args)
