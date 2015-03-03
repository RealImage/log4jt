#!/bin/sh

goimports -w=true .
go vet ./...
if [ $? != 0 ]; then
  exit
fi

if [ -d _goose ]; then
  cd _goose
  goose up
  goose -env="test" up
  if [ $? != 0 ]; then
    exit
  fi

  cd -
fi

gofmt -w .
godep go build

if [ $? != 0 ]; then
  exit
fi

#godep go test ./...
#if [ $? == 0 ]; then
#  ./log4jt
#fi
