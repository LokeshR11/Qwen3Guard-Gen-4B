#!/bin/bash

set -e

echo "Starting Qwen3Guard-Gen-4B..."

exec python3 -m vllm.entrypoints.openai.api_server \
  --model /app/model \
  --host 0.0.0.0 \
  --port 8080 \
  --dtype half \
  --trust-remote-code \
  --served-model-name Qwen3Guard-Gen-4B \
  --gpu-memory-utilization 0.95 \
  --max-model-len 8192
