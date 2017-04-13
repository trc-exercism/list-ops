defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    _count(l,0)
  end

  defp _count([],acc), do: acc
  defp _count([_h|t], acc), do: _count(t, acc + 1)

  @spec reverse(list) :: list
  def reverse(l) do
    _reverse(l,[])
  end
  def _reverse([],list), do: list
  def _reverse([h|t], list), do: _reverse(t,[h] ++ list)

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    _map(l, [], f)
  end

  defp _map([], list, _f), do: reverse(list)
  defp _map([h|t], list, f), do: _map(t, [f.(h)] ++ list, f)

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    _filter(l,f,[])
  end

  defp _filter([],_f,list), do: reverse(list)
  defp _filter([h|t], f, list) do
    if f.(h), do: _filter(t,f,[h] ++ list), else: _filter(t,f,list)
  end


  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce(l, acc, f) do
    _reduce(l, acc, f)
  end

  defp _reduce([], acc, _f), do: acc
  defp _reduce([h|t], acc, f), do: _reduce(t, f.(h, acc), f)

  @spec append(list, list) :: list
  def append(a, b) do
    _append(reverse(a), b)
  end

  defp _append(append_list, []), do: reverse(append_list)
  defp _append(append_list, [h|t]), do: _append([h] ++ append_list, t)

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    cond do
      ll == [] -> []
      count(ll) == 1 -> hd(ll)
      true -> _concat(Enum.split(ll, div(count(ll), 2)))
    end
  end

  defp _concat({left, right}) do
    append(concat(left), concat(right))
  end

end
