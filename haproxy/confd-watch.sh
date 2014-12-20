#!/bin/bash

set -eo pipefail

export ETCD_PORT=${ETCD_PORT:-4001}
export HOST_IP=${HOST_IP:-172.17.42.1}
export ETCD=$HOST_IP:$ETCD_PORT

echo "[haproxy] booting container. ETCD: $ETCD."

# Try to make initial configuration every 5 seconds until successful
until confd -onetime -node $ETCD -config-file /etc/confd/conf.d/haproxy.toml; do
      echo "[haproxy] waiting for confd to create initial haproxy configuration."
        sleep 5
      done

      # Put a continual polling `confd` process into the background to watch
      # for changes every 10 seconds
      confd -interval 10 -node $ETCD -config-file /etc/confd/conf.d/haproxy.toml &
      echo "[haproxy] confd is now monitoring etcd for changes..."

      # Start the haproxy service using the generated config
      echo "[haproxy] starting haproxy service..."
      service haproxy start

      # Follow the logs to allow the script to continue running
      tail -f /var/log/haproxy/*.log
done
