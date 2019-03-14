defmodule Esms.Api do
  use HTTPoison.Base
  require Logger
  alias __MODULE__, as: Self

  # @result_codes %{
  #   "100" => "Request đã được nhận và xử lý thành công",
  #   "100" => "Request đã được nhận và xử lý thành công",
  #   "104" => "Brandname không tồn tại hoặc đã bị hủy",
  #   "118" => "Loại tin nhắn không hợp lệ",
  #   "119" => "Brandname quảng cáo phải gửi ít nhất 20 số điện thoại",
  #   "131" => "Tin nhắn brandname quảng cáo độ dài tối đa 422 kí tự",
  #   "132" => "Không có quyền gửi tin nhắn đầu số cố định 8755",
  #   "99" => "Lỗi không xác định"
  # }

  def request(method, url, body, request_headers, hn_options) do
    Logger.debug("method: #{inspect(method)}")
    Logger.debug("url: #{inspect(process_url(url))}")
    Logger.debug("request_headers: #{inspect(request_headers)}")
    Logger.debug("body: #{inspect(body)}")
    Logger.debug("hn_options: #{inspect(hn_options)}")
    super(method, url, body, request_headers, hn_options)
  end

  def process_url(url) do
    "http://rest.esms.vn/MainService.svc/json" <> url
  end

  def process_response_body(body) do
    case Jason.decode(body) do
      {:ok, decoded_body = %{"CodeResult" => "100"}} ->
        {:ok, decoded_body}

      {:ok, decoded_body = %{"CodeResult" => value}} ->
        {:error, :request_invalid, decoded_body["ErrorMessage"]}

      {:ok, decoded_body = %{"CodeResponse" => "100"}} ->
        {:ok, decoded_body}

      {:ok, decoded_body = %{"CodeResponse" => value}} ->
        {:error, :request_invalid, decoded_body["ErrorMessage"]}

      {:error, err} ->
        Logger.error("Parse response body fail: #{inspect(err)}")
        {:error, :server_error}
    end
  end

  def get_balance() do
    api_key = Application.get_env(:esms, :api_key)
    secret_key = Application.get_env(:esms, :secret_key)

    case Self.get("/GetBalance/#{api_key}/#{secret_key}") do
      {:ok, response} ->
        response.body
      {:error, :request_invalid, message} ->
        Logger.error("Get balance error: #{message}")
      {:error, err} = err ->
        Logger.error("Get balance error: #{inspect(err)}")
    end
  end

  def send_message(phone, message) do
    data = %{
      "Phone" => phone,
      "Content" => message,
      "APIKey" => Application.get_env(:esms, :api_key),
      "SecretKey" => Application.get_env(:esms, :api_key),
      "SmsType" => Application.get_env(:esms, :sms_type),
      "Brandname" => Application.get_env(:esms, :brandname),
      "Sandbox" => Application.get_env(:esms, :sandbox)
    }

    Logger.debug("Data before send: #{inspect(data)}")

    case Self.get("/SendMultipleMessage_V4_get?" <> URI.encode_query(data)) do
      {:ok, response} ->
        response.body
      {:error, :request_invalid, message} ->
        Logger.error("Sending message fail with error: #{message}")
      {:error, err} ->
        Logger.error("Sending message fail with error: #{inspect(err)}")
    end
  end
end
