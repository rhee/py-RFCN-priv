#!/bin/bash
echo '/tmp/core.%h.%e.%t'>/proc/sys/kernel/core_pattern
addgroup --gid $GID user01
useradd --uid $UID --gid $GID --shell /bin/bash --create-home user01</dev/null
exec sudo -u user01 -H "$@"
