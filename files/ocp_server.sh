#!/usr/bin/bash
echo "This launches the ocp_vscode server for displaying 3d models. To connect, open a browser in the host os and type in 127.0.0.1:3939"
echo "To display models in this server use the ocp_vscode library!"
TMUX= && tmux new-session -d -s ocp_server "/app/ocp_vscode_venv/bin/python -m ocp_vscode --host 0.0.0.0 --port 3939"
