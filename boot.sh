#!/bin/bash

chef-solo -c ./boot/solo.rb -j ./boot/node.json
