# EasyScan

EasyScan is a Bash script that uses `hping3` to check a single TCP port across a `/24` IPv4 network. It reports response lines that contain `flags=SA` (SYN/ACK).

## Requirements

- Bash
- `hping3`
- `grep`

## Arguments

| Position | Argument | Format |
| --- | --- | --- |
| 1 | Network | The first three IPv4 octets. For example, `192.168.0` represents `192.168.0.0/24`. |
| 2 | TCP port | A decimal number from `0` through `65535` without leading zeros. |

## Output

EasyScan checks host addresses ending in `.1` through `.254`. The checks run in parallel, so response lines can appear in any order.

```text
EasyScan v1.0
----------------------------------------------------
Hosts that replied with SYN/ACK:

len=46 ip=192.168.0.12 flags=SA DF seq=0 ttl=64 id=0 win=64240 rtt=0.5 ms
```

An empty list means the script printed no matching response lines. Because the script suppresses `hping3` error messages, command errors can also produce an empty list.
