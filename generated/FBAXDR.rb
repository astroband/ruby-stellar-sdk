# Automatically generated from xdr/FBAXDR.x
# DO NOT EDIT or your changes may be overwritten
        
require 'xdr'

module Stellar
  include XDR::Namespace

  Signature = XDR::Opaque[64]
  Hash = XDR::Opaque[32]
  Uint256 = XDR::Opaque[32]
  Uint32 = XDR::UnsignedInt
  Uint64 = XDR::UnsignedHyper
  Value = XDR::VarOpaque[]
  Evidence = XDR::VarOpaque[]

  autoload :FBABallot

  autoload :FBAStatementType

  autoload :FBAStatement
  autoload :FBAEnvelope
  autoload :FBAQuorumSet
end
