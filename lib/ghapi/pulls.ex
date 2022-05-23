defmodule Ghapi.Pulls do
  @moduledoc """
  Get and handle pull requests from the github API.
  """
  @spec base_url :: binary()
  def base_url(), do: "https://api.github.com/repos/joinpapa/backend"

  @spec request(binary) ::
          {:error, HTTPoison.Error.t()}
          | {:ok, HTTPoison.AsyncResponse | HTTPoison.Response}
  def request(url) do
    headers = [
      {"owner", "joinpapa"},
      {"repo", "backend"},
      Ghapi.Auth.header(:username),
      Ghapi.Auth.header(:authorization)
    ]
    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: :infinity]

    HTTPoison.get(url, headers, options)
  end

  @spec get :: list
  def get() do
    base_url() <> "/pulls"
    |> request()
    |> response()
    |> case do
      {:ok, response} -> Enum.map(response, fn r -> Map.get(r, "number") end)
      {:error, _reason} -> [] # TODO log reason
      _ -> []
    end
  end

  @spec get_by_id(binary()) :: list()
  def get_by_id(id \\ "1")

  def get_by_id(id) when is_binary(id) do
    base_url() <> "/pulls/#{id}/comments"
    |> request()
    |> response()
    |> return()
  end

  def get_by_id(_), do: {:error, "Pull request ID must be a binary."}

  @spec response({:error, any} | {:ok, HTTPoison.Response.t()}) :: any
  def response({:ok, %HTTPoison.Response{body: body}}) do
    body
    |> Jason.decode()
  end

  def response({:error, reason}) do
    reason
  end

  @spec return({:ok, list()} | %{comment: any, created_at: any, id: any, link: any, user: any}) :: nil | list()
  def return({:ok, comments}) when is_list(comments) do
    Enum.map(comments, fn comment -> return(comment) end)
  end

  def return(%{"body" => comment, "created_at" => at, "html_url" => link, "id" => id, "user" => %{"login" => user}}) do
    %{
      id: id,
      comment: comment,
      created_at: at,
      link: link,
      user: user
    }
  end

  def return(_), do: nil
end
