grammar edu:umn:cs:melt:exts:ableC:interval:abstractsyntax;

imports silver:langutil;
imports silver:langutil:pp;

imports edu:umn:cs:melt:ableC:abstractsyntax:host;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;
imports edu:umn:cs:melt:ableC:abstractsyntax:env;

imports edu:umn:cs:melt:exts:ableC:string;

abstract production newInterval
top::Expr ::= min::Expr max::Expr
{
  top.pp = pp"intr [${min.pp}, ${max.pp}]";

  local localErrors::[Message] = checkIntervalHeaderDef(top.env);
  forward fwrd =
    directCallExpr(name("new_interval"), consExpr(@min, consExpr(@max, nilExpr())));
  forwards to
    if null(localErrors) then @fwrd else errorExpr(localErrors);
}

abstract production initInterval implements ObjectInitializer
top::Initializer ::= i::InitList
{
  top.pp = ppConcat([text("{"), ppImplode(text(", "), i.pps), text("}")]);

  forwards to bindObjectInitializer(@i,
    case i of
    | consInit(positionalInit(_), consInit(positionalInit(_), nilInit()))
        when i.bindRefExprs matches [min, max] ->
      newInterval(min, max)
    | _ -> errorExpr([errFromOrigin(top, "Invalid interval initializer")])
    end);
}

-- Extension productions that are used to resolve overloaded operators
abstract production memberInterval implements MemberAccess
top::Expr ::= @lhs::Expr deref::Boolean rhs::Name
{
  top.pp = parens(ppConcat([lhs.pp, text(if deref then "->" else "."), rhs.pp]));
  attachNote extensionGenerated("ableC-interval");

  local localErrors::[Message] =
    checkIntervalHeaderDef(top.env) ++
    checkIntervalType(lhs.typerep, ".") ++
    (if rhs.name == "min" || rhs.name == "max"
     then []
     else [errFromOrigin(rhs, s"interval does not have member ${rhs.name}")]);
  nondecorated local fwrd::Expr =
    memberExpr(
      explicitCastExpr(
        typeName(
          tagReferenceTypeExpr(
            nilQualifier(), structSEU(),
            name("_interval_s")),
          baseTypeExpr()),
        lhs.bindRefExpr),
      false, ^rhs);
  forwards to bindMemberAccess(lhs, deref, @rhs, mkErrorCheck(localErrors, fwrd));
}

abstract production negInterval implements UnaryOp
top::Expr ::= @i::Expr
{
  top.pp = pp"-(${i.pp})";
  attachNote extensionGenerated("ableC-interval");

  local localErrors::[Message] =
    checkIntervalHeaderDef(top.env) ++
    checkIntervalType(i.typerep, "-");
  nondecorated local fwrd::Expr =
    directCallExpr(name("neg_interval"), foldExpr([i.bindRefExpr]));
  forwards to bindUnaryOp(i, mkErrorCheck(localErrors, fwrd));
}

abstract production invInterval implements UnaryOp
top::Expr ::= @i::Expr
{
  top.pp = pp"~(${i.pp})";
  attachNote extensionGenerated("ableC-interval");
  
  local localErrors::[Message] =
    checkIntervalHeaderDef(top.env) ++
    checkIntervalType(i.typerep, "~");
  nondecorated local fwrd::Expr =
    directCallExpr(name("inv_interval"), foldExpr([i.bindRefExpr]));
  forwards to bindUnaryOp(i, mkErrorCheck(localErrors, fwrd));
}

abstract production addInterval implements BinaryOp
top::Expr ::= @i1::Expr @i2::Expr
{
  top.pp = pp"(${i1.pp}) + (${i2.pp})";
  attachNote extensionGenerated("ableC-interval");

  local localErrors::[Message] =
    checkIntervalHeaderDef(top.env) ++
    checkIntervalType(i1.typerep, "+") ++
    checkIntervalType(i2.typerep, "+");
  nondecorated local fwrd::Expr =
    directCallExpr(name("add_interval"), foldExpr([i1.bindRefExpr, i2.bindRefExpr]));
  forwards to bindBinaryOp(i1, i2, mkErrorCheck(localErrors, fwrd));
}

abstract production subInterval implements BinaryOp
top::Expr ::= @i1::Expr @i2::Expr
{
  top.pp = pp"(${i1.pp}) - (${i2.pp})";
  attachNote extensionGenerated("ableC-interval");

  local localErrors::[Message] =
    checkIntervalHeaderDef(top.env) ++
    checkIntervalType(i1.typerep, "-") ++
    checkIntervalType(i2.typerep, "-");
  nondecorated local fwrd::Expr =
    directCallExpr(name("sub_interval"), foldExpr([i1.bindRefExpr, i2.bindRefExpr]));
  forwards to bindBinaryOp(i1, i2, mkErrorCheck(localErrors, fwrd));
}

abstract production mulInterval implements BinaryOp
top::Expr ::= @i1::Expr @i2::Expr
{
  top.pp = pp"(${i1.pp}) * (${i2.pp})";
  attachNote extensionGenerated("ableC-interval");

  local localErrors::[Message] =
    checkIntervalHeaderDef(top.env) ++
    checkIntervalType(i1.typerep, "*") ++
    checkIntervalType(i2.typerep, "*");
  nondecorated local fwrd::Expr =
    directCallExpr(name("mul_interval"), foldExpr([i1.bindRefExpr, i2.bindRefExpr]));
  forwards to bindBinaryOp(i1, i2, mkErrorCheck(localErrors, fwrd));
}

abstract production divInterval implements BinaryOp
top::Expr ::= @i1::Expr @i2::Expr
{
  top.pp = pp"(${i1.pp}) / (${i2.pp})";
  attachNote extensionGenerated("ableC-interval");

  local localErrors::[Message] =
    checkIntervalHeaderDef(top.env) ++
    checkIntervalType(i1.typerep, "/") ++
    checkIntervalType(i2.typerep, "/");
  nondecorated local fwrd::Expr =
    directCallExpr(name("div_interval"), foldExpr([i1.bindRefExpr, i2.bindRefExpr]));
  forwards to bindBinaryOp(i1, i2, mkErrorCheck(localErrors, fwrd));
}

abstract production equalsInterval implements BinaryOp
top::Expr ::= @i1::Expr @i2::Expr
{
  top.pp = pp"(${i1.pp}) == (${i2.pp})";
  attachNote extensionGenerated("ableC-interval");

  local localErrors::[Message] =
    checkIntervalHeaderDef(top.env) ++
    checkIntervalType(i1.typerep, "==") ++
    checkIntervalType(i2.typerep, "==");
  nondecorated local fwrd::Expr =
    directCallExpr(name("equals_interval"), foldExpr([i1.bindRefExpr, i2.bindRefExpr]));
  forwards to bindBinaryOp(i1, i2, mkErrorCheck(localErrors, fwrd));
}

-- Check the given env for the given function name
fun checkIntervalHeaderDef [Message] ::= env::Env =
  if !null(lookupValue("new_interval", env))
  then []
  else [errFromOrigin(ambientOrigin(), "Missing include of interval.xh")];

-- Check that operand has interval type
fun checkIntervalType [Message] ::= t::Type op::String =
  if typeAssignableTo(extType(nilQualifier(), intervalType()), t)
  then []
  else [errFromOrigin(ambientOrigin(), s"Operand to ${op} expected interval type (got ${show(80, t)})")];
