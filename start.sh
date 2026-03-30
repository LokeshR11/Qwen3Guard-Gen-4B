#!/bin/bash

python3 -m vllm.entrypoints.openai.api_server \
  --model /app/models/Qwen3Guard-Gen-4B \
  --host 0.0.0.0 \
  --port 8000 \
  --gpu-memory-utilization 0.85 \
  --max-model-len 4096 \
  --dtype auto \
  --enforce-eager
