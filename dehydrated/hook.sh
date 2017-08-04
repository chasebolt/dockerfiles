#!/bin/bash
# shellcheck disable=SC2034
set -euo pipefail

HAPROXY_DIR=${HAPROXY_DIR:-"/data/haproxy"}

if [ "$CHALLENGE_TYPE" = "dns-01" ]; then
  export PROVIDER=${PROVIDER:-"cloudflare"}
fi

deploy_challenge() {
  DOMAIN="${1}"
  TOKEN_FILENAME="${2}"
  TOKEN_VALUE="${3}"

  # echo " + deploy_challenge called: ${DOMAIN}, ${TOKEN_FILENAME}, ${TOKEN_VALUE}"

  if [ "$CHALLENGE_TYPE" = "dns-01" ]; then
    lexicon $PROVIDER create ${DOMAIN} TXT --name="_acme-challenge.${DOMAIN}." --content="${TOKEN_VALUE}" > /dev/null
    sleep 30
  else
    sleep 5
  fi

  # This hook is called once for every domain that needs to be
  # validated, including any alternative names you may have listed.
  #
  # Parameters:
  # - DOMAIN
  #   The domain name (CN or subject alternative name) being
  #   validated.
  # - TOKEN_FILENAME
  #   The name of the file containing the token to be served for HTTP
  #   validation. Should be served by your web server as
  #   /.well-known/acme-challenge/${TOKEN_FILENAME}.
  # - TOKEN_VALUE
  #   The token value that needs to be served for validation. For DNS
  #   validation, this is what you want to put in the _acme-challenge
  #   TXT record. For HTTP validation it is the value that is expected
  #   be found in the $TOKEN_FILENAME file.
}

clean_challenge() {
  DOMAIN="${1}"
  TOKEN_FILENAME="${2}"
  TOKEN_VALUE="${3}"

  # echo " + clean_challenge called: ${DOMAIN}, ${TOKEN_FILENAME}, ${TOKEN_VALUE}"

  if [ "$CHALLENGE_TYPE" = "dns-01" ]; then
    lexicon $PROVIDER delete ${DOMAIN} TXT --name="_acme-challenge.${DOMAIN}." --content="${TOKEN_VALUE}" > /dev/null
  fi

  # This hook is called after attempting to validate each domain,
  # whether or not validation was successful. Here you can delete
  # files or DNS records that are no longer needed.
  #
  # The parameters are the same as for deploy_challenge.
}

deploy_cert() {
  DOMAIN="${1}"
  KEYFILE="${2}"
  CERTFILE="${3}"
  FULLCHAINFILE="${4}"
  CHAINFILE="${5}"

  # echo " + deploy_cert called: ${DOMAIN}, ${KEYFILE}, ${CERTFILE}, ${FULLCHAINFILE}, ${CHAINFILE}"

  create_haproxy "${DOMAIN}" "${KEYFILE}" "${FULLCHAINFILE}"

  # This hook is called once for each certificate that has been
  # produced. Here you might, for instance, copy your new certificates
  # to service-specific locations and reload the service.
  #
  # Parameters:
  # - DOMAIN
  #   The primary domain name, i.e. the certificate common
  #   name (CN).
  # - KEYFILE
  #   The path of the file containing the private key.
  # - CERTFILE
  #   The path of the file containing the signed certificate.
  # - FULLCHAINFILE
  #   The path of the file containing the full certificate chain.
  # - CHAINFILE
  #   The path of the file containing the intermediate certificate(s).
}

unchanged_cert() {
  DOMAIN="${1}"
  KEYFILE="${2}"
  CERTFILE="${3}"
  FULLCHAINFILE="${4}"
  CHAINFILE="${5}"

  # echo " + unchanged_cert called: ${DOMAIN}, ${KEYFILE}, ${CERTFILE}, ${FULLCHAINFILE}, ${CHAINFILE}"

  check_haproxy "${DOMAIN}" "${KEYFILE}" "${FULLCHAINFILE}"

  # This hook is called once for each certificate that is still
  # valid and therefore wasn't reissued.
  #
  # Parameters:
  # - DOMAIN
  #   The primary domain name, i.e. the certificate common
  #   name (CN).
  # - KEYFILE
  #   The path of the file containing the private key.
  # - CERTFILE
  #   The path of the file containing the signed certificate.
  # - FULLCHAINFILE
  #   The path of the file containing the full certificate chain.
  # - CHAINFILE
  #   The path of the file containing the intermediate certificate(s).
}

invalid_challenge() {
  ALTNAME="${1}"
  RESULT="${2}"

  # echo " + invalid_challenge called: ${ALTNAME}, ${RESULT}"

  # This hook is called if a challenge receives an invalid response
  # Parameters:
  # - ALTNAME
  #   The alternative domain name
  # - RESULT
  #   The result of the invalid challenge
}

request_failure() {
  STATUSCODE="${1}"
  ERRTXT="${2}"
  REQUEST="${3}"

  # echo " + request_failure called"

  # This hook is called when a HTTP request fails (e.g., when the ACME server is
  # busy, returns an error, etc). It will be called upon any response code that
  # does not start with '2'. Useful to alert admins about problems with requests.
  # Parameters:
  # - STATUSCODE
  #   The status code returned from HTTP call
  # - ERRTXT
  #   The error text returned
  # - REQUEST
  #   The request type used (head/get/post)
}

startup_hook() {
  # This hook is called before the cron command to do some initial tasks
  # (e.g. starting a webserver).

  true
}

exit_hook() {
  true

  # echo " + exit_hook called"

  # This hook is called at the end of a dehydrated command and can be used
  # to do some final (cleanup or other) tasks.
}

check_haproxy() {
  DOMAIN="${1}"
  KEYFILE="${2}"
  FULLCHAINFILE="${3}"

  printf " + Checking HAProxy cert..."

  HAPROXY_CERT=$(cat "${HAPROXY_DIR}/${DOMAIN}.pem")
  CURRENT_CERT=$(cat "${KEYFILE}" "${FULLCHAINFILE}")

  if [ "${CURRENT_CERT}" == "${HAPROXY_CERT}" ]; then
    echo " unchanged."
  else
    echo " changed!"
    echo " + Forcing rebuild of HAProxy cert!"
    create_haproxy "${DOMAIN}" "${KEYFILE}" "${FULLCHAINFILE}"
  fi
}

create_haproxy() {
  DOMAIN="${1}"
  KEYFILE="${2}"
  FULLCHAINFILE="${3}"

  echo " + Creating HAProxy cert."

  cat "${KEYFILE}" "${FULLCHAINFILE}" > "${HAPROXY_DIR}/${DOMAIN}.pem"
}

HANDLER=$1; shift; $HANDLER "$@"
