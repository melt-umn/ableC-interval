grammar edu:umn:cs:melt:exts:ableC:interval:abstractsyntax;

abstract production intervalTypeExpr
top::BaseTypeExpr ::= q::Qualifiers
{
  top.pp = pp"interval";
  forwards to
    if !null(lookupRefId("edu:umn:cs:melt:exts:ableC:interval:interval", top.env))
    then extTypeExpr(@q, intervalType())
    else errorTypeExpr([errFromOrigin(top, "Missing include of interval.xh")]);
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
  top.objectInitProd = just(initInterval);
  top.memberProd = just(memberInterval);
  top.negativeProd = just(negInterval);
  top.bitNegateProd = just(invInterval);
  top.lAddProd = just(addInterval);
  top.rAddProd = just(addInterval);
  top.lSubProd = just(subInterval);
  top.rSubProd = just(subInterval);
  top.lMulProd = just(mulInterval);
  top.rMulProd = just(mulInterval);
  top.lDivProd = just(divInterval);
  top.rDivProd = just(divInterval);
  -- Overloads for +=, -=, *=, /= automatically inferred from above
  top.lEqualsProd = just(equalsInterval);
  top.rEqualsProd = just(equalsInterval);
  -- Overload for != automatically inferred from above
  
  top.showErrors := checkIntervalHeaderDef;
  top.showMaxLenProd =
    \ _ -> declRefExpr(name("MAX_INTERVAL_STR_LEN"));
  top.showProd =
    \ buf::Expr e::Expr ->
      directCallExpr(name("show_interval"), foldExpr([buf, e]));
}
