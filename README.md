# Esms

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `esms` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:esms, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/esms](https://hexdocs.pm/esms).

## Config

```
config :esms,
  api_key: System.get_env("ESMS_API_KEY"),
  secret_key: System.get_env("ESMS_SECRET_KEY"),
  brandname: System.get_env("ESMS_BRANDNAME"),
  sms_type: String.to_integer(System.get_env("ESMS_SMS_TYPE")),
  sandbox: String.to_integer(System.get_env("ESMS_SANDBOX")) || 1
```
