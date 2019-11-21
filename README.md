# docker-jormungandr
Rust implementation of a Cardano full node

## To connect using CLI REST:
```
jcli rest v0 <CMD> --host "http://127.0.0.1:3100/api"
```
For example:
```
jcli rest v0 node stats get -h "http://127.0.0.1:3100/api"
```

## /usr/local/cargo/bin/jormungandr --help
```
jormungandr 0.2.3
Nicolas Di Prima <nicolas.diprima@iohk.io>, Vincent Hanquez <vincent.hanquez@iohk.io>, Eelco Dolstra <edolstra@gmail.com>, Mikhail Zabaluev
<mikhail.zabaluev@gmail.com>, Alexander Vershilov <alexander.vershilov@gmail.com>
Midgard Serpent

USAGE:
    jormungandr [FLAGS] [OPTIONS] --config <node_config>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information
    -v, --verbose    activate the verbosity, the more occurrences the more verbose. (-v, -vv, -vvv)

OPTIONS:
        --genesis-block-hash <block_0_hash>    set the genesis block hash (the hash of the block0) so we can retrieve the genesis block (and
                                               the blockchain configuration) from the existing storage or from the network.
        --genesis-block <block_0_path>         Path to the genesis block (the block0) of the blockchain
        --grpc-connect <grpc_connect>...       List of the nodes to connect to using the grpc protocol. These are the nodes we know we need to
                                               connect to and start processing blocks, transactions and participate with.
        --grpc-listen <grpc_listen>...         The address to listen for inbound gRPC connections at. The program will open a listening socket
                                               on the given address. You might need to have special privileges to open the TCP socket at this
                                               address.
        --log-format <log_format>              Set format of the log emitted. Can be "json" or "plain". If not configured anywhere, defaults to
                                               "plain".
        --log-output <log_output>              Set format of the log emitted. Can be "stderr", "gelf", "syslog" (unix only) or "journald"
                                               (linux with systemd only, must be enabled during compilation). If not configured anywhere,
                                               defaults to "stderr".
        --config <node_config>                 Set the node config (in YAML format) to use as general configuration
        --legacy-connect <ntt_connect>...      List of the nodes to connect to using the legacy protocol. These are the nodes we know we need
                                               to connect to and start processing blocks, transactions and participate with.
        --legacy-listen <ntt_listen>...        The address to listen for inbound legacy protocol connections at. The program will open a
                                               listening socket on the given address. You might need to have special privileges to open the TCP
                                               socket at this address.
        --secret <secret>...                   Set the secret node config (in YAML format). Can be given multiple times.
        --storage <storage>                    Path to the blockchain pool storage directory
```
## /usr/local/cargo/bin/jcli --help
```
jcli 0.2.3
Nicolas Di Prima <nicolas.diprima@iohk.io>, Vincent Hanquez <vincent.hanquez@iohk.io>, Eelco Dolstra <edolstra@gmail.com>, Mikhail Zabaluev
<mikhail.zabaluev@gmail.com>, Alexander Vershilov <alexander.vershilov@gmail.com>
Jormungandr CLI toolkit

USAGE:
    jcli <SUBCOMMAND>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

SUBCOMMANDS:
    address            Address tooling and helper
    auto-completion    Auto completion
    certificate        Certificate generation tool
    debug              Debug tools for developers
    genesis            Block tooling and helper
    help               Prints this message or the help of the given subcommand(s)
    key                Key Generation
    rest               Send request to node REST API
    transaction        Build and view offline transaction
    utils              Utilities that perform specialized tasks
```
## Start jormungandr on beta testnet
```
jormungandr \
    --trusted-peer /ip4/3.115.194.22/tcp/3000@ed25519_pk1npsal4j9p9nlfs0fsmfjyga9uqk5gcslyuvxy6pexxr0j34j83rsf98wl2 \
    --trusted-peer /ip4/13.113.10.64/tcp/3000@ed25519_pk16pw2st5wgx4558c6temj8tzv0pqc37qqjpy53fstdyzwxaypveys3qcpfl \
    --trusted-peer /ip4/52.57.214.174/tcp/3000@ed25519_pk1v4cj0edgmp8f2m5gex85jglrs2ruvu4z7xgy8fvhr0ma2lmyhtyszxtejz \
    --trusted-peer /ip4/3.120.96.93/tcp/3000@ed25519_pk10gmg0zkxpuzkghxc39n3a646pdru6xc24rch987cgw7zq5pmytmszjdmvh \
    --trusted-peer /ip4/52.28.134.8/tcp/3000@ed25519_pk1unu66eej6h6uxv4j4e9crfarnm6jknmtx9eknvq5vzsqpq6a9vxqr78xrw \
    --trusted-peer /ip4/13.52.208.132/tcp/3000@ed25519_pk15ppd5xlg6tylamskqkxh4rzum26w9acph8gzg86w4dd9a88qpjms26g5q9 \
    --trusted-peer /ip4/54.153.19.202/tcp/3000@ed25519_pk1j9nj2u0amlg28k27pw24hre0vtyp3ge0xhq6h9mxwqeur48u463s0crpfk \
    --genesis-block-hash adbdd5ede31637f6c9bad5c271eec0bc3d0cb9efb86a5b913bb55cba549d0770
```
## config.yaml
```
{
  "log": {
    "format": "plain",
    "level": "info",
    "output": "stderr"
  },
  "p2p": {
    "topics_of_interest": {
      "blocks": "normal",
      "messages": "low"
    },
    "trusted_peers": [
      {
        "address": "/ip4/3.115.194.22/tcp/3000",
        "id": "ed25519_pk1npsal4j9p9nlfs0fsmfjyga9uqk5gcslyuvxy6pexxr0j34j83rsf98wl2"
      },
      {
        "address": "/ip4/13.113.10.64/tcp/3000",
        "id": "ed25519_pk16pw2st5wgx4558c6temj8tzv0pqc37qqjpy53fstdyzwxaypveys3qcpfl"
      },
      {
        "address": "/ip4/52.57.214.174/tcp/3000",
        "id": "ed25519_pk1v4cj0edgmp8f2m5gex85jglrs2ruvu4z7xgy8fvhr0ma2lmyhtyszxtejz"
      },
      {
        "address": "/ip4/3.120.96.93/tcp/3000",
        "id": "ed25519_pk10gmg0zkxpuzkghxc39n3a646pdru6xc24rch987cgw7zq5pmytmszjdmvh"
      },
      {
        "address": "/ip4/52.28.134.8/tcp/3000",
        "id": "ed25519_pk1unu66eej6h6uxv4j4e9crfarnm6jknmtx9eknvq5vzsqpq6a9vxqr78xrw"
      },
      {
        "address": "/ip4/13.52.208.132/tcp/3000",
        "id": "ed25519_pk15ppd5xlg6tylamskqkxh4rzum26w9acph8gzg86w4dd9a88qpjms26g5q9"
      },
      {
        "address": "/ip4/54.153.19.202/tcp/3000",
        "id": "ed25519_pk1j9nj2u0amlg28k27pw24hre0vtyp3ge0xhq6h9mxwqeur48u463s0crpfk"
      }
    ]
  },
  "rest": {
    "listen": "127.0.0.1:3100"
  }
}

