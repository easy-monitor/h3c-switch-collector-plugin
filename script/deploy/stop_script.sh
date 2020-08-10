#!/bin/bash

ps -ef | grep snmp_exporter | awk '{print $2}' | xargs kill -9
