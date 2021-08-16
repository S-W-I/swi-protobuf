#!/bin/bash


# protoc --proto_path=./src \
#   --go_opt=Msrc/app.proto=swi-protobuf/protos/app app.proto


protoc --proto_path=src --go_out=out/app --go_opt=paths=source_relative app.proto 
protoc --proto_path=src --go_out=out/fs --go_opt=paths=source_relative fs.proto 
protoc --proto_path=src --go_out=out/session --go_opt=paths=source_relative session.proto 
protoc --proto_path=src --go_out=out/transport --go_opt=paths=source_relative transport.proto 

# protoc --proto_path=src --go_out=out/app --go_opt=paths=source_relative app.proto fs.proto session.proto transport.proto

cp -r out/* ../swi-backend/protobuf/


PROTOC_GEN_TS_PATH="./node_modules/.bin/protoc-gen-ts"

# Directory to write generated code to (.js and .d.ts files)
OUT_DIR="./out-ts"


directories=(app fs session transport)

for file in ${directories[@]}
do
    # protoc \
    #     --plugin="protoc-gen-ts=${PROTOC_GEN_TS_PATH}" \
    #     --js_out="import_style=commonjs,binary:${OUT_DIR}" \
    #     --ts_out="${OUT_DIR}" \
    #     "./src/$file.proto"

    protoc --plugin=./node_modules/.bin/protoc-gen-ts_proto \
        --ts_proto_opt=snakeToCamel=false \
        --ts_proto_out=./out-ts "./src/$file.proto"

    # protoc --plugin=./node_modules/ts-proto/protoc-gen-ts_proto \
    #     "./src/$file.proto"
    # protoc --plugin=node_modules/ts-proto/protoc-gen-ts_proto ./batching.proto -I.
done

cp -r out-ts/src/* ../selenium-web/src/protobuf