defmodule Talentgrid.Enum do

  # http://stackoverflow.com/questions/35245859/how-to-use-postgres-enumerated-type-with-ecto

  alias Postgrex.TypeInfo

  defmacro defenum(module, name, values, opts \\ []) do
    quote location: :keep do
      defmodule unquote(module) do

        @behaviour Postgrex.Extension

        @typename unquote(name)
        @values unquote(values)

        def type, do: :string

        def init(_params, opts), do: opts

        def matching(_), do: [type: @typename]

        def format(_), do: :text

        def encode(%TypeInfo{type: @typename}=typeinfo, str, args, opts) when is_atom(str), do: encode(typeinfo, to_string(str), args, opts)
        def encode(%TypeInfo{type: @typename}, str, _, _) when str in @values, do: to_string(str)
        def decode(%TypeInfo{type: @typename}, str, _, _), do: str

        def __values__(), do: @values

        defoverridable init: 2, matching: 1, format: 1, encode: 4, decode: 4

        unquote(Keyword.get(opts, :do, []))
      end
    end
  end

end
