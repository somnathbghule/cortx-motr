#!/bin/bash
#
# Copyright (c) 2020 Seagate Technology LLC and/or its Affiliates
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# For any questions about this software or licensing,
# please email opensource@seagate.com or cortx-questions@seagate.com.
#

set -eu

SANDBOX_DIR=${SANDBOX_DIR:-/var/motr/sandbox.51kem}

M0_SRC_DIR="$(realpath $0)"
M0_SRC_DIR="${M0_SRC_DIR%/*/*/*/*/*}"

. "$M0_SRC_DIR/utils/functions" # sandbox_init, report_and_exit

sandbox_init
rc=0;
(cd "$M0_SRC_DIR/scripts/systemtap/kem" && make)
"$M0_SRC_DIR/scripts/systemtap/kem/kem_run.sh" || rc=$?
(cd "$M0_SRC_DIR/scripts/systemtap/kem" && make clean)
sandbox_fini $rc
report_and_exit kem_run $rc
