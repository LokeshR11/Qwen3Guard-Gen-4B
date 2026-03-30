FROM vllm/vllm-openai:latest

WORKDIR /app

ENV VLLM_CONFIG_ROOT=/tmp
ENV XDG_CACHE_HOME=/tmp
ENV HF_HOME=/tmp
ENV NUMBA_CACHE_DIR=/tmp
ENV TRANSFORMERS_CACHE=/tmp


RUN pip install --no-cache-dir huggingface_hub

# Download 4B model during build
RUN huggingface-cli download Qwen/Qwen3Guard-Gen-4B \
    --local-dir /app/models/Qwen3Guard-Gen-4B \
    --local-dir-use-symlinks False

RUN chmod -R 777 /app/models

# Copy start script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8000

ENTRYPOINT ["/app/start.sh"]
