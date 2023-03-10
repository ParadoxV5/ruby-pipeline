# The `Pipeline` Refinement module bundles a method duo that builds
# a clean and clever pure-Ruby solution to rightward method piping.
# Check out [the README](index.html) for examples.
# 
# Reminder: activate a Refinement module with `using`:
# ```ruby
# using Pipeline
# my_obj.then_pipe(…)
# ```
# Refinements are only active for the module/class block or file
# (if top-level) that’s `using` them. See: `refinements.rdoc`
# ([on docs.ruby-lang.org](https://docs.ruby-lang.org/en/master/syntax/refinements_rdoc.html))
# 
# @!method then_pipe(*procs)
#   Yield `self` to the first `Proc` (or `#to_proc` object) argument,
#   then the result to the second argument, and so forth.
#   ```ruby
#   construct_url(arguments).then_pipe(
#     proc {|url| URI(url).read },
#     JSON.public_method :parse
#   )
#   ```
#   @param procs `Proc` or `#to_proc` objects to call
#   @return The result of the last call, or `self` if no arguments were given.
# 
# @!method sys(command)
#   Provide a replacement alias for `` Kernel#` ``, the subshell method.
#   @see #`
# 
# @!method `(name)
#   Alias `Object#method`.
#   ```ruby
#   m = 42.` :to_s
#   m.call #=> "42"
#   ```
#   The `` ` `` method is the backend to the `` `…` `` and `%x{…}` syntaxes.
#   ```ruby
#   class MyArray < Array
#     using Pipeline
#     def fetch_values(*indices)
#       indices.map(&`[]`)
#     end
#   end
#   a = MyArray.new(['A', 'B', 'C'])
#   a.fetch_values 1, 3 #=> ["B", nil]
#   ```
#   @see #sys

module Pipeline; refine Object do
  def then_pipe(*procs) = procs.reduce(self) { _1.then(&_2) }
  
  alias sys `
  alias ` method
end end
