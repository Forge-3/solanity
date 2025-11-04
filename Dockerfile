# Use NVIDIA CUDA base image with Ubuntu 22.04
FROM nvidia/cuda:11.8.0-devel-ubuntu22.04
# Set environment variables for CUDA
ENV PATH="/usr/local/cuda/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"

RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    cmake \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

COPY . /solanity
WORKDIR /solanity

RUN make -j$(nproc)

ENV LD_LIBRARY_PATH=./src/release
CMD ["src/release/cuda_ed25519_vanity"]