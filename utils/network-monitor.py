#!/usr/bin/env python3

import os
import re
import subprocess
import time

history = {}
writePath = os.path.expanduser("~/.config/dotfiles/utils")

def main():
    interfaces = getInterfaces()
    for interface in interfaces:
        rx, tx = getCurrentRxTx(interface)
        history[interface] = { 'rx': int(rx), 'tx': int(tx) }
    while True:
        time.sleep(1)
        for interface in interfaces:
            rx, tx = getCurrentRxTx(interface)
            drx = str(int(rx) - history[interface]['rx'])
            dtx = str(int(tx) - history[interface]['tx'])
            history[interface] = { 'rx': int(rx), 'tx': int(tx) }
            with open(f"{writePath}/{interface}.rx.data", "w") as rx_file:
                rx_file.write(drx)
            with open(f"{writePath}/{interface}.tx.data", "w") as tx_file:
                tx_file.write(dtx)

def getCurrentRxTx(interface):
    rx = command(f"cat /sys/class/net/{interface}/statistics/rx_bytes")
    tx = command(f"cat /sys/class/net/{interface}/statistics/tx_bytes")
    return (rx, tx)

def getInterfaces():
    rawInterfaces = command("ip addr | awk '/state UP/ { print $2 }'")
    cleanedInterfaces = re.sub(r':', '', rawInterfaces)
    splitInterfaces = cleanedInterfaces.split('\n')
    return splitInterfaces

def command(cmd: str):
    return subprocess.run([cmd], shell=True, stdout=subprocess.PIPE).stdout.decode().strip()

if __name__ == '__main__':
    main()
    exit(0)
