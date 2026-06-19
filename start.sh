1  #!/bin/bash
2
3  set -e
4
5  echo "Starting Qwen3Guard-Gen-4B..."
6
7  exec python3 -m vllm.entrypoints.openai.api_server \
8    --model /app/model \
9    --host 0.0.0.0 \
10   --port 8080 \
11   --dtype float16 \
12   --max-model-len 512 \
13   --gpu-memory-utilization 0.85 \
14   --max-num-seqs 16 \
15   --trust-remote-code
