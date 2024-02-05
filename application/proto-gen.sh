#!/bin/bash
cd ./proto
dirs=("payment" "settlement" "balance")
for file in *
do
    dirname="${file%.proto}"
    for dir in $dirs
    do
        dest=../$dir/proto/$dirname
        mkdir -p $dest
        protoc --go_out=$dest --go_opt=paths=source_relative --go-grpc_out=$dest --go-grpc_opt=paths=source_relative $file
    done
done
cd ..

cp -r ./proto/* ./bff/proto