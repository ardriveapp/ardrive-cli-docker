#/bin/sh

if [[ -z "${NO_AUTOBUILD}" ]]; then
  yarn config set --home enableTelemetry 0
  yarn install --immutable --inline-builds
  yarn build
fi

