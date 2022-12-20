#!/usr/bin/env bash
set -e

itk_dir=$1

# avoids warning by disabling functionality: SystemTools.cxx:(.text+0x1b6a): warning: Using 'getpwnam' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
f="$itk_dir/Modules/ThirdParty/KWSys/src/KWSys/SystemTools.cxx"
#cp $f $backupdir
sed -i 's/define HAVE_GETPWNAM 1/undef HAVE_GETPWNAM/' $f
