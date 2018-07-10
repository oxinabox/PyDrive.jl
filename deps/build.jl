using PyCall
using Conda

if PyCall.conda
    Conda.add_channel("conda-forge")
    Conda.add("pydrive")
else
    try
        pyimport("pydrive")
        # See if it works already
    catch ee
        typeof(ee) <: PyCall.PyError || rethrow(ee)
        error("""
Python pydrive not installed
Please either:
 - Rebuild PyCall to use Conda, by running in the julia REPL:
    - `ENV["PYTHON"]=""; Pkg.build("PyCall"); Pkg.build("PyDrive")`
 - Or install the python binding yourself, eg by running pip
    - `pip install pydrive`
    - then rebuilding PyDrive.jl via `Pkg.build("PyDrive")` in the julia REPL
    - make sure you run the right pip, for the instance of python that PyCall is looking at.
""")
    end
end

