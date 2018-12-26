#!/bin/bash
export LANG=ko_KR.UTF-8
### hash=$(python -c 'from notebook.auth import passwd; print(passwd("ubuntu"))')
### hash="sha1:737c22e0abdb:3bafc7cd71c0d31d3fa7de3e413b6f4b2c27a894"
#jupyter nbextension enable --py --sys-prefix widgetsnbextension
jupyter nbextension enable --py --user widgetsnbextension
#exec jupyter notebook --allow-root --ip 0.0.0.0 --port 8888 --no-browser --NotebookApp.password="$hash" --NotebookApp.allow_origin="*" "$@"
exec jupyter notebook --allow-root --ip 0.0.0.0 --port 8888 --no-browser --NotebookApp.password="sha1:737c22e0abdb:3bafc7cd71c0d31d3fa7de3e413b6f4b2c27a894" --NotebookApp.allow_origin="*" "$@"
