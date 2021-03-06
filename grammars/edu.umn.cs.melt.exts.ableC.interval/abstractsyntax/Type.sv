grammar edu:umn:cs:melt:exts:ableC:interval:abstractsyntax;

import edu:umn:cs:melt:ableC:abstractsyntax:overloadable;

abstract production intervalTypeExpr
top::BaseTypeExpr ::= q::Qualifiers loc::Location
{
  top.pp = pp"interval";
  forwards to
    if !null(lookupRefId("edu:umn:cs:melt:exts:ableC:interval:interval", top.env))
    then extTypeExpr(q, intervalType())
    else errorTypeExpr([err(loc, "Missing include of interval.xh")]);
}

abstract production intervalType
top::ExtType ::= 
{
  propagate canonicalType;
  top.pp = pp"interval";
  -- Translate to a reference to the struct with the refId specified in the header file
  top.host =
    extType(
      top.givenQualifiers,
      refIdExtType(
        structSEU(), just("_interval_s"),
        s"edu:umn:cs:melt:exts:ableC:interval:interval"));
  top.mangledName = "interval";
  top.isEqualTo =
    \ other::ExtType -> case other of intervalType() -> true | _ -> false end;
  
  -- Additional equations specify overload productions for the interval type
  top.objectInitProd = just(initInterval(_, location=_));
  top.memberProd = just(memberInterval(_, _, _, location=_));
  top.negativeProd = just(negInterval(_, location=_));
  top.bitNegateProd = just(invInterval(_, location=_));
  top.lAddProd = just(addInterval(_, _, location=_));
  top.rAddProd = just(addInterval(_, _, location=_));
  top.lSubProd = just(subInterval(_, _, location=_));
  top.rSubProd = just(subInterval(_, _, location=_));
  top.lMulProd = just(mulInterval(_, _, location=_));
  top.rMulProd = just(mulInterval(_, _, location=_));
  top.lDivProd = just(divInterval(_, _, location=_));
  top.rDivProd = just(divInterval(_, _, location=_));
  -- Overloads for +=, -=, *=, /= automatically inferred from above
  top.lEqualsProd = just(equalsInterval(_, _, location=_));
  top.rEqualsProd = just(equalsInterval(_, _, location=_));
  -- Overload for != automatically inferred from above
  
  top.showErrors = checkIntervalHeaderDef("show_interval", _, _);
  top.showProd =
    \ e::Expr ->
      directCallExpr(name("show_interval", location=builtin), foldExpr([e]), location=builtin);
}
