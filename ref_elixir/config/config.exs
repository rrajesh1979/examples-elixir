import Config

# # Our Logger general configuration
config :logger,
  backends: [:console],
  level: :info

# # Our Console Backend-specific configuration
# config :logger,
#        :console,
#        format: "\n##### $time $metadata[$level] $levelpad$message\n",
#        metadata: :all

# Uncomment this if you want to set up environment-level configuration
# import_config "#{Mix.env}.exs"
config :opus,
       :instrumentation,
       [Opus.Telemetry]

# config :opus,
#        :instrumentation,
#        [CustomInstrumentation]
