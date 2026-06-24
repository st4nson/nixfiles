# Pin python3Packages.okta to 2.9.13 so gimme-aws-creds (2.8.2) builds.
#
# Why this exists:
#   nixpkgs 26.05 bumped python3Packages.okta from 2.9.13 -> 3.1.0.
#   The 3.x line is a full rewrite of the Okta SDK; APIClient moved.
#   gimme-aws-creds 2.8.2 pins `okta>=2.9.0,<3.0.0` and imports
#   `from okta.api_client import APIClient`, so 3.x breaks both its
#   pytest collection AND its runtime entry point.
#
# Upstream tracking: https://github.com/NixOS/nixpkgs/issues/494067
#
# Blast radius: gimme-aws-creds is the only consumer of
# python3Packages.okta in nixpkgs, so downgrading globally via
# pythonPackagesExtensions is safe.
#
# Source: copied verbatim from nixpkgs release-25.05
# (pkgs/development/python-modules/okta/default.nix).
# Remove this overlay once nixpkgs ships a fixed gimme-aws-creds or
# reintroduces an okta_2.x attribute.

{
  lib,
  aenum,
  aiohttp,
  buildPythonPackage,
  fetchPypi,
  flatdict,
  jwcrypto,
  pycryptodomex,
  pydash,
  pyfakefs,
  pyjwt,
  pytest-asyncio,
  pytest-mock,
  pytest-recording,
  pytestCheckHook,
  pythonOlder,
  pyyaml,
  setuptools,
  xmltodict,
  yarl,
}:

buildPythonPackage rec {
  pname = "okta";
  version = "2.9.13";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-jY6SZ1G3+NquF5TfLsGw6T9WO4smeBYT0gXLnRDoN+8=";
  };

  build-system = [ setuptools ];

  dependencies = [
    aenum
    aiohttp
    flatdict
    jwcrypto
    pycryptodomex
    pydash
    pyjwt
    pyyaml
    xmltodict
    yarl
  ];

  checkInputs = [
    pyfakefs
    pytest-asyncio
    pytest-mock
    pytest-recording
    pytestCheckHook
  ];

  enabledTestPaths = [ "tests/" ];

  disabledTests = [
    "test_client_raise_exception"
    # vcr.errors.CannotOverwriteExistingCassetteException: Can't overwrite existing cassette
    "test_get_org_contact_user"
    "test_update_org_contact_user"
    "test_get_role_subscription"
    "test_subscribe_unsubscribe"
    "test_client_invalid_url"
  ];

  pythonImportsCheck = [
    "okta"
    "okta.cache"
    "okta.client"
    "okta.exceptions"
    "okta.http_client"
    "okta.models"
    "okta.request_executor"
  ];

  meta = with lib; {
    description = "Python SDK for the Okta Management API";
    homepage = "https://github.com/okta/okta-sdk-python";
    changelog = "https://github.com/okta/okta-sdk-python/blob/v${version}/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ jbgosselin ];
  };
}
