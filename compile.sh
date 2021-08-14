#!/bin/bash


# protoc --proto_path=./src \
#   --go_opt=Msrc/app.proto=swi-protobuf/protos/app app.proto


protoc --proto_path=src --go_out=out/app --go_opt=paths=source_relative app.proto 
protoc --proto_path=src --go_out=out/fs --go_opt=paths=source_relative fs.proto 
protoc --proto_path=src --go_out=out/session --go_opt=paths=source_relative session.proto 
protoc --proto_path=src --go_out=out/transport --go_opt=paths=source_relative transport.proto 

# protoc --proto_path=src --go_out=out/app --go_opt=paths=source_relative app.proto fs.proto session.proto transport.proto