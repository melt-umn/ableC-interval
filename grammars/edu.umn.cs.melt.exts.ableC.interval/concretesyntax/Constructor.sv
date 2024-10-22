grammar edu:umn:cs:melt:exts:ableC:interval:concretesyntax;

marking terminal Intr_t 'intr' lexer classes {Keyword, Global};

concrete productions top::PrimaryExpr_c
| 'intr' '[' min::AssignExpr_c ',' max::AssignExpr_c ']'
  { top.ast = newInterval(min.ast, max.ast); }
