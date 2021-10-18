#!/bin/bash

set -x

create_user=${ES_AUTH:-0}

host=${ELASTICSEARCH_HOST:-http://elk:9200}

if [[ $create_user -ne 0 ]];
then
  # create user ifood
  path=_security/user/ifood
  curl -X POST -u "${ES_SUPERUSER}:${ES_SUPERUSER_PASSWORD}" "${host}/${path}" -d@"post/${path}.json" -H "Content-Type: application/json"
  echo " "
fi

# create indexes
for i in $(find ./put/ -name '*.json' | sort -r);
do
  path=${i#./put/}
  curl -X PUT -u "ifood:ifood@" "${host}/${path%.json}" -d@"put/${path}" -H "Content-Type: application/json"
  echo " "
done

# create test indexes
for i in $(find ./post/test-index -name '*.json' | sort -r);
do
  path=${i#./post/}
  curl -X PUT -u "ifood:ifood@" "${host}/${path%.json}" -d@"post/${path}" -H "Content-Type: application/json"
  echo " "
done
