#!/bin/bash

set -e

exec python3 -m vllm.entrypoints.openai.api_server \
  --model /app/model \
  --host 0.0.0.0 \
  --port 8080 \
  --dtype float16 \
  --gpu-memory-utilization 0.85 \
  --trust-remote-code
