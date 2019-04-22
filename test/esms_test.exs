defmodule EsmsTest do
  use ExUnit.Case
  doctest Esms

  test "get_balance" do
    case Esms.get_balance() do
      {:ok, data} ->
        assert data["CodeResponse"] == "100"

      {:error, :request_invalid, message} ->
        assert is_binary(message)

      {:error, _error} ->
        assert true
    end
  end

  test "send_message" do
    case Esms.send_message("09xxxxxx", "Hi") do
      {:ok, data} ->
        assert data["CodeResponse"] == "100"

      {:error, :request_invalid, message} ->
        assert is_binary(message)

      {:error, _error} ->
        assert true
    end
  end
end
