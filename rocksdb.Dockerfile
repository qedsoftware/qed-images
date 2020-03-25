# Reference: github.com/facebook/rocksdb/blob/master/INSTALL.md
FROM python:3.8-buster

RUN apt-get update && apt-get install -y \
    # begin RocksDB dependencies
    libgflags-dev \
    libsnappy-dev \
    zlib1g-dev \
    libbz2-dev \
    liblz4-dev \
    libzstd-dev
    # end RocksDB dependencies

# Compile RocksDB
RUN git clone https://github.com/facebook/rocksdb.git && \
    cd rocksdb && \
    git checkout v6.6.4 && \
    make shared_lib

# Distribute RocksDB shared objects
RUN cd rocksdb &&\
    mkdir -p /usr/local/rocksdb/lib && \
    mkdir /usr/local/rocksdb/include && \
    cp librocksdb.so* /usr/local/rocksdb/lib && \
    cp /usr/local/rocksdb/lib/librocksdb.so* /usr/lib/ && \
    cp -r include /usr/local/rocksdb/ && \
    cp -r include/* /usr/include/
