#!/bin/sh

echo "SUBSCRIBING..."
./subscribe_from_event.sh "$1"
echo ""
echo "UNSUBSCRIBING..."
./unsubscribe_from_event.sh "$1"
