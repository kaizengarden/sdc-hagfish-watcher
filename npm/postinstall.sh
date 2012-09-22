#!/bin/bash

set -o xtrace

DIR=`dirname $0`

. /lib/sdc/config.sh
load_sdc_config

export PREFIX=$npm_config_prefix
export ETC_DIR=$npm_config_etc
export SMF_DIR=$npm_config_smfdir
export VERSION=$npm_package_version

subfile () {
  IN=$1
  OUT=$2
  sed -e "s#@@PREFIX@@#$PREFIX#g" \
      -e "s/@@VERSION@@/$VERSION/g" \
      $IN > $OUT
}

subfile "$DIR/../smf/manifests/hagfish-watcher.xml.in" "$SMF_DIR/hagfish-watcher.xml"
svccfg import $SMF_DIR/hagfish-watcher.xml