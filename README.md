# cfprobe-box
Tiny container that runs the CF-Server-Monitor probe (huilang-me/cfsm-agent) and answers "ok" on $PORT (default 8080).
Env: SECRET (required), NAME, SERVER_ID (set after first registration to avoid duplicates), WORKER_URL.
