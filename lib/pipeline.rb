require_relative 'pipeline/version'

module Pipeline; refine Object do
  # @deprecated
  def then_call(prc = nil) = self.then(&prc)
  # @deprecated
  def !(*prcs)
    if prcs.empty?
      super
    else
      prcs.reduce(self) { _1.then_call(_2) }
    end
  end
  
  alias sys `
  alias ` public_method
end end
