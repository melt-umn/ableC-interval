grammar edu:umn:cs:melt:exts:ableC:interval:concretesyntax;

imports edu:umn:cs:melt:ableC:concretesyntax;
imports silver:langutil only ast;

imports edu:umn:cs:melt:ableC:abstractsyntax:host;
imports edu:umn:cs:melt:ableC:abstractsyntax:construction;
imports edu:umn:cs:melt:ableC:abstractsyntax:env;
--imports edu:umn:cs:melt:ableC:abstractsyntax:debug;

imports edu:umn:cs:melt:exts:ableC:interval;

marking terminal Interval_t 'interval' lexer classes {Ckeyword};

concrete productions top::TypeSpecifier_c
| 'interval'
    { top.realTypeSpecifiers = [intervalTypeExpr(top.givenQualifiers, top.location)];
      top.preTypeSpecifiers = []; }
