# docker-jormungandr
Rust implementation of a Cardano full node

## jormungandr --help
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
## jcli --help
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
