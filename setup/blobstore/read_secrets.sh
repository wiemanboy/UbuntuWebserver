#!/bin/sh

echo "Read secrets"

for environment_variable in $(env); do
  if [ "${environment_variable#*_FILE=}" != "$environment_variable" ]; then
    variable_name="${environment_variable%%=*}"
    variable_name="${variable_name%_FILE}"
    file_path="${environment_variable#*=}"
    if [ -f "$file_path" ]; then
      echo $variable_name
      export "$variable_name"="$(cat "$file_path")"
    fi
  fi
done

exec "$@"
