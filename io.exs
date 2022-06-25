import Config

config :wizard,
  transports: [
    {GrpcTransport, codec: Codec.Identity},
    {RabbitTransport, codec: Codec.Etf}
  ]

config :grpc_transport,
  listen: {'0.0.0.0', 9000}

config :rabbit_transport,
  conn_opts: {{:system, "AEON_RABBITMQ_SERVICE_HOST"}, {:system, "AEON_RABBITMQ_SERVICE_PORT"}},
  security: {"next", "next"}

config :core,
  riak_conn_opts: {{:system, "AEON_RIAK_SERVICE_HOST"}, {:system, "AEON_RIAK_SERVICE_PORT"}},
  pool_config: {:meta_core, [size: 50, max_overflow: 0]},
  storage_module: MetaCore.Storage.Riak,
  # storage_module: MetaCore.Storage.InMemory,
  storage_opts: [],
  notifier: MetaCore.Notifier.WizardNotifier

config :distributed_lib,
  conn_opts: [{{:system, "AEON_ETCD_SERVICE_HOST"}, {:system, "AEON_ETCD_SERVICE_PORT"}}]
#,  etcd_credentials: [name: "root", password: "KKGQKqZZV6"]
