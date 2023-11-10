using Documenter
using Pkg: Pkg

# Fix for https://github.com/trixi-framework/Trixi.jl/issues/668
# to allow building the docs locally
if (get(ENV, "CI", nothing) != "true") &&
   (get(ENV, "JULIA_DOC_DEFAULT_ENVIRONMENT", nothing) != "true")
    push!(LOAD_PATH, dirname(@__DIR__))
end

using TrapezoidalRule

# Define module-wide setups such that the respective modules are available in doctests
DocMeta.setdocmeta!(TrapezoidalRule,
                    :DocTestSetup, :(using TrapezoidalRule); recursive = true)

# Copy some files from the top level directory to the docs and modify them
# as necessary
open(joinpath(@__DIR__, "src", "license.md"), "w") do io
    # Point to source license file
    println(io, """
    ```@meta
    EditURL = "https://github.com/tooczz/My_RSE_in_Julia.jl/blob/main/LICENSE.md"
    ```
    """)
    # Write the modified contents
    println(io, "# License")
    println(io, "")
    for line in eachline(joinpath(dirname(@__DIR__), "LICENSE"))
        line = replace(line, "[LICENSE.md](LICENSE.md)" => "[License](@ref)")
        println(io, "> ", line)
    end
end

# Make documentation
makedocs(modules = [TrapezoidalRule],
         sitename = "My_RSE_in_Julia.jl",
         format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true",
                                  canonical = "https://tooczz.github.io/My_RSE_in_Julia.jl/stable"),
         # Explicitly specify documentation structure
         pages = [
             "Home" => "index.md",
             "API reference" => "api_reference.md",
             "License" => "license.md",
         ])

deploydocs(repo = "github.com/tooczz/My_RSE_in_Julia.jl",
           devbranch = "main",
           push_preview = true)
