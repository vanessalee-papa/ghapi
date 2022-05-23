defmodule Ghapi.Auth do
  @moduledoc """
  Function for authentication
  """
  def header(:authorization) do
    {"Authorization", "token #{get_env(Application.get_env(:ghapi, :token))}"}
  end

  def header(:username) do
    {"username", get_env(Application.get_env(:ghapi, :username))}
  end

  def header(_), do: raise "Unknown header value requested from Ghapi.Auth"

  def get_env(nil), do: raise "Missing environment variable"

  def get_env(val), do: val
end
