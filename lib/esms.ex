defmodule Esms do
  @doc """
  Esms.get_balance()
  > {:ok, %{"Balance" => 5000, "CodeResponse" => "100", "UserID" => 1}}
  """
  def get_balance() do
    Esms.Api.get_balance()
  end

  @doc """
  Esms.send_message("09xxxxxx", "Ma kich hoat cua ban la: 00001")
  Esms.send_message("09xxxxxx", "Your OTP code for registration is 123456")
  Esms.send_message("09xxxxxx", "Your OTP code for resetting password is 123456")

  > %{
    "CodeResult" => "100",
    "CountRegenerate" => 0,
    "SMSID" => "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxxx"
  }
  """
  def send_message(phone, message) do
    Esms.Api.send_message(phone, message)
  end
end
